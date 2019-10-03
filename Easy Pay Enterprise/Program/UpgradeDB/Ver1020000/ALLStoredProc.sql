if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodLveAmount') then
   drop procedure FGetPayPeriodLveAmount
end if
;

CREATE FUNCTION "DBA"."FGetPayPeriodLveAmount"(
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
      PayRecPeriod = In_PayRecPeriod and LeaveTypeFunctCode = In_LeaveType
  else
    select sum(LveAmount) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType
  end if;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayEmployeePolicy') then
   drop procedure DeletePayEmployeePolicy
end if
;

CREATE PROCEDURE "DBA"."DeletePayEmployeePolicy"(
in In_EmployeeSysId integer)
begin
  if exists(select* from PayEmployeePolicy where
      PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId) then

    if FGetDBCountry(*) = 'Malaysia' then
        call DeleteMalPrevEmployerByEmployeeSysId(In_EmployeeSysId);
    end if;

    delete from PayEmployeePolicy where
      PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

commit work;