INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1000005\EC_SG_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

COMMIT WORK;