Read UpgradeDB\Ver1070100\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070100, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;