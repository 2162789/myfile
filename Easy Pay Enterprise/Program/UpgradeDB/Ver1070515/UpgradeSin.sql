Read UpgradeDB\Ver1070515\AllScript.sql;
Read UpgradeDB\Ver1070515\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070515, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;