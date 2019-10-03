READ UpgradeDB\Ver1030001\Entity.sql;
READ UpgradeDB\Ver1030001\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;