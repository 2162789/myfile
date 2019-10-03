Read upgradeDB\Ver1000006\AllStoredProc.sql;
Read upgradeDB\Ver1000006\AllScript.sql;
Read upgradeDB\Ver1000006\AllData.sql;
READ UpgradeDB\Ver1000006\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000006, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;