INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1000011\EC_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1000011\EC_SG_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;



commit work;