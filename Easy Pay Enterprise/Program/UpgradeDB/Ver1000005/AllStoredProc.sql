if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLConvertLeavePolicyBasis') then
   drop procedure ASQLConvertLeavePolicyBasis
end if
;

CREATE PROCEDURE "DBA"."ASQLConvertLeavePolicyBasis"(
in In_LeavePolicyId char(20),
in In_LeavePolicyBasis char(20))
begin
  delete from LeavePolicyRecord where LeavePolicyId = In_LeavePolicyId;
  update LeavePolicy set LeavePolicyBasis = In_LeavePolicyBasis where LeavePolicyId = In_LeavePolicyId;
  commit work;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'IsEPClassicDB') then
   drop procedure IsEPClassicDB
end if
;

CREATE FUNCTION "DBA"."IsEPClassicDB"()
returns smallint
begin
  declare Out_IsEPClassic smallint;

  select locate(FunctionList, 'EP Classic', 1) into Out_IsEPClassic 
    from LicenseRecord where 
    ProductName = 'Easy Pay Enterprise' and 
    SubProductName = 'Main' and
    length(FunctionList) > 0;

  return(Out_IsEPClassic)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetECModuleScreenId') then
   drop procedure FGetECModuleScreenId
end if
;

CREATE FUNCTION "DBA"."FGetECModuleScreenId"(
in In_ModuleScreenId char(20))
returns char(20)
begin
  declare Out_ECModuleScreenId char(20);

  if (IsEPClassicDB()=0) then
    set Out_ECModuleScreenId = In_ModuleScreenId;
  else
    if exists (select 1 from ModuleScreenGroup where ModuleScreenId = In_ModuleScreenId) then
      set Out_ECModuleScreenId = In_ModuleScreenId;
    else
      select EC_ModuleScreenId into Out_ECModuleScreenId
        from ModuleScreenGroup where
        ModuleScreenId = In_ModuleScreenId;
    end if;
  end if;

  return(Out_ECModuleScreenId)
end
;

