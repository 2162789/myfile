READ UpgradeDB\Ver1060807\AllScript.sql;
READ UpgradeDB\Ver1060807\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060807, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;