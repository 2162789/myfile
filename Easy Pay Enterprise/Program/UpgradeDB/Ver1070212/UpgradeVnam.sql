Read UpgradeDB\Ver1070212\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070212, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;