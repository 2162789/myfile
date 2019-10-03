Read upgradeDB\Ver1000007\AllStoredProc.sql;
Read upgradeDB\Ver1000007\Entity.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000007, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;