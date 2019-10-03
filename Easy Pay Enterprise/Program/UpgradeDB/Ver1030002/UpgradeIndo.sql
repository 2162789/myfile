READ UpgradeDB\Ver1030002\AllStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030002, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;