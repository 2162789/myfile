Read upgradeDB\Ver1010006\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010006, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;