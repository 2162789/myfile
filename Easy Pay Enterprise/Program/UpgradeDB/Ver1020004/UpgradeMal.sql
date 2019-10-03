READ UpgradeDB\Ver1020004\AllStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020004, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;