Read UpgradeDB\Ver1020206\Entity.sql;
READ UpgradeDB\Ver1020206\AllScript.sql;
READ UpgradeDB\Ver1020206\AllStoredProc.sql;
READ UpgradeDB\Ver1020206\AllData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020206, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;