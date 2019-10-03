if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTraining') then
   drop procedure InsertNewTraining
end if
;

create procedure dba.InsertNewTraining(
in In_PersonalSysId integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_SubmissionDate date,
in In_TrainingBatchId char(20),
in In_SponsorShipCode char(20),
in In_GradeCode char(20),
in In_Approve smallint,
in In_CourseResult double,
in In_AttendancePercent double,
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_SponsorType integer,
in In_SponsorValue double,
in In_SponsorReceived date,
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date,
in In_ClaimAmount double,
in In_ClaimAdvance double,
in In_ClaimApprove smallint,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollProcessDate date,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollPayElementId char(20),
in In_TrainingPaid smallint,
in In_GovernmentGrantId char(20),
in In_ePortalStatus char(20),
in In_ePortalEmployeeSysId integer,
in In_BondSysId integer,
in In_PlanDate date,
in In_CertificateExpiryDate date,
out Out_TrainingSysId integer)
begin
  declare In_ePortalNominateEmpSysId integer;
  set Out_TrainingSysId=0;
  if(In_CourseScheduleSysId is null and In_CourseCode is null) then
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode is null and
        Training.CourseScheduleSysId is null and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  elseif(In_CourseScheduleSysId is null) then
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode = In_CourseCode and
        Training.CourseScheduleSysId is null and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  elseif(In_CourseCode is null) then
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode is null and
        Training.CourseScheduleSysId = In_CourseScheduleSysId and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  else
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode = In_CourseCode and
        Training.CourseScheduleSysId = In_CourseScheduleSysId and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  end if;
  if(In_BondSysId = 0) then set In_BondSysId=null
  end if;
  if(In_ePortalStatus = 'TrainNominate') then set In_ePortalNominateEmpSysId=In_ePortalEmployeeSysId
  end if;
  insert into Training(PersonalSysId,
    CourseCode,
    CourseScheduleSysId,
    SubmissionDate,
    TrainingBatchId,
    SponsorShipCode,
    GradeCode,
    Approve,
    CourseResult,
    AttendancePercent,
    TrainingRemarks,
    TotalTrainingFee,
    TotalTaxAmount,
    SponsorType,
    SponsorValue,
    SponsorReceived,
    GovGrantType,
    GovGrantValue,
    GovGrantReceived,
    ClaimAmount,
    ClaimAdvance,
    ClaimApprove,
    PayrollDate,
    PayrollEmployeeSysId,
    PayrollProcessDate,
    PayrollYear,
    PayrollPeriod,
    PayrollSubPeriod,
    PayrollPayElementId,
    TrainingPaid,
    GovernmentGrantId,
    ePortalStatus,
    ePortalEmployeeSysId,
    ePortalNominateEmpSysId,
    BondSysId,
    PlanDate,
    CertificateExpiryDate) values(
    In_PersonalSysId,
    In_CourseCode,
    In_CourseScheduleSysId,
    In_SubmissionDate,
    In_TrainingBatchId,
    In_SponsorShipCode,
    In_GradeCode,
    In_Approve,
    In_CourseResult,
    In_AttendancePercent,
    In_TrainingRemarks,
    In_TotalTrainingFee,
    In_TotalTaxAmount,
    In_SponsorType,
    In_SponsorValue,
    In_SponsorReceived,
    In_GovGrantType,
    In_GovGrantValue,
    In_GovGrantReceived,
    In_ClaimAmount,
    In_ClaimAdvance,
    In_ClaimApprove,
    In_PayrollDate,
    In_PayrollEmployeeSysId,
    In_PayrollProcessDate,
    In_PayrollYear,
    In_PayrollPeriod,
    In_PayrollSubPeriod,
    In_PayrollPayElementId,
    In_TrainingPaid,
    In_GovernmentGrantId,
    In_ePortalStatus,
    In_ePortalEmployeeSysId,
    In_ePortalNominateEmpSysId,
    In_BondSysId,
    In_PlanDate,
    In_CertificateExpiryDate);
  commit work;
  if(In_CourseScheduleSysId is null and In_CourseCode is null) then
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode is null and
      Training.CourseScheduleSysId is null and
      Training.SubmissionDate = In_SubmissionDate
  elseif(In_CourseScheduleSysId is null) then
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode = In_CourseCode and
      Training.CourseScheduleSysId is null and
      Training.SubmissionDate = In_SubmissionDate
  elseif(In_CourseCode is null) then
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode is null and
      Training.CourseScheduleSysId = In_CourseScheduleSysId and
      Training.SubmissionDate = In_SubmissionDate
  else
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode = In_CourseCode and
      Training.CourseScheduleSysId = In_CourseScheduleSysId and
      Training.SubmissionDate = In_SubmissionDate
  end if;
  if Out_TrainingSysId is null then set Out_TrainingSysId=0
  end if;
  if(In_CourseScheduleSysId is not null and Out_TrainingSysId <> 0 and In_ePortalStatus = 'TrainAccepted' and In_Approve = 1 and
    not exists(select* from TrainCostRec where TrainingSysId = Out_TrainingSysId and TrainCostTypeId = 'Course Fee')) then
    insert into TrainCostRec(TrainingSysId,TrainCostTypeId,TrainAmount,TrainTaxAmount,TrainForClaim) values(
      Out_TrainingSysID,'Course Fee',
      (select CourseFee from CourseSchedule where CourseScheduleSysId = In_CourseScheduleSysId and CourseCode = In_CourseCode),
      0,(select TrainForClaim from TrainCostType where TrainCostTypeId = 'Course Fee'));
    commit work
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTraining') then
   drop procedure UpdateTraining
end if
;

create procedure dba.UpdateTraining(
in In_TrainingSysID integer,
in In_PersonalSysId integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_SubmissionDate date,
in In_TrainingBatchId char(20),
in In_SponsorShipCode char(20),
in In_GradeCode char(20),
in In_Approve smallint,
in In_CourseResult double,
in In_AttendancePercent double,
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_SponsorType integer,
in In_SponsorValue double,
in In_SponsorReceived date,
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date,
in In_ClaimAmount double,
in In_ClaimAdvance double,
in In_ClaimApprove smallint,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollProcessDate date,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollPayElementId char(20),
in In_TrainingPaid smallint,
in In_GovernmentGrantId char(20),
in In_ePortalStatus char(20),
in In_ePortalEmployeeSysId integer,
in In_BondSysId integer,
in In_PlanDate date,
in In_CertificateExpiryDate date)
begin
  declare In_ePortalNominateEmpSysId integer;
  if exists(select* from Training where
      Training.TrainingSysID = In_TrainingSysID) then
    if(In_BondSysId = 0) then set In_BondSysId=null
    end if;
    if(In_ePortalStatus = 'TrainNominate') then set In_ePortalNominateEmpSysId=In_ePortalEmployeeSysId
    else
      select ePortalNominateEmpSysId into In_ePortalNominateEmpSysId from Training where Training.TrainingSysID = In_TrainingSysID
    end if;
    update Training set
      PersonalSysId = In_PersonalSysId,
      CourseCode = In_CourseCode,
      CourseScheduleSysId = In_CourseScheduleSysId,
      SubmissionDate = In_SubmissionDate,
      TrainingBatchId = In_TrainingBatchId,
      SponsorShipCode = In_SponsorShipCode,
      GradeCode = In_GradeCode,
      Approve = In_Approve,
      CourseResult = In_CourseResult,
      AttendancePercent = In_AttendancePercent,
      TrainingRemarks = In_TrainingRemarks,
      TotalTrainingFee = In_TotalTrainingFee,
      TotalTaxAmount = In_TotalTaxAmount,
      SponsorType = In_SponsorType,
      SponsorValue = In_SponsorValue,
      SponsorReceived = In_SponsorReceived,
      GovGrantType = In_GovGrantType,
      GovGrantValue = In_GovGrantValue,
      GovGrantReceived = In_GovGrantReceived,
      ClaimAmount = In_ClaimAmount,
      ClaimAdvance = In_ClaimAdvance,
      ClaimApprove = In_ClaimApprove,
      PayrollDate = In_PayrollDate,
      PayrollEmployeeSysId = In_PayrollEmployeeSysId,
      PayrollProcessDate = In_PayrollProcessDate,
      PayrollYear = In_PayrollYear,
      PayrollPeriod = In_PayrollPeriod,
      PayrollSubPeriod = In_PayrollSubPeriod,
      PayrollPayElementId = In_PayrollPayElementId,
      TrainingPaid = In_TrainingPaid,
      GovernmentGrantId = In_GovernmentGrantId,
      ePortalStatus = In_ePortalStatus,
      ePortalEmployeeSysId = In_ePortalEmployeeSysId,
      ePortalNominateEmpSysId = In_ePortalNominateEmpSysId,
      BondSysId = In_BondSysId,
      PlanDate = In_PlanDate,
      CertificateExpiryDate = In_CertificateExpiryDate where
      Training.TrainingSysID = In_TrainingSysID;
    commit work;
    if(In_ePortalStatus = 'TrainAccepted' and In_Approve = 1 and
      not exists(select* from TrainCostRec where TrainingSysId = In_TrainingSysID and TrainCostTypeId = 'Course Fee')) then
      insert into TrainCostRec(TrainingSysId,TrainCostTypeId,TrainAmount,TrainTaxAmount,TrainForClaim) values(
        In_TrainingSysID,'Course Fee',
        (select CourseFee from CourseSchedule where CourseScheduleSysId = In_CourseScheduleSysId and CourseCode = In_CourseCode),
        0,(select TrainForClaim from TrainCostType where TrainCostTypeId = 'Course Fee'));
      commit work
    end if
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainingBatch') then
   drop procedure InsertNewTrainingBatch
end if
;

create procedure dba.InsertNewTrainingBatch(
in In_TrainingBatchId char(20),
in In_Approve integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_LastModified timestamp,
in In_PayrollDate date,
in In_PayrollPayElementId char(20),
in In_SponsorShipCode char(20),
in In_SponsorType integer,
in In_SponsorValue double,
in In_SubmissionDate date,
in In_TrainingBatchDesc char(100),
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_ClaimApprove integer,
in In_TrainTaxComputation integer,
in In_TrainingPaid integer,
in In_SponsorReceived date,
in In_GovernmentGrantId char(20),
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date,
in In_PlanDate date)
begin
  if not exists(select* from TrainingBatch where
      TrainingBatchId = In_TrainingBatchId) then
    insert into TrainingBatch(TrainingBatchId,
      Approve,
      CourseCode,
      CourseScheduleSysId,
      LastModified,
      PayrollDate,
      PayrollPayElementId,
      SponsorShipCode,
      SponsorType,
      SponsorValue,
      SubmissionDate,
      TrainingBatchDesc,
      TrainingRemarks,
      TotalTrainingFee,
      TotalTaxAmount,
      ClaimApprove,
      TrainTaxComputation,
      TrainingPaid,
      SponsorReceived,
      GovernmentGrantId,
      GovGrantType,
      GovGrantValue,
      GovGrantReceived,
      PlanDate) values(
      In_TrainingBatchId,
      In_Approve,
      In_CourseCode,
      In_CourseScheduleSysId,
      In_LastModified,
      In_PayrollDate,
      In_PayrollPayElementId,
      In_SponsorShipCode,
      In_SponsorType,
      In_SponsorValue,
      In_SubmissionDate,
      In_TrainingBatchDesc,
      In_TrainingRemarks,
      In_TotalTrainingFee,
      In_TotalTaxAmount,
      In_ClaimApprove,
      In_TrainTaxComputation,
      In_TrainingPaid,
      In_SponsorReceived,
      In_GovernmentGrantId,
      In_GovGrantType,
      In_GovGrantValue,
      In_GovGrantReceived,
      In_PlanDate);
    commit work
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainingBatch') then
   drop procedure UpdateTrainingBatch
end if
;

create procedure dba.UpdateTrainingBatch(
in In_TrainingBatchId char(20),
in In_Approve integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_LastModified timestamp,
in In_PayrollDate date,
in In_PayrollPayElementId char(20),
in In_SponsorShipCode char(20),
in In_SponsorType integer,
in In_SponsorValue double,
in In_SubmissionDate date,
in In_TrainingBatchDesc char(100),
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_ClaimApprove integer,
in In_TrainTaxComputation integer,
in In_TrainingPaid integer,
in In_SponsorReceived date,
in In_GovernmentGrantId char(20),
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date,
in In_PlanDate date)
begin
  if exists(select* from TrainingBatch where TrainingBatchId = In_TrainingBatchId) then
    update TrainingBatch set
      Approve = In_Approve,
      CourseCode = In_CourseCode,
      CourseScheduleSysId = In_CourseScheduleSysId,
      LastModified = In_LastModified,
      PayrollDate = In_PayrollDate,
      PayrollPayElementId = In_PayrollPayElementId,
      SponsorShipCode = In_SponsorShipCode,
      SponsorType = In_SponsorType,
      SponsorValue = In_SponsorValue,
      SubmissionDate = In_SubmissionDate,
      TrainingBatchDesc = In_TrainingBatchDesc,
      TrainingRemarks = In_TrainingRemarks,
      TotalTrainingFee = In_TotalTrainingFee,
      TotalTaxAmount = In_TotalTaxAmount,
      ClaimApprove = In_ClaimApprove,
      TrainTaxComputation = In_TrainTaxComputation,
      TrainingPaid = In_TrainingPaid,
      SponsorReceived = In_SponsorReceived,
      GovernmentGrantId = In_GovernmentGrantId,
      GovGrantType = In_GovGrantType,
      GovGrantValue = In_GovGrantValue,
      GovGrantReceived = In_GovGrantReceived,
      PlanDate = In_PlanDate where
      TrainingBatchId = In_TrainingBatchId;
    commit work
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeRetirementDate') then
   drop procedure FGetEmployeeRetirementDate
end if
;

create function dba.FGetEmployeeRetirementDate(
in In_EmployeeSysId integer)
returns char(40)
begin
  declare Out_EmployeeRetirementDate char(40);
  select FGetDateFormat(Employee.RetirementDate) into Out_EmployeeRetirementDate
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeRetirementDate)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseTrainingTypeId') then
   drop procedure FGetCourseTrainingTypeId
end if
;

create function dba.FGetCourseTrainingTypeId(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
returns char(20)
begin
  declare Out_TrainingTypeId char(20);
  select TrainingTypeId into Out_TrainingTypeId from CourseSchedule where
    CourseCode = In_CourseCode and
    CourseScheduleSysId = In_CourseScheduleSysId;
  return Out_TrainingTypeId
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseDuration') then
   drop procedure FGetCourseDuration
end if
;

create function dba.FGetCourseDuration(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
returns double
begin
  declare Out_CourseDuration double;
  select CourseDuration into Out_CourseDuration from CourseSchedule where
    CourseCode = In_CourseCode and
    CourseScheduleSysId = In_CourseScheduleSysId;
  return Out_CourseDuration
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseUnit') then
   drop procedure FGetCourseUnit
end if
;

create function dba.FGetCourseUnit(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
returns char(20)
begin
  declare Out_CourseUnit char(20);
  select CourseUnit into Out_CourseUnit from CourseSchedule where
    CourseCode = In_CourseCode and
    CourseScheduleSysId = In_CourseScheduleSysId;
  return Out_CourseUnit
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseProvider') then
   drop procedure FGetCourseProvider
end if
;

create function dba.FGetCourseProvider(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
returns char(20)
begin
  declare Out_OrganisationCode char(20);
  select OrganisationCode into Out_OrganisationCode from CourseSchedule where
    CourseCode = In_CourseCode and
    CourseScheduleSysId = In_CourseScheduleSysId;
  return Out_OrganisationCode
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseDurationConv') then
   drop procedure FGetCourseDurationConv
end if
;

create function dba.FGetCourseDurationConv(
in In_CourseDuration double,
in In_CourseUnit char(20),
in In_NewUnit char(20))
returns double
begin
  declare Out_NewDuration double;
  set Out_NewDuration=0;
  //
  // Convert to Hours
  //
  if In_NewUnit = 'Hours' then
    if In_CourseUnit = 'Hours' then
       select (In_CourseDuration) into Out_NewDuration
    end if;

    if In_CourseUnit = 'Days' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseDyToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if;
    if In_CourseUnit = 'Weeks' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseWkToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if;
    if In_CourseUnit = 'Months' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseMthToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if;
    if In_CourseUnit = 'Years' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseYrTpHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if
  end if;
  return Out_NewDuration
end;

commit work;

Update Modulescreengroup Set HideOnlyWage = 1, HideScreenForWage = 0 where ModuleScreenId='LvProvisionRpt'

commit work;

DELETE FROM UsageItem where UsageItemID in ('CompanyName','SerialNo','ExeIPAddress');
if not exists(select 1 from UsageItem where UsageItemID='UsageDataID') then
insert into UsageItem values('UsageDataID','System','Usage Database ID','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, RegProperty1 AS RetValue FROM Subregistry WHERE SubRegistryID=''UsageDataID'';','');
end if;
if not exists(select 1 from subregistry where subregistryID='UsageDataID') then
insert into subregistry values('System','UsageDataID','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
commit work;