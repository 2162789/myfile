Read UpgradeDB\Ver1070406\AllScript.sql;
Read UpgradeDB\Ver1070406\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070406, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;