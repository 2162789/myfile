INPUT INTO "DBA"."ModuleScreenGroup"
FROM UpgradeDB\Ver1020206\ModuleScreenGroup.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."Registry"
FROM UpgradeDB\Ver1020206\Registry.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."SubRegistry"
FROM UpgradeDB\Ver1020206\SubRegistry.dat
FORMAT ASCII
BY ORDER;

commit work;