-- CreateTable
CREATE TABLE "pre_requisitie" (
    "mod_code" VARCHAR(10) NOT NULL,
    "requisite" VARCHAR(10) NOT NULL,

    CONSTRAINT "pre_requisitie_pkey" PRIMARY KEY ("mod_code","requisite")
);
