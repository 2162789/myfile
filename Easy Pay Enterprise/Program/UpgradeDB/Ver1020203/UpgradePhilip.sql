READ UpgradeDB\Ver1020203\AllScript.sql;
READ UpgradeDB\Ver1020203\AllTriggers.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020203, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;