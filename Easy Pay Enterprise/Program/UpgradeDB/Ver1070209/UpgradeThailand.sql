Read UpgradeDB\Ver1070209\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070209, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;