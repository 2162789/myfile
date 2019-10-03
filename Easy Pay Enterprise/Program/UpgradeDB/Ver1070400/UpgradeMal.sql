Read UpgradeDB\Ver1070400\AllScript.sql;
Read UpgradeDB\Ver1070400\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070400, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;