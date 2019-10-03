/* ============================================================ */
/*   View: View_TMS_JobCode                      */
/* ============================================================ */ 
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_JobCode') then
ALTER VIEW "DBA"."View_TMS_JobCode"
   AS
   SELECT JobCode, JobCodeDesc FROM JobCode
else
CREATE VIEW "DBA"."View_TMS_JobCode"
   AS
   SELECT JobCode, JobCodeDesc FROM JobCode
end if;


if exists(select * from sys.sysprocedure where proc_name = 'InsertNewBatchRpt') then
  drop procedure InsertNewBatchRpt;
end if;

CREATE PROCEDURE "DBA"."InsertNewBatchRpt"(
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
end ;


if exists(select * from sys.sysprocedure where proc_name = 'InsertNewPersonalAttachment') then
  drop procedure InsertNewPersonalAttachment;
end if;

CREATE PROCEDURE "DBA"."InsertNewPersonalAttachment"(
in In_PersonalSysId integer,
in In_PersonalAttFileName char(100),
in In_PersonalAttOrgFilePath char(255),
in In_PersonalAttDescription char(255),
in In_PersonalAttCategory char(100),
out Out_PersonalAttachmentId integer
)
BEGIN
    select Max(PersonalAttachmentId) into Out_PersonalAttachmentId from PersonalAttachment;
    if(Out_PersonalAttachmentId is null) then set Out_PersonalAttachmentId=1
    else set Out_PersonalAttachmentId=Out_PersonalAttachmentId+1
    end if;
	Insert into PersonalAttachment(PersonalAttachmentId,PersonalSysId,PersonalAttFileName,PersonalAttOrgFilePath,PersonalAttDescription,PersonalAttCategory)
    Values(Out_PersonalAttachmentId,In_PersonalSysId,In_PersonalAttFileName,In_PersonalAttOrgFilePath,In_PersonalAttDescription,In_PersonalAttCategory);
    commit work;
END ;


if exists(select * from sys.sysprocedure where proc_name = 'UpdatePersonalAttachment') then
  drop procedure UpdatePersonalAttachment;
end if;

CREATE PROCEDURE "DBA"."UpdatePersonalAttachment"( 
in In_PersonalAttachmentId integer,
in In_PersonalAttFileName char(100),
in In_PersonalAttOrgFilePath char(255),
in In_PersonalAttDescription char(255),
in In_PersonalAttCategory char(100),
out Out_ErrorCode integer
)
BEGIN
   if exists(select * from PersonalAttachment where PersonalAttachmentId = In_PersonalAttachmentId) Then
      Update PersonalAttachment Set 
       PersonalAttFileName = In_PersonalAttFileName,
       PersonalAttOrgFilePath = In_PersonalAttOrgFilePath,
       PersonalAttDescription = In_PersonalAttDescription,
       PersonalAttCategory = In_PersonalAttCategory
     where PersonalAttachmentId = In_PersonalAttachmentId;
     Commit work;
     set Out_ErrorCode=1;
    else
     set Out_ErrorCode=0;
    end if;
END ;


if exists(select * from sys.sysprocedure where proc_name = 'DeletePersonalAttachment') then
  drop procedure DeletePersonalAttachment;
end if;

CREATE PROCEDURE "DBA"."DeletePersonalAttachment"( 
In In_PersonalAttachmentId integer,
Out Out_ErrorCode integer
)
BEGIN
	if exists(select * from PersonalAttachment where PersonalAttachmentId = In_PersonalAttachmentId) then
       delete from PersonalAttachment where PersonalAttachmentId = In_PersonalAttachmentId;;
       commit work;
      if exists(select * from PersonalAttachment where PersonalAttachmentId = In_PersonalAttachmentId) then 
        set Out_ErrorCode = 0;
      else 
        set Out_ErrorCode = 1;
      end if;
    else
       set Out_ErrorCode = 0;
    end if;
END ;


if exists(select * from sys.sysprocedure where proc_name = 'DeletePersonalRecord') then
  drop procedure DeletePersonalRecord;
end if;

CREATE PROCEDURE "DBA"."DeletePersonalRecord"(
in In_PersonalSysId integer)
begin
  if exists(select* from Personal where Personal.PersonalSysId = In_PersonalSysId) then
    EmployeeLoop: for EmployeeFor as Employeecurs dynamic scroll cursor for
      select Employee.EmployeeSysId as Out_EmployeeSysId from Employee where
        Employee.PersonalSysID = In_PersonalSysId do
      call ASQLDeleteEmployment(Out_EmployeeSysId);
      commit work end for;
    /*Standard deletion for all countries*/
    call DeleteRptConfigEmail(In_PersonalSysId);
    call DeletePersonalEmailAll(In_PersonalSysId);
    call DeletePersonalContactAll(In_PersonalSysId);
    call DeletePersonalAddressAll(In_PersonalSysId);
    call DeleteResStatusRecordBySysId(In_PersonalSysId);
    call DeleteHRDetails(In_PersonalSysId);
    delete from ProjContractWorker where
      ProjContractWorker.PersonalSysId = In_PersonalSysId;
    delete from InterfaceDetails where
      InterfaceDetails.PersonalSysId = In_PersonalSysId;
    delete from Attachment where
      Attachment.PersonalSysId = In_PersonalSysId;
    delete from PersonalAttachment where
      PersonalAttachment.PersonalSysId = In_PersonalSysId;
    
    /*Alert*/
    if exists(select * from AlertAssignRole where PersonalSysid = In_PersonalSysId) then
       AlertLoop: for AlertFor as Alertcurs dynamic scroll cursor for
      select AlertAssignRole.AlertAssignRoleSysId as Out_AlertAssignRoleSysId from AlertAssignRole where
        AlertAssignRole.PersonalSysID = In_PersonalSysId do
        delete from AlertUserDefAssign where AlertUserDefAssign.AlertAssignRoleSysId = Out_AlertAssignRoleSysId;
      commit work end for;

    delete from AlertAssignRole where PersonalSysid = In_PersonalSysId;
    end if;   
     
    /*Income Tax Deletion*/
    if FGetDBCountry(*) = 'Singapore' then
      call DeleteYEEmployeeByPersonalSysID(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Indonesia' then
      call DeleteIndoTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Malaysia' then
      call DeleteMalTaxDetails(In_PersonalSysId);
      call DeleteMalRebateGrantedByPersonalSysId(In_PersonalSysId);
      call DeleteMalRebateClaimByPersonalSysId(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Philippines' then
      call DeletePhTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Vietnam' then
      call DeleteVnTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Thailand' then
      call DeleteThTaxDetails(In_PersonalSysId)
    end if;
    /*Custom Tables*/
    call DeletePersonalCustomRecord(In_PersonalSysId);
    /*Delete Personal*/
    delete from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end ;


commit work;