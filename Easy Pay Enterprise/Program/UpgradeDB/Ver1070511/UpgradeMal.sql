Read UpgradeDB\Ver1070511\AllScript.sql;
Read UpgradeDB\Ver1070511\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070511, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;