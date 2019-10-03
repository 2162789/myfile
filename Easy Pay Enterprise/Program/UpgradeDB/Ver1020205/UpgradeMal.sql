READ UpgradeDB\Ver1020205\AllScript.sql;
READ UpgradeDB\Ver1020205\AllStoredProc.sql;
READ UpgradeDB\Ver1020205\MYStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020205, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;