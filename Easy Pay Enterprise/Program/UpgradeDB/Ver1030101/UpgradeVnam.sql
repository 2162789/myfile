READ UpgradeDB\Ver1030101\AllStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030101, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;