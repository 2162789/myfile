Read UpgradeDB\Ver1070500\AllScript.sql;
Read UpgradeDB\Ver1070500\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070500, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;