Read UpgradeDB\Ver1061006\ID_AnlysDispSection.sql;

//Disable Old Report Button
Update SubRegistry Set IntegerAttr = 0 where RegistryId = 'OldReport' and SubRegistryID='ReportOn';

/* Crystal report for Laser and Preprinted payslip */
if not exists(select * from keyword where keywordid = 'CR_IDPayLPayslip') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayLPayslip','Pay','Payslip - Laser','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report',NULL,NULL,0,NULL);
end if;

if not exists(select * from keyword where keywordid = 'CR_IDPayPPayslip') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayPPayslip','Pay','Payslip - Laser Pre-printed','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Pre-printed Payslip Report',NULL,NULL,0,NULL);
end if;

/* Laser payslip Default data for PayElement Remark */

If Not Exists(select * from SYSTEMRPTCOMP where SYSRPTID='Payslip - Laser' and SYSRPTCOMPNAME='ShowRemark_CheckBox') Then
Insert Into SYSTEMRPTCOMP(SYSRPTID,SYSRPTCOMPNAME,SYSRPTCOMPDESC,SYSRPTCOMPTYPE,ISRPTKEY,RPTKEYINDEX)
Values('Payslip - Laser','ShowRemark_CheckBox','Show Pay Element Remark','int',0,NULL);
End if;

If Not Exists(select * from RptCompConfig where RPTCOMPSYSID='Sys_79') Then
Insert Into RptCompConfig(RPTCOMPSYSID,RPTCONFIGID,SYSRPTID,SYSRPTCOMPNAME)
Values('Sys_79','_Payslip - Laser','Payslip - Laser','ShowRemark_CheckBox');
End if;

If Not Exists(select * from RptCompItemConfig where RPTCOMPSYSID='Sys_79') Then
Insert Into RptCompItemConfig(RPTCOMPSYSID,RPTCOMPITEMSYSID,ITEMVALUE)
Values('Sys_79','1','0');
End if;


if not exists(select * from keyword where keywordid = 'CR_IDPayPaySum') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayPaySum','Pay','Payroll Summary','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Payroll Summary Report',NULL,NULL,1,'');
end if;

commit work;