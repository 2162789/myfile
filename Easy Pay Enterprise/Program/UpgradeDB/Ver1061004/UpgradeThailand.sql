Read UpgradeDB\Ver1061004\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061004, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;