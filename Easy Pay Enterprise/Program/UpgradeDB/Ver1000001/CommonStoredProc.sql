if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewConnection') then
   drop procedure InsertNewConnection
end if
;

CREATE PROCEDURE "DBA"."InsertNewConnection"(
in In_InterfaceConnectionId char(20),
in In_InterfaceRemarks char(100),
in In_InterfaceDSN char(20),
in In_InterfacePassword char(50),
in In_InterfaceUserId char(50),
in In_IsEPEdb smallint)
begin
  if not exists(select* from Connection where InterfaceConnectionId = In_InterfaceConnectionId) then
    insert into Connection(
        InterfaceConnectionId,
        InterfaceRemarks,
        InterfaceDSN,
        InterfacePassword,
        InterfaceUserId,
        IsEPEdb) values(
        In_InterfaceConnectionId,
        In_InterfaceRemarks,
        In_InterfaceDSN,
        In_InterfacePassword,
        In_InterfaceUserId,
        In_IsEPEdb);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateConnection') then
   drop procedure UpdateConnection
end if
;

CREATE PROCEDURE "DBA"."UpdateConnection"(
in In_InterfaceConnectionId char(20),
in In_InterfaceRemarks char(100),
in In_InterfaceDSN char(20),
in In_InterfacePassword char(50),
in In_InterfaceUserId char(50),
in In_IsEPEdb smallint)
begin
  if exists(select* from Connection where InterfaceConnectionId = In_InterfaceConnectionId) then
    update Connection set
      InterfaceRemarks = In_InterfaceRemarks,
      InterfaceDSN = In_InterfaceDSN,
      InterfacePassword = In_InterfacePassword,
      InterfaceUserId = In_InterfaceUserId,
      IsEPEdb = In_IsEPEdb where
      InterfaceConnectionId = In_InterfaceConnectionId;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteConnection') then
   drop procedure DeleteConnection
end if
;

CREATE PROCEDURE "DBA"."DeleteConnection"(
in In_InterfaceConnectionId char(20))
begin
  if not exists(select* from ImportProject where InterfaceConnectionId = In_InterfaceConnectionId) then
    delete from Connection where InterfaceConnectionId = In_InterfaceConnectionId;
    commit work;
  end if;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewImportProject') then
   drop procedure InsertNewImportProject
end if
;

CREATE PROCEDURE "DBA"."InsertNewImportProject"(
in In_ImportProjectId char(20),
in In_InterfaceConnectionId char(20),
in In_ImportExtConnection smallint,
in In_ImportProjectRemarks char(100),
in In_ImportAppearIn char(20))
begin
  if not exists(select* from ImportProject where ImportProjectId = In_ImportProjectId) then
    insert into ImportProject(
        ImportProjectId,
        InterfaceConnectionId,
        ImportExtConnection,
        ImportProjectRemarks,
        ImportAppearIn) values(
        In_ImportProjectId,
        In_InterfaceConnectionId,
        In_ImportExtConnection,
        In_ImportProjectRemarks,
        In_ImportAppearIn);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateImportProject') then
   drop procedure UpdateImportProject
end if
;

CREATE PROCEDURE "DBA"."UpdateImportProject"(
in In_ImportProjectId char(20),
in In_InterfaceConnectionId char(20),
in In_ImportExtConnection smallint,
in In_ImportProjectRemarks char(100),
in In_ImportAppearIn char(20))
begin
  if exists(select* from ImportProject where ImportProjectId = In_ImportProjectId) then
    update ImportProject set
      InterfaceConnectionId = In_InterfaceConnectionId,
      ImportExtConnection = In_ImportExtConnection,
      ImportProjectRemarks = In_ImportProjectRemarks,
      ImportAppearIn = In_ImportAppearIn where
      ImportProjectId = In_ImportProjectId;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteImportProject') then
   drop procedure DeleteImportProject
end if
;

CREATE PROCEDURE "DBA"."DeleteImportProject"(
in In_ImportProjectId char(20))
begin
  if not exists(select* from ImportProjectMember where ImportProjectId = In_ImportProjectId) then
    delete from ImportProject where ImportProjectId = In_ImportProjectId;
    commit work;
  end if;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewImportProjectMember') then
   drop procedure InsertNewImportProjectMember
end if
;

CREATE PROCEDURE "DBA"."InsertNewImportProjectMember"(
in In_ImportSpSheetId char(20),
in In_ImportProjectId char(20),
in In_ProcessSequence integer)
begin
  if not exists(select* from ImportProjectMember where ImportSpSheetId = In_ImportSpSheetId and ImportProjectId = In_ImportProjectId) then
    insert into ImportProjectMember(
        ImportSpSheetId,
        ImportProjectId,
        ProcessSequence) values(
        In_ImportSpSheetId,
        In_ImportProjectId,
        In_ProcessSequence);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateImportProjectMember') then
   drop procedure UpdateImportProjectMember
end if
;

CREATE PROCEDURE "DBA"."UpdateImportProjectMember"(
in In_ImportSpSheetId char(20),
in In_ImportProjectId char(20),
in In_ProcessSequence integer)
begin
  if exists(select* from ImportProjectMember where ImportSpSheetId = In_ImportSpSheetId and ImportProjectId = In_ImportProjectId) then
    update ImportProjectMember set
      ProcessSequence = In_ProcessSequence where
      ImportSpSheetId = In_ImportSpSheetId and 
      ImportProjectId = In_ImportProjectId;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteImportProjectMember') then
   drop procedure DeleteImportProjectMember
end if
;

CREATE PROCEDURE "DBA"."DeleteImportProjectMember"(
in In_ImportSpSheetId char(20),
in In_ImportProjectId char(20))
begin
  delete from ImportProjectMember where ImportSpSheetId = In_ImportSpSheetId and ImportProjectId = In_ImportProjectId;
  commit work;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewImportSpreadSheet') then
   drop procedure InsertNewImportSpreadSheet
end if
;

CREATE PROCEDURE "DBA"."InsertNewImportSpreadSheet"(
in In_ImportSpSheetId char(20),
in In_ImportSpSheetRemarks char(100),
in In_ImportSpSheetPath char(200),
in In_ImportSpSheetType char(20),
in In_ImportSpSheetPassword char(50))
begin
  if not exists(select* from ImportSpreadSheet where ImportSpSheetId = In_ImportSpSheetId) then
    insert into ImportSpreadSheet(
        ImportSpSheetId,
        ImportSpSheetRemarks,
        ImportSpSheetPath,
        ImportSpSheetType,
        ImportSpSheetPassword) values(
        In_ImportSpSheetId,
        In_ImportSpSheetRemarks,
        In_ImportSpSheetPath,
        In_ImportSpSheetType,
        In_ImportSpSheetPassword);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateImportSpreadSheet') then
   drop procedure UpdateImportSpreadSheet
end if
;

CREATE PROCEDURE "DBA"."UpdateImportSpreadSheet"(
in In_ImportSpSheetId char(20),
in In_ImportSpSheetRemarks char(100),
in In_ImportSpSheetPath char(200),
in In_ImportSpSheetType char(20),
in In_ImportSpSheetPassword char(50))
begin
  if exists(select* from ImportSpreadSheet where ImportSpSheetId = In_ImportSpSheetId) then
    update ImportSpreadSheet set
      ImportSpSheetRemarks = In_ImportSpSheetRemarks,
      ImportSpSheetPath = In_ImportSpSheetPath,
      ImportSpSheetType = In_ImportSpSheetType,
      ImportSpSheetPassword = In_ImportSpSheetPassword where
      ImportSpSheetId = In_ImportSpSheetId;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteImportSpreadSheet') then
   drop procedure DeleteImportSpreadSheet
end if
;

CREATE PROCEDURE "DBA"."DeleteImportSpreadSheet"(
in In_ImportSpSheetId char(20))
begin
  if not exists(select* from ImportSSMember where ImportSpSheetId = In_ImportSpSheetId) then
    delete from ImportSpreadSheet where ImportSpSheetId = In_ImportSpSheetId;
    commit work;
  end if;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewImportSSMember') then
   drop procedure InsertNewImportSSMember
end if
;

CREATE PROCEDURE "DBA"."InsertNewImportSSMember"(
in In_WorkSheetID char(20),
in In_ImportSpSheetId char(20),
in In_ProcessSequence integer)
begin
  if not exists(select* from ImportSSMember where WorkSheetID = In_WorkSheetID and ImportSpSheetId = In_ImportSpSheetId) then
    insert into ImportSSMember(
        WorkSheetID,
        ImportSpSheetId,
        ProcessSequence) values(
        In_WorkSheetID,
        In_ImportSpSheetId,
        In_ProcessSequence);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateImportSSMember') then
   drop procedure UpdateImportSSMember
end if
;

CREATE PROCEDURE "DBA"."UpdateImportSSMember"(
in In_WorkSheetID char(20),
in In_ImportSpSheetId char(20),
in In_ProcessSequence integer)
begin
  if exists(select* from ImportSSMember where WorkSheetID = In_WorkSheetID and ImportSpSheetId = In_ImportSpSheetId) then
    update ImportSSMember set
      ProcessSequence = In_ProcessSequence where
      WorkSheetID = In_WorkSheetID and
      ImportSpSheetId = In_ImportSpSheetId;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteImportSSMember') then
   drop procedure DeleteImportSSMember
end if
;

CREATE PROCEDURE "DBA"."DeleteImportSSMember"(
in In_WorkSheetID char(20),
in In_ImportSpSheetId char(20))
begin
  delete from ImportSSMember where WorkSheetID = In_WorkSheetID and ImportSpSheetId = In_ImportSpSheetId;
  commit work;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewImportWorkSheet') then
   drop procedure InsertNewImportWorkSheet
end if
;

CREATE PROCEDURE "DBA"."InsertNewImportWorkSheet"(
in In_WorkSheetID char(20),
in In_WorkSheetName char(50),
in In_WorkSheetType char(20),
in In_PhysicalTableName char(50),
in In_EndingColumn char(2),
in In_EndingRow integer,
in In_StartingColumn char(2),
in In_StartingRow integer,
in In_LogFileName char(50),
in In_LogFilePath char(200))
begin
  if not exists(select* from ImportWorkSheet where WorkSheetID = In_WorkSheetID) then
    insert into ImportWorkSheet(
        WorkSheetID,
        WorkSheetName,
        WorkSheetType,
        PhysicalTableName,
        EndingColumn,
        EndingRow,
        StartingColumn,
        StartingRow,
        LogFileName,
        LogFilePath) values(
        In_WorkSheetID,
        In_WorkSheetName,
        In_WorkSheetType,
        In_PhysicalTableName,
        In_EndingColumn,
        In_EndingRow,
        In_StartingColumn,
        In_StartingRow,
        In_LogFileName,
        In_LogFilePath);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateImportWorkSheet') then
   drop procedure UpdateImportWorkSheet
end if
;

CREATE PROCEDURE "DBA"."UpdateImportWorkSheet"(
in In_WorkSheetID char(20),
in In_WorkSheetName char(50),
in In_WorkSheetType char(20),
in In_PhysicalTableName char(50),
in In_EndingColumn char(2),
in In_EndingRow integer,
in In_StartingColumn char(2),
in In_StartingRow integer,
in In_LogFileName char(50),
in In_LogFilePath char(200))
begin
  if exists(select* from ImportWorkSheet where WorkSheetID = In_WorkSheetID) then
    update ImportWorkSheet set
      WorkSheetName = In_WorkSheetName,
      WorkSheetType = In_WorkSheetType,
      PhysicalTableName = In_PhysicalTableName,
      EndingColumn = In_EndingColumn,
	  EndingRow = In_EndingRow,
	  StartingColumn = In_StartingColumn,
	  StartingRow = In_StartingRow,
	  LogFileName = In_LogFileName,
	  LogFilePath = In_LogFilePath where
      WorkSheetID = In_WorkSheetID;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteImportWorkSheet') then
   drop procedure DeleteImportWorkSheet
end if
;

CREATE PROCEDURE "DBA"."DeleteImportWorkSheet"(
in In_WorkSheetID char(20))
begin
  if not exists(select* from ImportField where WorkSheetID = In_WorkSheetID) then
    delete from ImportWorkSheet where WorkSheetID = In_WorkSheetID;
    commit work;
  end if;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewImportField') then
   drop procedure InsertNewImportField
end if
;

CREATE PROCEDURE "DBA"."InsertNewImportField"(
in In_WorkSheetID char(20),
in In_ImportFieldPhysical char(50),
in In_Column char(2),
in In_Row integer,
in In_DateValue date,
in In_StringValue char(100),
in In_IntegerValue integer,
in In_NumericValue double)
begin
  if not exists(select* from ImportField where WorkSheetID = In_WorkSheetID and ImportFieldPhysical = In_ImportFieldPhysical) then
    insert into ImportField(
        WorkSheetID,
        ImportFieldPhysical,
        Column,
        Row,
        DateValue,
        StringValue,
        IntegerValue,
        NumericValue) values(
        In_WorkSheetID,
        In_ImportFieldPhysical,
        In_Column,
        In_Row,
        In_DateValue,
        In_StringValue,
        In_IntegerValue,
        In_NumericValue);
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateImportField') then
   drop procedure UpdateImportField
end if
;

CREATE PROCEDURE "DBA"."UpdateImportField"(
in In_WorkSheetID char(20),
in In_ImportFieldPhysical char(50),
in In_Column char(2),
in In_Row integer,
in In_DateValue date,
in In_StringValue char(100),
in In_IntegerValue integer,
in In_NumericValue double)
begin
  if exists(select* from ImportField where WorkSheetID = In_WorkSheetID and ImportFieldPhysical = In_ImportFieldPhysical) then
    update ImportField set
      Column = In_Column,
      Row = In_Row,
      DateValue = In_DateValue,
      StringValue = In_StringValue,
      IntegerValue = In_IntegerValue,
      NumericValue = In_NumericValue where
      WorkSheetID = In_WorkSheetID and
      ImportFieldPhysical = In_ImportFieldPhysical;
    commit work;
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteImportField') then
   drop procedure DeleteImportField
end if
;

CREATE PROCEDURE "DBA"."DeleteImportField"(
in In_ImportSpSheetId char(20),
in In_ImportFieldPhysical char(50))
begin
  delete from ImportField where WorkSheetID = In_WorkSheetID and ImportFieldPhysical = In_ImportFieldPhysical;
  commit work;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveEligibleGroup') then
   drop procedure InsertNewLeaveEligibleGroup
end if
;

CREATE PROCEDURE "DBA"."InsertNewLeaveEligibleGroup"(
in In_LeaveTypeId char(20),
in In_LeaveEligibleGroup char(20))
begin
  if not exists(select* from LeaveEligibleGroup where LeaveTypeId = In_LeaveTypeId and LeaveEligibleGroup = In_LeaveEligibleGroup) then
    insert into LeaveEligibleGroup(LeaveTypeId,
      LeaveEligibleGroup) values(
      In_LeaveTypeId,
      In_LeaveEligibleGroup);
    commit work
  end if
end
;



if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveEligibleGroup') then
   drop procedure DeleteLeaveEligibleGroup
end if
;

CREATE PROCEDURE "DBA"."DeleteLeaveEligibleGroup"(
in In_LeaveTypeId char(20),
in In_LeaveEligibleGroup char(20))
begin
  if not exists(select* from LeaveEligibleItem where LeaveTypeId = In_LeaveTypeId and LeaveEligibleGroup = In_LeaveEligibleGroup) then
    delete from LeaveEligibleGroup where LeaveTypeId = In_LeaveTypeId and LeaveEligibleGroup = In_LeaveEligibleGroup;
    commit work;
  end if;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveEligibleItem') then
   drop procedure InsertNewLeaveEligibleItem
end if
;

CREATE PROCEDURE "DBA"."InsertNewLeaveEligibleItem"(
in In_LeaveTypeId char(20),
in In_LeaveEligibleGroup char(20),
in In_LeaveEligibleItem char(100))
begin
  if not exists(select* from LeaveEligibleItem where LeaveTypeId = In_LeaveTypeId and LeaveEligibleGroup = In_LeaveEligibleGroup and LeaveEligibleItem = In_LeaveEligibleItem) then
    insert into LeaveEligibleItem(LeaveTypeId,
      LeaveEligibleGroup,
      LeaveEligibleItem) values(
      In_LeaveTypeId,
      In_LeaveEligibleGroup,
      In_LeaveEligibleItem);
    commit work
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveEligibleItem') then
   drop procedure DeleteLeaveEligibleItem
end if
;

CREATE PROCEDURE "DBA"."DeleteLeaveEligibleItem"(
in In_LeaveTypeId char(20),
in In_LeaveEligibleGroup char(20),
in In_LeaveEligibleItem char(100))
begin
  delete from LeaveEligibleItem where LeaveTypeId = In_LeaveTypeId and LeaveEligibleGroup = In_LeaveEligibleGroup and LeaveEligibleItem = In_LeaveEligibleItem;
  commit work;
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOutboxMessage') then
   drop procedure DeleteOutboxMessage
end if
;

CREATE PROCEDURE "DBA"."DeleteOutboxMessage"(
in In_OutboxMsgSysId integer,
out Out_Code integer)
begin
  if exists(select* from OutboxMessage where OutboxMsgSysId = In_OutboxMsgSysId) then
    delete from OutboxMessageAttachment where OutboxMessageAttachment.OutboxMsgSysId = In_OutboxMsgSysId;
    delete from OutboxRecipientList where OutboxRecipientList.OutboxMsgSysId = In_OutboxMsgSysId;
    delete from OutboxMessage where OutboxMessage.OutboxMsgSysId = In_OutboxMsgSysId;
    commit work
  end if
end
;



if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRptConfigEmail') then
   drop procedure InsertNewRptConfigEmail
end if
;

CREATE PROCEDURE "DBA"."InsertNewRptConfigEmail"( 
in In_PersonalSysId int,
in In_CompressFilePassword char(50),
in In_CCEmail char(200),
in In_BCCEmail char(200))

BEGIN
    if not exists(select* from RptConfigEmail where RptConfigEmail.PersonalSysId = In_PersonalSysId) then
    insert into RptConfigEmail(PersonalSysId, CompressFilePassword, CCEmail, BCCEmail) values(
      In_PersonalSysId,In_CompressFilePassword,In_CCEmail, In_BCCEmail);
    commit work
  end if
END
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRptConfigEmail') then
   drop procedure UpdateRptConfigEmail
end if
;

CREATE PROCEDURE "DBA"."UpdateRptConfigEmail"( 
in In_PersonalSysId int,
in In_CompressFilePassword char(50),
in In_CCEmail char(200),
in In_BCCEmail char(200)) 
BEGIN
	  if exists(select* from RptConfigEmail where RptConfigEmail.PersonalSysId = In_PersonalSysId) then
    update RptConfigEmail set
      RptConfigEmail.CompressFilePassword = In_CompressFilePassword,
      RptConfigEmail.CCEmail = In_CCEmail,
      RptConfigEmail.BCCEmail = In_BCCEmail where
      RptConfigEmail.PersonalSysId = In_PersonalSysId;
    commit work
  end if
END
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmailAddressByContactLocationId') then
   drop procedure FGetEmailAddressByContactLocationId
end if
;

CREATE FUNCTION "DBA"."FGetEmailAddressByContactLocationId"(
in In_PersonalSysId integer, 
in In_ContactLocationId char(20))
RETURNS char(50)
NOT DETERMINISTIC
BEGIN
	DECLARE "Out_EmailAddress" char(50);
	SELECT FIRST personalemail into OUT_EmailAddress FROM PersonalEmail 
    WHERE ContactLocationId = In_ContactLocationId AND PersonalSysId=In_PersonalSysId
    ORDER BY PersonalSysId; 
	RETURN "Out_EmailAddress";
END
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterfaceProject') then
   drop procedure InsertNewInterfaceProject
end if
;

CREATE PROCEDURE "DBA"."InsertNewInterfaceProject"(
in In_InterfaceProjectID char(20),
in In_InterfaceProjRemarks char(100))
begin
  if not exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    insert into InterfaceProject(InterfaceProjectID,InterfaceProjRemarks) values(In_InterfaceProjectID,In_InterfaceProjRemarks);
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'OT Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Shift Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Employment Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Pay Element Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Leave Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Lve Summary Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'HR Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Daily Hourly Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Income Tax Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Casual Pay Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'YTD Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Time Sheet Detail',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Setup Process',null,0,0,'');
    commit work
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRptConfig') then
   drop procedure InsertNewRptConfig
end if
;

CREATE PROCEDURE "DBA"."InsertNewRptConfig"(
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
in In_CompressFileExt char(20),
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
      In_CompressFileExt);
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


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRptConfig') then
   drop procedure UpdateRptConfig
end if
;

CREATE PROCEDURE "DBA"."UpdateRptConfig"(
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
in In_CompressFileExt char(20),
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
      CompressFileExt = In_CompressFileExt where
      RptConfigId = In_RptConfigId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRefreshEmpeeOtherInfo') then
   drop procedure ASQLRefreshEmpeeOtherInfo
end if
;

CREATE PROCEDURE "DBA"."ASQLRefreshEmpeeOtherInfo"(
in In_EmployeeSysId integer,
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
end
;






























