Read upgradeDB\Ver1000011\AllScript.sql;
Read upgradeDB\Ver1000011\AllData.sql;
Read upgradeDB\Ver1000011\AllStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000011, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;