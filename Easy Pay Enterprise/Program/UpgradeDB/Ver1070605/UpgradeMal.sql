Read UpgradeDB\Ver1070605\AllScript.sql;
Read UpgradeDB\Ver1070605\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070605, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;