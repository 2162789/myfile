READ UpgradeDB\Ver1020101\MYStoredProc.sql;
READ UpgradeDB\Ver1020101\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020101, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;