Read UpgradeDB\Ver1070504\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070504, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;