READ UpgradeDB\Ver1030103\Entity.sql;
READ UpgradeDB\Ver1030103\AllStoredProc.sql;
READ UpgradeDB\Ver1030103\AllData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030103, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;