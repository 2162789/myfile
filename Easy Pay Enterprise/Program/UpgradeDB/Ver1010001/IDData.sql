INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010001\ID_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

commit work;