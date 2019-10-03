READ UpgradeDB\Ver1060407\UsageItem.sql;

If exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSystemUser') then
  drop procedure DeleteSystemUser
end if;

create procedure dba.DeleteSystemUser(
in In_UserId char(20))
begin
  if exists(select* from SystemUser where SystemUser.UserId = In_UserId) then
    DeleteQueryRecLoop: for DeleteQueryFor as Cur_DeleteQuery dynamic scroll cursor for
      select QueryRecId as In_QueryRecId from AdHocQueryRec where UserId = In_UserId do
      call DeleteAdHocQueryFieldsRecord(In_QueryRecId);
      call DeleteUserSecurityQuery(In_QueryRecId);
      call DeleteAdHocQueryRecord(In_QueryRecId) end for;
    delete from LoginRec where LoginRec.UserId = In_UserId;
    delete from UserSearchSetting where UserId = In_UserId;
    delete from PasswordHistory where UserId = In_UserId;
	delete from Task where CreatedBy = In_UserId;
	delete from RemSetup where CreatedBy = In_UserId;
	delete from UpdatePatchLog where UserId = In_UserId;
	delete from CustomisedPatchLog where UserId = In_UserId;
    delete from SystemUser where
      SystemUser.UserId = In_UserId;
    commit work
  end if
end
;

commit work;

