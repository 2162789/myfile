if exists(select 1 from sys.sysprocedure where proc_name = 'FGetECModuleScreenId') then
   drop procedure FGetECModuleScreenId
end if
;

CREATE FUNCTION "DBA"."FGetECModuleScreenId"(
in In_ModuleScreenId char(20))
returns char(20)
begin
  declare Out_IsEPClassic smallint;
  declare Out_ECModuleScreenId char(20);

  select locate(FunctionList, 'EP Classic', 1) into Out_IsEPClassic 
    from LicenseRecord where 
    ProductName = 'Easy Pay Enterprise' and 
    SubProductName = 'Main' and
    length(FunctionList) > 0;

  if (Out_IsEPClassic=0) then
    set Out_ECModuleScreenId = In_ModuleScreenId;
  else
    select EC_ModuleScreenId into Out_ECModuleScreenId
      from ModuleScreenGroup where
      ModuleScreenId = In_ModuleScreenId;
  end if;

  return(Out_ECModuleScreenId)
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCPFProgression') then
   drop procedure ASQLUpdateCPFProgression
end if
;

CREATE PROCEDURE "DBA"."ASQLUpdateCPFProgression"(in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_NewCPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFProgRemarks char(255))

BEGIN
    if (In_NewCPFEffectiveDate = In_CPFEffectiveDate) then

       Call UpdateCPFProgression(In_EmployeeSysId, In_CPFEffectiveDate, 
        In_CPFProgCurrent, In_CPFCareerId, In_CPFProgPolicyId, In_CPFProgAccountNo, In_CPFProgSchemeId,
        In_CPFMAWOption, In_CPFMAWLimit , In_CPFMAWPeriodOrdWage, In_CPFMedisavePaidByER, In_CPFProgRemarks);
    else
        // Remove CPFEddactiveDate record 
        if exists(select * from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
            Call DeleteCPFProgressionRec(In_EmployeeSysId, In_CPFEffectiveDate);
        end if;
        // Remove NewCPFEddactiveDate record if already exists
        if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_NewCPFEffectiveDate) then
            Call DeleteCPFProgressionRec(In_EmployeeSysId, In_NewCPFEffectiveDate);
        end if;
        Call InsertNewCPFProgression(In_EmployeeSysId, In_NewCPFEffectiveDate, 
            In_CPFProgCurrent, In_CPFCareerId, In_CPFProgPolicyId, In_CPFProgAccountNo, In_CPFProgSchemeId,
            In_CPFMAWOption, In_CPFMAWLimit , In_CPFMAWPeriodOrdWage, In_CPFMedisavePaidByER, In_CPFProgRemarks);
  end if
END
;


if exists(select 1 from sys.sysprocedure where proc_name = 'IsModuleAccessible') then
   drop procedure IsModuleAccessible
end if
;

CREATE FUNCTION "DBA"."IsModuleAccessible"(
in In_UserGroupId char(20),
in In_ModuleScreenId char(20))
returns smallint
begin 
  if ((In_ModuleScreenId <> '' and In_ModuleScreenId is not null) and 
    not exists(select* from UserModuleNoAccess where
      ModuleScreenId = In_ModuleScreenId and
      UserGroupId = In_UserGroupId)) then
    return 1
  end if;
  return 0
end
;

