READ UpgradeDB\Ver1060006\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060006, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;