Read UpgradeDB\Ver1070617\AllScript.sql;
Read UpgradeDB\Ver1070617\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070617, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;