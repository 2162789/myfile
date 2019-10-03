INPUT INTO "DBA"."ModuleScreenGroup"
FROM UpgradeDB\Ver1000004\EC_ModuleScreenGroup.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."FunctionDefineRecord"
FROM UpgradeDB\Ver1000004\FunctionDefineRecord.dat
FORMAT ASCII
BY ORDER;