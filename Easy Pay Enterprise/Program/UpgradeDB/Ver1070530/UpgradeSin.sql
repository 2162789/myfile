Read UpgradeDB\Ver1070530\AllScript.sql;
Read UpgradeDB\Ver1070530\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070530, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;