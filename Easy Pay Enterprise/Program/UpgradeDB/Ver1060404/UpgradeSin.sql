READ UpgradeDB\Ver1060404\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060404, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;