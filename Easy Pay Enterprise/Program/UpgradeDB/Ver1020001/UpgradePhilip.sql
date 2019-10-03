READ UpgradeDB\Ver1020001\PHScript.sql;
READ UpgradeDB\Ver1020001\PHStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;