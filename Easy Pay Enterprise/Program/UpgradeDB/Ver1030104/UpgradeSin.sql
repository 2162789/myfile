READ UpgradeDB\Ver1030104\AllScriptPart1.sql;
READ UpgradeDB\Ver1030104\AllScriptPart2.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030104, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;