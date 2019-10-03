Read UpgradeDB\Ver1070006\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070006, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;