Read UpgradeDB\Ver1070508\AllScript.sql;
Read UpgradeDB\Ver1070508\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070508, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;