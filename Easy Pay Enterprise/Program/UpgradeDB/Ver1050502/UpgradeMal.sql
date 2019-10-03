READ UpgradeDB\Ver1050502\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050502, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;