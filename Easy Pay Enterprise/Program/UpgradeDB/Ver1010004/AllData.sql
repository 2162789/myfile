INPUT INTO "DBA"."ModuleScreenGroup"
FROM "UpgradeDB\Ver1010004\ModuleScreenGroup.dat"
FORMAT ASCII
BY ORDER;

commit work;