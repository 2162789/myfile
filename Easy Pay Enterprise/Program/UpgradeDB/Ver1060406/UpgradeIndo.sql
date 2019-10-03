READ UpgradeDB\Ver1060406\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060406, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;