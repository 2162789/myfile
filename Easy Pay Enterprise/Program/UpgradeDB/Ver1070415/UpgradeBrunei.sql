Read UpgradeDB\Ver1070415\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070415, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;