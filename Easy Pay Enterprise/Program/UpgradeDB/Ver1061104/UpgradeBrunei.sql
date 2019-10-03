Read UpgradeDB\Ver1061104\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061104, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;