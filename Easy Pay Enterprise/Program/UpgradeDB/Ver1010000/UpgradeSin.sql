Read upgradeDB\Ver1010000\AllScript.sql;
Read upgradeDB\Ver1010000\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010000, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;