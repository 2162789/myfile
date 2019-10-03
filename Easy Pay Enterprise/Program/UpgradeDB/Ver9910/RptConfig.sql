/* ============================================================ */
/*   Database name:  Model_37                                   */
/*   DBMS name:      Sybase AS Anywhere 6                       */
/*   Created on:     9/3/2007  11:31 AM                         */
/* ============================================================ */

create procedure
dba.DeleteRptCompItemConfig(
in In_RptConfigId char(30),
in In_SysRptId char(40),
in In_SysRptCompName char(40),
out Out_ErrorCode integer)
begin
  if exists(select* from RptCompItemConfig join RptCompConfig where RptConfigId = In_RptConfigId and SysRptId = In_SysRptId and SysRptCompName = In_SysRptCompName) then
    delete from RptCompItemConfig where RptCompSysId = any(select RptCompSysId from RptCompConfig where RptConfigId = In_RptConfigId and SysRptId = In_SysRptId and SysRptCompName = In_SysRptCompName);
    commit work;
    if exists(select* from RptCompItemConfig join RptCompConfig where RptConfigId = In_RptConfigId and SysRptId = In_SysRptId and SysRptCompName = In_SysRptCompName) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure DBA.ASQLUpdateRptCompItemConfig(
in In_RptCompItemSysId integer,
in In_RptConfigId char(40),
in In_SysRptId char(40),
in In_SysRptCompName char(40),
in In_ItemValue char(100),
out Out_ErrorCode integer)
begin
  declare In_RptCompSysId char(30);
  set Out_ErrorCode=0;
  if exists(select* from RptCompConfig where RptConfigId = In_RptConfigId and
      SysRptId = In_SysRptId and SysRptCompName = In_SysRptCompName) then
    select RptCompSysId into In_RptCompSysId from RptCompConfig where RptConfigId = In_RptConfigId and
      SysRptId = In_SysRptId and SysRptCompName = In_SysRptCompName;
    if exists(select* from RptCompItemConfig where RptCompSysId = In_RptCompSysId and RptCompItemSysId = In_RptCompItemSysId) then
      //
      // Update RptCompItemConfig
      //
      update RptCompItemConfig set ItemValue = In_ItemValue where
        RptCompSysId = In_RptCompSysId and RptCompItemSysId = In_RptCompItemSysId;
      commit work;
      set Out_ErrorCode=1
    else
      //
      // Insert RptCompItemConfig
      //
      insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) values(
        In_RptCompSysId,In_RptCompItemSysId,In_ItemValue);
      commit work;
      set Out_ErrorCode=1
    end if
  else
    //
    // Insert RptCompConfig and RptCompItemConfig
    //
    if exists(select* from SystemRptComp where SysRptId = In_SysRptId and SysRptCompName = In_SysRptCompName) then
      set In_RptCompSysId=FGetNewSGSPGeneratedIndex('RptCompConfig');
      insert into RptCompConfig(RptCompSysId,SysRptId,SysRptCompName,RptConfigId) values(
        In_RptCompSysId,In_SysRptId,In_SysRptCompName,In_RptConfigId);
      commit work;
      if exists(select* from RptCompConfig where RptCompSysId = In_RptCompSysId) then
        insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) values(
          In_RptCompSysId,In_RptCompItemSysId,In_ItemValue);
        commit work;
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=-1
    end if
  end if
end
;

create procedure dba.DeleteBatchRpt(
in In_BatchRptSysId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from BatchRpt where BatchRptSysId = In_BatchRptSysId) then
    call DeleteBatchRptItem(In_BatchRptSysId,Out_ErrorCode);
    delete from BatchRpt where BatchRptSysId = In_BatchRptSysId;
    commit work;
    if exists(select* from BatchRpt where BatchRptSysId = In_BatchRptSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.DeleteBatchRptItem(
in In_BatchRptSysId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId) then
    delete from BatchRptItem where BatchRptSysId = In_BatchRptSysId;
    commit work;
    if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.DeleteRptConfig(
in In_RptConfigId char(40),
out Out_ErrorCode integer)
begin
  if exists(select* from RptConfig where RptConfigId = In_RptConfigId) then
    if not exists(select* from BatchRpt where BatchRptConfigId = In_RptConfigId) then
      /* Delete RptCompItemConfig*/
      RptCompConfigLoop: for RptCompConfigFor as Cur_RptCompSysId dynamic scroll cursor for
        select RptCompSysId as Get_RptCompSysId from RptCompConfig where RptConfigId = In_RptConfigId do
        delete from RptCompItemConfig where RptCompSysId = Get_RptCompSysId;
        commit work end for;
      /* Delete RptCompConfig*/
      delete from RptCompConfig where RptConfigId = In_RptConfigId;
      commit work;
      /* Delete RptConfig*/
      delete from RptConfig where RptConfigId = In_RptConfigId;
      commit work;
      if exists(select* from RptConfig where RptConfigId = In_RptConfigId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewBatchRpt(
in In_BatchRptConfigId char(40),
in In_BatchRptLevel char(20),
in In_BatchKey1 char(50),
in In_BatchKey2 char(50),
in In_BatchKey3 char(50),
in In_BatchKey4 char(50),
in In_BatchKey5 char(50),
in In_BatchKey6 char(50),
in In_BatchKey7 char(50),
in In_BatchKey8 char(50),
in In_BatchKey9 char(50),
in In_BatchKey10 char(50),
in In_BatchRptDesc char(100),
out Out_BatchRptSysId char(30),
out Out_ErrorCode integer)
begin
  if not exists(select* from BatchRpt where BatchRptConfigId = In_BatchRptConfigId and
      BatchRptLevel = In_BatchRptLevel and
      BatchKey1 = In_BatchKey1 and BatchKey2 = In_BatchKey2 and
      BatchKey3 = In_BatchKey3 and BatchKey4 = In_BatchKey4 and
      BatchKey5 = In_BatchKey5 and BatchKey6 = In_BatchKey6 and
      BatchKey7 = In_BatchKey7 and BatchKey8 = In_BatchKey8 and
      BatchKey9 = In_BatchKey9 and BatchKey10 = In_BatchKey10) then
    set Out_BatchRptSysId=FGetNewSGSPGeneratedIndex('BatchRpt');
    insert into BatchRpt(BatchRptSysId,
      BatchRptConfigId,
      BatchRptLevel,
      BatchKey1,
      BatchKey2,
      BatchKey3,
      BatchKey4,
      BatchKey5,
      BatchKey6,
      BatchKey7,
      BatchKey8,
      BatchKey9,
      BatchKey10,
      BatchRptDesc,
      BatchStartDateTime) values(
      Out_BatchRptSysId,
      In_BatchRptConfigId,
      In_BatchRptLevel,
      In_BatchKey1,
      In_BatchKey2,
      In_BatchKey3,
      In_BatchKey4,
      In_BatchKey5,
      In_BatchKey6,
      In_BatchKey7,
      In_BatchKey8,
      In_BatchKey9,
      In_BatchKey10,
      In_BatchRptDesc,
      Now(*));
    commit work;
    if not exists(select* from BatchRpt where BatchRptSysId = Out_BatchRptSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewBatchRptItem(
in In_BatchRptSysId char(30),
in In_RptPersonEmpeeSysId integer,
out Out_BatchRptItemSysId integer,
out Out_ErrorCode integer)
begin
  if In_RptPersonEmpeeSysId is null then
    // Summary Rpt
    if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId) then
      set Out_BatchRptItemSysId=1;
      insert into BatchRptItem(BatchRptSysId,
        BatchRptItemSysId,
        RptPersonEmpeeSysId) values(
        In_BatchRptSysId,
        Out_BatchRptItemSysId,
        In_RptPersonEmpeeSysId);
      commit work;
      if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = Out_BatchRptItemSysId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    // Individual Rpt
    if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and RptPersonEmpeeSysId = In_RptPersonEmpeeSysId) then
      select MAX(BatchRptItemSysId) into Out_BatchRptItemSysId from BatchRptItem where BatchRptSysId = In_BatchRptSysId;
      if Out_BatchRptItemSysId is null then
        set Out_BatchRptItemSysId=1
      else
        set Out_BatchRptItemSysId=Out_BatchRptItemSysId+1
      end if;
      insert into BatchRptItem(BatchRptSysId,
        BatchRptItemSysId,
        RptPersonEmpeeSysId) values(
        In_BatchRptSysId,
        Out_BatchRptItemSysId,
        In_RptPersonEmpeeSysId);
      commit work;
      if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = Out_BatchRptItemSysId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

create procedure dba.InsertNewRptConfig(
in In_RptConfigId char(40),
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
      RptFilePath) values(
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
      In_RptFilePath);
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
end
;

create procedure dba.UpdateRptConfig(
in In_RptConfigId char(40),
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
      RptFilePath = In_RptFilePath where
      RptConfigId = In_RptConfigId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

