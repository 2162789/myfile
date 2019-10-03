if exists(select 1 from sys.sysprocedure where proc_name = 'IsMalAllowanceHasRebateProperty') then
   drop procedure IsMalAllowanceHasRebateProperty
end if
;

CREATE FUNCTION DBA.IsMalAllowanceHasRebateProperty(in In_EmployeeSysId integer, in In_PayRecYear integer, in In_FormulaId char(20))
returns integer
begin
  declare Out_result integer;
  declare Out_PersonalSysId integer;
  declare Out_MalTaxPolicyProgSysId integer;

  Select PersonalSysId into Out_PersonalSysId From Employee where EmployeeSysId = In_EmployeeSysId;
  
  Select first MalTaxPolicyProgSysId into Out_MalTaxPolicyProgSysId From MalTaxPolicyProg where 
  MalTaxPolicyId in (Select MalTaxPolicyId from MalTaxDetails where PersonalSysId = Out_PersonalSysId) and
  Year(MalTaxPolicyEffDate) <= In_PayRecYear Order By MalTaxPolicyEffDate desc;
  
  select Count(*) into Out_result from FormulaProperty where FormulaId = In_FormulaId and 
  KeywordId in(select distinct RebateProperty from RebateItem join RebateSetup where MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId);

  if Out_result >= 1 then return 1
  end if;
  return 0
end;

IF NOT EXISTS (SELECT * FROM SubRegistry WHERE RegistryId = 'MalGovForm' AND SubRegistryId = 'ShowEACrossCheckRpt') THEN
  INSERT INTO SubRegistry VALUES ('MalGovForm','ShowEACrossCheckRpt','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;

COMMIT WORK;