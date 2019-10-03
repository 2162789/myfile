if exists (select 1 from sys.syscolumns where tname='iExcelWkSheetItem' and cname='WhSheetSysId') then
   ALTER TABLE iExcelWkSheetItem RENAME WhSheetSysId TO WkSheetSysId; 
end if;


/* SystemRpt */
IF NOT EXISTS(SELECT * FROM SystemRpt WHERE SysRptId = 'Statistics Report') THEN
  INSERT INTO SystemRpt(SysRptId,SysRptName,SysRptModule,SysRptSubModule,SysRptAvailSummLevel)
  Values('Statistics Report','Statistics Report','Payroll','Pay','RptSummEmployee');
END IF;

/* SystemRptComp */
IF NOT EXISTS(SELECT * FROM SystemRptComp WHERE SysRptId = 'Statistics Report') THEN  
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_SortBy','Sort By','ItemIndex',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','RadioGroup_RptFormat','Report Format','ItemIndex',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','Customised_wwDBLookupCombo','Customised','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','CheckBox_PageBreak','Page Break','int',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_Year_From','From Year','AnsiString',1,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_Period_From','From Period','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_Year_To','To Year','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_Period_To','To Period','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_SubPeriod','Sub Period','AnsiString',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','PayRec_RadioGroup','Pay Record Type/ ID','int',0,NULL);
  INSERT INTO SystemRptComp Values('Statistics Report','ComboBox_PayRecType','Pay Record Type','AnsiString',0,NULL);
END IF;

/* RptConfig */
IF NOT EXISTS(SELECT * FROM RptConfig WHERE RptConfigId = '_Statistics Report') THEN
  INSERT INTO RptConfig(RptConfigId,UserId,SysRptId,RptConfigDesc,IsDefaultConfig,RptQueryId,RptFileType,DelBefIns,RptSummaryLevel,IsIndividualRpt,RptOutputTo,RptFilePath)
  Values('_Statistics Report',NULL,'Statistics Report','Statistics Report',1,'','RptFilePDF',1,'RptSummEmployee',1,'RptOpToFile','');
END IF;

/* RptCompConfig */
IF NOT EXISTS(SELECT * FROM RptCompConfig WHERE RptCompSysId IN ('Sys_400','Sys_401','Sys_402','Sys_403','Sys_404','Sys_405','Sys_406','Sys_407','Sys_408','Sys_409','Sys_410')) THEN
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_400','_Statistics Report','Statistics Report','ComboBox_SortBy');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_401','_Statistics Report','Statistics Report','RadioGroup_RptFormat');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_402','_Statistics Report','Statistics Report','Customised_wwDBLookupCombo');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_403','_Statistics Report','Statistics Report','CheckBox_PageBreak');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_404','_Statistics Report','Statistics Report','ComboBox_Year_From');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_405','_Statistics Report','Statistics Report','ComboBox_Period_From');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_406','_Statistics Report','Statistics Report','ComboBox_Year_To');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_407','_Statistics Report','Statistics Report','ComboBox_Period_To');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_408','_Statistics Report','Statistics Report','ComboBox_SubPeriod');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_409','_Statistics Report','Statistics Report','PayRec_RadioGroup');
  INSERT INTO RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) Values('Sys_410','_Statistics Report','Statistics Report','ComboBox_PayRecType');
END IF;

/* RptCompItemConfig */
IF NOT EXISTS(SELECT * FROM RptCompItemConfig WHERE RptCompSysId IN('Sys_400','Sys_401','Sys_402','Sys_403','Sys_404','Sys_405','Sys_406','Sys_407','Sys_408','Sys_409','Sys_410')) THEN
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_400','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_401','1','1');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_402','1','');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_403','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_404','1','');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_405','1','');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_406','1','');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_407','1','');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_408','1','All');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_409','1','0');
  INSERT INTO RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) Values('Sys_410','1','All');
END IF;


COMMIT WORK;