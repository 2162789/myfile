READ UpgradeDB\Ver1060501\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060501, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;