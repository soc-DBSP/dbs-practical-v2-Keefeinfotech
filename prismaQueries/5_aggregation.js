const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient()
const util = require('util');


function getMeanCourseFee() {
    return prisma.course.aggregate({
        _avg: {
            crseFee: true,
        }
    })
}


/** Section A */

function getNumberOfFullTimeStaff() {
    return prisma.staff.aggregate({
        // TODO: Implement the query
            select:{_count: {
            select: {staffNo: true}
            }},
        where:{
            typeOfEmployment: "FT"
        }
    })
}

/** Section B */

function getTotalAllowanceOfStaffByGrade() {
    return prisma.staff.groupBy({
        // TODO: Implement the query
        by: ['grade'],
        where:{
            NOT:[{grade: { startsWith: "S"}}, {allowance: null}],
        },
        select:{
            _sum:{
                select:{allowance: true}
            },
            grade: true
        },
        orderBy: [{grade: "desc"}]
    });
}


function getTotalPayAndNoOfStaffByDeptWithHighTotal() {
    return prisma.staff.groupBy({
        // TODO: Implement the query
        by: ["deptCode"],
        select: {
            _sum: {select:{pay: true}},
            _count: {select: {staffNo: true}},
            deptCode: true
        },
        where:{
         NOT:[
            {deptCode: "DPO"}
          ]
        },
        having: {
         pay:{
          _sum:{
            gt: 20000
          }
        }
        }
    });
}

/** Using Raw Query */


function getAvgLabFeeWithRawQuery() {
    return prisma.$queryRaw`SELECT AVG(COALESCE(lab_fee, 0)) AS "Mean Lab Fee" FROM course;`
}


async function main(argument) {
    let results;
    switch (argument) {
        case 'getMeanCourseFee':
            results = await getMeanCourseFee();
            break;
        case 'getNumberOfFullTimeStaff':
            results = await getNumberOfFullTimeStaff();
            break;
        case 'getTotalAllowanceOfStaffByGrade':
            results = await getTotalAllowanceOfStaffByGrade();
            break;                        
        case 'getTotalPayAndNoOfStaffByDeptWithHighTotal':
            results = await getTotalPayAndNoOfStaffByDeptWithHighTotal();
            break;            
        case 'getAvgLabFeeWithRawQuery':
            results = await getAvgLabFeeWithRawQuery()
            break;            
        default:
            console.log('Invalid argument');
    }
    results && console.log(util.inspect(results, { showHidden: false, depth: null, colors: true }));
}

main(process.argv[2]);
