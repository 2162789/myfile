Read UpgradeDB\Ver1061101\AllScript.sql;
Read UpgradeDB\Ver1061101\IDScript.sql; 

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061101, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;