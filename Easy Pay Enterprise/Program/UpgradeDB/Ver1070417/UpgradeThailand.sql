Read UpgradeDB\Ver1070417\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070417, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;