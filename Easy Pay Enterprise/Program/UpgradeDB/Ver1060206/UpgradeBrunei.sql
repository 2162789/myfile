READ UpgradeDB\Ver1060206\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr= 1060206, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;