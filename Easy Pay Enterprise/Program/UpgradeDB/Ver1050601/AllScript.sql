if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSystemUser') then
   drop procedure DeleteSystemUser
end if
;

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
    delete from SystemUser where
      SystemUser.UserId = In_UserId;
    commit work
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSystemUserGroup') then
   drop procedure DeleteSystemUserGroup
end if
;

create procedure dba.DeleteSystemUserGroup(
in In_UserGroupId char(20))
begin
  declare In_UserId char(20);

  if exists(select* from SystemUser where
      SystemUser.UserGroupId = In_UserGroupId) then
    SystemUserLoop: for SystemUserFor as SystemUserCurs dynamic scroll cursor for
        select UserId as In_UserId from SystemUser where
            SystemUser.UserGroupId = In_UserGroupId do
        call DeleteSystemUser(In_UserId) end for;
    commit work
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSystemUser') then
   drop procedure InsertNewSystemUser
end if
;

create procedure dba.InsertNewSystemUser(
in In_UserId char(20),
in In_UserGroup char(20),
in In_UserPassword char(50),
in In_ExpiryDate date,
in In_FirstTimeLogin integer,
in In_SysPersonalSysId integer,
in In_IsDirServices smallint,
in In_DirServicesUserName char(200),
in In_DirServicesDomainName char(200))
begin
  if not exists(select* from SystemUser where SystemUser.UserId = In_UserId) then
    insert into SystemUser(
      UserId,
      UserGroupId,
      UserPassword,
      ExpiryDate,
      FirstTimeLogin,
      SysPersonalSysId,
      IsDirServices,
      DirServicesUserName,
      DirServicesDomainName) values(
      In_UserId,
      In_UserGroup,
      In_UserPassword,
      In_ExpiryDate,
      In_FirstTimeLogin,
      In_SysPersonalSysId,
      In_IsDirServices,
      In_DirServicesUserName,
      In_DirServicesDomainName);
    
    /* directly insert 1 record into PasswordHistory table upon insert of new SystemUser record*/
    insert into PasswordHistory(
      UserId, 
      UserPassword) values(
      In_UserId,
      In_UserPassword);

    commit work
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSystemUser') then
   drop procedure UpdateSystemUser
end if
;

create procedure dba.UpdateSystemUser(
in In_UserId char(20),
in In_UserGroupId char(20),
in In_UserPassword char(50),
in In_ExpiryDate date,
in In_FirstTimeLogin integer,
in In_SysPersonalSysId integer,
in In_IsDirServices smallint,
in In_DirServicesUserName char(200),
in In_DirServicesDomainName char(200),
in In_LastFailDateTime timestamp,
in In_AccumulatedFails integer)
begin
  declare In_KeepPasswordHistory smallint;

  if exists(select* from SystemUser where SystemUser.UserId = In_UserId) then
    update SystemUser set
      SystemUser.UserGroupId = In_UserGroupId,
      SystemUser.UserPassword = In_UserPassword,
      SystemUser.ExpiryDate = In_ExpiryDate,
      SystemUser.FirstTimeLogin = In_FirstTimeLogin,
      SystemUser.SysPersonalSysId = In_SysPersonalSysId,
      SystemUser.IsDirServices = In_IsDirServices,
      SystemUser.DirServicesUserName = In_DirServicesUserName,
      SystemUser.DirServicesDomainName = In_DirServicesDomainName,
      SystemUser.LastFailDateTime = In_LastFailDateTime,
      SystemUser.AccumulatedFails = In_AccumulatedFails where
      SystemUser.UserId = In_UserId;

    select BooleanAttr into In_KeepPasswordHistory from SubRegistry where RegistryId = 'System' and SubRegistryId = 'PasswordPolicy';
    if (In_KeepPasswordHistory = 1) then
        insert into PasswordHistory (
          UserId, 
          UserPassword) values(
          In_UserId,
          In_UserPassword);
    
        /* purge records older than latest 10*/
        delete from PasswordHistory where PasswordHxSysId in (
          select PasswordHxSysId from PasswordHistory where UserId = In_UserId) and PasswordHxSysId not in (
          select top 10 PasswordHxSysId from PasswordHistory where UserId = In_UserId
          order by PasswordHxSysId desc);
    else
        update PasswordHistory set UserPassword = In_UserPassword
        where UserId = In_UserId;
    end if;

    commit work
  end if
end;

commit work;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'System' and SubRegistryId = 'PasswordPolicy')
then
  insert into SubRegistry
  values ('System','PasswordPolicy','8','0','0','0','0','3','0','0','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

update SystemUser set
  LastFailDateTime = '1899-12-30 00:00:00',
  AccumulatedFails = 0;

insert into PasswordHistory (UserId, UserPassword) 
select UserId, UserPassword from SystemUser;

commit work;
