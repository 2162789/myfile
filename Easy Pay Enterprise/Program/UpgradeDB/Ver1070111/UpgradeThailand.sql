Read UpgradeDB\Ver1070111\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070111, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;