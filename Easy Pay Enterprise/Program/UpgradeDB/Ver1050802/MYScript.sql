if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxRecordEmployeeSysId') then
   drop procedure FGetMalTaxRecordEmployeeSysId
end if
;

CREATE FUNCTION DBA.FGetMalTaxRecordEmployeeSysId(
in In_PersonalSysId integer,
in In_MalTaxYear integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare TaxEmploymentCount integer;
  select Count(*) into TaxEmploymentCount from MalTaxEmployee where
    PersonalSysId = In_PersonalSysId and
    MalTaxYear = In_MalTaxYear;
  /*
  Only 1 Employment (No Rejoin)
  */
  if(TaxEmploymentCount = 1) then
    select MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  else
    /*
    Assume the latest especially for Histroical Records that are not fixed
    User should split the current year records
    */
    select first MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear order by ToPayRecYear desc,ToPayRecPeriod desc, FromPayRecYear desc, FromPayRecPeriod desc
  end if;
  if Out_EmployeeSysId is null then set Out_EmployeeSysId=0
  end if;
  return(Out_EmployeeSysId)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormRebateGranted') then
   drop procedure FGetEAFormRebateGranted
end if
;

CREATE FUNCTION DBA.FGetEAFormRebateGranted(
in In_PersonalSysId integer,
in In_Year integer)
returns double
begin
  declare Out_SectionG double;
  declare Out_PeriodFrom integer;
  declare Out_PeriodTo integer;
  declare Out_EmployeeSysID integer;
  declare Out_TRebateAmt double;
  declare Out_TLPAmt double;
  declare Out_TEmployeeSysId integer;
  declare Out_ExcludeRebate double;
  
    set Out_EmployeeSysID = FGetMalTaxRecordEmployeeSysId(In_PersonalSysId,In_Year); 

    /* Get the Employee Payment Period */
    Select FromPayRecPeriod, ToPayRecPeriod into Out_PeriodFrom, Out_PeriodTo
        From MalTaxEmployee Where
	    MalTaxEESysId = Out_EmployeeSysID and
	    MalTaxYear = In_Year;

    /* Get Rebate Granted */
    Select Sum(g.RebateAmt-g.LPAmt) into Out_SectionG
        From RebateGranted as g Where
        FGetMalTaxExemptFromEr(g.RebateID) = 1 and
        IsPeriodWithin(g.RebatePayrollYear, g.RebatePayrollPeriod, FGetMalTaxRecordYear(In_Year), Out_PeriodFrom, FGetMalTaxRecordYear(In_Year), Out_PeriodTo) = 1 and 
        g.RebatePayrollYear = FGetMalTaxRecordYear(In_Year) and
        g.PersonalSysId = In_PersonalSysId; 
  
    if(Out_SectionG is null) then return 0 end if;
  
    /* Check Employee shared employment in the same Period */
    RebateLoop: for RebateFor as curs dynamic scroll cursor for
        Select PayRecYear as Out_PayRecYear, 
        PayRecPeriod as Out_PayRecPeriod, 
        FGetPersonalSysIDByEmployeeSysID(EmployeeSysID) as PersonalSysID, 
        Count(Distinct EmployeeSysid) as Rejoin 
        From PayRecord 
        Group By PayRecYear, PayRecPeriod, PersonalSysID
        Having PayRecYear = FGetMalTaxRecordYear(In_Year)
        And Rejoin > 1 
        And PayRecPeriod >= Out_PeriodFrom 
        And PayRecPeriod <= Out_PeriodTo
        Order by PayRecYear, PayRecPeriod
  
    do

        Select TRebateAmt, TLPAmt, TEmployeeSysId 
            into Out_TRebateAmt, Out_TLPAmt, Out_TEmployeeSysId from RebateGranted 
            Where RebatePayrollYear = Out_PayRecYear
            And RebatePayrollPeriod = Out_PayRecPeriod
            And PersonalSysID =  In_PersonalSysId;

        /* Employee has terminated in this Period - to exclude the other employment*/
        if (Out_TEmployeeSysId = Out_EmployeeSysID) then
            Select ((RebateAmt - LPAmt) - (TRebateAmt - TLPAmt)) into Out_ExcludeRebate
            From RebateGranted
            Where RebatePayrollYear = Out_PayRecYear
            And RebatePayrollPeriod = Out_PayRecPeriod
            And PersonalSysID =  In_PersonalSysId;
            set Out_SectionG = Out_SectionG - Out_ExcludeRebate;
        else
            set Out_SectionG = Out_SectionG - (Out_TRebateAmt - Out_TLPAmt);
        end if;

    end for;

    return Out_SectionG;

end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTotalZakatByPersonalSysId') then
   drop procedure FGetPeriodTotalZakatByPersonalSysId
end if
;

CREATE FUNCTION DBA.FGetPeriodTotalZakatByPersonalSysId(
in In_PersonalSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Zakat double;
  select Sum(TotalCDAC) into Out_Zakat
    from Employee, PeriodPolicySummary where 
    Employee.EmployeeSysId = PeriodPolicySummary.EmployeeSysId and
    PersonalSysId = In_PersonalSysId and 
    PayRecYear = In_PayRecYear and 
    PayRecPeriod = In_PayRecPeriod;
  return(Out_Zakat)
end;

commit work;