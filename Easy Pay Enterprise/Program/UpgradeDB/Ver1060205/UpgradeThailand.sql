READ UpgradeDB\Ver1060205\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060205, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;