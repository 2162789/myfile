Read UpgradeDB\Ver1070301\AllScript.sql;
Read UpgradeDB\Ver1070301\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070301, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;