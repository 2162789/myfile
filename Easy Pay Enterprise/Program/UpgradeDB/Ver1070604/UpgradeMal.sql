Read UpgradeDB\Ver1070604\AllScript.sql;
Read UpgradeDB\Ver1070604\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070604, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;