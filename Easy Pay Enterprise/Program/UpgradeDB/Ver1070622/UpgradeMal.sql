Read UpgradeDB\Ver1070622\AllScript.sql;
Read UpgradeDB\Ver1070622\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070622, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;