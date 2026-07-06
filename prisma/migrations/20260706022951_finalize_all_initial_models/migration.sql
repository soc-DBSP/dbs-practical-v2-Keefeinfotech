/*
  Warnings:

  - You are about to drop the column `gpa` on the `student` table. All the data in the column will be lost.
  - You are about to drop the column `gpa_last_updated` on the `student` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "course" DROP CONSTRAINT "fk_course_offered_by";

-- DropForeignKey
ALTER TABLE "module" DROP CONSTRAINT "mod_mod_coord_fk";

-- AlterTable
ALTER TABLE "module" ALTER COLUMN "mod_coord" DROP NOT NULL;

-- AlterTable
ALTER TABLE "stud_mod_performance" ALTER COLUMN "mark" DROP NOT NULL,
ALTER COLUMN "grade" DROP NOT NULL;

-- AlterTable
ALTER TABLE "student" DROP COLUMN "gpa",
DROP COLUMN "gpa_last_updated",
ALTER COLUMN "mobile_phone" DROP NOT NULL,
ALTER COLUMN "home_phone" DROP NOT NULL;

-- RenameForeignKey
ALTER TABLE "stud_mod_performance" RENAME CONSTRAINT "modCode_mod_registered" TO "stud_mod_performance_mod_registered_fkey";

-- RenameForeignKey
ALTER TABLE "stud_mod_performance" RENAME CONSTRAINT "student_stud_mod_performance" TO "stud_mod_performance_adm_no_fkey";

-- AddForeignKey
ALTER TABLE "course" ADD CONSTRAINT "course_offered_by_fk" FOREIGN KEY ("offered_by") REFERENCES "department"("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "module" ADD CONSTRAINT "mod_mod_coord_fk" FOREIGN KEY ("mod_coord") REFERENCES "staff"("staff_no") ON DELETE NO ACTION ON UPDATE NO ACTION;
