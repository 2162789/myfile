Read upgradeDB\Ver1010003\AllStoredProc.sql;
Read upgradeDB\Ver1010003\MYStoredProc.sql;
Read upgradeDB\Ver1010003\MYData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;