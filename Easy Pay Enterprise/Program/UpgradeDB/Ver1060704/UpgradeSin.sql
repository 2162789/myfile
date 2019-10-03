READ UpgradeDB\Ver1060704\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060704, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;