Read UpgradeDB\Ver1070200\AllScript.sql;
Read UpgradeDB\Ver1070200\IDScript.sql;
UPDATE "DBA"."subRegistry" SET IntegerAttr=1070200, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;