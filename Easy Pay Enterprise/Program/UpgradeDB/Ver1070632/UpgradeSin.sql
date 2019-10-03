Read UpgradeDB\Ver1070632\AllScript.sql;
Read UpgradeDB\Ver1070632\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070632, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;