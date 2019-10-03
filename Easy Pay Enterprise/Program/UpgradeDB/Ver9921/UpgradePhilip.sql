Read upgradeDB\Ver9921\CommonStoreProc.sql;
Read upgradeDB\Ver9921\PhilSpecial.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9921, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;