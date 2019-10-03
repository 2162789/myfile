Read UpgradeDB\Ver1070402\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070402, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;