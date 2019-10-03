READ UpgradeDB\Ver1060403\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060403, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;