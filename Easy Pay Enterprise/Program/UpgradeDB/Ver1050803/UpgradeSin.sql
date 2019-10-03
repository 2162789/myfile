Read UpgradeDB\Ver1050803\Entity.sql;
Read UpgradeDB\Ver1050803\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050803, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;