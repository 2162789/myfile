Read UpgradeDB\Ver1070631\AllScript.sql;
Read UpgradeDB\Ver1070631\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070631, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;