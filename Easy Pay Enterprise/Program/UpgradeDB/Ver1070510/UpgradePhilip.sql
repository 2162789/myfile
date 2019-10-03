Read UpgradeDB\Ver1070510\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070510, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;