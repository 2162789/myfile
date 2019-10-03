IF Not Exists(Select KeywordId From keyword where keywordId='CR_THPayLPayslip') Then
Insert into Keyword(KeywordId,KeywordDefaultName,keywordUserDefinedName,KeywordCategory,KeywordPropertySelection,KeyWordFormulaSelection,KeywordRangeSelection,KeywordDesc,KeywordSubCategory,KeywordSubProperty,keywordStage,KeyWordGroup)
Values('CR_THPayLPayslip','Pay','Payslip - Laser','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report',NULL,NULL,0,NULL)
End If;

IF Not Exists(Select KeywordId From keyword where keywordId='CR_THPayPPayslip') Then
Insert into Keyword(KeywordId,KeywordDefaultName,keywordUserDefinedName,KeywordCategory,KeywordPropertySelection,KeyWordFormulaSelection,KeywordRangeSelection,KeywordDesc,KeywordSubCategory,KeywordSubProperty,keywordStage,KeyWordGroup)
Values('CR_THPayPPayslip','Pay','Payslip - Laser Pre-printed','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Pre-printed Payslip Report',NULL,NULL,0,NULL)
End If;


commit work;