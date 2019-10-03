READ UpgradeDB\Ver1020002\PHStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020002, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;