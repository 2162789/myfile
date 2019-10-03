READ UpgradeDB\Ver1060707\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060707, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;