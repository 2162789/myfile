Read UpgradeDB\Ver1070416\AllScript.sql;
Read UpgradeDB\Ver1070416\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070416, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;