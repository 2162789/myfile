Read UpgradeDB\Ver1070514\AllScript.sql;
Read UpgradeDB\Ver1070514\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070514, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;