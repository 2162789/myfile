Read UpgradeDB\Ver1070108\AllScript.sql;
Read UpgradeDB\Ver1070108\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070108, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;