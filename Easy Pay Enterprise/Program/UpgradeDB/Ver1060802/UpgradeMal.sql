READ UpgradeDB\Ver1060802\MYScript.sql;
UPDATE "DBA"."subRegistry" SET IntegerAttr=1060802, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;