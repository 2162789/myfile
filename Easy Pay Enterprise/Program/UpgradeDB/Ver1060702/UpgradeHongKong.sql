READ UpgradeDB\Ver1060702\StoredProc.sql;
READ UpgradeDB\Ver1060702\2013NovMPFRate.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060702, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;