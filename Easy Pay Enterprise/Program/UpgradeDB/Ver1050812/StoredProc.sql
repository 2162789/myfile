if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCurrentKeyCostCentre' and user_name(creator) = 'DBA') then
   drop function DBA.FGetEmployeeCurrentKeyCostCentre
end if;

create function DBA.FGetEmployeeCurrentKeyCostCentre(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_CostCentreId char(20);
  select EmployeeCostCentre.CostCentreId into Out_CostCentreId
    from EmployeeCostCentre join CostProgression on
    EmployeeCostCentre.CostProgSysId = CostProgression.CostProgSysId where
    CostProgression.EmployeeSysId = In_EmployeeSysId and KeyCostCentre = 1 and
    CostCentreCurrent=1;
  return(Out_CostCentreId)
end;

