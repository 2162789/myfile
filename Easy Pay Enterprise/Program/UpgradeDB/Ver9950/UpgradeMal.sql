READ UpgradeDB\Ver9950\Entity.sql;
READ UpgradeDB\Ver9950\CommonStoredProc.sql;
READ UpgradeDB\Ver9950\AllScript.sql;
READ UpgradeDB\Ver9950\MYStoredProc.sql;
READ UpgradeDB\Ver9950\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9950, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;