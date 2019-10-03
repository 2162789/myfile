Read UpgradeDB\Ver1070624\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070624, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;