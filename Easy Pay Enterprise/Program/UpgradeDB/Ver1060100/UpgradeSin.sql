READ UpgradeDB\Ver1060100\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060100, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;