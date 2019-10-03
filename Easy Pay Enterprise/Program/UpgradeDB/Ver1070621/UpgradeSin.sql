Read UpgradeDB\Ver1070621\AllScript.sql;
Read UpgradeDB\Ver1070621\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070621, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;