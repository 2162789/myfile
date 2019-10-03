Read UpgradeDB\Ver1070609\AllScript.sql;
Read UpgradeDB\Ver1070609\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070609, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;