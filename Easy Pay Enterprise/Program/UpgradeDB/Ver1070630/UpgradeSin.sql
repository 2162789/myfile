Read UpgradeDB\Ver1070630\AllScript.sql;
Read UpgradeDB\Ver1070630\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070630, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;