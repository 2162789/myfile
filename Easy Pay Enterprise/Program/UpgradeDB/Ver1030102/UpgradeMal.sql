READ UpgradeDB\Ver1030102\Entity.sql;
READ UpgradeDB\Ver1030102\AllStoredProc.sql;
READ UpgradeDB\Ver1030102\AllScript.sql;
READ UpgradeDB\Ver1030102\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030102, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;