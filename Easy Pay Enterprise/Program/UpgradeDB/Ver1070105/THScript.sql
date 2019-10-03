//Employee Listing Report

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTHManContriPolicy') then
   drop PROCEDURE FGetTHManContriPolicy;
end if;

CREATE FUNCTION "DBA"."FGetTHManContriPolicy"(
in In_EmployeeSysId integer)
returns char(100)
begin
  
  declare Out_PFPolicy char(30);
  select MandContriPolicyId into Out_PFPolicy
  from mandatorycontributeprog  where
  mandatorycontributeprog.EmployeeSysId = In_EmployeeSysId and
  MandContriSchemeId='Provident Fund 1' and MandContriCurrent = 1 ;

  if Out_PFPolicy is null then set Out_PFPolicy='NA'
  end if;

  return(Out_PFPolicy);
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTHManContriScheme') then
   drop PROCEDURE FGetTHManContriScheme;
end if;

CREATE FUNCTION "DBA"."FGetTHManContriScheme"(
in In_EmployeeSysId integer)
returns char(100)
begin
  
  declare Out_PFScheme char(30);
 
  select MandContriSchemeId into Out_PFScheme
  from mandatorycontributeprog  where
  mandatorycontributeprog.EmployeeSysId = In_EmployeeSysId and
  MandContriSchemeId='Provident Fund 1' and MandContriCurrent = 1 ;

  if Out_PFScheme is null then set Out_PFScheme='NA'
  end if;

  return(Out_PFScheme);
end;

commit work;