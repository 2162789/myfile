Read UpgradeDB\Ver1070613\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070613, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;