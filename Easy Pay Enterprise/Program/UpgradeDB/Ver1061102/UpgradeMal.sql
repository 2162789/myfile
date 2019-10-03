Read UpgradeDB\Ver1061102\AllScript.sql;
Read UpgradeDB\Ver1061102\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061102, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;