INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010001\MY_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

commit work;