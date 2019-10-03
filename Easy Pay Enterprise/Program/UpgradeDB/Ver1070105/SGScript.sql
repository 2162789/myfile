
//---------------------------------------------------------------------------------------------------
// Delete and re-insert IRAS Submit User ID Type
//---------------------------------------------------------------------------------------------------

DELETE  FROM YEKeyWord WHERE YEKeywordCategory = 'SubmitUserIDType'

 INSERT INTO YEKeyword 
(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  VALUES 
 ('SubmitUserTypeNRIC','NRIC','NRIC','SubmitUserIDType','','1','','','','','','','','1899-12-30 00:00:00');

 INSERT INTO YEKeyword 
(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  VALUES 
 ('SubmitUserTypeFIN','FIN','FIN','SubmitUserIDType','','2','','','','','','','','1899-12-30 00:00:00');

 INSERT INTO YEKeyword 
(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  VALUES 
 ('SubmitUserTypeWP','WP','Work Permit No.','SubmitUserIDType','','4','','','','','','','','1899-12-30 00:00:00');

 INSERT INTO YEKeyword 
(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  VALUES 
 ('SubmitUserTypeASGD','ASGD','Tax Reference number assigned by IRAS','SubmitUserIDType','','A','','','','','','','','1899-12-30 00:00:00');

 INSERT INTO YEKeyword 
(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  VALUES 
 ('SubmitUserTypeMIC','MIC','Malaysia I/C','SubmitUserIDType','','11','','','','','','','','1899-12-30 00:00:00');


//GPCL Form

if exists (select 1 from sys.sysprocedure where proc_name = 'FGetPeriodGPCLSalary') then
  drop procedure FGetPeriodGPCLSalary;
end if;

CREATE FUNCTION "DBA"."FGetPeriodGPCLSalary"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  
  declare In_BasicRateType Char(30);
  declare In_TotWorkDays double;
  declare In_TotWorkHrperDay double;
  declare In_CurrentBasicRate double;
  declare In_NWCMVC double;
  declare In_GPCLSalary double;
  
  Select Sum(CurrentBasicRate) into In_CurrentBasicRate From DetailRecord where 
  EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod ;

  Select Sum(CurrentMVC+CurrentNWC) into In_NWCMVC From PolicyRecord where
  EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod;
  
  Select CurrentBasicRateType into In_BasicRateType From DetailRecord 
  where EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod ;
  
//Monthly Rated
  if In_BasicRateType='MonthlyRated' then          
   Set In_GPCLSalary=In_CurrentBasicRate+In_NWCMVC 
 end if;

//Daily Rated
  if In_BasicRateType='DailyRated' then  
    Select SUM(WKCALENDAYWKPATTERN) into In_TotWorkDays  From CalendarDay Where CalendarIDCode=FGetEmployeeCalendarId(In_EmployeeSysId) and Year(CalendarDate)=In_PayRecYear and Month(CalendarDate)=In_PayRecPeriod ;   
    Set In_GPCLSalary= ((In_CurrentBasicRate+In_NWCMVC)*In_TotWorkDays) ;
  end if;

//Hourly Rated

  if In_BasicRateType='HourlyRated' then   
    Select SUM(WKCALENDAYWKPATTERN) into In_TotWorkDays  From CalendarDay Where CalendarIDCode=FGetEmployeeCalendarId(In_EmployeeSysId) and Year(CalendarDate)=In_PayRecYear and Month(CalendarDate)=In_PayRecPeriod ; 
    Select SUM(HOURSPERFULLDAY) into In_TotWorkHrperDay  From Calendar Where CalendarID=FGetEmployeeCalendarId(In_EmployeeSysId);
    
    Set In_GPCLSalary=(In_CurrentBasicRate+In_NWCMVC)*In_TotWorkDays*In_TotWorkHrperDay;

  end if;
 return In_GPCLSalary;
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'FGetPeriodGPCLAllowance') then
  drop procedure FGetPeriodGPCLAllowance;
end if;

CREATE FUNCTION "DBA"."FGetPeriodGPCLAllowance"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_GPCLAllowance double;
  select Sum(AllowanceAmount) into In_GPCLAllowance from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    AllowanceFormulaId in
    (Select FormulaId as AllowanceFormulaId From Formula Where 
    (FormulaSubCategory = 'Allowance') And 
    IsFormulaIdHasProperty(FormulaId,'GPCLCode') = 1);
    
 if In_GPCLAllowance is null then set In_GPCLAllowance=0
  end if;
  return In_GPCLAllowance;
 
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'FGetPeriodOrdERCPF') then
  drop procedure FGetPeriodOrdERCPF;
end if;

CREATE FUNCTION "DBA"."FGetPeriodOrdERCPF"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_ERCPF double;
  select Sum(CONTRIORDERCPF) into In_ERCPF from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_ERCPF is null then set In_ERCPF=0
  end if;
  return In_ERCPF;
end;


if not exists(select * from keyword where KeywordId = 'GPCLCode' ) then
  Insert into keyword(KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,
  KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP) 
  Values('GPCLCode','GPCL Code','GPCL Code','System',1,0,0,'Only available if not Additional or Bonus or OT Code',0,0,0,'G');
end if;


commit work;