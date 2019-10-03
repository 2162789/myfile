READ UpgradeDB\Ver1060402\CPF2012Sep.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060402, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;