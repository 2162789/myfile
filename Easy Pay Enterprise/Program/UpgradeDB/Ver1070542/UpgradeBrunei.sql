Read UpgradeDB\Ver1070542\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070542, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;