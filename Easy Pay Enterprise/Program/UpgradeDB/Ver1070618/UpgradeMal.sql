Read UpgradeDB\Ver1070618\AllScript.sql;
Read UpgradeDB\Ver1070618\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070618, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;