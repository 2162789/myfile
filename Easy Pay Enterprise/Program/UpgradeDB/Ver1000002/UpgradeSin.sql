READ UpgradeDB\Ver1000002\CommonStoredProc.sql;
READ UpgradeDB\Ver1000002\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000002, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;