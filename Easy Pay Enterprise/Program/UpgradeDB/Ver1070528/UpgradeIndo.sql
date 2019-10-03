Read UpgradeDB\Ver1070528\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070528, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;