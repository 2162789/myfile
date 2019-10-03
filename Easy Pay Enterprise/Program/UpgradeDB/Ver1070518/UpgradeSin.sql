Read UpgradeDB\Ver1070518\AllScript.sql;
Read UpgradeDB\Ver1070518\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070518, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;