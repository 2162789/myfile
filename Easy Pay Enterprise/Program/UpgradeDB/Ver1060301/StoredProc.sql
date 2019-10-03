if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSystemUser') then
   drop procedure DBA.DeleteSystemUser
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
    delete from SystemUser where
      SystemUser.UserId = In_UserId;
    commit work
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteSubPeriodRecordsByPayGroupId') then
   drop procedure DBA.ASQLDeleteSubPeriodRecordsByPayGroupId
end if;

create PROCEDURE DBA.ASQLDeleteSubPeriodRecordsByPayGroupId(
in In_PayGroupId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  DeleteSubPeriodLoop: for EmployeeFor as curs dynamic scroll cursor for
      select distinct EmployeeSysId from PayPeriodRecord where PayPayGroupId = In_PayGroupId do
        call ASQLDeleteSubPeriodRecords(EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod)
  end for;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodCurDaysTaken') then
   drop FUNCTION DBA.FGetPayPeriodCurDaysTaken
end if;

create FUNCTION DBA.FGetPayPeriodCurDaysTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Amt double;
  if(In_PayRecSubPeriod = 0) then
    select sum(CurrentLveDays) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and LeaveTypeFunctCode = In_LeaveType
  else
    select sum(CurrentLveDays) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType
  end if;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodCurHrsTaken') then
   drop FUNCTION DBA.FGetPayPeriodCurHrsTaken
end if;

create FUNCTION DBA.FGetPayPeriodCurHrsTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Amt double;
  if(In_PayRecSubPeriod = 0) then
    select sum(CurrentLveHours) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and LeaveTypeFunctCode = In_LeaveType
  else
    select sum(CurrentLveHours) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType
  end if;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodLastDaysTaken') then
   drop FUNCTION DBA.FGetPayPeriodLastDaysTaken
end if;

create FUNCTION DBA.FGetPayPeriodLastDaysTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Amt double;
  if(In_PayRecSubPeriod = 0) then
    select sum(PreviousLveIncDays) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and LeaveTypeFunctCode = In_LeaveType
  else
    select sum(PreviousLveIncDays) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType
  end if;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodLastHrsTaken') then
   drop FUNCTION DBA.FGetPayPeriodLastHrsTaken
end if;

create FUNCTION DBA.FGetPayPeriodLastHrsTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Amt double;
  if(In_PayRecSubPeriod = 0) then
    select sum(PreviousLveIncHours) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and LeaveTypeFunctCode = In_LeaveType
  else
    select sum(PreviousLveIncHours) into Amt from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType
  end if;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTask') then
   drop PROCEDURE DBA.InsertNewTask
end if;

Create PROCEDURE DBA.InsertNewTask(
In In_TaskCategoryID   char(20),
In In_RemSetupSysID    integer,
In In_Message          char(255),
In In_Details          char(2000),
In In_DueDate          date,
In In_ReminderDate     date,
In In_Priority         char(20),
In In_IsCompleted      smallint,
In In_CompletedBy      char(20),
In In_CompletedDate    date,
In In_CreatedBy        char(20),
In In_ModifiedBy       char(20),
In In_FuncKey1         char(50),
In In_FuncKey2         char(50),
In In_FuncKey3         char(50),
In In_FuncKey4         char(50),
In In_FuncKey5         char(50),
Out Out_TaskSysId      integer)
BEGIN
    declare talCount integer;
    select count(*) into talCount from Task;
    if talCount = 0 then
       set Out_TaskSysId = 1;
    else 
       select (Max(TaskSysId)+1) into Out_TaskSysId from Task ;
    end if;
    Insert into Task(TaskSysId,TaskCategoryID, RemSetupSysID, "Message",Details,DueDate,ReminderDate,
     Priority,IsCompleted,CompletedBy,CompletedDate,CreatedBy,CreatedDateTime,ModifiedBy,
     ModifiedDateTime,FuncKey1,FuncKey2,FuncKey3,FuncKey4,FuncKey5)
    Values(Out_TaskSysId,In_TaskCategoryID,In_RemSetupSysID,In_Message,In_Details,In_DueDate,In_ReminderDate,
     In_Priority,In_IsCompleted, In_CompletedBy,In_CompletedDate,In_CreatedBy,Now(*),In_ModifiedBy,
     Now(*),In_FuncKey1,In_FuncKey2,In_FuncKey3,In_FuncKey4,In_FuncKey5);

   commit work;
     
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTask') then
   drop PROCEDURE DBA.DeleteTask
end if;

create PROCEDURE DBA.DeleteTask( 
In In_TaskSysID integer,
Out Out_ErrorCode integer )
BEGIN
	if exists(select * from task where TaskSysID = In_TaskSysID) then
       delete from task where TaskSysID = In_TaskSysID;
       commit work;
      if exists(select * from task where TaskSysID = In_TaskSysID) then 
        set Out_ErrorCode = 0;
      else 
        set Out_ErrorCode = 1;
      end if;
    else
       set Out_ErrorCode = 0;
    end if;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTask') then
   drop PROCEDURE DBA.UpdateTask
end if;

create PROCEDURE DBA.UpdateTask(
In In_TaskSysID        integer,
In In_TaskCategoryID   char(20),
In In_RemSetupSysID    integer,
In In_Message          char(255),
In In_Details          char(2000),
In In_DueDate          date,
In In_ReminderDate     date,
In In_Priority         char(20),
In In_IsCompleted      smallint,
In In_CompletedBy      char(20),
In In_CompletedDate    date,
In In_ModifiedBy       char(20),
In In_FuncKey1         char(50),
In In_FuncKey2         char(50),
In In_FuncKey3         char(50),
In In_FuncKey4         char(50),
In In_FuncKey5         char(50),
Out Out_ErrorCode      integer)
BEGIN
   if exists(select * from Task where TaskSysID = In_TaskSysID) Then
      Update Task Set 
       TaskCategoryID = In_TaskCategoryID,
       RemSetupSysID = In_RemSetupSysID,
       "Message" = In_Message,
       Details = In_Details,
       DueDate = In_DueDate,
       ReminderDate = In_ReminderDate,
       Priority = In_Priority,
       IsCompleted = In_IsCompleted,
       CompletedBy = In_CompletedBy,
       CompletedDate = In_CompletedDate,
       ModifiedBy = In_ModifiedBy,
       ModifiedDateTime = Now(*),
       FuncKey1 = In_FuncKey1,
       FuncKey2 = In_FuncKey2,
       FuncKey3 = In_FuncKey3,
       FuncKey4 = In_FuncKey4,
       FuncKey5 = In_FuncKey5
     where TaskSysID = In_TaskSysID;
     Commit work;
     set Out_ErrorCode=1;
    else
     set Out_ErrorCode=0;
    end if;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRemSetup') then
   drop PROCEDURE DBA.InsertNewRemSetup
end if;

create PROCEDURE DBA.InsertNewRemSetup(
in In_RemFunctionID char(20),
in In_TaskCategoryID char(20),
in In_Occurrence char(20),
in In_Message char(255),
in In_Details char(2000),
in In_DueDate date,
in In_OccurrenceValue integer,
in In_ParamValueU1 char(100),
in In_ParamValueU2 char(100),
in In_ParamValueU3 char(100),
in In_ParamValueU4 char(100),
in In_ParamValueU5 char(100),
in In_CreatedBy char(20),
out Out_RemSetupSysId  integer)
begin
    declare talCount integer;
    if In_RemFunctionID is null then set Out_RemSetupSysId =-1;
        return
    end if;
    if In_Occurrence is null then set Out_RemSetupSysId =-2;
        return
    end if;
    if In_TaskCategoryID is null then set Out_RemSetupSysId =-3;
        return
    end if;

    select count(*) into talCount from RemSetup;
	if talCount = 0 then
	   set Out_RemSetupSysId = 1;
	else
      Select (Max(RemSetupSysId)+1) into Out_RemSetupSysId from RemSetup ;
    end if;
	
    if not exists(Select * from RemSetup where TaskCategoryID = In_TaskCategoryID and RemFunctionID = In_RemFunctionID and
      DueDate = In_DueDate and CreatedBy=In_CreatedBy and Occurrence=In_Occurrence and OccurrenceValue=In_OccurrenceValue and
      Details=In_Details) then

    insert into RemSetup(
    RemSetupSysId,
    TaskCategoryID,
    RemFunctionID ,
    [Message] ,
    Details ,
    DueDate ,
    Occurrence ,
    OccurrenceValue ,
    ParamValueU1 ,
    ParamValueU2 ,
    ParamValueU3 ,
    ParamValueU4,
    ParamValueU5 ,
    CreatedBy,
    CreatedDateTime,
    ModifiedDateTime) 
    values(
    Out_RemSetupSysId,
    In_TaskCategoryID,
    In_RemFunctionID ,
    In_Message ,
    In_Details ,
    In_DueDate ,
    In_Occurrence ,
    In_OccurrenceValue ,
    In_ParamValueU1 ,
    In_ParamValueU2 ,
    In_ParamValueU3 ,
    In_ParamValueU4,
    In_ParamValueU5 ,
    In_CreatedBy,
    Now(*),
    Now(*)); 
 if not exists(Select * from RemSetup where TaskCategoryID = In_TaskCategoryID and RemFunctionID = In_RemFunctionID and
      DueDate = In_DueDate and CreatedBy=In_CreatedBy and Occurrence=In_Occurrence and OccurrenceValue=In_OccurrenceValue and
      Details=In_Details) then
      set Out_RemSetupSysId =0
 end if
  else
    set Out_RemSetupSysId =0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRemSetup') then
   drop PROCEDURE DBA.UpdateRemSetup
end if;

create PROCEDURE DBA.UpdateRemSetup(
in In_RemSetupSysID integer,
in In_RemFunctionID char(20),
in In_TaskCategoryID char(20),
in In_Occurrence char(20),
in In_Message char(255),
in In_Details char(2000),
in In_DueDate DateTime,
in In_OccurrenceValue integer,
in In_ParamValueU1 char(100),
in In_ParamValueU2 char(100),
in In_ParamValueU3 char(100),
in In_ParamValueU4 char(100),
in In_ParamValueU5 char(100),
in In_ModifiedBy char(20),
out Out_ErrorCode integer)
begin
    if exists(select* from RemSetup where
     RemSetupSysID=In_RemSetupSysID) then  
        update RemSetup set
        RemFunctionID =In_RemFunctionID,
        TaskCategoryID=In_TaskCategoryID,
        Occurrence =In_Occurrence,
        [Message] =In_Message,
        Details =In_Details,
        DueDate =In_DueDate,
        OccurrenceValue =In_OccurrenceValue,
        ParamValueU1 =In_ParamValueU1,
        ParamValueU2 =In_ParamValueU2,
        ParamValueU3 =In_ParamValueU3,
        ParamValueU4 =In_ParamValueU4,
        ParamValueU5 =In_ParamValueU5,
        ModifiedBy=In_ModifiedBy,
        ModifiedDateTime=Now(*) where
        RemSetupSysID=In_RemSetupSysID;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRemSetup') then
   drop PROCEDURE DeleteRemSetup
end if;

create PROCEDURE DBA.DeleteRemSetup(
in In_RemSetupSysID integer,
out Out_ErrorCode integer)
begin
  if exists(select* from RemSetup where RemSetupSysID = In_RemSetupSysID) then
    delete from Task where
      Task.RemSetupSysID = In_RemSetupSysID;
    commit work;
    delete from RemSetup where
      RemSetupSysID  = In_RemSetupSysID;
    commit work;
    if exists(select* from RemSetup where  RemSetupSysID  = In_RemSetupSysID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditWarningMessage') then
   drop FUNCTION DBA.FGetLveCreditWarningMessage
end if;

Create FUNCTION DBA.FGetLveCreditWarningMessage(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_Balance double,
in In_LeaveStatus char(20),
in In_LeaveDate date)
RETURNS char(100)
BEGIN
	Declare out_Message char(100);
    Declare preCount integer;
    Declare curExpireDate date;
    Set out_Message = '';
    
    if In_Balance < 0 then
       set out_Message = 'Balance is negative;';
     end if;

    if (In_LeaveStatus = 'Earned') then
       Select CreditExpireDate into curExpireDate  from AdjustCredit
       where EmployeesysId  = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and AdjType = 0
           and AdjEffectiveDate = In_LeaveDate;
 
       Select count(*) into preCount From AdjustCredit
       where EmployeesysId  = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and AdjType = 0
          and (AdjEffectiveDate < In_LeaveDate and CreditExpireDate > curExpireDate) ;

       if preCount > 0 then
          set out_Message = out_Message + 'Expiry date cannot be earlier than previous records'' Expiry Date.';
       end if;

       Select count(*) into preCount From AdjustCredit
       where EmployeesysId  = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and AdjType = 0
          and (AdjEffectiveDate > In_LeaveDate and CreditExpireDate < curExpireDate) ;

       if preCount > 0 then 
          set out_Message = out_Message + 'Expiry date cannot be later than future records'' Expiry Date.';
       end if;
    end if;
  
	RETURN out_Message
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateTask') then
   drop PROCEDURE DBA.ASQLCreateTask
end if;

Create PROCEDURE DBA.ASQLCreateTask( 
in In_RemSetupSysID integer,
in In_TaskCategoryID char(20),
in In_Message char(255),
in In_Details char(2000),
in In_DueDate date,
in In_ReminderDate date,
in In_Priority char(20),
in In_IsCompleted smallint,
in In_CompletedBy char(20),
in In_CompletedDate date,
in In_CreatedBy char(20),
in In_FuncKey1 char(50),
in In_FuncKey2 char(50),
in In_FuncKey3 char(50),
in In_FuncKey4 char(50),
in In_FuncKey5 char(50))
BEGIN
	
    declare Out_TaskSysID integer;
    IF NOT EXISTS (SELECT * FROM Task 
        WHERE RemSetupSysID = In_RemSetupSysID AND CreatedBy = In_CreatedBy AND ReminderDate = In_ReminderDate 
            AND FuncKey1 = In_FuncKey1 AND FuncKey2 = In_FuncKey2 AND FuncKey3 = In_FuncKey3
            AND FuncKey4 = In_FuncKey4 AND FuncKey5 = In_FuncKey5) THEN
    
            CALL InsertNewTask(In_TaskCategoryID
                , In_RemSetupSysID
                , In_Message 
                , In_Details
                , In_DueDate
                , In_ReminderDate
                , In_Priority
                , In_IsCompleted
                , In_CompletedBy
                , In_CompletedDate
                , In_CreatedBy
                , NULL
                , In_FuncKey1  
                , In_FuncKey2  
                , In_FuncKey3  
                , In_FuncKey4  
                , In_FuncKey5
                , Out_TaskSysID);  
    END IF;
END
;

commit work;








