Read UpgradeDB\Ver1061203\IDStoredProc.sql;
Read UpgradeDB\Ver1061203\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061203, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;