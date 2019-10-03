READ UpgradeDB\Ver1060001\AllScript.sql;
READ UpgradeDB\Ver1060001\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;