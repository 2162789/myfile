Read upgradeDB\Ver1020000\ALLStoredProc.sql;
Read upgradeDB\Ver1020000\MYStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020000, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;