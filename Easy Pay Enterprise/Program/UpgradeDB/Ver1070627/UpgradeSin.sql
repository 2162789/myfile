Read UpgradeDB\Ver1070627\AllScript.sql;
Read UpgradeDB\Ver1070627\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070627, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;