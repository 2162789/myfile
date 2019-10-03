Read UpgradeDB\Ver1070544\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070544, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;