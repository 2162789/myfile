//Employee Listing Report

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPHManContriPolicy') then
   drop PROCEDURE FGetPHManContriPolicy;
end if;

CREATE FUNCTION "DBA"."FGetPHManContriPolicy"(
in In_EmployeeSysId integer)
returns char(100)
begin
  
  declare Out_HDMFPolicy char(30);
  select MandContriPolicyId into Out_HDMFPolicy
  from mandatorycontributeprog  where
  mandatorycontributeprog.EmployeeSysId = In_EmployeeSysId and
  MandContriSchemeId='HDMF' and MandContriCurrent = 1 ;

  if Out_HDMFPolicy is null then set Out_HDMFPolicy='NA'
  end if;

  return(Out_HDMFPolicy)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPHManContriScheme') then
   drop PROCEDURE FGetPHManContriScheme;
end if;

CREATE FUNCTION "DBA"."FGetPHManContriScheme"(
in In_EmployeeSysId integer)
returns char(100)
begin
  
  declare Out_HDMFScheme char(30);
 
  select MandContriSchemeId into Out_HDMFScheme
  from mandatorycontributeprog  where
  mandatorycontributeprog.EmployeeSysId = In_EmployeeSysId and
  MandContriSchemeId='HDMF' and MandContriCurrent = 1 ;

  if Out_HDMFScheme is null then set Out_HDMFScheme='NA'
  end if;

  return(Out_HDMFScheme);
end;

commit work;