if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormRebateGranted') then
   drop procedure FGetEAFormRebateGranted
end if
;

CREATE FUNCTION "DBA"."FGetEAFormRebateGranted"(
in In_PersonalSysId integer,
in In_Year integer)
returns double
begin
  declare total double;
  declare Out_PeriodFrom integer;
  declare Out_PeriodTo integer;
  select FromPayRecPeriod, ToPayRecPeriod into Out_PeriodFrom, Out_PeriodTo
    from MalTaxEmployee where
	MalTaxEESysId = FGetMalTaxRecordEmployeeSysId(In_PersonalSysId,In_Year) and
	MalTaxYear = In_Year;
 select sum(g.RebateAmt-g.LPAmt) into total
    from RebateGranted as g where
    FGetMalTaxExemptFromEr(g.RebateID) = 1 and
    IsPeriodWithin(g.RebatePayrollYear, g.RebatePayrollPeriod, FGetMalTaxRecordYear(In_Year), Out_PeriodFrom, FGetMalTaxRecordYear(In_Year), Out_PeriodTo) = 1 and 
    g.RebatePayrollYear = FGetMalTaxRecordYear(In_Year) and
    g.PersonalSysId = In_PersonalSysId; 
  if(total is null) then return 0
  end if;
  return total
end
;