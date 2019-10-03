Read UpgradeDB\Ver1070511\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070511, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;