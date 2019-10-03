Read UpgradeDB\Ver1070538\AllScript.sql;
Read UpgradeDB\Ver1070538\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070538, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;