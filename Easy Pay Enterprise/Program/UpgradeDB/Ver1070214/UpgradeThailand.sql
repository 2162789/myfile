Read UpgradeDB\Ver1070214\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070214, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;