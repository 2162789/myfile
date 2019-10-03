Read UpgradeDB\Ver1070003\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070003, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;