Read UpgradeDB\Ver1070527\AllScript.sql;
Read UpgradeDB\Ver1070527\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070527, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;