Read UpgradeDB\Ver1070505\AllScript.sql;
Read UpgradeDB\Ver1070505\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070505, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;