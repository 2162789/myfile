if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewIndoTaxDetails') then
  drop procedure InsertNewIndoTaxDetails
end if;
create procedure dba.InsertNewIndoTaxDetails(
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoEETaxNo char(30),
in In_NoOfDependent integer,
in In_IndoTaxMethod char(20),
in In_PensionWorker smallint,
in In_TaxCategory char(20),
in In_ClaimMarriageRelief smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
    insert into IndoTaxDetails(PersonalSysId,
      IndoTaxPolicyId,
      IndoTaxEmployerId,
      IndoEETaxNo,
      NoOfDependent,
      IndoTaxMethod,
      PensionWorker,
      TaxCategory,
      ClaimMarriageRelief) values(
      In_PersonalSysId,
      In_IndoTaxPolicyId,
      In_IndoTaxEmployerId,
      In_IndoEETaxNo,
      In_NoOfDependent,
      In_IndoTaxMethod,
      In_PensionWorker,
      In_TaxCategory,
      In_ClaimMarriageRelief);
    commit work;
    if not exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists (select 1 from sys.sysprocedure where proc_name = 'UpdateIndoTaxDetails') then
  drop procedure UpdateIndoTaxDetails
end if;
create procedure dba.UpdateIndoTaxDetails(
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoEETaxNo char(30),
in In_NoOfDependent integer,
in In_IndoTaxMethod char(20),
in In_PensionWorker smallint,
in In_TaxCategory char(20),
in In_ClaimMarriageRelief smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
    update IndoTaxDetails set
      IndoTaxPolicyId = In_IndoTaxPolicyId,
      IndoTaxEmployerId = In_IndoTaxEmployerId,
      IndoEETaxNo = In_IndoEETaxNo,
      NoOfDependent = In_NoOfDependent,
      IndoTaxMethod = In_IndoTaxMethod,
      PensionWorker = In_PensionWorker,
      TaxCategory = In_TaxCategory,
      ClaimMarriageRelief = In_ClaimMarriageRelief where
      PersonalSysId = In_PersonalSysId;
    if(select IdentityTypeId from Personal where PersonalSysId = In_PersonalSysId) = 'NPWP' then
      update Personal set IdentityNo = In_IndoEETaxNo where PersonalSysId = In_PersonalSysId
    end if;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

/* Add Claim Marriage Relief for Indonesia Tax Detail Viewer*/
if not exists(select * from ImportFieldName where TableNamePhysical = 'iIndoTaxDetails' and FieldNamePhysical = 'ClaimMarriageRelief') then
   insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iIndoTaxDetails','ClaimMarriageRelief','Claim Marriage Relief','Numeric',0);
end if;

commit work;