INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010001\PH_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

commit work;