if exists(select * from sys.sysprocedure where proc_name = 'FGetEAFormRebateGranted') then
   drop function FGetEAFormRebateGranted
end if;
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
        g.PersonalSysId = In_PersonalSysId and 
        g.PrevEmployerSysId = 0; 
  
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
        And PersonalSysID =  In_PersonalSysId 
        And Rejoin > 1 
        And PayRecPeriod >= Out_PeriodFrom 
        And PayRecPeriod <= Out_PeriodTo
        Order by PayRecYear, PayRecPeriod
  
    do

        Select sum(TRebateAmt), sum(TLPAmt), TEmployeeSysId 
            into Out_TRebateAmt, Out_TLPAmt, Out_TEmployeeSysId from RebateGranted 
            Where RebatePayrollYear = Out_PayRecYear
            And RebatePayrollPeriod = Out_PayRecPeriod
            And PersonalSysID =  In_PersonalSysId 
            And TEmployeeSysId > 0
            And PrevEmployerSysId = 0
            Group By TEmployeeSysId;

        if Out_TRebateAmt is null then set Out_TRebateAmt = 0 end if;
        if Out_TLPAmt is null then set Out_TLPAmt = 0 end if;

        /* Employee has terminated in this Period - to exclude the other employment*/
        if (Out_TEmployeeSysId = Out_EmployeeSysID) then
            Select sum((RebateAmt - LPAmt) - (TRebateAmt - TLPAmt)) into Out_ExcludeRebate
            From RebateGranted
            Where RebatePayrollYear = Out_PayRecYear
            And RebatePayrollPeriod = Out_PayRecPeriod
            And PersonalSysID =  In_PersonalSysId
            And PrevEmployerSysId = 0;				
            if Out_ExcludeRebate is null then set Out_ExcludeRebate = 0 end if;
            set Out_SectionG = Out_SectionG - Out_ExcludeRebate;
        else
            set Out_SectionG = Out_SectionG - (Out_TRebateAmt - Out_TLPAmt);
        end if;

    end for;

    return Out_SectionG;

end
;

commit work;