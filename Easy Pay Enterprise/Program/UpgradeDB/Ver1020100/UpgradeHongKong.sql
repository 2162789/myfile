READ UpgradeDB\Ver1020100\AllStoredProc.sql;
READ UpgradeDB\Ver1020100\AllScript.sql;
READ UpgradeDB\Ver1020100\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020100, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;