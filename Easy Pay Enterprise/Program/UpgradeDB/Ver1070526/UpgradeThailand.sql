Read UpgradeDB\Ver1070526\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070526, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;