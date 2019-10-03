READ UpgradeDB\Ver1000005\AllStoredProc.sql;
READ UpgradeDB\Ver1000005\AllScript.sql;
READ UpgradeDB\Ver1000005\THScript.sql;
READ UpgradeDB\Ver1000005\THData.sql;
READ UpgradeDB\Ver1000005\AllData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000005, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;