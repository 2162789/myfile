INPUT INTO "DBA"."CompanyGov"
FROM "UpgradeDB\Ver1010001\SG_CompanyGov.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010001\SG_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

COMMIT WORK;