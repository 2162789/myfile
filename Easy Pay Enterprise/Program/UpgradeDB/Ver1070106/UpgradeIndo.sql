Read UpgradeDB\Ver1070106\AllScript.sql;
Read UpgradeDB\Ver1070106\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070106, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;