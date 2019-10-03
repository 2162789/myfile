Read UpgradeDB\Ver1070300\AllScript.sql;
Read UpgradeDB\Ver1070300\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070300, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;