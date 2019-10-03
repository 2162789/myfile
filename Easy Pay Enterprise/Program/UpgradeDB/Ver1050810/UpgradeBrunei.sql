READ UpgradeDB\Ver1050810\Entity.sql;
READ UpgradeDB\Ver1050810\StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050810, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;