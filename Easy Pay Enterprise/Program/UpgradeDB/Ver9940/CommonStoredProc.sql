
if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCareerProgression') then
   drop procedure InsertNewCareerProgression
end if
;

create procedure
dba.InsertNewCareerProgression(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerRemarks char(100),
in In_CareerAttachmentID char(100),
in In_CareerCareerId char(20),
in In_CareerCurrent integer)
begin
  if(In_CareerCurrent = 1) then
    if exists(select* from CareerProgression where CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerCurrent = In_CareerCurrent) then
      update CareerProgression set
        CareerProgression.CareerCurrent = 0 where
        CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerCurrent = In_CareerCurrent;
      commit work
    end if
  else
    if not exists(select* from CareerProgression where CareerProgression.EmployeeSysId = In_EmployeeSysId) then
      set In_CareerCurrent=1
    end if
  end if;
  if not exists(select* from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate) then
    insert into CareerProgression(EmployeeSysId,
      CareerEffectiveDate,
      CareerRemarks,
      CareerAttachmentID,
      CareerCareerId,
      CareerCurrent) values(
      In_EmployeeSysId,
      In_CareerEffectiveDate,
      In_CareerRemarks,
      In_CareerAttachmentID,
      In_CareerCareerId,
      In_CareerCurrent);
    commit work
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmployeeRecord') then
   drop procedure InsertNewEmployeeRecord
end if
;

create procedure
dba.InsertNewEmployeeRecord(
in In_PersonalSysId integer,
in In_EmployeeId char(30),
in In_CompanyId char(20),
in In_BranchId char(20),
in In_CessationCode char(20),
in In_CategoryId char(20),
in In_DepartmentId char(20),
in In_PositionId char(20),
in In_SectionId char(20),
in In_CessationDate date,
in In_HireDate date,
in In_ConfirmationDate date,
in In_ProbationPeriod integer,
in In_ProbationUnit char(10),
in In_RetirementAge integer,
in In_RetirementDate date,
in In_Supervisor char(30),
in In_IsSupervisor smallint,
in In_PreviousSvcYear double,
in In_SalaryGradeId char(20),
in In_EmpCode1Id char(20),
in In_EmpCode2Id char(20),
in In_EmpCode3Id char(20),
in In_EmpCode4Id char(20),
in In_EmpCode5Id char(20),
in In_EmpLocation1Id char(20),
in In_ClassificationCode char(20),
in In_CustBoolean1 smallint,
in In_CustBoolean2 smallint,
in In_CustBoolean3 smallint,
in In_CustDate1 date,
in In_CustDate2 date,
in In_CustDate3 date,
in In_CustInteger1 integer,
in In_CustInteger2 integer,
in In_CustInteger3 integer,
in In_CustNumeric1 double,
in In_CustNumeric2 double,
in In_CustNumeric3 double,
in In_CustString1 char(50),
in In_CustString2 char(50),
in In_CustString3 char(50),
in In_CustString4 char(50),
in In_CustString5 char(50))
begin
  declare Char_IdentityNo char(30);
  declare Char_RaceId char(20);
  declare Char_ReligionId char(20);
  declare Char_TitleId char(20);
  declare Char_MaritalstatusCode char(10);
  declare Char_IdentityTypeCode char(20);
  declare Char_CountryOfBirth char(60);
  declare Date_DateOfBirth date;
  declare Char_PersonalName char(150);
  declare SInt_Gender char(1);
  declare Char_Nationality char(60);
  declare Int_HighestEduCode integer;
  declare Char_ResidenceStatus char(20);
  declare Out_LicenseExceed integer;
  declare UpdateCurEmployeeId integer;
  /*
  Check for License Exceeded
  */
  select FGetLicenseEmployeeCountExceed(In_PersonalSysId) into Out_LicenseExceed;
  if(Out_LicenseExceed = 1) then return
  end if;
  /*
  Check for Current Employee ID
  */
  if In_CessationDate is null or In_CessationDate = '1899-12-30' then
    set UpdateCurEmployeeId=1
  else
    if exists(select* from Employee where PersonalSysId = In_PersonalSysId and(CessationDate = '1899-12-30' or CessationDate > In_CessationDate)) then
      set UpdateCurEmployeeId=0
    else
      set UpdateCurEmployeeId=1
    end if
  end if;
  /*
  Create Employee Record
  */
  if not exists(select* from Employee where Employee.EmployeeId = In_EmployeeId and
      Employee.PersonalSysId = In_PersonalsysId) then
    select ResidenceStatusRecord.ResidenceTypeId into Char_ResidenceStatus
      from ResidenceStatusRecord where
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId and
      ResidenceStatusRecord.ResStatusCurrent = 1;
    select Personal.IdentityNo,Personal.RaceId,Personal.ReligionId,Personal.TitleId,
      Personal.MaritalStatusCode,Personal.IdentityTypeId,Personal.CountryOfBirth,
      Personal.DateOfBirth,Personal.PersonalName,Personal.Gender,Personal.Nationality into Char_IdentityNo,
      Char_RaceId,Char_ReligionId,Char_TitleId,
      Char_MaritalStatusCode,Char_IdentityTypeCode,Char_CountryOfBirth,
      Date_DateOfBirth,Char_PersonalName,SInt_Gender,
      Char_Nationality from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    select EducationRec.EduRecId into Int_HighestEduCode
      from EducationRec where
      EducationRec.PersonalSysId = In_PersonalSysId and
      EducationRec.EduHighest = 1;
    insert into Employee(PersonalSysId,EmployeeId,IdentityNo,RaceId,
      ReligionID,TitleId,MaritalStatusCode,IdentityTypeCode,
      CountryOfBirth,DateOfBirth,EmployeeName,Gender,Nationality,
      ResidenceStatus,HighestEduCode,CompanyId,BranchId,
      CessationCode,CategoryId,DepartmentId,
      PositionId,SectionId,CessationDate,
      HireDate,ConfirmationDate,ProbationPeriod,
      ProbationUnit,RetirementAge,RetirementDate,
      Supervisor,IsSupervisor,PreviousSvcYear,
      SalaryGradeId,
      EmpCode1Id,
      EmpCode2Id,
      EmpCode3Id,
      EmpCode4Id,
      EmpCode5Id,
      EmpLocation1Id,
      ClassificationCode,
      CustBoolean1,
      CustBoolean2,
      CustBoolean3,
      CustDate1,
      CustDate2,
      CustDate3,
      CustInteger1,
      CustInteger2,
      CustInteger3,
      CustNumeric1,
      CustNumeric2,
      CustNumeric3,
      CustString1,
      CustString2,
      CustString3,
      CustString4,
      CustString5) values(
      In_PersonalSysId,In_EmployeeId,Char_IdentityNo,Char_RaceId,
      Char_ReligionId,Char_TitleId,Char_MaritalStatusCode,Char_IdentityTypeCode,
      Char_CountryOfBirth,Date_DateOfBirth,Char_PersonalName,SInt_Gender,Char_Nationality,
      Char_ResidenceStatus,Int_HighestEduCode,In_CompanyId,In_BranchId,
      In_CessationCode,In_CategoryId,In_DepartmentId,
      In_PositionId,In_SectionId,In_CessationDate,
      In_HireDate,In_ConfirmationDate,In_ProbationPeriod,
      In_ProbationUnit,In_RetirementAge,In_RetirementDate,
      In_Supervisor,In_IsSupervisor,In_PreviousSvcYear,
      In_SalaryGradeId,
      In_EmpCode1Id,
      In_EmpCode2Id,
      In_EmpCode3Id,
      In_EmpCode4Id,
      In_EmpCode5Id,
      In_EmpLocation1Id,
      In_ClassificationCode,
      In_CustBoolean1,
      In_CustBoolean2,
      In_CustBoolean3,
      In_CustDate1,
      In_CustDate2,
      In_CustDate3,
      In_CustInteger1,
      In_CustInteger2,
      In_CustInteger3,
      In_CustNumeric1,
      In_CustNumeric2,
      In_CustNumeric3,
      In_CustString1,
      In_CustString2,
      In_CustString3,
      In_CustString4,
      In_CustString5);
    commit work;
    if UpdateCurEmployeeId = 1 then
      update Personal set
        Personal.EmployeeId = In_EmployeeId where
        Personal.PersonalSysId = In_PersonalSysId;
      commit work
    end if
  end if
end
;