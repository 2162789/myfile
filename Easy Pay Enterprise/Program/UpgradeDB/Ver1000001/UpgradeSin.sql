READ UpgradeDB\Ver1000001\Entity.sql;
READ UpgradeDB\Ver1000001\CommonStoredProc.sql;
READ UpgradeDB\Ver1000001\CommonData.sql;
READ UpgradeDB\Ver1000001\AllScript.sql;
READ UpgradeDB\Ver1000001\SgData.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1000001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;