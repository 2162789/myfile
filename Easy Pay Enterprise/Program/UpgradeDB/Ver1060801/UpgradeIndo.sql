READ UpgradeDB\Ver1060801\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060801, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;