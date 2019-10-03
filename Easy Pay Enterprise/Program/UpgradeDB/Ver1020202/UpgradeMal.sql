READ UpgradeDB\Ver1020202\AllData.sql;
READ UpgradeDB\Ver1020202\AllStoredProc.sql;
READ UpgradeDB\Ver1020202\MYScript.sql;
READ UpgradeDB\Ver1020202\MYData.sql;
READ UpgradeDB\Ver1020202\MYStoredProc.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020202, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;