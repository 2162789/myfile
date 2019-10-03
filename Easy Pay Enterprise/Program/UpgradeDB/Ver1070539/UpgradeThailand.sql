Read UpgradeDB\Ver1070539\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070539, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;