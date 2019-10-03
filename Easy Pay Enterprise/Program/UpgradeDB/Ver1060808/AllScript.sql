READ UpgradeDB\Ver1060808\entity.sql;

//ASQLCreatePayRecord

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCreatePayRecord') then
  drop procedure ASQLCreatePayRecord;
end if;


CREATE PROCEDURE "DBA"."ASQLCreatePayRecord"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PayRecType char(20),
in In_PayDesc char(100),
in In_PayInterfaceProjectId char(20))
begin
  call InsertNewPayRecord(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  In_PayRecID,
  In_PayRecType,'Active','S',
  now(*),
  In_PayDesc,
  In_PayInterfaceProjectId,0)
end;



//InsertNewEmployeeRecord

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewEmployeeRecord') then
  drop procedure InsertNewEmployeeRecord;
end if;


CREATE PROCEDURE "DBA"."InsertNewEmployeeRecord"(
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
in In_CustString5 char(50),
in In_IsSalaryDeductCap smallint)
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
      CustString5,
      IsSalaryDeductCap) values(
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
      In_CustString5,
      In_IsSalaryDeductCap);
    commit work;
    if UpdateCurEmployeeId = 1 then
      update Personal set
        Personal.EmployeeId = In_EmployeeId where
        Personal.PersonalSysId = In_PersonalSysId;
      commit work
    end if
  end if
end;



//InsertNewPayRecord

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewPayRecord') then
  drop procedure InsertNewPayRecord;
end if;

CREATE PROCEDURE "DBA"."InsertNewPayRecord"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PayRecType char(20),
in In_Status char(20),
in In_CreatedBy char(1),
in In_LastProcessed timestamp,
in In_PayDesc char(100),
in In_PayInterfaceProjectId char(20),
in In_IsExceedAuthDeductCap smallint)
begin
  if not exists(select* from PayRecord where
      PayRecord.EmployeeSysId = In_EmployeeSysId and
      PayRecord.PayRecYear = In_PayRecYear and
      PayRecord.PayRecPeriod = In_PayRecPeriod and
      PayRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecord.PayRecID = In_PayRecID) then
    insert into PayRecord(PayRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      PayRecType,
      Status,
      CreatedBy,
      LastProcessed,
      PayDesc,
      PayInterfaceProjectId,
      IsExceedAuthDeductCap) values(
      FGetNewSGSPGeneratedIndex('PayRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_PayRecType,
      In_Status,
      In_CreatedBy,
      In_LastProcessed,
      In_PayDesc,
      In_PayInterfaceProjectId,
      In_IsExceedAuthDeductCap);
    commit work
  end if
end;


//UpdateEmployeeRecord

if exists(select * from sys.sysprocedure where proc_name = 'UpdateEmployeeRecord') then
  drop procedure UpdateEmployeeRecord;
end if;

CREATE PROCEDURE "DBA"."UpdateEmployeeRecord"(
in In_EmployeeSysId integer,
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
in In_CustString5 char(50),
in In_IsSalaryDeductCap smallint)
begin
  declare Old_HireDate date;
  declare Old_ConfirmationDate date;
  declare In_BRProgDate date;
  declare In_BRProgRemarks char(255);
  declare In_BRProgEffectiveDate date;
  declare In_BRProgBasicRateType char(20);
  declare In_BRProgNewBasicRate double;
  declare In_BRProgPercentage double;
  declare In_BRProgressionCode char(20);
  declare In_BRProgCareerId char(20);
  declare In_BRProgPrevBasicRate double;
  declare In_BRProgIncrementAmt double;
  declare In_BRProgPayGroup char(20);
  declare In_BRProgCurrent smallint;
  declare Current_EmployeeSysId integer;
  if exists(select* from Employee where Employee.EmployeeSysId = In_EmployeeSysId) then
    select HireDate,ConfirmationDate into Old_HireDate,Old_ConfirmationDate from Employee where EmployeeSysId = In_EmployeeSysId;
    update Employee set
      Employee.CompanyId = In_CompanyId,
      Employee.BranchId = In_BranchId,
      Employee.CessationCode = In_CessationCode,
      Employee.CategoryId = In_CategoryId,
      Employee.DepartmentId = In_DepartmentId,
      Employee.PositionId = In_PositionId,
      Employee.SectionId = In_SectionId,
      Employee.CessationDate = In_CessationDate,
      Employee.HireDate = In_HireDate,
      Employee.ConfirmationDate = In_ConfirmationDate,
      Employee.ProbationPeriod = In_ProbationPeriod,
      Employee.ProbationUnit = In_ProbationUnit,
      Employee.RetirementAge = In_RetirementAge,
      Employee.RetirementDate = In_RetirementDate,
      Employee.Supervisor = In_Supervisor,
      Employee.IsSupervisor = In_IsSupervisor,
      Employee.PreviousSvcYear = In_PreviousSvcYear,
      Employee.SalaryGradeId = In_SalaryGradeId,
      Employee.EmpCode1Id = In_EmpCode1Id,
      Employee.EmpCode2Id = In_EmpCode2Id,
      Employee.EmpCode3Id = In_EmpCode3Id,
      Employee.EmpCode4Id = In_EmpCode4Id,
      Employee.EmpCode5Id = In_EmpCode5Id,
      Employee.EmpLocation1Id = In_EmpLocation1Id,
      Employee.ClassificationCode = In_ClassificationCode,
      Employee.CustBoolean1 = In_CustBoolean1,
      Employee.CustBoolean2 = In_CustBoolean2,
      Employee.CustBoolean3 = In_CustBoolean3,
      Employee.CustDate1 = In_CustDate1,
      Employee.CustDate2 = In_CustDate2,
      Employee.CustDate3 = In_CustDate3,
      Employee.CustInteger1 = In_CustInteger1,
      Employee.CustInteger2 = In_CustInteger2,
      Employee.CustInteger3 = In_CustInteger3,
      Employee.CustNumeric1 = In_CustNumeric1,
      Employee.CustNumeric2 = In_CustNumeric2,
      Employee.CustNumeric3 = In_CustNumeric3,
      Employee.CustString1 = In_CustString1,
      Employee.CustString2 = In_CustString2,
      Employee.CustString3 = In_CustString3,
      Employee.CustString4 = In_CustString4,
      Employee.CustString5 = In_CustString5,
      Employee.IsSalaryDeductCap = In_IsSalaryDeductCap,
      Employee.EmployeeId = In_EmployeeId where
      Employee.EmployeeSysId = In_EmployeeSysId;
    select first EmployeeSysId into Current_EmployeeSysId from Employee where PersonalSysId = In_PersonalSysId order by hiredate desc;
    if(Current_EmployeeSysId = In_EmployeeSysId) then
      update Personal set
        Personal.EmployeeId = In_EmployeeId where
        Personal.PersonalSysId = In_PersonalSysId
    end if;
    if(Old_HireDate <> In_HireDate) then
      if(not exists(select* from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and BRProgDate = In_HireDate)) then
        select BRProgressionCode,
          BRProgCareerId,
          BRProgPrevBasicRate,
          BRProgIncrementAmt,
          BRProgPercentage,
          BRProgNewBasicRate,
          BRProgBasicRateType,
          BRProgPayGroup,
          BRProgCurrent,
          BRProgRemarks into In_BRProgressionCode,
          In_BRProgCareerId,
          In_BRProgPrevBasicRate,
          In_BRProgIncrementAmt,
          In_BRProgPercentage,
          In_BRProgNewBasicRate,
          In_BRProgBasicRateType,
          In_BRProgPayGroup,
          In_BRProgCurrent,
          In_BRProgRemarks from BasicRateProgression where
          EmployeeSysId = In_EmployeeSysId and
          BRProgDate = Old_HireDate;
        insert into BasicRateProgression(EmployeeSysId,
          BRProgRemarks,
          BRProgDate,
          BRProgEffectiveDate,
          BRProgBasicRateType,
          BRProgNewBasicRate,
          BRProgPercentage,
          BRProgressionCode,
          BRProgCareerId,
          BRProgPrevBasicRate,
          BRProgIncrementAmt,
          BRProgPayGroup,BRProgCurrent) values(
          In_EmployeeSysId,
          In_BRProgRemarks,
          In_HireDate,
          In_HireDate,
          In_BRProgBasicRateType,
          In_BRProgNewBasicRate,
          In_BRProgPercentage,
          In_BRProgressionCode,
          In_BRProgCareerId,
          In_BRProgPrevBasicRate,
          In_BRProgIncrementAmt,
          In_BRProgPayGroup,
          In_BRProgCurrent);
        update PolicyProgression set
          BRProgDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          BRProgDate = Old_HireDate;
        delete from BasicRateProgression where
          EmployeeSysId = In_EmployeeSysId and
          BRProgDate = Old_HireDate
      end if;
      if(not exists(select* from SOCSOProgression where EmployeeSysId = In_EmployeeSysId and SOCSOEffectiveDate = In_HireDate)) then
        update SOCSOProgression set
          SOCSOEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          SOCSOEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from EPFProgression where EmployeeSysId = In_EmployeeSysId and EPFEffectiveDate = In_HireDate)) then
        update EPFProgression set
          EPFEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          EPFEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from CPFProgression where EmployeeSysId = In_EmployeeSysId and CPFEffectiveDate = In_HireDate)) then
        update CPFProgression set
          CPFEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          CPFEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from EmployPassProgression where EmployeeSysId = In_EmployeeSysId and EPEffectiveDate = In_HireDate)) then
        update EmployPassProgression set
          EPEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          EPEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from FWLProgression where EmployeeSysId = In_EmployeeSysId and FWLEffectiveDate = In_HireDate)) then
        update FWLProgression set
          FWLEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          FWLEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from CostProgression where EmployeeSysId = In_EmployeeSysId and CostProgEffectiveDate = In_HireDate)) then
        update CostProgression set
          CostProgEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          CostProgEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and MandContriEffDate = In_HireDate)) then
        update MandatoryContributeProg set
          MandContriEffDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          MandContriEffDate = Old_HireDate
      end if;
      if(not exists(select* from MPFProgression where EmployeeSysId = In_EmployeeSysId and MPFProgEffDate = In_HireDate)) then
        update MPFProgression set
          MPFProgEffDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          MPFProgEffDate = Old_HireDate
      end if
    end if;
    if(Old_ConfirmationDate <> In_ConfirmationDate) then
      if(not exists(select* from SIProgression where EmployeeSysId = In_EmployeeSysId and SIProgressionDate = In_ConfirmationDate)) then
        update SIProgression set
          SIProgressionDate = In_ConfirmationDate,
          SIEffectiveDate = In_ConfirmationDate where
          EmployeeSysId = In_EmployeeSysId and
          SIProgressionDate = Old_ConfirmationDate
      end if;
      if(not exists(select* from HIProgression where EmployeeSysId = In_EmployeeSysId and HIEffectiveDate = In_ConfirmationDate)) then
        update HIProgression set
          HIEffectiveDate = In_ConfirmationDate where
          EmployeeSysId = In_EmployeeSysId and
          HIEffectiveDate = Old_ConfirmationDate
      end if
    end if;
    call ASQLChgKeyCareerProgression(In_EmployeeSysId,In_HireDate,Old_HireDate);
    commit work
  end if
end;

//UpdatePayRecord

if exists(select * from sys.sysprocedure where proc_name = 'UpdatePayRecord') then
  drop procedure UpdatePayRecord;
end if;

CREATE PROCEDURE "DBA"."UpdatePayRecord"(
in In_PayRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PayRecType char(20),
in In_Status char(20),
in In_CreatedBy char(1),
in In_LastProcessed timestamp,
in In_PayDesc char(100),
in In_PayInterfaceProjectId char(100),
in In_IsExceedAuthDeductCap smallint)
begin
  if exists(select* from PayRecord where
      PayRecord.PayRecSGSPGenId = In_PayRecSGSPGenId) then
    update PayRecord set
      PayRecSGSPGenId = In_PayRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      PayRecType = In_PayRecType,
      Status = In_Status,
      CreatedBy = In_CreatedBy,
      LastProcessed = In_LastProcessed,
      PayInterfaceProjectId = In_PayInterfaceProjectId,
      PayDesc = In_PayDesc,
      IsExceedAuthDeductCap = In_IsExceedAuthDeductCap where
      PayRecord.PayRecSGSPGenId = In_PayRecSGSPGenId;
    commit work
  end if
end;

commit work;
