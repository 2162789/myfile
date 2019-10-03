If exists(Select viewname From SysViews Where viewname='View_Acc_SG_TimeSheet') Then
    drop view "View_Acc_SG_TimeSheet";
End if;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewMandatoryContributeProg') then
  drop procedure InsertNewMandatoryContributeProg
end if;
create procedure dba.InsertNewMandatoryContributeProg(
in In_EmployeeSysId integer,
in In_MandContriCareerId char(20),
in In_MandContriEffDate date,
in In_MandContriPolicyId char(20),
in In_MandContriSchemeId char(20),
in In_MandContriRemarks char(100),
in In_MandContriCurrent smallint,
out Out_ErrorCode integer)
begin
  declare Out_MandContriSysId integer;
  if not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  elseif not In_MandContriPolicyId = any(select CPFPolicyId from CPFPolicy) then
    set Out_ErrorCode=-2; // MandContriPolicyId not exist
    return
  elseif not In_MandContriCareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-4; // MandContriCareerId not exist
    return
  elseif ((not In_MandContriSchemeId = any(select KeywordId from Keyword where KeywordCategory = 'CPFScheme')) and (FGetDBCountry(*) <> 'Indonesia')) then
    if FGetDBCountry(*) = 'Thailand' then
      if not In_MandContriSchemeId = any(select PFSchemeId from ProvidentFundScheme) then
        set Out_ErrorCode=-3; // MandContriSchemeId not exist
        return
      end if
    else
      set Out_ErrorCode=-3; // MandContriSchemeId not exist
      return
    end if
  end if;
  insert into MandatoryContributeProg(EmployeeSysId,MandContriCareerId,MandContriEffDate,MandContriPolicyId,MandContriSchemeId,MandContriRemarks,MandContriCurrent) values(
    In_EmployeeSysId,In_MandContriCareerId,In_MandContriEffDate,In_MandContriPolicyId,In_MandContriSchemeId,In_MandContriRemarks,In_MandContriCurrent);
  commit work;
  if
    not exists(select MandContriSysId into Out_MandContriSysId from MandatoryContributeProg where
      EmployeeSysId = In_EmployeeSysId and
      MandContriCareerId = In_MandContriCareerId and
      MandContriEffDate = In_MandContriEffDate and
      MandContriPolicyId = In_MandContriPolicyId and
      MandContriSchemeId = In_MandContriSchemeId and
      MandContriRemarks = In_MandContriRemarks and
      MandContriCurrent = In_MandContriCurrent) then
    set Out_ErrorCode=0; // System error
    return
  else
    select MandContriSysId into Out_MandContriSysId from MandatoryContributeProg where
      EmployeeSysId = In_EmployeeSysId and
      MandContriCareerId = In_MandContriCareerId and
      MandContriEffDate = In_MandContriEffDate and
      MandContriPolicyId = In_MandContriPolicyId and
      MandContriSchemeId = In_MandContriSchemeId and
      MandContriRemarks = In_MandContriRemarks and
      MandContriCurrent = In_MandContriCurrent;
    // mark current if this is the first record for that particular scheme
    if(select count(*) from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and MandContriSchemeId = In_MandContriSchemeId) = 1 then
      update MandatoryContributeProg set
        MandContriCurrent = 1 where
        MandContriSysId = Out_MandContriSysId
    end if;
    set Out_ErrorCode=Out_MandContriSysId // Successful
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateMandatoryContributeProg') then
  drop procedure UpdateMandatoryContributeProg
end if;
create procedure dba.UpdateMandatoryContributeProg(
in In_MandContriSysId integer,
in In_EmployeeSysId integer,
in In_MandContriCareerId char(20),
in In_MandContriEffDate date,
in In_MandContriPolicyId char(20),
in In_MandContriSchemeId char(20),
in In_MandContriRemarks char(100),
in In_MandContriCurrent smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from MandatoryContributeProg where MandContriSysId = In_MandContriSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  elseif not In_MandContriPolicyId = any(select CPFPolicyId from CPFPolicy) then
    set Out_ErrorCode=-3; // MandContriPolicyId not exist
    return
  elseif not In_MandContriCareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-5; // MandContriCareerId not exist
    return
  elseif ((not In_MandContriSchemeId = any(select KeywordId from Keyword where KeywordCategory = 'CPFScheme')) and (FGetDBCountry(*) <> 'Indonesia')) then
    if FGetDBCountry(*) = 'Thailand' then
      if not In_MandContriSchemeId = any(select PFSchemeId from ProvidentFundScheme) then
        set Out_ErrorCode=-4; // MandContriSchemeId not exist
        return
      end if
    else
      set Out_ErrorCode=-4; // MandContriSchemeId not exist
      return
    end if
  end if;
  // if this is current, set other record for this scheme to not current
  if In_MandContriCurrent = 1 then
    update MandatoryContributeProg set
      MandContriCurrent = 0 where
      EmployeeSysId = In_EmployeeSysId and
      MandContriSchemeId = In_MandContriSchemeId
  end if;
  update MandatoryContributeProg set
    EmployeeSysId = In_EmployeeSysId,
    MandContriCareerId = In_MandContriCareerId,
    MandContriEffDate = In_MandContriEffDate,
    MandContriPolicyId = In_MandContriPolicyId,
    MandContriSchemeId = In_MandContriSchemeId,
    MandContriRemarks = In_MandContriRemarks,
    MandContriCurrent = In_MandContriCurrent where
    MandContriSysId = In_MandContriSysId;
  commit work;
  set Out_ErrorCode=In_MandContriSysId // Successful
end
;

//
// Add new column for RptConfig - SkipPasswordEncryption. Alter store procedures for InsertNewRptConfig() and UpdateNewRptConfig().
//
IF NOT EXISTS(select 1 from sys.syscolumns where tname='RptConfig' and cname='SkipPasswordEncryption') THEN
    alter table DBA.RptConfig Add SkipPasswordEncryption smallint default 0;
end if;

Update RptConfig SET SkipPasswordEncryption=0;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewRptConfig') then
  drop procedure InsertNewRptConfig;
end if;

create  PROCEDURE DBA.InsertNewRptConfig(in In_RptConfigId char(40),
in In_UserId char(20),
in In_SysRptId char(40),
in In_RptConfigDesc char(100),
in In_IsDefaultConfig smallint,
in In_RptQueryId char(20),
in In_RptFileType char(20),
in In_DelBefIns char(20),
in In_RptSummaryLevel char(20),
in In_IsIndividualRpt smallint,
in In_RptOutputTo char(20),
in In_RptFilePath char(100),
in In_CompressFileExt char(20),
in In_SkipPasswordEncryption smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from RptConfig where RptConfigId = In_RptConfigId) then
    if Substr(In_RptConfigId,1,1) = '_' then
      set Out_ErrorCode=-1;
      return
    end if;
    insert into RptConfig(RptConfigId,
      UserId,
      SysRptId,
      RptConfigDesc,
      IsDefaultConfig,
      RptQueryId,
      RptFileType,
      DelBefIns,
      RptSummaryLevel,
      IsIndividualRpt,
      RptOutputTo,
      RptFilePath,
      CompressFileExt) values(
      In_RptConfigId,
      In_UserId,
      In_SysRptId,
      In_RptConfigDesc,
      In_IsDefaultConfig,
      In_RptQueryId,
      In_RptFileType,
      In_DelBefIns,
      In_RptSummaryLevel,
      In_IsIndividualRpt,
      In_RptOutputTo,
      In_RptFilePath,
      In_CompressFileExt,
      In_SkipPasswordEncryption);
    commit work;
    if not exists(select* from RptConfig where RptConfigId = In_RptConfigId) then
      set Out_ErrorCode=0
    else
      //
      // Get and copy default RptCompConfig
      //
      RptCompConfigLoop: for RptCompConfigFor as Cur_RptCompSysId dynamic scroll cursor for
        select SysRptCompName as Cur_SysRptCompName,RptCompItemSysId as Cur_RptCompItemSysId,ItemValue as Cur_ItemValue from
          RptConfig join RptCompConfig join
          RptCompItemConfig where
          RptConfig.SysRptId = In_SysRptId and UserId is null order by
          RptCompConfig.RptCompSysId asc,RptCompItemSysId asc do
        call ASQLUpdateRptCompItemConfig(Cur_RptCompItemSysId,In_RptConfigId,In_SysRptId,Cur_SysRptCompName,Cur_ItemValue,Out_ErrorCode) end for;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateRptConfig') then
  drop procedure UpdateRptConfig;
end if;


CREATE PROCEDURE DBA.UpdateRptConfig(in In_RptConfigId char(40),
in In_UserId char(20),
in In_SysRptId char(40),
in In_RptConfigDesc char(100),
in In_IsDefaultConfig smallint,
in In_RptQueryId char(20),
in In_RptFileType char(20),
in In_DelBefIns char(20),
in In_RptSummaryLevel char(20),
in In_IsIndividualRpt smallint,
in In_RptOutputTo char(20),
in In_RptFilePath char(100),
in In_CompressFileExt char(20),
in In_SkipPasswordEncryption smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from RptConfig where RptConfigId = In_RptConfigId) then
    update RptConfig set
      UserId = In_UserId,
      SysRptId = In_SysRptId,
      RptConfigDesc = In_RptConfigDesc,
      IsDefaultConfig = In_IsDefaultConfig,
      RptQueryId = In_RptQueryId,
      RptFileType = In_RptFileType,
      DelBefIns = In_DelBefIns,
      RptSummaryLevel = In_RptSummaryLevel,
      IsIndividualRpt = In_IsIndividualRpt,
      RptOutputTo = In_RptOutputTo,
      RptFilePath = In_RptFilePath, 
      CompressFileExt = In_CompressFileExt,
      SkipPasswordEncryption = In_SkipPasswordEncryption where
      RptConfigId = In_RptConfigId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end;


commit work;