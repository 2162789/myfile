Read UpgradeDB\Ver1070633\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070633, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;