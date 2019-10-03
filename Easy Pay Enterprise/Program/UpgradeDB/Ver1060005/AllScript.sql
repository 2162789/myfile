if not exists (select 1 from sys.syscolumns where tname='RebateGranted' and cname='PrevEmployerSysId') then
   alter table dba.RebateGranted add PrevEmployerSysId integer default 0;
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsResignedEmployment') then
   drop FUNCTION IsResignedEmployment
end if
;
Create FUNCTION DBA.IsResignedEmployment(
in In_PersonalSysId integer)
RETURNS integer
BEGIN
    DECLARE out_LastPayDate DATE;
	SELECT FIRST FGetLastPayDate(EmployeeSysId) INTO out_LastPayDate FROM Employee
	WHERE PersonalSysId = in_PersonalSysId
	ORDER BY HireDate DESC;
	
    IF (out_LastPayDate IS NULL) THEN RETURN 2
	ELSEIF (out_LastPayDate != '1899-12-30' AND ((YEAR(out_LastPayDate) < YEAR(NOW(*))) OR
	    (MONTH(out_LastPayDate) < MONTH(NOW(*)) AND YEAR(out_LastPayDate) = YEAR(NOW(*)))))
       THEN RETURN 1
    ELSE RETURN 0 
	END IF;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteCostGroupPeriod') then
   drop PROCEDURE ASQLDeleteCostGroupPeriod
end if
;
Create PROCEDURE DBA.ASQLDeleteCostGroupPeriod(
in In_CostGroupYear integer,
in In_CostGroupPeriod integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostGroupPeriod where CostGroupYear = In_CostGroupYear and CostGroupPeriod=In_CostGroupPeriod ) then
    set Out_ErrorCode=-1; // CostGroupPeriod not exist
    return
  else
    delete from AccrualRecord where CostPeriodSysId in (select CostPeriodSysId from CostPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod);
    delete from CostTimeSheetRecord where CostRecordSysId in (select CostRecordSysId from CostRecord where CostPeriodSysId in (select CostPeriodSysId from CostPeriod where CostYear = In_CostGroupYear and CostPeriod=In_CostGroupPeriod));
    delete from CostRecord where CostPeriodSysId in (select CostPeriodSysId from CostPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod);
    delete from CostSubPeriod where CostPeriodSysId in (select CostPeriodSysId from CostPeriod where CostYear = In_CostGroupYear and CostPeriod =In_CostGroupPeriod);
    delete from CostPeriodHistory where CostPeriodSysId in (select CostPeriodSysId from CostPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod);
    delete from CostPeriodCostCentre where CostPeriodSysId in (select CostPeriodSysId from CostPeriod where CostYear = In_CostGroupYear and CostPeriod =In_CostGroupPeriod);
    delete from CostPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod;
    delete from CostGroupPeriod where CostGroupYear = In_CostGroupYear and CostGroupPeriod= In_CostGroupPeriod;
  end if;

end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayRecords') then
   drop PROCEDURE ASQLDeletePayRecords
end if
;
Create PROCEDURE DBA.ASQLDeletePayRecords(
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
        RebatePayrollPeriod = In_PayRecPeriod and
        PrevEmployerSysId = 0;
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
    delete from DMBRecord where
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
      end if end for;
    if(In_PayRecID = 'Normal') then
      update LeaveDeductionRecord set
        CurrentLveDays = 0,
        CurrentLveHours = 0,
        PreviousLveIncDays = 0,
        PreviousLveIncHours = 0 where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod;
      update LeaveInfoRecord set
        CurrLvePeriodTaken = 0 where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod
    end if;
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePeriodRecords') then
   drop PROCEDURE ASQLDeletePeriodRecords
end if
;
Create PROCEDURE DBA.ASQLDeletePeriodRecords(
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
  delete from DMBRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from RebateGranted where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
    RebatePayrollYear = In_PayRecYear and
    RebatePayrollPeriod = In_PayRecPeriod and
    PrevEmployerSysId = 0;
  delete from DeMinimisGranted where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
    DMBPayrollYear = In_PayRecYear and
    DMBPayrollPeriod = In_PayRecPeriod;
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

COMMIT WORK;

