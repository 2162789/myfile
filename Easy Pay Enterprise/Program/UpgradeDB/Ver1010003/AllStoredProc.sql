if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteSubPeriodRecords') then
   drop procedure ASQLDeleteSubPeriodRecords
end if
;

CREATE PROCEDURE "DBA"."ASQLDeleteSubPeriodRecords"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare CountSubPeriod integer;
  select count(*) into CountSubPeriod from SubPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if(CountSubPeriod = 1) then
    call ASQLDeletePeriodRecords(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)
  else
    delete from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from SubPeriodSetting where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from SubPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from OTRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from ShiftRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from MalBIKRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from DMBRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
      select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId from AllowanceRecord left outer join AllowanceHistoryRecord do
      if(EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod) then
        delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
        delete from AllowanceRecord where AllowanceSGSPGenId = GenId
      end if end for
  end if;
  commit work
end
;

commit work;