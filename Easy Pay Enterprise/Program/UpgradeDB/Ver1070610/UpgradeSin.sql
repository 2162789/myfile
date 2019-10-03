Read UpgradeDB\Ver1070610\AllScript.sql;
Read UpgradeDB\Ver1070610\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070610, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;