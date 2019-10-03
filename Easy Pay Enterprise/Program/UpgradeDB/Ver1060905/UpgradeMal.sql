READ UpgradeDB\Ver1060905\AllScript.sql;
READ UpgradeDB\Ver1060905\MYScript.sql;


UPDATE "DBA"."subRegistry" SET IntegerAttr=1060905, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;