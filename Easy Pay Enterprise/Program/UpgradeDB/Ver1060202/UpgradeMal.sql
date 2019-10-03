READ UpgradeDB\Ver1060202\StoredProc.sql;

READ UpgradeDB\Ver1060202\MY_StoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060202, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;