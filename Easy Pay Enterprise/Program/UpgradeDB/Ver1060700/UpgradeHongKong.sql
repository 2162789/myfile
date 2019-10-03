READ UpgradeDB\Ver1060700\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060700, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;