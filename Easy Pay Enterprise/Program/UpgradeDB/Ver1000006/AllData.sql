INPUT INTO "DBA"."ModuleScreenGroup"
FROM UpgradeDB\Ver1000006\EC_ModuleScreenGroup.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."ModuleScreenGroup"
FROM UpgradeDB\Ver1000006\Std_ModuleScreenGroup.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."SubRegistry"
FROM UpgradeDB\Ver1000006\Std_Subregistry.dat
FORMAT ASCII
BY ORDER;