Read UpgradeDB\Ver1070202\AllScript.sql;
Read UpgradeDB\Ver1070202\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070202, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;