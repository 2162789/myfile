Read UpgradeDB\Ver1070211\AllScript.sql;
Read UpgradeDB\Ver1070211\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070211, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;