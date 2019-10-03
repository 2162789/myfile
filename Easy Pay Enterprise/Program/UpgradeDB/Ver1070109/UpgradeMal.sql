Read UpgradeDB\Ver1070109\AllScript.sql;
Read UpgradeDB\Ver1070109\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070109, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;