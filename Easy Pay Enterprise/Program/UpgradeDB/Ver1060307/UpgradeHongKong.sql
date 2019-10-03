READ UpgradeDB\Ver1060307\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060307, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;