Read UpgradeDB\Ver1061207\SG_2016JulyFWL.sql;
Read UpgradeDB\Ver1061207\SGScript.sql;
UPDATE "DBA"."subRegistry" SET IntegerAttr=1061207, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;