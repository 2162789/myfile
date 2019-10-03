if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalRebateGranted') then
   drop procedure InsertNewMalRebateGranted
end if
;

create procedure
DBA.InsertNewMalRebateGranted(
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
      RebatePaymentCount = In_RebatePaymentCount) then
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
      RebatePaymentCount) values(
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
      In_RebatePaymentCount);
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
        RebatePaymentCount = In_RebatePaymentCount) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

commit work;