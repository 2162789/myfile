Read UpgradeDB\Ver1070112\AllScript.sql;
Read UpgradeDB\Ver1070112\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070112, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;