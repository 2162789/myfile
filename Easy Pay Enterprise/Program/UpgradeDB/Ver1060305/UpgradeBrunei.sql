READ UpgradeDB\Ver1060305\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060305, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;