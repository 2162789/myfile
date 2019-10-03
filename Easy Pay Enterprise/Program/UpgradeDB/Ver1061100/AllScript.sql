if not exists(select * from ePortalVersion Where EPE = '1061100') then
   Insert into ePortalVersion(EPE,ePortal) Values('1061100','1030000');
end if;

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
      CompressFileExt,
      SkipPasswordEncryption) values(
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

if not exists(select * from Subregistry where SubRegistryId = 'TMSViewSystemInfo') then
  Insert into Subregistry (RegistryId,SubRegistryId,RegProperty1) values ('SageProdIntegrate','TMSViewSystemInfo','View_TMS_SystemInfo');
end if;
commit work;