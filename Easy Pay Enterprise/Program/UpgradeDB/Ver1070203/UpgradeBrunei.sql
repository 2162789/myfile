Read UpgradeDB\Ver1070203\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070203, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;