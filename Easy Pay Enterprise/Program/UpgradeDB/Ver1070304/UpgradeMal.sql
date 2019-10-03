Read UpgradeDB\Ver1070304\AllScript.sql;
Read UpgradeDB\Ver1070304\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070304, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;