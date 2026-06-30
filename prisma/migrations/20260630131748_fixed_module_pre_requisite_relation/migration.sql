/*
  Warnings:

  - You are about to drop the column `pre_requisitieMod_code` on the `module` table. All the data in the column will be lost.
  - You are about to drop the column `pre_requisitieRequisite` on the `module` table. All the data in the column will be lost.
  - You are about to drop the column `moduleModCode` on the `pre_requisite` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "pre_requisite" DROP CONSTRAINT "pre_requisite_moduleModCode_fkey";

-- AlterTable
ALTER TABLE "module" DROP COLUMN "pre_requisitieMod_code",
DROP COLUMN "pre_requisitieRequisite";

-- AlterTable
ALTER TABLE "pre_requisite" DROP COLUMN "moduleModCode";
