Read UpgradeDB\Ver1061001\AllScript.sql;
Read UpgradeDB\Ver1061001\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;