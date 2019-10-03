Read UpgradeDB\Ver1070616\AllScript.sql;
Read UpgradeDB\Ver1070616\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070616, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;