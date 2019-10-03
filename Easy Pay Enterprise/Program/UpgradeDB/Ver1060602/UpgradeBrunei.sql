READ UpgradeDB\Ver1060602\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060602, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;