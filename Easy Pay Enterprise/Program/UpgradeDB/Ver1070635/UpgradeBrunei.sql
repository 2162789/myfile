Read UpgradeDB\Ver1070635\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070635, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;