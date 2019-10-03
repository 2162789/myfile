READ UpgradeDB\Ver1000003\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;