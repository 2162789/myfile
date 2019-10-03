READ UpgradeDB\Ver1060105\AllScript.sql;
READ UpgradeDB\Ver1060105\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060105, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;