INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010003\MY_ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

commit work;