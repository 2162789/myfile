Read upgradeDB\Ver1010002\Entity.sql;
Read upgradeDB\Ver1010002\AllStoredProc.sql;
Read upgradeDB\Ver1010002\PhStoredProc.sql;
Read upgradeDB\Ver1010002\PhScript.sql;
Read upgradeDB\Ver1010002\PhData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010002, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;