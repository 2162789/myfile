/*==============================================================*/
/* Philippines Crystal Report Laser Payslip                     */
/*==============================================================*/
/* Enable customization for Laser Payslip form */
if not exists(Select * from Keyword where KeywordId = 'CR_PHPayLPayslip') then
	INSERT INTO Keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage, KeyWordGroup) VALUES('CR_PHPayLPayslip','Pay','Payslip - Laser','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report',NULL,NULL,0, NULL);
end if;

/* Enable customization for Laser Pre-Printed Payslip form */
if not exists(Select * from Keyword where KeywordId = 'CR_PHPayPPayslip') then
	INSERT INTO Keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup) VALUES('CR_PHPayPPayslip','Pay','Payslip - Laser Pre-printed','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Pre-printed Payslip Report',NULL,NULL,0,NULL);
end if;

commit work;