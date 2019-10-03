Read UpgradeDB\Ver1070540\AllScript.sql;
Read UpgradeDB\Ver1070540\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070540, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;