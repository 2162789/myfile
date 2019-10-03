Read UpgradeDB\Ver1070602\AllScript.sql;
Read UpgradeDB\Ver1070602\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070602, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;