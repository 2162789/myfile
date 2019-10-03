READ UpgradeDB\Ver1060500\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060500, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;