Read UpgradeDB\Ver1070607\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070607, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;