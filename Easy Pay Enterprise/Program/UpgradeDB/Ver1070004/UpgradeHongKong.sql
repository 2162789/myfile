Read UpgradeDB\Ver1070004\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070004, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;