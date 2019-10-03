Read upgradeDB\Ver1010005\Entity.sql;
Read upgradeDB\Ver1010005\MYScript.sql;
Read upgradeDB\Ver1010005\MYStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010005, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;