Read UpgradeDB\Ver1070519\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070519, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;