Read UpgradeDB\Ver1070533\AllScript.sql;
Read UpgradeDB\Ver1070533\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070533, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;