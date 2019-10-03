Read UpgradeDB\Ver1050701\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050701, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;