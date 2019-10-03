Read UpgradeDB\Ver1070529\AllScript.sql;
Read UpgradeDB\Ver1070529\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070529, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;