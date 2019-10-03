READ UpgradeDB\Ver1030105\AllScript.sql;
READ UpgradeDB\Ver1030105\AllStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030105, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;