
/* SystemRptComp */

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 1' and SysRptCompName = 'DateOfPayment_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 1','DateOfPayment_wwDBDateTimePicker','Date of Payment','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 1' and SysRptCompName = 'OTPeriodFrom_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 1','OTPeriodFrom_wwDBDateTimePicker','OT Payment Period(s) From','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 1' and SysRptCompName = 'OTPeriodTo_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 1','OTPeriodTo_wwDBDateTimePicker','OT Payment Period(s) To','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 2' and SysRptCompName = 'DateOfPayment_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 2','DateOfPayment_wwDBDateTimePicker','Date of Payment','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 2' and SysRptCompName = 'OTPeriodFrom_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 2','OTPeriodFrom_wwDBDateTimePicker','OT Payment Period(s) From','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 2' and SysRptCompName = 'OTPeriodTo_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 2','OTPeriodTo_wwDBDateTimePicker','OT Payment Period(s) To','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - 3 Payslips On A4' and SysRptCompName = 'DateOfPayment_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - 3 Payslips On A4','DateOfPayment_wwDBDateTimePicker','Date of Payment','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - 3 Payslips On A4' and SysRptCompName = 'OTPeriodFrom_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - 3 Payslips On A4','OTPeriodFrom_wwDBDateTimePicker','OT Payment Period(s) From','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - 3 Payslips On A4' and SysRptCompName = 'OTPeriodTo_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - 3 Payslips On A4','OTPeriodTo_wwDBDateTimePicker','OT Payment Period(s) To','Date',0,NULL);
end if;


/* Default RptCompConfig & RptCompItemConfig*/
if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_191' and RptConfigId = '_Payslip - CS 1') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_191','_Payslip - CS 1','Payslip - CS 1','DateOfPayment_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_192' and RptConfigId = '_Payslip - CS 1') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_192','_Payslip - CS 1','Payslip - CS 1','OTPeriodFrom_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_193' and RptConfigId = '_Payslip - CS 1') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_193','_Payslip - CS 1','Payslip - CS 1','OTPeriodTo_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_194' and RptConfigId = '_Payslip - CS 2') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_194','_Payslip - CS 2','Payslip - CS 2','DateOfPayment_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_195' and RptConfigId = '_Payslip - CS 2') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_195','_Payslip - CS 2','Payslip - CS 2','OTPeriodFrom_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_196' and RptConfigId = '_Payslip - CS 2') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_196','_Payslip - CS 2','Payslip - CS 2','OTPeriodTo_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_197' and RptConfigId = '_Payslip - 3 Payslips On A4') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_197','_Payslip - 3 Payslips On A4','Payslip - 3 Payslips On A4','DateOfPayment_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_198' and RptConfigId = '_Payslip - 3 Payslips On A4') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_198','_Payslip - 3 Payslips On A4','Payslip - 3 Payslips On A4','OTPeriodFrom_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_199' and RptConfigId = '_Payslip - 3 Payslips On A4') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_199','_Payslip - 3 Payslips On A4','Payslip - 3 Payslips On A4','OTPeriodTo_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_191' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_191','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_192' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_192','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_193' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_193','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_194' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_194','1','1899-12-30');
end if;
    
if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_195' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_195','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_196' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_196','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_197' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_197','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_198' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_198','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_199' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_199','1','1899-12-30');
end if;




if not exists(select * from SubRegistry where RegistryId = 'EmployeeSetupData' and SubRegistryId = 'IsSalaryDeductCap') then
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('EmployeeSetupData','IsSalaryDeductCap','Check','Employment Act Deduction Cap','BooleanAttr','N','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000')
end if;


if not exists(select * from labelname where TableName = 'Employee' and AttributeName = 'IsSalaryDeductCap') then
  insert into labelname 
(TableName,AttributeName,DefaultLName,NewLName,DefaultAttrLength,MinAttrLength,MainModuleName,FieldSecurity,QueryField,CustomField)
   values('Employee','IsSalaryDeductCap','Employment Act Deduction Cap','Employment Act Deduction Cap',0,0,'Core',0,1,0)
end if;



if not exists(select * from Registry where RegistryId = 'AuthDeductCap') then
  insert into Registry(RegistryId, RegistryDesc)
  values('AuthDeductCap','Authorised Deduction Cap for Singapore Employment Act');
end if;

if not exists(select * from SubRegistry where RegistryId = 'AuthDeductCap' and SubRegistryId = 'DeductCap') then
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('AuthDeductCap','DeductCap','','','','','','','','','','',50,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000')
end if;

if not exists(select * from SubRegistry where RegistryId = 'AuthDeductCap' and SubRegistryId = 'DeductSubCap') then
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('AuthDeductCap','DeductSubCap','','','','','','','','','','',25,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000')
end if;

if not exists(select * from Keyword where KeywordId = 'DeductCap') then
   insert into Keyword
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('DeductCap','Authorised Deduction Cap','Authorised Deduction Cap','System',1,0,0,'',0,0,0,'N')
end if;

if not exists(select * from Keyword where KeywordId = 'DeductSubCap') then
   insert into Keyword
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('DeductSubCap','Authorised Deduction Sub Cap','Authorised Deduction Sub Cap','System',1,0,0,'',0,0,0,'N')
end if;



if not exists(select * from FormulaProperty where FormulaId = 'CDAC' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'CDAC') then
       insert into FormulaProperty(KeyWordId,FormulaId) 
	   values('DeductCap','CDAC');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'COMC' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'COMC') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','COMC');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'EUCF' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'EUCF') then
     insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','EUCF');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'MOSQ' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'MOSQ') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','MOSQ');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'SIND' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'SIND') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','SIND');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'YMF' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId= 'YMF') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','YMF');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'MOSQ2005' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'MOSQ2005') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','MOSQ2005');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'YMF2005' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'YMF2005') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','YMF2005');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'MOSQ2009' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'MOSQ2009') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
      values('DeductCap','MOSQ2009');
	end if;
end if;

if not exists(select * from FormulaProperty where FormulaId = 'YMF2009' and KeyWordId = 'DeductCap') then
    if exists(select * from Formula where FormulaId = 'YMF2009') then
      insert into FormulaProperty(KeyWordId,FormulaId) 
	  values('DeductCap','YMF2009');
	end if;
end if;





commit work;







	












