Read UpgradeDB\Ver1070501\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070501, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;