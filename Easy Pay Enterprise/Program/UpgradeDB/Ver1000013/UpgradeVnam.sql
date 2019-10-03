Read upgradeDB\Ver1000013\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000013, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;