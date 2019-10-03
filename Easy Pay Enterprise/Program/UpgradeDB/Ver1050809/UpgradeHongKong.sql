READ UpgradeDB\Ver1050809\Entity.sql;
READ UpgradeDB\Ver1050809\StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050809, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;