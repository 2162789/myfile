if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRefreshEmpeeOtherInfo') then
   drop procedure ASQLRefreshEmpeeOtherInfo
end if
;

CREATE PROCEDURE DBA.ASQLRefreshEmpeeOtherInfo(in In_EmployeeSysId integer,
in In_EmpeeOtherInfoDataType char(100),
out Out_ErrorCode integer)
begin
  declare Out_ResStatus char(30);
  declare Out_IdentityNo char(20);
  if not exists(select* from Employee where Employee.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    if In_EmpeeOtherInfoDataType is null or In_EmpeeOtherInfoDataType = '' then
      set In_EmpeeOtherInfoDataType='%'
    end if;
    EmpeeOtherInfoLoop: for EmpeeOtherInfoForLoop as Cur_EmpeeOtherInfo dynamic scroll cursor for
      select SubRegistryId as In_EmpeeOtherInfoId,RegProperty1 as In_EmpeeOtherInfoCaption,RegProperty2 as In_EmpeeOtherInfoType from
        Subregistry where
        RegistryId = 'EmpeeOtherInfo' and
        RegProperty2 like In_EmpeeOtherInfoDataType and
        In_EmpeeOtherInfoCaption <> '' do
      if not exists(select* from EmpeeOtherInfo where
          EmpeeOtherInfoId = In_EmpeeOtherInfoId and
          EmployeeSysId = In_EmployeeSysId) then
        if(In_EmpeeOtherInfoId = 'SOCSONo') then
          // special processing for SOCSONo
          select FGetCurrentResStatus(PersonalSysId) into Out_ResStatus from Employee where EmployeeSysId = In_EmployeeSysId;
          if(Out_ResStatus = 'Local') then
            select IdentityNo into Out_IdentityNo from Employee where EmployeeSysId = In_EmployeeSysId
          else
            set Out_IdentityNo=''
          end if;
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,Out_IdentityNo,0,0)
        elseif(In_EmpeeOtherInfoId = 'SDFOption') then
          // special processing for SDFOption
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',1,0)
        elseif(In_EmpeeOtherInfoId = 'HRDFOption') then
          // special processing for HRDFOption
          select FGetCurrentResStatus(PersonalSysId) into Out_ResStatus from Employee where EmployeeSysId = In_EmployeeSysId;
          if(Out_ResStatus = 'Local' or Out_ResStatus = 'PR') then
            call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',1,0)
          else
            call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',0,0)
          end if;
        else
          // normal insert
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',0,0)
        end if
      else
        update EmpeeOtherInfo set
          EmpeeOtherInfoCaption = In_EmpeeOtherInfoCaption,
          EmpeeOtherInfoType = In_EmpeeOtherInfoType where
          EmpeeOtherInfoId = In_EmpeeOtherInfoId and
          EmployeeSysId = In_EmployeeSysId
      end if end for;
    commit work
  end if
end;

commit work;
