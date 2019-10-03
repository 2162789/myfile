Read UpgradeDB\Ver1070412\AllScript.sql;
Read UpgradeDB\Ver1070412\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070412, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;