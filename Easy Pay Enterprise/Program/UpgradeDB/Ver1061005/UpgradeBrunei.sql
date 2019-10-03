Read UpgradeDB\Ver1061005\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061005, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;