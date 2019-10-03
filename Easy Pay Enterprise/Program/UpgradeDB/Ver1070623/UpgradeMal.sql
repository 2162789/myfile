Read UpgradeDB\Ver1070623\AllScript.sql;
Read UpgradeDB\Ver1070623\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070623, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;