Read UpgradeDB\Ver1070310\AllScript.sql;
Read UpgradeDB\Ver1070310\BNScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070310, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;