READ UpgradeDB\Ver1060705\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060705, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;