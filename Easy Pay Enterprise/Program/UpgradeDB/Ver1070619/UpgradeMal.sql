Read UpgradeDB\Ver1070619\AllScript.sql;
Read UpgradeDB\Ver1070619\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070619, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;