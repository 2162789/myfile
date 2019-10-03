//Employee Listing Report

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentMPFPolicyTable') then
   drop PROCEDURE FGetCurrentMPFPolicyTable;
end if;

CREATE FUNCTION "DBA"."FGetCurrentMPFPolicyTable"(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_MPFPolicy char(30);
  select MPFMandatoryPolicyId into Out_MPFPolicy
    from mpfprogression where
    mpfprogression.EmployeeSysId = In_EmployeeSysId and
    MPFScheme='MPF' and mpfcurrent = 1;
  return(Out_MPFPolicy);
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentMPFScheme') then
   drop PROCEDURE FGetCurrentMPFScheme;
end if;

CREATE FUNCTION "DBA"."FGetCurrentMPFScheme"(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_MPFScheme char(30);
  select MPFScheme into Out_MPFScheme
    from mpfprogression where
    MPFScheme='MPF' and mpfprogression.EmployeeSysId = In_EmployeeSysId and
    mpfcurrent = 1;
  return(Out_MPFScheme);
end;

commit work;