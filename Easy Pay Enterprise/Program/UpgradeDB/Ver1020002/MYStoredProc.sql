if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalEmployeeIdByRebateGranted') then
   drop procedure FGetMalEmployeeIdByRebateGranted
end if
;

create function DBA.FGetMalEmployeeIdByRebateGranted(
in In_PersonalSysId integer,
in In_RebatePayrollYear integer,
in In_RebatePayrollPeriod integer)
returns char(20)
begin
  declare Out_EmployeeID char(20);
  select Employee.EmployeeID into Out_EmployeeID
    from
    PayRecord join Employee on PayRecord.EmployeeSysId = Employee.EmployeeSysId where
    PayRecord.PayRecYear = In_RebatePayrollYear and
    PayRecord.PayRecPeriod = In_RebatePayrollPeriod and
    FGetPersonalSysIdByEmployeeSysID(Employee.EmployeeSysID) = In_PersonalSysID;
  return(Out_EmployeeID)
end
;