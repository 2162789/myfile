READ UpgradeDB\Ver1060903\AllScript.sql;
READ UpgradeDB\Ver1060903\SGScript.sql;


UPDATE "DBA"."subRegistry" SET IntegerAttr=1060903, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;