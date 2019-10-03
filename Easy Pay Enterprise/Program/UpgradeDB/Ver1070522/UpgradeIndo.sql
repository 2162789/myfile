Read UpgradeDB\Ver1070522\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070522, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;