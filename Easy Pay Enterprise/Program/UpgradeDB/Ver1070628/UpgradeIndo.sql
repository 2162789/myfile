Read UpgradeDB\Ver1070628\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070628, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;