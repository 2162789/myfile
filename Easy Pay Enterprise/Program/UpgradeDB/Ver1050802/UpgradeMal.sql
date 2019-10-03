Read UpgradeDB\Ver1050802\Entity.sql;
Read UpgradeDB\Ver1050802\AllScript.sql;
Read UpgradeDB\Ver1050802\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050802, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;