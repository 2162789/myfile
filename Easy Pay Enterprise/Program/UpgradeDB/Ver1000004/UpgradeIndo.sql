READ UpgradeDB\Ver1000004\Entity.sql;
READ UpgradeDB\Ver1000004\AllStoredProc.sql;
READ UpgradeDB\Ver1000004\AllScript.sql;
READ UpgradeDB\Ver1000004\AllData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000004, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;