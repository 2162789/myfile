READ UpgradeDB\Ver1020202\AllData.sql;
READ UpgradeDB\Ver1020202\AllStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020202, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;