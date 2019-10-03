Read UpgradeDB\Ver1070412\AllScript.sql;
Read UpgradeDB\Ver1070412\2019ID_PH.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070412, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;