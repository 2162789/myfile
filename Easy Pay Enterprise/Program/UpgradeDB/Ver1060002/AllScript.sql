if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLeaveGroupDesc' and user_name(creator) = 'DBA') then
   drop function DBA.FGetLeaveGroupDesc
end if;

create FUNCTION DBA.FGetLeaveGroupDesc(
in In_LeaveGroupId char(20))
returns char(100)
begin
  declare Out_LeaveGroupDesc char(100);
  select LeaveGroup.LeaveGroupDesc into Out_LeaveGroupDesc
    from LeaveGroup where
    LeaveGroup.LeaveGroupId = In_LeaveGroupId;
  return(Out_LeaveGroupDesc)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditPeriodTaken' and user_name(creator) = 'DBA') then
   drop function DBA.FGetLveCreditPeriodTaken
end if;

create FUNCTION DBA.FGetLveCreditPeriodTaken( 
in In_EmployeeSysid integer,
in In_LeaveTypeid char(20),
in In_LveYear integer,
in In_LveMonth integer)
RETURNS double
BEGIN
	DECLARE Out_TotalTaken double;
    Select Sum(LveRecConvertDays) into Out_TotalTaken From LeaveRecord Where 
      LeaveappSGSpGenid = Any(select LeaveappSGSpGenid from leaveapplication where 
        EmployeeSysid = In_EmployeeSysid and
        LeaveTypeid = In_LeaveTypeid and
        LveRecApproved =1) and Datepart(yy,LveRecDate) = In_LveYear and Datepart(mm,LveRecDate) = In_LveMonth;
    
    If (Out_TotalTaken is null) then set Out_TotalTaken = 0 
    end if;

	RETURN Out_TotalTaken;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditPolicy' and user_name(creator) = 'DBA') then
   drop function DBA.FGetLveCreditPolicy
end if;

create FUNCTION DBA.FGetLveCreditPolicy( 
in In_EmployeeSysid integer,
in In_EffectiveDate Date,
in In_CareerAttributeID char(20))
RETURNS char(20)
BEGIN
	DECLARE Out_PolicyId char(100);
	select First CareerNewValue into Out_PolicyId from CareerAttribute where 
       EmployeeSysid = In_EmployeeSysid And CareerEffectiveDate <= In_EffectiveDate and CareerAttributeID = In_CareerAttributeID
       Order by CareerEffectiveDate desc;
	RETURN Out_PolicyId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxDetails' and user_name(creator) = 'DBA') then
   drop function DBA.DeleteMalTaxDetails
end if;

create PROCEDURE DBA.DeleteMalTaxDetails(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  call DeleteMalRebateClaimByPersonalSysId(In_PersonalSysId,Out_ErrorCode);
  call DeleteMalRebateGrantedByPersonalSysId(In_PersonalSysId,Out_ErrorCode);
  delete from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId;
  delete from MalTaxEmployee where PersonalSysId = In_PersonalSysId;
  delete from MalTaxRecord where PersonalSysId = In_PersonalSysId;
  delete from MalTaxDetails where PersonalSysId = In_PersonalSysId;
  delete from RebateGranted where PersonalSysId = In_PersonalSysId;
  set Out_ErrorCode=1
end
;

/* KeyWord */
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_ePortal') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_ePortal','Contact Number (ePortal)','Contact Number (ePortal)','EXPORT',0,0,0,'ePortalContact',243,5,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_Home') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_Home','Contact Number (Home)','Contact Number (Home)','EXPORT',0,0,0,'HomeContact',244,5,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_Work') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_Work','Contact Number (Work)','Contact Number (Work)','EXPORT',0,0,0,'WorkContact',245,5,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_Office') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_Office','Contact Number (Office)','Contact Number (Office)','EXPORT',0,0,0,'OfficeContact',246,5,0,'')
END IF;

Update ModuleScreenGroup Set HideScreenForWage = 0 where ModuleScreenId = 'ProcExcelExpDetails';

Commit Work;
