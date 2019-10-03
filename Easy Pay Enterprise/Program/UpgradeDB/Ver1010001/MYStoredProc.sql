if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalBIKRecord') then
   drop procedure InsertNewMalBIKRecord
end if
;

create procedure DBA.InsertNewMalBIKRecord(
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKRecurSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BIKAmount double,
out Out_MalBIKRecSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  select FGetNewSGSPGeneratedIndex('MalBIKRecord') into Out_MalBIKRecSGSPGenId;
  insert into MalBIKRecord(MalBIKRecSGSPGenId,
    MalBIKItemId,
    EmployeeSysId,
    BIKRecurSysId,
    PayRecYear,
    PayRecPeriod,
    PayRecSubPeriod,
    PayRecID,
    BIKAmount) values(
    Out_MalBIKRecSGSPGenId,
    In_MalBIKItemId,
    In_EmployeeSysId,
    In_BIKRecurSysId,
    In_PayRecYear,
    In_PayRecPeriod,
    In_PayRecSubPeriod,
    In_PayRecID,
    In_BIKAmount);
  commit work;
  if not exists(select* from MalBIKRecord where
      MalBIKRecSGSPGenId = Out_MalBIKRecSGSPGenId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalBIKRecord') then
   drop procedure UpdateMalBIKRecord
end if
;

create procedure DBA.UpdateMalBIKRecord(
in In_MalBIKRecSGSPGenId char(30),
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKRecurSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BIKAmount double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecord where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId) then
    update MalBIKRecord set
      MalBIKItemId = In_MalBIKItemId,
      EmployeeSysId = In_EmployeeSysId,
      BIKRecurSysId = In_BIKRecurSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      BIKAmount = In_BIKAmount where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalBIKRecord') then
   drop procedure DeleteMalBIKRecord
end if
;

create procedure DBA.DeleteMalBIKRecord(
in In_MalBIKRecSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecord where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId) then
    delete from MalBIKRecord where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId;
    commit work
  end if;
  if exists(select* from MalBIKRecord where MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalBIKRecurring') then
   drop procedure InsertNewMalBIKRecurring
end if
;

create procedure
DBA.InsertNewMalBIKRecurring(
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKStartYear integer,
in In_BIKStartPeriod integer,
in In_BIKEndPeriod integer,
in In_BIKAnnualAmount double,
in In_BIKNoOfPayment double,
in In_BIKPaymentPerSubPeriod double,
in In_BIKPreviousPayment double,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from MalBIKRecurring where
      MalBIKItemId = In_MalBIKItemId and
      EmployeeSysId = In_EmployeeSysId and
      BIKStartYear = In_BIKStartYear and
      BIKStartPeriod = In_BIKStartPeriod and
      BIKEndPeriod = In_BIKEndPeriod and
      BIKAnnualAmount = In_BIKAnnualAmount and
      BIKNoOfPayment = In_BIKNoOfPayment and
      BIKPaymentPerSubPeriod = In_BIKPaymentPerSubPeriod and
      BIKPreviousPayment = In_BIKPreviousPayment and
      Remarks = In_Remarks) then
    insert into MalBIKRecurring(MalBIKItemId,
      EmployeeSysId,
      BIKStartYear,
      BIKStartPeriod,
      BIKEndPeriod,
      BIKAnnualAmount,
      BIKNoOfPayment,
      BIKPaymentPerSubPeriod,
      BIKPreviousPayment,
      Remarks) values(
      In_MalBIKItemId,
      In_EmployeeSysId,
      In_BIKStartYear,
      In_BIKStartPeriod,
      In_BIKEndPeriod,
      In_BIKAnnualAmount,
      In_BIKNoOfPayment,
      In_BIKPaymentPerSubPeriod,
      In_BIKPreviousPayment,
      In_Remarks);
    commit work;
    if not exists(select* from MalBIKRecurring where
        MalBIKItemId = In_MalBIKItemId and
        EmployeeSysId = In_EmployeeSysId and
        BIKStartYear = In_BIKStartYear and
        BIKStartPeriod = In_BIKStartPeriod and
        BIKEndPeriod = In_BIKEndPeriod and
        BIKAnnualAmount = In_BIKAnnualAmount and
        BIKNoOfPayment = In_BIKNoOfPayment and
        BIKPaymentPerSubPeriod = In_BIKPaymentPerSubPeriod and
        BIKPreviousPayment = In_BIKPreviousPayment and
        Remarks = In_Remarks) then
      set Out_ErrorCode=0
    else
      select BIKRecurSysId into Out_ErrorCode from MalBIKRecurring where
        MalBIKItemId = In_MalBIKItemId and
        EmployeeSysId = In_EmployeeSysId and
        BIKStartYear = In_BIKStartYear and
        BIKStartPeriod = In_BIKStartPeriod and
        BIKEndPeriod = In_BIKEndPeriod and
        BIKAnnualAmount = In_BIKAnnualAmount and
        BIKNoOfPayment = In_BIKNoOfPayment and
        BIKPaymentPerSubPeriod = In_BIKPaymentPerSubPeriod and
        BIKPreviousPayment = In_BIKPreviousPayment and
        Remarks = In_Remarks
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalBIKRecurring') then
   drop procedure UpdateMalBIKRecurring
end if
;

create procedure DBA.UpdateMalBIKRecurring(
in In_BIKRecurSysId integer,
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKStartYear integer,
in In_BIKStartPeriod integer,
in In_BIKEndPeriod integer,
in In_BIKAnnualAmount double,
in In_BIKNoOfPayment double,
in In_BIKPaymentPerSubPeriod double,
in In_BIKPreviousPayment double,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecurring where BIKRecurSysId = In_BIKRecurSysId) then
    update MalBIKRecurring set
      MalBIKItemId = In_MalBIKItemId,
      EmployeeSysId = In_EmployeeSysId,
      BIKStartYear = In_BIKStartYear,
      BIKStartPeriod = In_BIKStartPeriod,
      BIKEndPeriod = In_BIKEndPeriod,
      BIKAnnualAmount = In_BIKAnnualAmount,
      BIKNoOfPayment = In_BIKNoOfPayment,
      BIKPaymentPerSubPeriod = In_BIKPaymentPerSubPeriod,
      BIKPreviousPayment = In_BIKPreviousPayment,
      Remarks = In_Remarks where
      BIKRecurSysId = In_BIKRecurSysId;
    commit work;
    select BIKRecurSysId into Out_ErrorCode from MalBIKRecurring where BIKRecurSysId = In_BIKRecurSysId
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalBIKRecurring') then
   drop procedure DeleteMalBIKRecurring
end if
;

create procedure DBA.DeleteMalBIKRecurring(
in In_BIKRecurSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecurring where BIKRecurSysId = In_BIKRecurSysId) then
    delete from MalBIKRecurring where BIKRecurSysId = In_BIKRecurSysId;
    commit work;
    if exists(select* from MalBIKRecurring where BIKRecurSysId = In_BIKRecurSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalBIKItem') then
   drop procedure InsertNewMalBIKItem
end if
;

create procedure dba.InsertNewMalBIKItem(
in In_MalBIKItemID char(20),
in In_MalBIKPropertyId char(20),
in In_MalBIKItemDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
    insert into MalBIKItem(MalBIKItemId,
      MalBIKPropertyId,
      MalBIKItemDesc) values(
      In_MalBIKItemID,
      In_MalBIKPropertyId,
      In_MalBIKItemDesc);
    commit work;
    if not exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalBIKItem') then
   drop procedure UpdateMalBIKItem
end if
;

create procedure dba.UpdateMalBIKItem(
in In_MalBIKItemID char(20),
in In_MalBIKPropertyId char(20),
in In_MalBIKItemDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
    update MalBIKItem set MalBIKPropertyId = In_MalBIKPropertyId,
      MalBIKItemDesc = In_MalBIKItemDesc where
      MalBIKItemId = In_MalBIKItemID;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalBIKItem') then
   drop procedure DeleteMalBIKItem
end if
;

create procedure dba.DeleteMalBIKItem(
in In_MalBIKItemID char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
    delete from MalBIKItem where MalBIKItemId = In_MalBIKItemID;
    commit work;
    if exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateClaimByPersonalSysId') then
   drop procedure DeleteMalRebateClaimByPersonalSysId
end if
;

create procedure
DBA.DeleteMalRebateClaimByPersonalSysId(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaim where PersonalSysId = In_PersonalSysId) then
    DeleteRebateSetupLoop: for RebateSetupFor as RebateSetupcurs dynamic scroll cursor for
      select RebateClaimRecordSysId as In_RebateClaimRecordSysId from RebateClaimRecord where
        RebateSysId = RebateSysId do
      call DeleteMalRebateClaimRecord(In_RebateClaimRecordSysId) end for;
    delete from RebateClaim where PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from RebateClaim where PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalBIKRecurringByEmployeeSysId') then
   drop procedure DeleteMalBIKRecurringByEmployeeSysId
end if
;

create procedure DBA.DeleteMalBIKRecurringByEmployeeSysId(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecurring where EmployeeSysId = In_EmployeeSysId) then
    delete from MalBIKRecurring where EmployeeSysId = In_EmployeeSysId;
    commit work;
    if exists(select* from MalBIKRecurring where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalBIKRecordByEmployeeSysId') then
   drop procedure DeleteMalBIKRecordByEmployeeSysId
end if
;

create procedure DBA.DeleteMalBIKRecordByEmployeeSysId(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecord where
      MalBIKRecord.EmployeeSysId = In_EmployeeSysId) then
    delete from MalBIKRecord where
      MalBIKRecord.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  if exists(select* from MalBIKRecord where
      MalBIKRecord.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

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
      LPAmt = In_LPAmt) then
    insert into RebateGranted(RebateID,
      PersonalSysId,
      RebatePayrollYear,
      RebatePayrollPeriod,
      RebateDeclaredYear,
      RebateAmt,
      TaxableAmt,
      AddTaxableAmt,
      CreatedBy,
      LPAmt) values(
      In_RebateID,
      In_PersonalSysId,
      In_RebatePayrollYear,
      In_RebatePayrollPeriod,
      In_RebateDeclaredYear,
      In_RebateAmt,
      In_TaxableAmt,
      In_AddTaxableAmt,
      In_CreatedBy,
      In_LPAmt);
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
        LPAmt = In_LPAmt) then
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

create procedure
DBA.UpdateMalRebateGranted(
in In_RebateGrantSysId integer,
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
      CreatedBy = In_CreatedBy,
      LPAmt = In_LPAmt where
      RebateGrantSysId = In_RebateGrantSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormRebateGranted') then
   drop procedure FGetEAFormRebateGranted
end if
;

create function DBA.FGetEAFormRebateGranted(
in In_PersonalSysId integer,
in In_Year integer)
returns double
begin
  declare total double;
  select distinct sum(g.RebateAmt-g.LPAmt) into total
    from RebateGranted as g where
    FGetMalTaxExemptFromEr(g.RebateID) = 1
    group by PersonalSysId,RebateDeclaredYear having
    g.RebateDeclaredYear = In_Year and
    g.PersonalSysId = In_PersonalSysId;
  return total
end
;