INPUT INTO "DBA"."ModuleScreenGroup"
FROM UpgradeDB\Ver1000004\EC_SG_ModuleScreenGroup.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."ModuleScreenGroup"
FROM UpgradeDB\Ver1000004\EC_SG_YE_ModuleScreenGroup.dat
FORMAT ASCII
BY ORDER;