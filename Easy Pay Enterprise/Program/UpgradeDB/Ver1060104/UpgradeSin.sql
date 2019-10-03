READ UpgradeDB\Ver1060104\AllScript.sql;
READ UpgradeDB\Ver1060104\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060104, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;