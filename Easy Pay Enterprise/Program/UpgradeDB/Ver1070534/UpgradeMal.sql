Read UpgradeDB\Ver1070534\AllScript.sql;
Read UpgradeDB\Ver1070534\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070534, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;