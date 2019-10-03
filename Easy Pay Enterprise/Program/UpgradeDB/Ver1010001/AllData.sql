INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010001\ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010001\EC_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

commit work;