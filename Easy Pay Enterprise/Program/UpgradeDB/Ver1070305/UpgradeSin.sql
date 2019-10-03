Read UpgradeDB\Ver1070305\AllScript.sql;
Read UpgradeDB\Ver1070305\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070305, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;