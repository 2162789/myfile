Read UpgradeDB\Ver1070207\AllScript.sql;
Read UpgradeDB\Ver1070207\2018BN_PH.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070207, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;