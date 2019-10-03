READ UpgradeDB\Ver1060304\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060304, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;