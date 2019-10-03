Read upgradeDB\Ver1000012\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000012, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;