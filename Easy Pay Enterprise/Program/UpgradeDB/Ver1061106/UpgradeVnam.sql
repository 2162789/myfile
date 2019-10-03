Read UpgradeDB\Ver1061106\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061106, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;