Read UpgradeDB\Ver1070103\AllScript.sql;
Read UpgradeDB\Ver1070103\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070103, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;