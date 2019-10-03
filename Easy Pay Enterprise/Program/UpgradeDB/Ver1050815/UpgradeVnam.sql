READ UpgradeDB\Ver1050815\AllScript.sql;
READ UpgradeDB\Ver1050815\StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050815, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;