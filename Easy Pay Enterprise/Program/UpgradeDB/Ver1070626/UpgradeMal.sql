Read UpgradeDB\Ver1070626\AllScript.sql;
Read UpgradeDB\Ver1070626\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070626, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;