READ UpgradeDB\Ver1000005\AllStoredProc.sql;
READ UpgradeDB\Ver1000005\AllScript.sql;
READ UpgradeDB\Ver1000005\PHScript.sql;
READ UpgradeDB\Ver1000005\AllData.sql;
READ UpgradeDB\Ver1000005\PHData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000005, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;