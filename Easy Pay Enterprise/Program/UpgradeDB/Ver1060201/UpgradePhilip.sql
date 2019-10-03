READ UpgradeDB\Ver1060201\Entity.sql;
READ UpgradeDB\Ver1060201\StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060201, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;