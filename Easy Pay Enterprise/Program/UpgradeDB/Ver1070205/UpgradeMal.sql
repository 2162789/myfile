Read UpgradeDB\Ver1070205\AllScript.sql;
Read UpgradeDB\Ver1070205\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070205, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;