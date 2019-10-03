READ UpgradeDB\Ver1060309\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060309, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;