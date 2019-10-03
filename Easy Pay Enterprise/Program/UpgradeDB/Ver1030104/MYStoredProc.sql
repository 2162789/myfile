if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxDetails') then
   drop procedure DeleteMalTaxDetails
end if
;

CREATE PROCEDURE "DBA"."DeleteMalTaxDetails"(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  call DeleteMalRebateClaimByPersonalSysId(In_PersonalSysId,Out_ErrorCode);
  call DeleteMalRebateGrantedByPersonalSysId(In_PersonalSysId,Out_ErrorCode);
  delete from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId;
  delete from MalTaxEmployee where PersonalSysId = In_PersonalSysId;
  delete from MalTaxRecord where PersonalSysId = In_PersonalSysId;
  delete from MalTaxDetails where PersonalSysId = In_PersonalSysId;
  set Out_ErrorCode=1
end
;

COMMIT WORK;
