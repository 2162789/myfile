READ UpgradeDB\Ver1000003\AllScript.sql;
READ UpgradeDB\Ver1000003\SGScript.sql;
READ UpgradeDB\Ver1000003\SGStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;