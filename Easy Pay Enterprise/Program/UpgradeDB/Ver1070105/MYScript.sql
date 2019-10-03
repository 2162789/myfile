//Employee Listing Report

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentEPFScheme') then
   drop PROCEDURE FGetCurrentEPFScheme;
end if;

CREATE FUNCTION "DBA"."FGetCurrentEPFScheme"(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_EPFScheme char(30);
  select EPFProgSchemeId into Out_EPFScheme
    from epfprogression where
    epfprogression.EmployeeSysId = In_EmployeeSysId and
    epfprogcurrent = 1;
  return(Out_EPFScheme)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentEPFPolicyTable') then
   drop PROCEDURE FGetCurrentEPFPolicyTable;
end if;

CREATE FUNCTION "DBA"."FGetCurrentEPFPolicyTable"(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_EPFScheme char(30);
  select EPFProgPolicyId into Out_EPFScheme
    from Epfprogression where
    epfprogression.EmployeeSysId = In_EmployeeSysId and
    epfprogcurrent = 1;
  return(Out_EPFScheme)
end;



commit work;