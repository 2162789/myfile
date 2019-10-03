Read upgradeDB\Ver9920\SingaporeStoreProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9920, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;