/* ============================================================ */
/*   Database name:  Model_2                                    */
/*   DBMS name:      Sybase AS Anywhere 6                       */
/*   Created on:     8/10/2004  10:29 AM                        */
/* ============================================================ */


create procedure dba.DeleteAlertGroup(
in In_AlertGroupId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AlertGroup where AlertGroupId = In_AlertGroupId) then
    //delete AlertGroupItemAttach
    delete from AlertGroupItemAttach where AlertGroupItemSysId = 
      any(select AlertGroupItemSysId from AlertGroupItem where AlertGroupId = In_AlertGroupId);
    commit work;
    //delete AlertItemMsgMapping
    delete from AlertItemMsgMapping where AlertItemAssignSysId = 
      any(select AlertItemAssignSysId from AlertItemAssign where AlertGroupItemSysId = 
        any(select AlertGroupItemSysId from AlertGroupItem where AlertGroupId = In_AlertGroupId));
    commit work;
    //delete AlertAssignMsg
    delete from AlertItemAssignMsg where AlertItemAssignSysId = 
      any(select AlertItemAssignSysId from AlertItemAssign where AlertGroupItemSysId = 
        any(select AlertGroupItemSysId from AlertGroupItem where AlertGroupId = In_AlertGroupId));
    commit work;
    //delete AlertUserDefAssign
    delete from AlertUserDefAssign where AlertItemAssignSysId = 
      any(select AlertItemAssignSysId from AlertItemAssign where AlertGroupItemSysId = 
        any(select AlertGroupItemSysId from AlertGroupItem where AlertGroupId = In_AlertGroupId));
    commit work;
    //delete AlertItemAssign
    delete from AlertItemAssign where AlertGroupItemSysId = 
      any(select AlertGroupItemSysId from AlertGroupItem where AlertGroupId = In_AlertGroupId);
    commit work;
    //delete Alert GroupItem
    delete from AlertGroupItem where AlertGroupId = In_AlertGroupId;
    commit work;
    //delete Alert Group
    delete from AlertGroup where AlertGroupId = In_AlertGroupId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteAlertGroupItem(
in In_AlertGroupItemSysId integer,
out ErrorCode integer)
begin
  if exists(select* from AlertGroupItem where
      AlertGroupItemSysId = In_AlertGroupItemSysId) then
    delete from AlertItemMsgMapping where AlertItemAssignSysId = 
      any(select AlertItemAssignSysId from AlertItemAssign where AlertGroupItemSysId = In_AlertGroupItemSysId);
    commit work;
    delete from AlertItemAssignMsg where AlertItemAssignSysId = 
      any(select AlertItemAssignSysId from AlertItemAssign where AlertGroupItemSysId = In_AlertGroupItemSysId);
    commit work;
    delete from AlertUserDefAssign where AlertItemAssignSysId = 
      any(select AlertItemAssignSysId from AlertItemAssign where AlertGroupItemSysId = In_AlertGroupItemSysId);
    commit work;
    delete from AlertItemAssign where AlertGroupItemSysId = In_AlertGroupItemSysId;
    commit work;
    delete from AlertGroupItemAttach where AlertGroupItemSysId = In_AlertGroupItemSysId;
    commit work;
    delete from AlertGroupItem where AlertGroupItemSysId = In_AlertGroupItemSysId;
    commit work;
    set ErrorCode=1
  end if
end
;


create procedure dba.DeleteAlertGroupItemAttach(
in In_AlertGrpItemAttachSysId integer,
out ErrorCode integer)
begin
  if exists(select* from AlertGroupItemAttach where
      AlertGrpItemAttachSysId = In_AlertGrpItemAttachSysId) then
    delete from AlertGroupItemAttach where
      AlertGrpItemAttachSysId = In_AlertGrpItemAttachSysId;
    commit work;
    set ErrorCode=1
  end if
end
;


create procedure dba.DeleteAlertItemAssignMsg(
in In_OutEmailMsgId char(20),
in In_AlertItemAssignSysId integer,
out ErrorCode integer)
begin
  if exists(select* from AlertItemAssignMsg where
      OutEmailMsgId = In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId) then
    delete from AlertItemMsgMapping where
      OutEmailMsgId = In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId;
    commit work;
    delete from AlertItemAssignMsg where
      OutEmailMsgId = In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId;
    commit work;
    set ErrorCode=1
  end if
end
;


create procedure dba.DeleteAlertRole(
in In_AlertRoleId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AlertRole where AlertRole.AlertRoleId = In_AlertRoleId) then
    if not exists(select* from AlertItemAssign where AlertItemAssign.AlertAssignTo = In_AlertRoleId) then
      if exists(select* from AlertAssignRole where AlertAssignRole.AlertRoleId = In_AlertRoleId) then
        delete from AlertAssignRole where AlertAssignRole.AlertRoleId = In_AlertRoleId;
        commit work
      end if;
      delete from AlertRole where AlertRole.AlertRoleId = In_AlertRoleId;
      commit work
    end if;
    if exists(select* from AlertRole where AlertRole.AlertRoleId = In_AlertRoleId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteOutEmailMessage(
in In_OutEmailMsgId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from OutEmailMessage where OutEmailMessage.OutEmailMsgId = In_OutEmailMsgId) then
    if not exists(select* from AlertItemAssignMsg where AlertItemAssignMsg.OutEmailMsgId = In_OutEmailMsgId) then
      delete from OutEmailMessage where
        OutEmailMessage.OutEmailMsgId = In_OutEmailMsgId;
      commit work
    end if;
    if exists(select* from OutEmailMessage where OutEmailMessage.OutEmailMsgId = In_OutEmailMsgId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteOutEmailMsgMapping(
in In_OutEmailMsgMapId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from OutEmailMsgMapping where OutEmailMsgMapping.OutEmailMsgMapId = In_OutEmailMsgMapId) then
    if not exists(select* from OutEmailMessage where OutEmailMessage.OutEmailMsgMapId = In_OutEmailMsgMapId) then
      delete from OutEmailMsgMapping where
        OutEmailMsgMapping.OutEmailMsgMapId = In_OutEmailMsgMapId;
      commit work
    end if;
    if exists(select* from OutEmailMsgMapping where OutEmailMsgMapping.OutEmailMsgMapId = In_OutEmailMsgMapId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewAlertGroup(
in In_AlertGroupId char(20),
in In_AlertIsActive integer,
in In_AlertRuns char(20),
in In_AlertDesc char(100),
in In_AlertRunMonth integer,
in In_AlertRunDay integer,
in In_AlertIsSummarized integer,
out Out_Code integer)
begin
  if In_AlertGroupId is null then set Out_Code=-1;
    return
  end if;
  if In_AlertRuns is null then set Out_Code=-2;
    return
  end if;
  if not exists(select* from AlertGroup where AlertGroupId = In_AlertGroupId) then
    insert into AlertGroup(AlertGroupId,
      AlertIsActive,
      AlertRuns,
      AlertDesc,
      AlertRunMonth,
      AlertRunDay,
      AlertIsSummarized) values(
      In_AlertGroupId,
      In_AlertIsActive,
      In_AlertRuns,
      In_AlertDesc,
      In_AlertRunMonth,
      In_AlertRunDay,
      In_AlertIsSummarized);
    commit work;
    set Out_Code=1
  else
    set Out_Code=-3;
    return
  end if
end
;

create procedure dba.InsertNewAlertGroupItem(
in In_AlertGroupId char(20),
in In_AlertBefore integer,
in In_AlertBeforeUnit char(20),
in In_AlertAfter integer,
in In_AlertAfterUnit char(20),
in In_AlertHasAttachment integer,
in In_AlertGroupAlertFieldId char(20),
in In_AlertFilterBy integer,
in In_AlertFilterByQueryId char(20),
in In_AlertActualDate integer,
in In_AlertStartDay integer,
in In_AlertStartMth char(20),
in In_AlertEndDay integer,
in In_AlertEndMth char(20),
in In_AlertParameter1 char(250),
in In_AlertParameter2 char(250),
in In_AlertParameter3 char(250),
in In_AlertParameter4 char(250),
in In_AlertParameter5 char(250),
out Out_Code integer)
begin
  declare MaxSysId integer;
  if In_AlertGroupId is null then set Out_Code=-1;
    return
  end if;
  if In_AlertGroupAlertFieldId is null then set Out_Code=-2;
    return
  end if;
  if exists(select* from AlertGroupItem) then
    select max(AlertGroupItemSysId) into MaxSysId from AlertGroupItem;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  insert into AlertGroupItem(AlertGroupItemSysId,
    AlertGroupId,
    AlertBefore,
    AlertBeforeUnit,
    AlertAfter,
    AlertAfterUnit,
    AlertHasAttachment,
    AlertGroupAlertFieldId,
    AlertFilterBy,
    AlertFilterByQueryId,
    AlertActualDate,
    AlertStartDay,
    AlertStartMth,
    AlertEndDay,
    AlertEndMth,
    AlertParameter1,
    AlertParameter2,
    AlertParameter3,
    AlertParameter4,
    AlertParameter5) values(
    Out_Code,
    In_AlertGroupId,
    In_AlertBefore,
    In_AlertBeforeUnit,
    In_AlertAfter,
    In_AlertAfterUnit,
    In_AlertHasAttachment,
    In_AlertGroupAlertFieldId,
    In_AlertFilterBy,
    In_AlertFilterByQueryId,
    In_AlertActualDate,
    In_AlertStartDay,
    In_AlertStartMth,
    In_AlertEndDay,
    In_AlertEndMth,
    In_AlertParameter1,
    In_AlertParameter2,
    In_AlertParameter3,
    In_AlertParameter4,
    In_AlertParameter5);
  commit work
end
;


create procedure dba.InsertNewAlertGroupItemAttach(
in In_AlertGroupItemSysId integer,
in In_AlertAttachFileType char(20),
in In_AlertAttachRemarks char(100),
out Out_Code integer)
begin
  declare MaxSysId integer;
  if In_AlertGroupItemSysId is null then set Out_Code=-1;
    return
  end if;
  if exists(select* from AlertGroupItemAttach) then
    select max(AlertGrpItemAttachSysId) into MaxSysId from AlertGroupItemAttach;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  insert into AlertGroupItemAttach(AlertGrpItemAttachSysId,
    AlertGroupItemSysId,
    AlertAttachFileType,
    AlertAttachRemarks) values(
    Out_Code,
    In_AlertGroupItemSysId,
    In_AlertAttachFileType,
    In_AlertAttachRemarks);
  commit work
end
;


create procedure dba.InsertNewAlertItemAssignMsg(
in In_OutEmailMsgId char(20),
in In_AlertItemAssignSysId integer,
in In_AlertAssignMsgIsStd integer,
out Out_Code integer)
begin
  if In_OutEmailMsgId is null then
    set Out_Code=-1;
    return
  end if;
  if In_AlertAssignMsgIsStd = 1 then
    update AlertItemAssignMsg set AlertAssignMsgIsStd = 0 where AlertAssignMsgIsStd = 1 and AlertItemAssignSysId = In_AlertItemAssignSysId;
    commit work
  end if;
  if not exists(select* from AlertItemAssignMsg where AlertAssignMsgIsStd = 1 and AlertItemAssignSysId = In_AlertItemAssignSysId) then
    set In_AlertAssignMsgIsStd=1
  end if;
  if not exists(select* from AlertItemAssignMsg where OutEmailMsgId = In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId) then
    insert into AlertItemAssignMsg(OutEmailMsgId,
      AlertItemAssignSysId,
      AlertAssignMsgIsStd) values(
      In_OutEmailMsgId,
      In_AlertItemAssignSysId,
      In_AlertAssignMsgIsStd);
    commit work;
    set Out_Code=1
  else
    set Out_Code=-2
  end if
end
;


create procedure dba.InsertNewAlertRole(
in In_AlertRoleId char(20),
in In_AlertRoleDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from AlertRole where AlertRole.AlertRoleId = In_AlertRoleId) then
    insert into AlertRole(AlertRoleId,AlertRoleDesc) values(In_AlertRoleId,In_AlertRoleDesc);
    commit work;
    if not exists(select* from AlertRole where AlertRole.AlertRoleId = In_AlertRoleId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewOutEmailMessage(
in In_OutEmailMsgId char(20),
in In_OutEmailDesc char(100),
in In_OutEmailSysTableId char(100),
in In_OutEmailMapping integer,
in In_OutEmailSubject char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from OutEmailMessage where OutEmailMsgId = In_OutEmailMsgId) then
    insert into OutEmailMessage(OutEmailMsgId,
      OutEmailDesc,
      OutEmailSysTableId,
      OutEmailMapping,
      OutEmailSubject,
      OutEmailMsgMapId) values(
      In_OutEmailMsgId,
      In_OutEmailDesc,
      In_OutEmailSysTableId,
      In_OutEmailMapping,
      In_OutEmailSubject,null);
    commit work;
    if not exists(select* from OutEmailMessage where OutEmailMsgId = In_OutEmailMsgId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewOutEmailMsgMapping(
in In_OutEmailMsgMapId char(20),
in In_OutEmailSysTableId char(100),
in In_OutEmailMsgMapDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from OutEmailMsgMapping where OutEmailMsgMapId = In_OutEmailMsgMapId) then
    insert into OutEmailMsgMapping(OutEmailMsgMapId,OutEmailSysTableId,OutEmailMsgMapDesc,
      String1,String2,String3,String4,String5,String6,String7,String8,String9,String10) values(
      In_OutEmailMsgMapId,In_OutEmailSysTableId,In_OutEmailMsgMapDesc,'','','','','','','','','','');
    commit work;
    if not exists(select* from OutEmailMsgMapping where OutEmailMsgMapId = In_OutEmailMsgMapId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateAlertGroup(
in In_AlertGroupId char(20),
in In_AlertIsActive integer,
in In_AlertRuns char(20),
in In_AlertDesc char(100),
in In_AlertRunMonth integer,
in In_AlertRunDay integer,
in In_AlertIsSummarized integer,
out Out_Code integer)
begin
  if In_AlertRuns is null then set Out_Code=-1;
    return
  end if;
  if exists(select* from AlertGroup where AlertGroupId = In_AlertGroupId) then
    update AlertGroup set
      AlertIsActive = In_AlertIsActive,
      AlertRuns = In_AlertRuns,
      AlertDesc = In_AlertDesc,
      AlertRunMonth = In_AlertRunMonth,
      AlertRunDay = In_AlertRunDay,
      AlertIsSummarized = In_AlertIsSummarized where AlertGroupId = In_AlertGroupId;
    commit work;
    set Out_Code=1
  end if
end
;


create procedure dba.UpdateAlertGroupItem(
in In_AlertGroupItemSysId integer,
in In_AlertGroupId char(20),
in In_AlertBefore integer,
in In_AlertBeforeUnit char(20),
in In_AlertAfter integer,
in In_AlertAfterUnit char(20),
in In_AlertHasAttachment integer,
in In_AlertGroupAlertFieldId char(20),
in In_AlertFilterBy integer,
in In_AlertFilterByQueryId char(20),
in In_AlertActualDate integer,
in In_AlertStartDay integer,
in In_AlertStartMth char(20),
in In_AlertEndDay integer,
in In_AlertEndMth char(20),
in In_AlertParameter1 char(250),
in In_AlertParameter2 char(250),
in In_AlertParameter3 char(250),
in In_AlertParameter4 char(250),
in In_AlertParameter5 char(250),
out Out_Code integer)
begin
  if In_AlertGroupAlertFieldId is null then set Out_Code=-1;
    return
  end if;
  if exists(select* from AlertGroupItem where AlertGroupItemSysId = In_AlertGroupItemSysId) then
    update AlertGroupItem set
      AlertGroupId = In_AlertGroupId,
      AlertBefore = In_AlertBefore,
      AlertBeforeUnit = In_AlertBeforeUnit,
      AlertAfter = In_AlertAfter,
      AlertAfterUnit = In_AlertAfterUnit,
      AlertHasAttachment = In_AlertHasAttachment,
      AlertGroupAlertFieldId = In_AlertGroupAlertFieldId,
      AlertFilterBy = In_AlertFilterBy,
      AlertFilterByQueryId = In_AlertFilterByQueryId,
      AlertActualDate = In_AlertActualDate,
      AlertStartDay = In_AlertStartDay,
      AlertStartMth = In_AlertStartMth,
      AlertEndDay = In_AlertEndDay,
      AlertEndMth = In_AlertEndMth,
      AlertParameter1 = In_AlertParameter1,
      AlertParameter2 = In_AlertParameter2,
      AlertParameter3 = In_AlertParameter3,
      AlertParameter4 = In_AlertParameter4,
      AlertParameter5 = In_AlertParameter5 where AlertGroupItemSysId = In_AlertGroupItemSysId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-2;
    return
  end if
end
;


create procedure dba.UpdateAlertGroupItemAttach(
in In_AlertGrpItemAttachSysId integer,
in In_AlertGroupItemSysId integer,
in In_AlertAttachFileType char(20),
in In_AlertAttachRemarks char(100),
out Out_Code integer)
begin
  if In_AlertGroupItemSysId is null then set Out_Code=-1;
    return
  end if;
  if exists(select* from AlertGroupItemAttach where AlertGrpItemAttachSysId = In_AlertGrpItemAttachSysId) then
    update AlertGroupItemAttach set
      AlertGroupItemSysId = In_AlertGroupItemSysId,
      AlertAttachFileType = In_AlertAttachFileType,
      AlertAttachRemarks = In_AlertAttachRemarks where
      AlertGrpItemAttachSysId = In_AlertGrpItemAttachSysId;
    commit work;
    set Out_Code=1
  end if
end
;

create procedure dba.UpdateAlertItemAssignMsg(
in In_OutEmailMsgId char(20),
in In_AlertItemAssignSysId integer,
in In_AlertAssignMsgIsStd integer,
out Out_Code integer)
begin
  if In_OutEmailMsgId is null then set Out_Code=-1;
    return
  end if;
  if In_AlertAssignMsgIsStd = 0 and not exists(select* from AlertItemAssignMsg where AlertAssignMsgIsStd = 1 and OutEmailMsgId <> In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId) then
    set Out_Code=-2;
    return
  end if;
  if In_AlertAssignMsgIsStd = 1 then
    update AlertItemAssignMsg set AlertAssignMsgIsStd = 0 where AlertAssignMsgIsStd = 1 and AlertItemAssignSysId = In_AlertItemAssignSysId;
    commit work
  end if;
  if exists(select* from AlertItemAssignMsg where OutEmailMsgId = In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId) then
    update AlertItemAssignMsg set
      AlertAssignMsgIsStd = In_AlertAssignMsgIsStd where
      OutEmailMsgId = In_OutEmailMsgId and AlertItemAssignSysId = In_AlertItemAssignSysId;
    commit work;
    set Out_Code=1
  end if
end
;


create procedure dba.UpdateAlertRole(
in In_AlertRoleId char(20),
in In_AlertRoleDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AlertRole where AlertRoleId = In_AlertRoleId) then
    update AlertRole set
      AlertRoleDesc = In_AlertRoleDesc where
      AlertRoleId = In_AlertRoleId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateOutEmailMessage(
in In_OutEmailMsgId char(20),
in In_OutEmailDesc char(100),
in In_OutEmailSysTableId char(100),
in In_OutEmailMapping integer,
in In_OutEmailSubject char(100),
in In_OutEmailMsgMapId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from OutEmailMessage where OutEmailMsgId = In_OutEmailMsgId) then
    update OutEmailMessage set
      OutEmailDesc = In_OutEmailDesc,
      OutEmailSysTableId = In_OutEmailSysTableId,
      OutEmailMapping = In_OutEmailMapping,
      OutEmailSubject = In_OutEmailSubject,
      OutEmailMsgMapId = In_OutEmailMsgMapId where
      OutEmailMsgId = In_OutEmailMsgId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateOutEmailMsgMapping(
in In_OutEmailMsgMapId char(20),
in In_OutEmailSysTableId char(100),
in In_OutEmailMsgMapDesc char(100),
in In_String1 char(100),
in In_String2 char(100),
in In_String3 char(100),
in In_String4 char(100),
in In_String5 char(100),
in In_String6 char(100),
in In_String7 char(100),
in In_String8 char(100),
in In_String9 char(100),
in In_String10 char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from OutEmailMsgMapping where OutEmailMsgMapId = In_OutEmailMsgMapId) then
    update OutEmailMsgMapping set
      OutEmailSysTableId = In_OutEmailSysTableId,
      OutEmailMsgMapDesc = In_OutEmailMsgMapDesc,
      String1 = In_String1,
      String2 = In_String2,
      String3 = In_String3,
      String4 = In_String4,
      String5 = In_String5,
      String6 = In_String6,
      String7 = In_String7,
      String8 = In_String8,
      String9 = In_String9,
      String10 = In_String10 where
      OutEmailMsgMapId = In_OutEmailMsgMapId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create function dba.FGetAlertDayName(
in In_AlertDay integer)
returns char(10)
begin
  if In_AlertDay > 0 then
    return Trim(Str(In_AlertDay))
  elseif In_AlertDay = 0 then
    return 'Last Day'
  else
    return ''
  end if
end
;


create function dba.FGetAlertFilterBy(
in In_AlertFilterBy smallint,
in In_AlertFilterByQueryId char(20))
returns char(20)
begin
  if In_AlertFilterBy = 0 then
    return 'All'
  else
    return In_AlertFilterByQueryId
  end if
end
;


create function dba.FGetAlertKeyWordUserDefinedName(
in In_AlertKeyWordId char(20))
returns char(100)
begin
  declare Out_AlertKeyWordUserDefinedName char(100);
  select AlertKeyWordUserDefinedName into Out_AlertKeyWordUserDefinedName from AlertKeyword where
    AlertKeyWordId = In_AlertKeyWordId;
  if(Out_AlertKeyWordUserDefinedName is null or Out_AlertKeyWordUserDefinedName = '') then
    return(In_AlertKeyWordId)
  else return(Out_AlertKeyWordUserDefinedName)
  end if
end
;


create function dba.FGetAlertMonthName(
in In_AlertMonth integer)
returns char(3)
begin
  if(In_AlertMonth >= 1) and(In_AlertMonth <= 12) then
    return DateFormat('2004-'+Str(In_AlertMonth)+'-01','Mmm')
  else
    return ''
  end if
end
;

create function dba.FGetServiceYearDate(
in In_EmployeeSysId integer,
in In_ServiceYrs integer)
returns date
begin
  declare Out_ServiceYrDate date;
  declare Out_HireDate date;
  select HireDate into Out_HireDate from Employee where EmployeeSysId = In_EmployeeSysId;
  select DateAdd(year,In_ServiceYrs,Out_HireDate) into Out_ServiceYrDate;
  return(Out_ServiceYrDate)
end
;


