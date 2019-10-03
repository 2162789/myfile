Read UpgradeDB\Ver1070546\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070546, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;