READ UpgradeDB\Ver1060301\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060301, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;