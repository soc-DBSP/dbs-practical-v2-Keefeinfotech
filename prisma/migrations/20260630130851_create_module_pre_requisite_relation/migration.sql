/*
  Warnings:

  - The primary key for the `module` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `mod_code` on the `module` table. The data in that column could be lost. The data in that column will be cast from `Integer` to `VarChar(10)`.
  - You are about to drop the `pre_requisitie` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `mod_coord` to the `module` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "module" DROP CONSTRAINT "module_pkey",
ADD COLUMN     "mod_coord" CHAR(4) NOT NULL,
ADD COLUMN     "pre_requisitieMod_code" VARCHAR(10),
ADD COLUMN     "pre_requisitieRequisite" VARCHAR(10),
ALTER COLUMN "mod_code" SET DATA TYPE VARCHAR(10),
ADD CONSTRAINT "module_pkey" PRIMARY KEY ("mod_code");

-- DropTable
DROP TABLE "pre_requisitie";

-- CreateTable
CREATE TABLE "pre_requisite" (
    "mod_code" VARCHAR(10) NOT NULL,
    "requisite" VARCHAR(10) NOT NULL,
    "moduleModCode" VARCHAR(10),

    CONSTRAINT "pre_requisite_pkey" PRIMARY KEY ("mod_code","requisite")
);

-- AddForeignKey
ALTER TABLE "module" ADD CONSTRAINT "mod_mod_coord_fk" FOREIGN KEY ("mod_coord") REFERENCES "staff"("staff_no") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pre_requisite" ADD CONSTRAINT "pre_requisite_mod_code_fk" FOREIGN KEY ("mod_code") REFERENCES "module"("mod_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pre_requisite" ADD CONSTRAINT "pre_requisite_requisite_fk" FOREIGN KEY ("requisite") REFERENCES "module"("mod_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pre_requisite" ADD CONSTRAINT "pre_requisite_moduleModCode_fkey" FOREIGN KEY ("moduleModCode") REFERENCES "module"("mod_code") ON DELETE SET NULL ON UPDATE CASCADE;
