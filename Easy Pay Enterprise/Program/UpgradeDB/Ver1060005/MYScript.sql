if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalPrevEmployer') then
   drop PROCEDURE DeleteMalPrevEmployer
end if
;
Create procedure DBA.DeleteMalPrevEmployer(
in In_MalPrevEmployerSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalPrevEmployer where MalPrevEmployerSysId = In_MalPrevEmployerSysId) then
    delete from MalPrevEmployer where MalPrevEmployerSysId = In_MalPrevEmployerSysId;
    delete from RebateGranted where PrevEmployerSysId = In_MalPrevEmployerSysId;
    commit work;
    if exists(select* from MalPrevEmployer where MalPrevEmployerSysId = In_MalPrevEmployerSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormRebateGranted') then
   drop FUNCTION FGetEAFormRebateGranted
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

        /* Employee has terminated in this Period - to exclude the other employment*/
        if (Out_TEmployeeSysId = Out_EmployeeSysID) then
            Select sum((RebateAmt - LPAmt) - (TRebateAmt - TLPAmt)) into Out_ExcludeRebate
            From RebateGranted
            Where RebatePayrollYear = Out_PayRecYear
            And RebatePayrollPeriod = Out_PayRecPeriod
            And PersonalSysID =  In_PersonalSysId
            And PrevEmployerSysId = 0;
            set Out_SectionG = Out_SectionG - Out_ExcludeRebate;
        else
            set Out_SectionG = Out_SectionG - (Out_TRebateAmt - Out_TLPAmt);
        end if;

    end for;

    return Out_SectionG;

end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalRebateGranted') then
   drop procedure InsertNewMalRebateGranted
end if
;
Create procedure DBA.InsertNewMalRebateGranted(
in In_RebateID char(20),
in In_PersonalSysId integer,
in In_RebatePayrollYear integer,
in In_RebatePayrollPeriod integer,
in In_RebateDeclaredYear integer,
in In_RebateAmt double,
in In_TaxableAmt double,
in In_AddTaxableAmt double,
in In_CreatedBy char(1),
in In_LPAmt double,
in In_RebatePaymentCount integer,
in In_TRebateAmt double,
in In_TLPAmt double,
in In_TEmployeeSysId integer,
in In_PrevEmployerSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from RebateGranted where
      RebateID = In_RebateID and
      PersonalSysId = In_PersonalSysId and
      RebatePayrollYear = In_RebatePayrollYear and
      RebatePayrollPeriod = In_RebatePayrollPeriod and
      RebateDeclaredYear = In_RebateDeclaredYear and
      RebateAmt = In_RebateAmt and
      TaxableAmt = In_TaxableAmt and
      AddTaxableAmt = In_AddTaxableAmt and
      CreatedBy = In_CreatedBy and
      LPAmt = In_LPAmt and
      RebatePaymentCount = In_RebatePaymentCount and
      TRebateAmt = In_TRebateAmt and
      TLPAmt = In_TLPAmt and
      TEmployeeSysId = In_TEmployeeSysId and
      PrevEmployerSysId = In_PrevEmployerSysId) then
    insert into RebateGranted(RebateID,
      PersonalSysId,
      RebatePayrollYear,
      RebatePayrollPeriod,
      RebateDeclaredYear,
      RebateAmt,
      TaxableAmt,
      AddTaxableAmt,
      CreatedBy,
      LPAmt,
      RebatePaymentCount,
      TRebateAmt,
      TLPAmt,
      TEmployeeSysId,
      PrevEmployerSysId) values(
      In_RebateID,
      In_PersonalSysId,
      In_RebatePayrollYear,
      In_RebatePayrollPeriod,
      In_RebateDeclaredYear,
      In_RebateAmt,
      In_TaxableAmt,
      In_AddTaxableAmt,
      In_CreatedBy,
      In_LPAmt,
      In_RebatePaymentCount,
      In_TRebateAmt,
      In_TLPAmt,
      In_TEmployeeSysId,
      In_PrevEmployerSysId);
    commit work;
    if not exists(select* from RebateGranted where
        RebateID = In_RebateID and
        PersonalSysId = In_PersonalSysId and
        RebatePayrollYear = In_RebatePayrollYear and
        RebatePayrollPeriod = In_RebatePayrollPeriod and
        RebateDeclaredYear = In_RebateDeclaredYear and
        RebateAmt = In_RebateAmt and
        TaxableAmt = In_TaxableAmt and
        AddTaxableAmt = In_AddTaxableAmt and
        CreatedBy = In_CreatedBy and
        LPAmt = In_LPAmt and
        RebatePaymentCount = In_RebatePaymentCount and
        TRebateAmt = In_TRebateAmt and
        TLPAmt = In_TLPAmt and
        TEmployeeSysId = In_TEmployeeSysId and
        PrevEmployerSysId = In_PrevEmployerSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalRebateGranted') then
   drop procedure UpdateMalRebateGranted
end if
;
Create procedure DBA.UpdateMalRebateGranted(
in In_RebateGrantSysId integer,
in In_RebateID char(20),
in In_PersonalSysId integer,
in In_RebatePayrollYear integer,
in In_RebatePayrollPeriod integer,
in In_RebateDeclaredYear integer,
in In_RebateAmt double,
in In_TaxableAmt double,
in In_AddTaxableAmt double,
in In_LPAmt double,
in In_RebatePaymentCount integer,
in In_TRebateAmt double,
in In_TLPAmt double,
in In_TEmployeeSysId integer,
in In_PrevEmployerSysId integer,
in In_CreatedBy char(1),
out Out_ErrorCode integer)
begin
  if exists(select* from RebateGranted where
      RebateGrantSysId = In_RebateGrantSysId) then
    update RebateGranted set
      RebateID = In_RebateID,
      PersonalSysId = In_PersonalSysId,
      RebatePayrollYear = In_RebatePayrollYear,
      RebatePayrollPeriod = In_RebatePayrollPeriod,
      RebateDeclaredYear = In_RebateDeclaredYear,
      RebateAmt = In_RebateAmt,
      TaxableAmt = In_TaxableAmt,
      AddTaxableAmt = In_AddTaxableAmt,
      LPAmt = In_LPAmt ,
      RebatePaymentCount = In_RebatePaymentCount,
      TRebateAmt = In_TRebateAmt,
      TLPAmt = In_TLPAmt,
      TEmployeeSysId = In_TEmployeeSysId,
      PrevEmployerSysId = In_PrevEmployerSysId,
      CreatedBy = In_CreatedBy
where
      RebateGrantSysId = In_RebateGrantSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

/* RebateGranted */
Update RebateGranted Set TRebateAmt = 0 where TRebateAmt is null;
Update RebateGranted Set TLPAmt = 0 where TLPAmt is null;
Update RebateGranted Set TEmployeeSysId = 0 where TEmployeeSysId is null;

COMMIT WORK;
