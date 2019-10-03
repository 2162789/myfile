READ UpgradeDB\Ver1050503\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050503, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;