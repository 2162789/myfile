if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodLveAmount') then
   drop procedure FGetPayPeriodLveAmount
end if
;

create function
dba.FGetPayPeriodLveAmount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Amt double;
  if(In_PayRecSubPeriod = 0) then
    select sum(LveAmount) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType
  else
    select sum(LveAmount) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and LeaveTypeFunctCode = In_LeaveType
  end if;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePeriodRecords') then
   drop procedure ASQLDeletePeriodRecords
end if
;

create procedure
DBA.ASQLDeletePeriodRecords(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  delete from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from HKOrdinance where PayPeriodSGSPGenId = 
    (select PayPeriodSGSPGenId from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod);
  delete from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from SubPeriodSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from SubPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from OTRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from ShiftRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from MalBIKRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from RebateGranted where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
    RebatePayrollYear = In_PayRecYear and
    RebatePayrollPeriod = In_PayRecPeriod;
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId from AllowanceRecord left outer join AllowanceHistoryRecord do
    if(EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod) then
      delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
      delete from AllowanceRecord where AllowanceSGSPGenId = GenId
    end if end for;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayRecords') then
   drop procedure ASQLDeletePayRecords
end if
;

create procedure
DBA.ASQLDeletePayRecords(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare CountPayRecord integer;
  select count(*) into CountPayRecord from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  if(CountPayRecord = 1) then
    call ASQLDeleteSubPeriodRecords(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod);
    if(FGetDBCountry(*) = 'Malaysia') then
      delete from RebateGranted where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
        RebatePayrollYear = In_PayRecYear and
        RebatePayrollPeriod = In_PayRecPeriod
    end if
  else
    delete from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from OTRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from ShiftRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from MalBIKRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
      select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId from AllowanceRecord left outer join AllowanceHistoryRecord do
      if(EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID) then
        delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
        delete from AllowanceRecord where AllowanceSGSPGenId = GenId
      end if end for
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaidCurrentTaxAmt') then
   drop procedure FGetPaidCurrentTaxAmt
end if
;

CREATE FUNCTION "DBA"."FGetPaidCurrentTaxAmt"(
in In_PayRecYear integer, 
in In_PayRecPeriod integer)
RETURNS double
BEGIN
	DECLARE "Out_PaidCurrentTaxAmt" double;
	    SELECT sum(PaidCurrentTaxAmt) into Out_PaidCurrentTaxAmt
        FROM PeriodPolicySummary
        WHERE PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
        if(Out_PaidCurrentTaxAmt is null) then 
            set Out_PaidCurrentTaxAmt = 0;
        end if;
	RETURN "Out_PaidCurrentTaxAmt";
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayEmployee') then
   drop procedure ASQLDeletePayEmployee
end if
;

create procedure
DBA.ASQLDeletePayEmployee(
in In_EmployeeSysId integer)
begin
  call DeletePayEmployeePolicy(In_EmployeeSysId);
  call DeleteCPFPayment(In_EmployeeSysId);
  call DeletePayAllocation(In_EmployeeSysId);
  call DeletePayLeaveSetting(In_EmployeeSysId);
  call DeleteBalPayElementId(In_EmployeeSysId);
  call DeleteLoanEmployeeEmp(In_EmployeeSysId);
  delete from EmployeeRecurAllowance where EmployeeSysId = In_EmployeeSysId;
  /*
  Delete NS Pay Records
  */
  DeleteNSPayCaseLoop: for NSPayCaseFor as NSPayCaseCurs dynamic scroll cursor for
    select NSPaySysId as In_NSPaySysId from NSPayCase where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteNSPayCase(In_NSPaySysId) end for;
  /*
  Delete Casual Records
  */
  DeleteNSPayCaseLoop: for CasualFor as CasualCurs dynamic scroll cursor for
    select CasualSGSPGenId as In_CasualSGSPGenId from CasRecord where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteCasRecord(In_CasualSGSPGenId) end for;
  /*
  Delete Time Sheet Records
  */
  TimeSheetLoop: for TimeSheetFor as TimeSheetcurs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId from TimeSheet where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteTimeSheet(In_TMSSGSPGenId) end for;
  /*
  Delete Certification Records
  */
  delete from EmpCertification where EmployeeSysId = In_EmployeeSysId;
  /*
  Delete HKPeriodOrdinance Records (HongKong only)
  */
  if FGetDBCountry(*) = 'HongKong' then call DeleteHKPeriodOrdinanceByEmployeeSysId(In_EmployeeSysId)
  end if;
  if FGetDBCountry(*) = 'Malaysia' then
    call DeleteMalBIKRecordByEmployeeSysId(In_EmployeeSysId);
    call DeleteMalBIKRecurringByEmployeeSysId(In_EmployeeSysId)
  end if;
  call DeletePayEmployee(In_EmployeeSysId);
  commit work
end
;

commit work;