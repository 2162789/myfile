Read UpgradeDB\Ver1070102\AllScript.sql;
Read UpgradeDB\Ver1070102\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070102, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;



