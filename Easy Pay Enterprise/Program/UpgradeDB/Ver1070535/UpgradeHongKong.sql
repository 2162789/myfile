Read UpgradeDB\Ver1070535\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070535, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;