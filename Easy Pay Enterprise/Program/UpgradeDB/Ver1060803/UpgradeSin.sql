READ UpgradeDB\Ver1060803\AllScript.sql;
READ UpgradeDB\Ver1060803\SGStoredProc.sql;
READ UpgradeDB\Ver1060803\SurveyKeyword.sql;
READ UpgradeDB\Ver1060803\SurveyRegistry.sql;
READ UpgradeDB\Ver1060803\SurveySetup.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060803, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;