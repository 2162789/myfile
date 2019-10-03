Read UpgradeDB\Ver1070204\AllScript.sql;
Read UpgradeDB\Ver1070204\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070204, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;