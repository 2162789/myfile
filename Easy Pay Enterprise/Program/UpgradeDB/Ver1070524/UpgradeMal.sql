Read UpgradeDB\Ver1070524\AllScript.sql;
Read UpgradeDB\Ver1070524\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070524, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;