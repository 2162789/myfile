READ UpgradeDB\Ver1050811\ReportExport_Update.sql;

READ UpgradeDB\Ver1050811\TmplFolder.sql;
READ UpgradeDB\Ver1050811\TmplFolderSample.sql;
READ UpgradeDB\Ver1050811\TmplQuery.sql;
READ UpgradeDB\Ver1050811\TmplMember.sql;
READ UpgradeDB\Ver1050811\TmplSearch.sql;
READ UpgradeDB\Ver1050811\TmplTable.sql;
READ UpgradeDB\Ver1050811\TmplAttribute.sql;
READ UpgradeDB\Ver1050811\TmplRelation.sql;
READ UpgradeDB\Ver1050811\TmplVariables.sql;
READ UpgradeDB\Ver1050811\SystemFunction.sql;

READ UpgradeDB\Ver1050811\QueryFolder.sql;
READ UpgradeDB\Ver1050811\CustomVariables.sql;
READ UpgradeDB\Ver1050811\CustomQuery.sql;
READ UpgradeDB\Ver1050811\CustomTable.sql;
READ UpgradeDB\Ver1050811\CustomAttribute.sql;
READ UpgradeDB\Ver1050811\CustomSearch.sql;
READ UpgradeDB\Ver1050811\CustomRelation.sql;

READ UpgradeDB\Ver1050811\ReportExport.sql;
READ UpgradeDB\Ver1050811\ReportAccess.sql;


IF NOT EXISTS (SELECT 1 FROM SubRegistry WHERE RegistryId = 'AccpacVersion' AND SubRegistryId = '60A') THEN
  INSERT INTO SubRegistry VALUES ('AccpacVersion','60A','6.0A','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
END IF;

IF NOT EXISTS (SELECT 1 FROM Keyword WHERE KeywordId = 'EX_KeyCostCentre') THEN
  INSERT INTO Keyword VALUES ('EX_KeyCostCentre','Key Cost Centre','Key Cost Centre','EXPORT',0,0,0,'KeyCostCentreID',247,5,0,'');
END IF;

IF NOT EXISTS (SELECT 1 FROM Keyword WHERE KeywordId = 'EX_KeyCostCentreDesc') THEN
  INSERT INTO Keyword VALUES ('EX_KeyCostCentreDesc','Key Cost Centre Desc','Key Cost Centre Desc','EXPORT',0,0,0,'KeyCostCentreDesc',248,5,0,'');
END IF;


COMMIT WORK;