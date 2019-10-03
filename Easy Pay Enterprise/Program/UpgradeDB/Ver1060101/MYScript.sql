/* SystemRpt */
IF NOT EXISTS(SELECT * FROM SystemRpt WHERE SysRptId = 'EA Form') THEN
  INSERT INTO SystemRpt(SysRptId,SysRptName,SysRptModule,SysRptSubModule,SysRptAvailSummLevel)
  Values('EA Form','EA Form','Payroll','Pay','RptSummEmployee');
END IF;

/* SystemRptComp */
IF NOT EXISTS(SELECT * FROM SystemRptComp WHERE SysRptId = 'EA Form') THEN  
  INSERT INTO SystemRptComp Values('EA Form','Year_wwDBLookupCombo','Year','AnsiString',1,NULL);
  INSERT INTO SystemRptComp Values('EA Form','SortBy_ComboBox','Sort by','ItemIndex',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','SalaryRangeFrom_Edit','From','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','SalaryRangeTo_Edit','To','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','Last2Year_CheckBox','To show declared in XXXX','int',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','IncludeZeroAmount_CheckBox','Include zero amount','int',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','PrintPrePrintedForm_CheckBox','Print pre-printed form','int',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','CLHDMN_CheckBox','Cawangan LHDNM Visible','int',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','IncludedSocso_CheckBox','Include Socso Amount','int',0,NULL);
  INSERT INTO SystemRptComp Values('EA Form','EAStatus_CheckBox','New Format','int',0,NULL);
END IF;

/* RptConfig */
IF NOT EXISTS(SELECT * FROM RptConfig WHERE RptConfigId = '_EA Form') THEN
  INSERT INTO RptConfig(RptConfigId,SysRptId,UserId,RptConfigDesc,IsDefaultConfig,RptQueryId,RptFileType,DelBefIns,RptSummaryLevel,IsIndividualRpt,RptOutputTo,RptFilePath)
  Values('_EA Form','EA Form',NULL,'EA Form',1,'','RptFilePDF',1,'RptSummEmployee',1,'RptOpToFile','');
END IF;

/* RptCompConfig */
IF NOT EXISTS(SELECT * FROM RptCompConfig WHERE RptCompSysId IN ('Sys_113','Sys_114','Sys_115','Sys_116','Sys_117','Sys_118','Sys_119','Sys_120','Sys_121','Sys_122')) THEN
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_113','_EA Form','EA Form','Year_wwDBLookupCombo');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_114','_EA Form','EA Form','SortBy_ComboBox');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_115','_EA Form','EA Form','SalaryRangeFrom_Edit');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_116','_EA Form','EA Form','SalaryRangeTo_Edit');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_117','_EA Form','EA Form','Last2Year_CheckBox');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_118','_EA Form','EA Form','IncludeZeroAmount_CheckBox');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_119','_EA Form','EA Form','PrintPrePrintedForm_CheckBox');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_120','_EA Form','EA Form','CLHDMN_CheckBox');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_121','_EA Form','EA Form','IncludedSocso_CheckBox');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_122','_EA Form','EA Form','EAStatus_CheckBox');
END IF;

/* RptCompItemConfig */
IF NOT EXISTS(SELECT * FROM RptCompItemConfig WHERE RptCompSysId IN('Sys_113','Sys_114','Sys_115','Sys_116','Sys_117','Sys_118','Sys_119','Sys_120','Sys_121','Sys_122')) THEN
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_113','1','2011');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_114','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_115','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_116','1','999999999');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_117','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_118','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_119','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_120','1','1');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_121','1','1');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_122','1','0');
END IF;

COMMIT WORK;