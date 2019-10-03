Read UpgradeDB\Ver1070504\AllScript.sql;
Read UpgradeDB\Ver1070504\MYScript.sql;
Read UpgradeDB\Ver1070504\MY_SOCSO2019Jan.sql;
Read UpgradeDB\Ver1070504\MYEPF2019.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070504, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;