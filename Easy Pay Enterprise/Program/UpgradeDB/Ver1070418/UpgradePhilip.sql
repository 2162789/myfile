Read UpgradeDB\Ver1070418\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070418, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;