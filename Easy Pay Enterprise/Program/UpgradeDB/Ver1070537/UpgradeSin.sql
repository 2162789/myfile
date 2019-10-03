Read UpgradeDB\Ver1070537\AllScript.sql;
Read UpgradeDB\Ver1070537\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070537, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;