INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1000005\EC_HK_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1000005\HK_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

COMMIT WORK;