Read UpgradeDB\Ver1070309\AllScript.sql;
Read UpgradeDB\Ver1070309\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070309, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;