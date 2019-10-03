Read UpgradeDB\Ver1070506\AllScript.sql;
Read UpgradeDB\Ver1070506\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070506, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;