Read upgradeDB\Ver1020000\ALLStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020000, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;