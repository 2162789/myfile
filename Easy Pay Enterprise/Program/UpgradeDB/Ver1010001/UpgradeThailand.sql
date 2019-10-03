Read upgradeDB\Ver1010001\entity.sql;
Read upgradeDB\Ver1010001\AllScript.sql;
Read upgradeDB\Ver1010001\AllStoredProc.sql;
Read upgradeDB\Ver1010001\AllData.sql;
Read upgradeDB\Ver1010001\THData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;