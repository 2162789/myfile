READ UpgradeDB\Ver1030108\SGScriptPart1.sql;
READ UpgradeDB\Ver1030108\SGScriptPart2.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030108, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;