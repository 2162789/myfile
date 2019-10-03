Read UpgradeDB\Ver1070700\AllScript.sql;
Read UpgradeDB\Ver1070700\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070700, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;