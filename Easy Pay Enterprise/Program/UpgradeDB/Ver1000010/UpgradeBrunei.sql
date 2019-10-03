Read upgradeDB\Ver1000010\CommonData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000010, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;