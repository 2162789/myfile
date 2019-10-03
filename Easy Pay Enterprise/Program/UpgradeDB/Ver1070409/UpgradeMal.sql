Read UpgradeDB\Ver1070409\AllScript.sql;
Read UpgradeDB\Ver1070409\MYScript.sql;
Read UpgradeDB\Ver1070409\2019MY_PH.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070409, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;