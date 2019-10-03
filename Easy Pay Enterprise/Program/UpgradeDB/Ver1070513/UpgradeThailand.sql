Read UpgradeDB\Ver1070513\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070513, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;