INPUT INTO "DBA"."CoreKeyword"
FROM "UpgradeDB\Ver1000001\CoreKeyWord.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."CustView"
FROM "UpgradeDB\Ver1000001\CustView.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."CustViewObj"
FROM "UpgradeDB\Ver1000001\CustViewObj.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."CustViewObjTbl"
FROM "UpgradeDB\Ver1000001\CustViewObjTbl.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."CustViewItem"
FROM "UpgradeDB\Ver1000001\CustViewItem.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."InterfaceProject"
FROM "UpgradeDB\Ver1000001\InterfaceProject.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."InterfaceProcess"
FROM "UpgradeDB\Ver1000001\InterfaceProjProcess.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."InterfaceAttribute"
FROM "UpgradeDB\Ver1000001\InterfaceProjAttribute.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."InterfaceCodeTable"
FROM "UpgradeDB\Ver1000001\InterfaceProjCodeTable.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."InterfaceTableMapping"
FROM "UpgradeDB\Ver1000001\InterfaceTableMapping.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."Registry"
FROM "UpgradeDB\Ver1000001\Registry.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."SubRegistry"
FROM "UpgradeDB\Ver1000001\InterfaceProcess.dat"
FORMAT ASCII
BY ORDER;


INPUT INTO "DBA"."SubRegistry"
FROM "UpgradeDB\Ver1000001\SubRegistry.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."UserGroup"
FROM "UpgradeDB\Ver1000001\UserGroup.dat"
FORMAT ASCII
BY ORDER;


COMMIT WORK;


