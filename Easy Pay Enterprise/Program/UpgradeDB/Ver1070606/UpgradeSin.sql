Read UpgradeDB\Ver1070606\AllScript.sql;
Read UpgradeDB\Ver1070606\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070606, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;