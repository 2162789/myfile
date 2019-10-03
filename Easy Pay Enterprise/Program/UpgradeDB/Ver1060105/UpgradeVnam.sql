READ UpgradeDB\Ver1060105\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060105, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;