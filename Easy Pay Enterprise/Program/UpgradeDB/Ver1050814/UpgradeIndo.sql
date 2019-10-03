READ UpgradeDB\Ver1050814\AllScript.sql;
READ UpgradeDB\Ver1050814\StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050814, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;