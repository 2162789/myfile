READ UpgradeDB\Ver1050812\AllScript.sql;
READ UpgradeDB\Ver1050812\StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050812, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;