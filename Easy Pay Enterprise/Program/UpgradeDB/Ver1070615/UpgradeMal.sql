Read UpgradeDB\Ver1070615\AllScript.sql;
Read UpgradeDB\Ver1070615\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070615, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;