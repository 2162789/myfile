Read upgradeDB\Ver1010003\AllStoredProc.sql;
Read upgradeDB\Ver1010003\PHStoredProc.sql;
Read upgradeDB\Ver1010003\PhScript.sql;
Read upgradeDB\Ver1010003\PhData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;