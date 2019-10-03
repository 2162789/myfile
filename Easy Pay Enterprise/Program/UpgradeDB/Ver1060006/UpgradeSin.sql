READ UpgradeDB\Ver1060006\AllScript.sql;
READ UpgradeDB\Ver1060006\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060006, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;