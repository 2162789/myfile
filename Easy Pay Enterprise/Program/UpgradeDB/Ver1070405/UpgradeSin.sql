Read UpgradeDB\Ver1070405\AllScript.sql;
Read UpgradeDB\Ver1070405\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070405, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;