READ UpgradeDB\Ver1020003\Entity.sql;
READ UpgradeDB\Ver1020003\MYScript.sql;
READ UpgradeDB\Ver1020003\MYStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;