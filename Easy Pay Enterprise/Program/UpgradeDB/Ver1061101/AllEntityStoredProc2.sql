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
  declare In_BRProgNextIncDate date;
  declare In_BRProgExRateId char(20);
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
          BRProgNextIncDate,
          BRProgExRateId, 
          BRProgRemarks into In_BRProgressionCode,
          In_BRProgCareerId,
          In_BRProgPrevBasicRate,
          In_BRProgIncrementAmt,
          In_BRProgPercentage,
          In_BRProgNewBasicRate,
          In_BRProgBasicRateType,
          In_BRProgPayGroup,
          In_BRProgCurrent,
          In_BRProgNextIncDate,
          In_BRProgExRateId,
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
          BRProgPayGroup,BRProgCurrent,
          BRProgNextIncDate, 
          BRProgExRateId) values(
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
          In_BRProgCurrent,
          In_BRProgNextIncDate,
          In_BRProgExRateId);
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

if exists(select * from sys.sysprocedure where proc_name = 'FGetCPFProgAccountNo') then
   drop function FGetCPFProgAccountNo;
end if;
create function DBA.FGetCPFProgAccountNo(
in In_Employeesysid integer)
returns char(30)
begin
  declare fResult char(30);
  select distinct CPFProgAccountNo into fResult from CPFProgression where EmployeeSysId = In_EmployeeSysId and CPFProgCurrent = 1;
  if fResult is null then set fResult=''
  end if;
  if FGetDBCountry(*) = 'Singapore' then set fResult=SubString(fResult,1,10)
  end if;
  return(fResult)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewMandatoryContributeProg') then
   drop procedure InsertNewMandatoryContributeProg;
end if;
create procedure dba.InsertNewMandatoryContributeProg(
in In_EmployeeSysId integer,
in In_MandContriCareerId char(20),
in In_MandContriEffDate date,
in In_MandContriPolicyId char(20),
in In_MandContriSchemeId char(20),
in In_MandContriRemarks char(100),
in In_MandContriCurrent smallint,
in In_ManContriActSchemeId char(20),
out Out_ErrorCode integer)
begin
  declare Out_MandContriSysId integer;
  if not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  elseif not In_MandContriPolicyId = any(select CPFPolicyId from CPFPolicy) then
    set Out_ErrorCode=-2; // MandContriPolicyId not exist
    return
  elseif ((not In_MandContriCareerId = any(select CareerId from Career)) and (FGetDBCountry(*) <> 'Indonesia')) then
    set Out_ErrorCode=-4; // MandContriCareerId not exist
    return
  elseif ((not In_MandContriSchemeId = any(select KeywordId from Keyword where KeywordCategory = 'CPFScheme')) and (FGetDBCountry(*) <> 'Indonesia')) then
    if FGetDBCountry(*) = 'Thailand' then
      if not In_MandContriSchemeId = any(select PFSchemeId from ProvidentFundScheme) then
        set Out_ErrorCode=-3; // MandContriSchemeId not exist
        return
      end if
    else
      set Out_ErrorCode=-3; // MandContriSchemeId not exist
      return
    end if
  end if;
  insert into MandatoryContributeProg(EmployeeSysId,MandContriCareerId,MandContriEffDate,MandContriPolicyId,MandContriSchemeId,MandContriRemarks,MandContriCurrent,ManContriActSchemeId) values(
    In_EmployeeSysId,In_MandContriCareerId,In_MandContriEffDate,In_MandContriPolicyId,In_MandContriSchemeId,In_MandContriRemarks,In_MandContriCurrent,In_ManContriActSchemeId);
  commit work;
  if
    not exists(select MandContriSysId into Out_MandContriSysId from MandatoryContributeProg where
      EmployeeSysId = In_EmployeeSysId and
      MandContriCareerId = In_MandContriCareerId and
      MandContriEffDate = In_MandContriEffDate and
      MandContriPolicyId = In_MandContriPolicyId and
      MandContriSchemeId = In_MandContriSchemeId and
      MandContriRemarks = In_MandContriRemarks and
      MandContriCurrent = In_MandContriCurrent and
      ManContriActSchemeId = In_ManContriActSchemeId) then
    set Out_ErrorCode=0; // System error
    return
  else
    select MandContriSysId into Out_MandContriSysId from MandatoryContributeProg where
      EmployeeSysId = In_EmployeeSysId and
      MandContriCareerId = In_MandContriCareerId and
      MandContriEffDate = In_MandContriEffDate and
      MandContriPolicyId = In_MandContriPolicyId and
      MandContriSchemeId = In_MandContriSchemeId and
      MandContriRemarks = In_MandContriRemarks and
      MandContriCurrent = In_MandContriCurrent and 
      ManContriActSchemeId = In_ManContriActSchemeId;
    // mark current if this is the first record for that particular scheme
	if FGetDBCountry(*) = 'Indonesia' then
       if(select count(*) from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and ManContriActSchemeId = In_ManContriActSchemeId) = 1 then
         update MandatoryContributeProg set
           MandContriCurrent = 1 where
           MandContriSysId = Out_MandContriSysId
       end if;
	else
	   if(select count(*) from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and MandContriSchemeId = In_MandContriSchemeId) = 1 then
         update MandatoryContributeProg set
           MandContriCurrent = 1 where
           MandContriSysId = Out_MandContriSysId
       end if; 
	end if;
    set Out_ErrorCode=Out_MandContriSysId // Successful
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateMandatoryContributeProg') then
   drop procedure UpdateMandatoryContributeProg;
end if;
create procedure dba.UpdateMandatoryContributeProg(
in In_MandContriSysId integer,
in In_EmployeeSysId integer,
in In_MandContriCareerId char(20),
in In_MandContriEffDate date,
in In_MandContriPolicyId char(20),
in In_MandContriSchemeId char(20),
in In_MandContriRemarks char(100),
in In_MandContriCurrent smallint,
in In_ManContriActSchemeId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MandatoryContributeProg where MandContriSysId = In_MandContriSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  elseif not In_MandContriPolicyId = any(select CPFPolicyId from CPFPolicy) then
    set Out_ErrorCode=-3; // MandContriPolicyId not exist
    return
  elseif ((not In_MandContriCareerId = any(select CareerId from Career)) and (FGetDBCountry(*) <> 'Indonesia')) then
    set Out_ErrorCode=-5; // MandContriCareerId not exist
    return
  elseif ((not In_MandContriSchemeId = any(select KeywordId from Keyword where KeywordCategory = 'CPFScheme')) and (FGetDBCountry(*) <> 'Indonesia')) then
    if FGetDBCountry(*) = 'Thailand' then
      if not In_MandContriSchemeId = any(select PFSchemeId from ProvidentFundScheme) then
        set Out_ErrorCode=-4; // MandContriSchemeId not exist
        return
      end if
    else
      set Out_ErrorCode=-4; // MandContriSchemeId not exist
      return
    end if
  end if;
  // if this is current, set other record for this scheme to not current
  if FGetDBCountry(*) = 'Indonesia' then
    if In_MandContriCurrent = 1 then
      update MandatoryContributeProg set
        MandContriCurrent = 0 where
        EmployeeSysId = In_EmployeeSysId and
        ManContriActSchemeId = In_ManContriActSchemeId
    end if;
  else
   if In_MandContriCurrent = 1 then
      update MandatoryContributeProg set
        MandContriCurrent = 0 where
        EmployeeSysId = In_EmployeeSysId and
        MandContriSchemeId = In_MandContriSchemeId
    end if; 
  end if;
  
  update MandatoryContributeProg set
    EmployeeSysId = In_EmployeeSysId,
    MandContriCareerId = In_MandContriCareerId,
    MandContriEffDate = In_MandContriEffDate,
    MandContriPolicyId = In_MandContriPolicyId,
    MandContriSchemeId = In_MandContriSchemeId,
    MandContriRemarks = In_MandContriRemarks,
    MandContriCurrent = In_MandContriCurrent,
    ManContriActSchemeId = In_ManContriActSchemeId where
    MandContriSysId = In_MandContriSysId;
  commit work;
  set Out_ErrorCode=In_MandContriSysId // Successful
end
;

commit work;