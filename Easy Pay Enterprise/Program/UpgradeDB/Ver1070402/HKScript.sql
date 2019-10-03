/* Enable customization for Laser Payslip form */
if not exists(Select * from Keyword where KeywordId = 'CR_HKPayLPayslip') then
	INSERT INTO Keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage, KeyWordGroup) VALUES('CR_HKPayLPayslip','Pay','Payslip - Laser','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report',NULL,NULL,0, NULL);
end if;

/* Enable customization for Laser Pre-Printed Payslip form */
if not exists(Select * from Keyword where KeywordId = 'CR_HKPayPPayslip') then
	INSERT INTO Keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup) VALUES('CR_HKPayPPayslip','Pay','Payslip - Laser Pre-printed','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Pre-printed Payslip Report',NULL,NULL,0,NULL);
end if;

/* Include Company Letterhead component in Report Configuration */
if not exists(Select * from SystemRptComp where SysRptCompName = 'CheckBox_IncludeLogo') then
	INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey, RptKeyIndex) VALUES ('Payslip - Laser','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL);
	INSERT INTO RptCompConfig (RptCompSysId, RptConfigId, SysRptId, SysRptCompName) VALUES ('Sys_78','_Payslip - Laser','Payslip - Laser','CheckBox_IncludeLogo');
	INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysId, ItemValue) VALUES ('Sys_78','1','1');
end if;

commit work;