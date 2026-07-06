const { PrismaClient, Prisma } = require('@prisma/client'); 
const prisma = new PrismaClient(); 

module.exports.create = function create(code, name, credit) {
    return prisma.module.create({
        data: {
            modCode: code,
            modName: name,
            creditUnit: parseInt(credit, 10)
        }
    }).then(function (module) {
        return module;

    }).catch(function (error) {

        if (error instanceof Prisma.PrismaClientKnownRequestError) {

            if (error.code === 'P2002') {
                throw new Error("Module already exists.");
            }

        }

        throw error;
    });
};

module.exports.updateByCode = function updateByCode(code, credit) {
    return prisma.module.update({
        where: {
            modCode: code
        },
        data: {
            creditUnit: Number(credit)
        }
    }).then(function (module) {
        // Left Blank
    }).catch(function (error) {

        if (error instanceof Prisma.PrismaClientKnownRequestError) {

            // Record not found
            if (error.code === "P2025") {
                throw new Error("Module not found.");
            }

        }

        throw error;
    });
};

module.exports.deleteByCode = function deleteByCode(code) { 
    return prisma.module.delete({ 
        // TODO: Add where 
        where:{
             modCode: code
        }
 
    }).then(function (module) { 
        // Leave blank 
    }).catch(function (error) { 
        // Prisma error codes: https://www.prisma.io/docs/orm/reference/error reference#p2025 
        // TODO: Handle Prisma Error, throw a new error if module is not found                              
     if (error instanceof Prisma.PrismaClientKnownRequestError) {

            // Record not found
            if (error.code === "P2025") {
                throw new Error("Module not found.");
            }

        }

        throw error;
    }) 
}; 

module.exports.retrieveAll = function retrieveAll() {
    return prisma.module.findMany()
        .then(function(modules) {
            return modules;
        })
        .catch(function(error) {
            throw error;
        });
};

module.exports.retrieveByCode = function retrieveByCode(code) {
    return prisma.module.findUnique({
        where: {
            modCode: code
        }
    })
    .then(function(module) {
        if (!module) {
            throw new Error("Module not found.");
        }

        return module;
    })
    .catch(function(error) {
        throw error;
    });
};