Read UpgradeDB\Ver1070536\AllScript.sql;
Read UpgradeDB\Ver1070536\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070536, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;