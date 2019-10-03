READ UpgradeDB\Ver1060203\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr= 1060203, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;