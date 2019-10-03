Read UpgradeDB\Ver1070502\AllScript.sql;
Read UpgradeDB\Ver1070502\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070502, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;