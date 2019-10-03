READ UpgradeDB\Ver1060106\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060106, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;