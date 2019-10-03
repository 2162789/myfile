READ UpgradeDB\Ver1060604\AllScript.sql;
READ UpgradeDB\Ver1060604\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060604, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;