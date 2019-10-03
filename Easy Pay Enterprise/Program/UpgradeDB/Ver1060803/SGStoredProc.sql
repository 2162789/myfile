if exists(select * from sys.sysprocedure where proc_name = 'InsertNewLabSurveyRecord') then
  drop procedure InsertNewLabSurveyRecord;
end if;

create PROCEDURE DBA.InsertNewLabSurveyRecord( 
in In_LabSurveySetupId integer,
in In_Description char(255),
in In_Rule1 char(255),
in In_Rule2 char(255),
in In_DisplaySequence integer,
in In_Result double,
in In_IPAddress char(100),
out Out_LabSurveyRecordId integer
)
BEGIN
    select Max(LabSurveyRecordId) into Out_LabSurveyRecordId from LabSurveyRecord;
    if(Out_LabSurveyRecordId is null) then set Out_LabSurveyRecordId=1
    else set Out_LabSurveyRecordId=Out_LabSurveyRecordId+1
    end if;
	Insert into LabSurveyRecord(LabSurveyRecordId,LabSurveySetupId,Description,Rule1,Rule2,DisplaySequence,
                                         Result,IPAddress)
    Values(Out_LabSurveyRecordId,In_LabSurveySetupId,In_Description,In_Rule1,In_Rule2,In_DisplaySequence,
           In_Result,In_IPAddress);
    commit work;
END;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewLabSurveyEmployeeRecord') then
  drop procedure InsertNewLabSurveyEmployeeRecord;
end if;

create PROCEDURE DBA.InsertNewLabSurveyEmployeeRecord(
In In_LabSurveyRecordId integer,
In In_EmployeeSysId integer,
In In_Result double,
out Out_LabSurveyEmployeeRecordId integer
)
BEGIN
    select Max(LabSurveyEmployeeRecordId) into Out_LabSurveyEmployeeRecordId from LabSurveyEmployeeRecord;
    if(Out_LabSurveyEmployeeRecordId is null) then set Out_LabSurveyEmployeeRecordId=1
    else set Out_LabSurveyEmployeeRecordId=Out_LabSurveyEmployeeRecordId+1
    end if;
	if exists(select * from LabSurveyRecord where LabSurveyRecordId = In_LabSurveyRecordId) then
       insert into LabSurveyEmployeeRecord(LabSurveyEmployeeRecordId,LabSurveyRecordId,EmployeeSysId,Result)
       values(Out_LabSurveyEmployeeRecordId,In_LabSurveyRecordId,in_EmployeeSysId,in_Result);
    else 
       set Out_LabSurveyEmployeeRecordId = 0;
    end if;
END;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateLabSurveyRecord') then
  drop procedure UpdateLabSurveyRecord;
end if;

create PROCEDURE DBA.UpdateLabSurveyRecord(
in In_LabSurveyRecordId integer,
in In_Result double,
out Out_ErrorCode integer
)
BEGIN
   if exists(select * from LabSurveyRecord where LabSurveyRecordId = In_LabSurveyRecordId) Then
      Update LabSurveyRecord Set 
       Result = In_Result
     where LabSurveyRecordId = In_LabSurveyRecordId;
     Commit work;
     set Out_ErrorCode=1;
    else
     set Out_ErrorCode=0;
    end if;
END;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateLabSurveyEmployeeRecord') then
  drop procedure UpdateLabSurveyEmployeeRecord;
end if;

create PROCEDURE DBA.UpdateLabSurveyEmployeeRecord(
in In_LabSurveyEmployeeRecordId integer,
in In_LabSurveyRecordId integer,
in In_EmployeeSysId integer,
in In_Result double,
out Out_ErrorCode integer)
BEGIN
   if exists(select * from LabSurveyEmployeeRecord where LabSurveyEmployeeRecordId = In_LabSurveyEmployeeRecordId) Then
      Update LabSurveyEmployeeRecord Set 
       LabSurveyRecordId = In_LabSurveyRecordId,
       EmployeeSysId = In_EmployeeSysId,
       Result = In_Result
     where LabSurveyEmployeeRecordId = In_LabSurveyEmployeeRecordId;
     Commit work;
     set Out_ErrorCode=1;
    else
     set Out_ErrorCode=0;
    end if;	
END;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteLabSurveyRecord') then
  drop procedure DeleteLabSurveyRecord;
end if;

create PROCEDURE DBA.DeleteLabSurveyRecord(
In In_LabSurveyRecordId integer,
Out Out_ErrorCode integer)
BEGIN
	if exists(select * from LabSurveyRecord where LabSurveyRecordId = In_LabSurveyRecordId) then
       delete from LabSurveyEmployeeRecord where LabSurveyRecordId = In_LabSurveyRecordId;;
       delete from LabSurveyRecord where LabSurveyRecordId = In_LabSurveyRecordId;
       commit work;
      if exists(select * from LabSurveyRecord where LabSurveyRecordId = In_LabSurveyRecordId) then 
        set Out_ErrorCode = 0;
      else 
        set Out_ErrorCode = 1;
      end if;
    else
       set Out_ErrorCode = 0;
    end if;
END;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteLabSurveyEmployeeRecord') then
  drop procedure DeleteLabSurveyEmployeeRecord;
end if;

create PROCEDURE DBA.DeleteLabSurveyEmployeeRecord(
in In_LabSurveyEmployeeRecordId integer,
out Out_ErrorCode integer)
BEGIN
	if exists(select * from LabSurveyEmployeeRecord where LabSurveyEmployeeRecordId = In_LabSurveyEmployeeRecordId) then
       delete from LabSurveyEmployeeRecord where LabSurveyEmployeeRecordId = In_LabSurveyEmployeeRecordId;
       commit work;
      if exists(select * from LabSurveyEmployeeRecord where LabSurveyEmployeeRecordId = In_LabSurveyEmployeeRecordId) then 
        set Out_ErrorCode = 0;
      else 
        set Out_ErrorCode = 1;
      end if;
    else
       set Out_ErrorCode = 0;
    end if;	
END;

commit work;