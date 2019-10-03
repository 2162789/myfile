Read UpgradeDB\Ver1050506\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050506, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;