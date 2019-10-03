READ UpgradeDB\Ver1060102\AllScript.sql;
READ UpgradeDB\Ver1060102\BNStoredPro.sql;
READ UpgradeDB\Ver1060102\BNSCP.sql;
READ UpgradeDB\Ver1060102\AnalysisSystemAttribute.sql;
READ UpgradeDB\Ver1060102\AnItemLookup.sql;
READ UpgradeDB\Ver1060102\AnlysDispSection.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060102, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;