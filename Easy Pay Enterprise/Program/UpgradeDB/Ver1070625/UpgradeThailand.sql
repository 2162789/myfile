Read UpgradeDB\Ver1070625\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070625, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;