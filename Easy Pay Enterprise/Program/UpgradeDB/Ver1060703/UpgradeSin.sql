READ UpgradeDB\Ver1060703\SGScript.sql;
READ UpgradeDB\Ver1060703\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060703, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;