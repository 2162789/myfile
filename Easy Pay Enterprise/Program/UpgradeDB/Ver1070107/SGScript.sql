if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodGPCLSalary') then
   drop PROCEDURE  FGetPeriodGPCLSalary;
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
  PayRecPeriod = In_PayRecPeriod 
  and PayRecId='Normal';

  Select Sum(CurrentMVC+CurrentNWC) into In_NWCMVC From PolicyRecord where
  EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod
  and PayRecId='Normal';
  
  Select CurrentBasicRateType into In_BasicRateType From DetailRecord 
  where EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod 
  and PayRecId='Normal';
  
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

commit work;