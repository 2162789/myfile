Read UpgradeDB\Ver1061002\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061002, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;