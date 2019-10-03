Read UpgradeDB\Ver1070410\AllScript.sql;
Read UpgradeDB\Ver1070410\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070410, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;