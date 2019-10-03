Read UpgradeDB\Ver1070545\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070545, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;