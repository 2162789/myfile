Read upgradeDB\Ver1010004\Entity.sql;
Read upgradeDB\Ver1010004\AllView.sql;
Read upgradeDB\Ver1010004\AllScript.sql;
Read upgradeDB\Ver1010004\AllData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1010004, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;