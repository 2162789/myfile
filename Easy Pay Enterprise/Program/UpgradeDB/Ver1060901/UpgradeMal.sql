READ UpgradeDB\Ver1060901\AllScript.sql;
READ UpgradeDB\Ver1060901\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060901, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;