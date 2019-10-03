

/*SystemRpt *************************************/

IF NOT EXISTS (SELECT * FROM SystemRpt WHERE SysRptId='Payslip - CS 2') THEN
INSERT INTO SystemRpt (SysRptId, SysRptName, SysRptModule, SysRptSubModule, SysRptAvailSummLevel)
VALUES ('Payslip - CS 2','Payslip - CS 2 Format','Payroll','Pay','RptSummEmployee, RptSummPersonal')
END IF;

/*SystemRptComp  *************************************/

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='PayGroupId_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','PayGroupId_wwDBLookupCombo','Pay Group','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='SortBy_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','SortBy_wwDBLookupCombo','Sort By','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='Year_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','Year_wwDBLookupCombo','Year','AnsiString',1,1)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='Period_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','Period_wwDBLookupCombo','Period','AnsiString',1,2)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='SubPeriod_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','SubPeriod_wwDBLookupCombo','Sub Period','AnsiString',1,3)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='dxDBGridMaskColumn_PayGroup') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','dxDBGridMaskColumn_PayGroup','Pay Group','TStringList',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='dxDBGridMaskColumn_Year') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','dxDBGridMaskColumn_Year','Year','TStringList',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='dxDBGridMaskColumn_Period') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','dxDBGridMaskColumn_Period','Period','TStringList',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='dxDBGridMaskColumn_SubPeriod') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','dxDBGridMaskColumn_SubPeriod','Sub Period','TStringList',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='dxDBGridMaskColumn_RecType') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','dxDBGridMaskColumn_RecType','Pay Record Type','TStringList',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='dxDBGridMaskColumn_RecID') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','dxDBGridMaskColumn_RecID','Pay Record ID','TStringList',1,4)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='ZeroAmt_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','ZeroAmt_CheckBox','Include Zero Pay Details','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='AdvancePay_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','AdvancePay_CheckBox','Include Advance Pay Details','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CalendarOption_RadioGroup') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CalendarOption_RadioGroup','Calendar Used For Leave Info','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_OTRate') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_OTRate','OT Rate','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_OTRateAmt') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_OTRateAmt','OT Rate Amt','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_OTFrequency') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_OTFrequency','OT Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_BPRate') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_BPRate','OT Back Pay Rate','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_BPRateAmt') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_BPRateAmt','OT Back Pay Rate Amt','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_BPFrequency') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_BPFrequency','OT Back Pay Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_ShiftRate') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_ShiftRate','Shift Rate','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_ShiftFrequency') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_ShiftFrequency','Shift Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_LDRateAmt') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_LDRateAmt','Leave Deduction Rate Amt','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_LDFrequency') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_LDFrequency','Leave Deduction Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_Allowance') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_Allowance','Allowance','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_Reimbursement') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_Reimbursement','Reimbursement','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_Deduction') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_Deduction','Deduction','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_AnnualSick') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_AnnualSick','Annual/Sick Leave','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_Category') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_Category','Include Basis','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='DisplayOption_ComboBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','DisplayOption_ComboBox','Basis','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_YTDDetail') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_YTDDetail','YTD Detail','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_DottedLine') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_DottedLine','Dotted Line','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='IncludeZeroNetWage_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','IncludeZeroNetWage_CheckBox','Include Zero Net Wage','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='RadioButton_Global_Message_Dos') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','RadioButton_Global_Message_Dos','Global Message','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='RadioButton_Employee_Message_Dos') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','RadioButton_Employee_Message_Dos','Employee Message','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_Signature') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_Signature','Signature Line','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='Emp_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','Emp_CheckBox','Include Employee Details','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='Emp_ComboBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','Emp_ComboBox','Employee Details','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_JamsostekWage') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_JamsostekWage','Include Jamsostek Wage','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='JWageTaxAmtOpt_ComboBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','JWageTaxAmtOpt_ComboBox','Jamsostek Wage','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='HideTaxSalary_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','HideTaxSalary_CheckBox','Hide Tax Gross Salary','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='CheckBox_IncludeLogo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='Edit_Header') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','Edit_Header','Header Message','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 2' and SysRptCompName='Edit_Footer') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 2','Edit_Footer','Footer Message','AnsiString',0,NULL)
END IF;

/*************RptConfig*/

IF NOT EXISTS (SELECT * FROM RptConfig WHERE RptConfigId='_Payslip - CS 2' ) THEN
INSERT INTO RptConfig (RptConfigId, UserID, SysRptId, RptConfigDesc, IsDefaultConfig,RptQueryID,RptFileType,DelBefIns,RptSummaryLevel,IsIndividualRpt,RptOutputTo,RptFilePath,CompressFileExt)
VALUES ('_Payslip - CS 2',NULL,'Payslip - CS 2','Payslip - CS 2 Format',1,'','RptFilePDF',1,'RptSummEmployee',1,'RptOpToFile','',NULL)
END IF;

/**************************** RptCompConfig*/

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_1' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_1','_Payslip - CS 2','Payslip - CS 2','PayGroupId_wwDBLookupCombo')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_2' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_2','_Payslip - CS 2','Payslip - CS 2','SortBy_wwDBLookupCombo')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_3' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_3','_Payslip - CS 2','Payslip - CS 2','Year_wwDBLookupCombo')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_4' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_4','_Payslip - CS 2','Payslip - CS 2','Period_wwDBLookupCombo')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_5' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_5','_Payslip - CS 2','Payslip - CS 2','SubPeriod_wwDBLookupCombo')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_6' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_6','_Payslip - CS 2','Payslip - CS 2','dxDBGridMaskColumn_PayGroup')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_7' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_7','_Payslip - CS 2','Payslip - CS 2','dxDBGridMaskColumn_Year')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_8' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_8','_Payslip - CS 2','Payslip - CS 2','dxDBGridMaskColumn_Period')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_9' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_9','_Payslip - CS 2','Payslip - CS 2','dxDBGridMaskColumn_SubPeriod')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_10' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_10','_Payslip - CS 2','Payslip - CS 2','dxDBGridMaskColumn_RecType')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_11' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_11','_Payslip - CS 2','Payslip - CS 2','dxDBGridMaskColumn_RecID')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_12' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_12','_Payslip - CS 2','Payslip - CS 2','ZeroAmt_CheckBox')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_13' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_13','_Payslip - CS 2','Payslip - CS 2','AdvancePay_CheckBox')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_14' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_14','_Payslip - CS 2','Payslip - CS 2','CalendarOption_RadioGroup')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_15' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_15','_Payslip - CS 2','Payslip - CS 2','CheckBox_OTRate')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_16' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_16','_Payslip - CS 2','Payslip - CS 2','CheckBox_OTRateAmt')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_17' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_17','_Payslip - CS 2','Payslip - CS 2','CheckBox_OTFrequency')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_18' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_18','_Payslip - CS 2','Payslip - CS 2','CheckBox_BPRate')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_19' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_19','_Payslip - CS 2','Payslip - CS 2','CheckBox_BPRateAmt')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_20' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_20','_Payslip - CS 2','Payslip - CS 2','CheckBox_BPFrequency')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_21' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_21','_Payslip - CS 2','Payslip - CS 2','CheckBox_ShiftRate')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_22' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_22','_Payslip - CS 2','Payslip - CS 2','CheckBox_ShiftFrequency')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_23' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_23','_Payslip - CS 2','Payslip - CS 2','CheckBox_LDRateAmt')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_24' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_24','_Payslip - CS 2','Payslip - CS 2','CheckBox_LDFrequency')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_25' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_25','_Payslip - CS 2','Payslip - CS 2','CheckBox_Allowance')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_26' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_26','_Payslip - CS 2','Payslip - CS 2','CheckBox_Reimbursement')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_27' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_27','_Payslip - CS 2','Payslip - CS 2','CheckBox_Deduction')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_28' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_28','_Payslip - CS 2','Payslip - CS 2','CheckBox_AnnualSick')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_29' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_29','_Payslip - CS 2','Payslip - CS 2','CheckBox_Category')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_30' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_30','_Payslip - CS 2','Payslip - CS 2','DisplayOption_ComboBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_31' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_31','_Payslip - CS 2','Payslip - CS 2','CheckBox_YTDDetail')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_32' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_32','_Payslip - CS 2','Payslip - CS 2','CheckBox_DottedLine')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_33' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_33','_Payslip - CS 2','Payslip - CS 2','IncludeZeroNetWage_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_34' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_34','_Payslip - CS 2','Payslip - CS 2','RadioButton_Global_Message_Dos')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_35' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_35','_Payslip - CS 2','Payslip - CS 2','RadioButton_Employee_Message_Dos')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_36' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_36','_Payslip - CS 2','Payslip - CS 2','CheckBox_Signature')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_37' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_37','_Payslip - CS 2','Payslip - CS 2','Emp_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_38' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_38','_Payslip - CS 2','Payslip - CS 2','Emp_ComboBox')
END IF;

//*****************RptCompItemConfig

IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_1' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_1','1','1 Payment Group')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_2' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_2','1','EmployeeId')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_3' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_3','1','2007')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_4' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_4','1','10')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_5' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_5','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_6' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_6','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_7' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_7','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_8' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_8','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_9' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_9','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_10' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_10','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_11' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_11','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_12' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_12','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_13' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_13','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_14' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_14','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_15' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_15','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_16' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_16','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_17' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_17','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_18' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_18','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_19' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_19','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_20' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_20','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_21' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_21','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_22' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_22','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_23' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_23','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_24' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_24','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_25' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_25','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_26' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_26','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_27' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_27','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_28' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_28','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_29' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_29','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_30' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_30','1','Category')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_31' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_31','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_32' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_32','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_33' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_33','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_34' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_34','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_35' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_35','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_36' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_36','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_37' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_37','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_38' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_38','1','Hire Date')
END IF;




/*SystemRpt *************************************/

IF NOT EXISTS (SELECT * FROM SystemRpt WHERE SysRptId='Payslip - Laser') THEN
INSERT INTO SystemRpt (SysRptId, SysRptName, SysRptModule, SysRptSubModule, SysRptAvailSummLevel)
VALUES ('Payslip - Laser','Payslip - Laser','Payroll','Pay','RptSummEmployee, RptSummPersonal')
END IF;

/*SystemRptComp  *************************************/

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='PayGroupId_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','PayGroupId_wwDBLookupCombo','Pay Group','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='SortBy_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','SortBy_wwDBLookupCombo','Sort By','AnsiString',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='Year_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','Year_wwDBLookupCombo','Year','AnsiString',1,1)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='Period_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','Period_wwDBLookupCombo','Period','AnsiString',1,2)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='SubPeriod_wwDBLookupCombo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','SubPeriod_wwDBLookupCombo','Sub Period','AnsiString',1,3)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='dxDBGridMaskColumn_PayGroup') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','dxDBGridMaskColumn_PayGroup','Pay Group','TStringList',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='dxDBGridMaskColumn_Year') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','dxDBGridMaskColumn_Year','Year','TStringList',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='dxDBGridMaskColumn_Period') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','dxDBGridMaskColumn_Period','Period','TStringList',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='dxDBGridMaskColumn_SubPeriod') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','dxDBGridMaskColumn_SubPeriod','Sub Period','TStringList',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='dxDBGridMaskColumn_RecType') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','dxDBGridMaskColumn_RecType','Record Type','TStringList',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='dxDBGridMaskColumn_RecID') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','dxDBGridMaskColumn_RecID','Record ID','TStringList',1,4)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='ZeroAmt_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','ZeroAmt_CheckBox','Include Zero Pay Details','int',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='AdvancePay_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','AdvancePay_CheckBox','Include Advance Pay Details','int',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='CalendarOption_RadioGroup') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','CalendarOption_RadioGroup','Calendar Used For Leave Info','int',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='OTRate_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','OTRate_CheckBox','OT Rate','int',0,NULL)
END IF;
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='OTRateAmt_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','OTRateAmt_CheckBox','OT Rate Amt','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='OTFrequency_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','OTFrequency_CheckBox','OT Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='BPRate_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','BPRate_CheckBox','OT Back Pay Rate','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='BPRateAmt_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','BPRateAmt_CheckBox','OT Back Pay Rate Amt','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='BPFrequency_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','BPFrequency_CheckBox','OT Back Pay Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='ShiftRate_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','ShiftRate_CheckBox','Shift Rate','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='ShiftFrequency_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','ShiftFrequency_CheckBox','Shift Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='LDRateAmt_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','LDRateAmt_CheckBox','Leave Deduction Rate Amt','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='LDFrequency_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','LDFrequency_CheckBox','Leave Deduction Frequency','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='PrePrintedPaySlip_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','PrePrintedPaySlip_CheckBox','Pre-printed PaySlip','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='IncludeZeroSubTotal_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','IncludeZeroSubTotal_CheckBox','Include Zero Sub Total','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='PayElement_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','PayElement_CheckBox','Pay Element Detail','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='CoverPage_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','CoverPage_CheckBox','Include Cover Page','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='CompanyAddress_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','CompanyAddress_CheckBox','Company Address','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='IncludeZeroNetWage_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','IncludeZeroNetWage_CheckBox','Include Zero Net Wage','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='BankDetail_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','BankDetail_CheckBox','Bank Detail','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='Legend_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','Legend_CheckBox','Legend on PaySlip','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='PPHeaderOption_RadioGroup') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','PPHeaderOption_RadioGroup','Header Option','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='Leave_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','Leave_CheckBox','Annual/Sick Leave','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='YTDDetail_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','YTDDetail_CheckBox','YTD Detail','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='SignatureLine_CheckBox') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','SignatureLine_CheckBox','Signature Line','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='Global_RadioButton') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','Global_RadioButton','Global Message','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='Employee_RadioButton') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','Employee_RadioButton','Employee Message','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='CheckBox_JamsostekWage') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','CheckBox_JamsostekWage','Include Jamsostek Wage','int',0,NULL)
END IF;

IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - Laser' and SysRptCompName='CheckBox_IncludeLogo') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - Laser','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL)
END IF;

/*************RptConfig*/

IF NOT EXISTS (SELECT * FROM RptConfig WHERE RptConfigId='_Payslip - Laser' ) THEN
INSERT INTO RptConfig (RptConfigId, UserID, SysRptId, RptConfigDesc, IsDefaultConfig,RptQueryID,RptFileType,DelBefIns,RptSummaryLevel,IsIndividualRpt,RptOutputTo,RptFilePath,CompressFileExt)
VALUES ('_Payslip - Laser',NULL,'Payslip - Laser','Payslip - Laser',1,'','RptFilePDF',1,'RptSummEmployee',1,'RptOpToFile','',NULL)
END IF;

/**************************** RptCompConfig*/


IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_39' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_39','_Payslip - Laser','Payslip - Laser','PayGroupId_wwDBLookupCombo')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_40' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_40','_Payslip - Laser','Payslip - Laser','SortBy_wwDBLookupCombo')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_41' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_41','_Payslip - Laser','Payslip - Laser','Year_wwDBLookupCombo')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_42' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_42','_Payslip - Laser','Payslip - Laser','Period_wwDBLookupCombo')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_43' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_43','_Payslip - Laser','Payslip - Laser','SubPeriod_wwDBLookupCombo')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_44' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_44','_Payslip - Laser','Payslip - Laser','dxDBGridMaskColumn_PayGroup')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_45' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_45','_Payslip - Laser','Payslip - Laser','dxDBGridMaskColumn_Year')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_46' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_46','_Payslip - Laser','Payslip - Laser','dxDBGridMaskColumn_Period')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_47' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_47','_Payslip - Laser','Payslip - Laser','dxDBGridMaskColumn_SubPeriod')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_48' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_48','_Payslip - Laser','Payslip - Laser','dxDBGridMaskColumn_RecType')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_49' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_49','_Payslip - Laser','Payslip - Laser','dxDBGridMaskColumn_RecID')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_50' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_50','_Payslip - Laser','Payslip - Laser','ZeroAmt_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_51' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_51','_Payslip - Laser','Payslip - Laser','AdvancePay_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_52' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_52','_Payslip - Laser','Payslip - Laser','CalendarOption_RadioGroup')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_53' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_53','_Payslip - Laser','Payslip - Laser','OTRate_CheckBox')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_54' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_54','_Payslip - Laser','Payslip - Laser','OTRateAmt_CheckBox')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_55' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_55','_Payslip - Laser','Payslip - Laser','OTFrequency_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_56' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_56','_Payslip - Laser','Payslip - Laser','BPRate_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_57' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_57','_Payslip - Laser','Payslip - Laser','BPRateAmt_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_58' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_58','_Payslip - Laser','Payslip - Laser','BPFrequency_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_59' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_59','_Payslip - Laser','Payslip - Laser','ShiftRate_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_60' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_60','_Payslip - Laser','Payslip - Laser','ShiftFrequency_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_61' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_61','_Payslip - Laser','Payslip - Laser','LDRateAmt_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_62' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_62','_Payslip - Laser','Payslip - Laser','LDFrequency_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_63' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_63','_Payslip - Laser','Payslip - Laser','PrePrintedPaySlip_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_64' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_64','_Payslip - Laser','Payslip - Laser','IncludeZeroSubTotal_CheckBox')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_65' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_65','_Payslip - Laser','Payslip - Laser','CoverPage_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_66' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_66','_Payslip - Laser','Payslip - Laser','CompanyAddress_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_67' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_67','_Payslip - Laser','Payslip - Laser','IncludeZeroNetWage_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_68' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_68','_Payslip - Laser','Payslip - Laser','BankDetail_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_69' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_69','_Payslip - Laser','Payslip - Laser','Legend_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_70' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_70','_Payslip - Laser','Payslip - Laser','PPHeaderOption_RadioGroup')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_71' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_71','_Payslip - Laser','Payslip - Laser','Leave_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_72' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_72','_Payslip - Laser','Payslip - Laser','YTDDetail_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_73' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_73','_Payslip - Laser','Payslip - Laser','SignatureLine_CheckBox')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_74' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_74','_Payslip - Laser','Payslip - Laser','Global_RadioButton')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_75' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_75','_Payslip - Laser','Payslip - Laser','Employee_RadioButton')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_76' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_76','_Payslip - Laser','Payslip - Laser','PayElement_CheckBox')
END IF;



//*****************RptCompItemConfig

IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_39' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_39','1','1 Payment Group')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_40' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_40','1','EmployeeId')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_41' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_41','1','2007')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_42' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_42','1','10')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_43' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_43','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_44' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_44','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_45' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_45','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_46' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_46','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_47' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_47','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_48' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_48','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_49' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_49','','')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_50' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_50','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_51' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_51','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_52' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_52','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_53' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_53','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_54' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_54','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_55' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_55','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_56' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_56','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_57' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_57','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_58' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_58','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_59' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_59','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_60' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_60','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_61' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_61','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_62' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_62','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_63' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_63','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_64' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_64','1','0')
END IF;

IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_65' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_65','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_66' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_66','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_67' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_67','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_68' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_68','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_69' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_69','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_70' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_70','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_71' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_71','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_72' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_72','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_73' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_73','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_74' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_74','1','1')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_75' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_75','1','0')
END IF;
IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_76' ) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_76','1','0')
END IF;

// Keyword

IF NOT EXISTS (SELECT * FROM keyword WHERE KeyWordId='CR_BNPayLPayslip' ) THEN
insert keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
              KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
values('CR_BNPayLPayslip','Pay','Payslip - Laser','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report',NULL,NULL,0,'')
END IF;

IF NOT EXISTS (SELECT * FROM keyword WHERE KeyWordId='CR_BNPayPPayslip' ) THEN
insert keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
              KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
values('CR_BNPayPPayslip','Pay','Payslip - Laser Pre-printed','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Pre-printed Payslip Report',NULL,NULL,0,'')
END IF;

//Payslip Format


IF NOT EXISTS (SELECT * FROM payslipformat WHERE PayslipFormatId='Laser Payslip' ) THEN
insert payslipformat(PayslipFormatId,DllName,FormatterInvoke,BooleanField1,BooleanField2,BooleanField3,IntegerField1,IntegerField2,IntegerField3,
       NumericField1,NumericField2,NumericField3,DateField1,DateField2,DateField3,StringField1,StringField2,StringField3,StringField4,StringField5)
values('Laser Payslip','BruneiLaserPayslip.dll','InvokePayslipReport',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
END IF;

commit work;