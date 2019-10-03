Read upgradeDB\Ver1010001\entity.sql;
Read upgradeDB\Ver1010001\AllScript.sql;
Read upgradeDB\Ver1010001\AllStoredProc.sql;
Read upgradeDB\Ver1010001\AllData.sql;
Read upgradeDB\Ver1010001\MYStoredProc.sql;
Read upgradeDB\Ver1010001\MYScript.sql;
Read upgradeDB\Ver1010001\MYData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;