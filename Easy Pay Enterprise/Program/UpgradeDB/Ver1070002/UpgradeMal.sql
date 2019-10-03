Read UpgradeDB\Ver1070002\AllScript.sql;
Read UpgradeDB\Ver1070002\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070002, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;