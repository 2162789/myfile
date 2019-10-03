Read UpgradeDB\Ver1070105\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070105, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;