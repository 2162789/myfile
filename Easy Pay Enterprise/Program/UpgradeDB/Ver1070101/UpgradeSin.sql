Read UpgradeDB\Ver1070101\AllScript.sql;
Read UpgradeDB\Ver1070101\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070101, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;