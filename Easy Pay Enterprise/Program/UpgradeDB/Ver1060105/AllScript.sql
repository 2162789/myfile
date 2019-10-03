READ UpgradeDB\Ver1060105\UsageItem.sql;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMedClaimRangeBasis') then
   drop procedure ASQLMedClaimRangeBasis
end if;

create procedure DBA.ASQLMedClaimRangeBasis(
in In_PersonalSysId integer,
in In_MedClaimPolicyId char(20),
in In_ProcessDate date,
out Out_String char(20),
out Out_Value double)
begin
  declare Out_MedClaimPolicyBasis char(20);
  declare Out_DateOfBirth date;
  declare Out_HireDate date;
  declare Out_PreviousSvcYear double;
  declare Out_EmployeeSysId integer;
  set Out_String=0;
  set Out_Value=0;
  select MedClaimPolicyBasis into Out_MedClaimPolicyBasis from MClaimPolicy where
    MedClaimPolicyId = In_MedClaimPolicyId;
  select first EmployeeSysId into Out_EmployeeSysId from Employee where
    PersonalSysId = In_PersonalSysId order by HireDate desc;
  if Out_EmployeeSysId is null then set Out_EmployeeSysId=0
  end if;
  case Out_MedClaimPolicyBasis 
   when 'ServiceYear' then
    /*
    Get the latest Employment Record's Service Year
    */
    select HireDate,PreviousSvcYear into Out_HireDate,Out_PreviousSvcYear from Employee where
      PersonalSysId = In_PersonalSysId and
      EmployeeSysId = Out_EmployeeSysId;
    select Round(cast(Months(Out_HireDate,In_ProcessDate) as double)/12,2)+Out_PreviousSvcYear into Out_Value 
   when 'Age' then
    /*
    Get the latest Personal Record's Age
    */
    select DateOfBirth into Out_DateOfBirth from Personal where
      PersonalSysId = In_PersonalSysId;
    select Round(cast(Months(Out_DateOfBirth,In_ProcessDate) as double)/12,2) into Out_Value 
   when 'Department' then
    /*
    Get the latest Employment Record's Department
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerDepartment' order by CareerEffectiveDate desc 
   when 'Branch' then
    /*
    Get the latest Employment Record's Branch
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerBranch' order by CareerEffectiveDate desc 
   when 'Category' then
    /*
    Get the latest Employment Record's Category
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerCategory' order by CareerEffectiveDate desc 
   when 'Section' then
    /*
    Get the latest Employment Record's Section
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerSection' order by CareerEffectiveDate desc 
   when 'ClassificationCode' then
    /*
    Get the latest Employment Record's Classification
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'ClassificationCode' order by CareerEffectiveDate desc     
   when 'LeaveGroup' then
    /*
    Get the latest Employment Record's Leave Group
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerLeaveGroup' order by CareerEffectiveDate desc     
     
   when 'Position' then
    /*
    Get the latest Employment Record's Position
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerPosition' order by CareerEffectiveDate desc     
   when 'SalaryGradeId' then
    /*
    Get the latest Employment Record's Salary Grade Id
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'SalaryGradeId' order by CareerEffectiveDate desc             
           
   when 'Gender' then
    /*
    Get the latest Personal Record's Gender
    */
    select GenderCodeName into Out_String from Personal join GenderCode on(Gender = GenderCodeId) where
      PersonalSysId = In_PersonalSysId 
   when 'Race' then
    /*
    Get the latest Personal Record's Race
    */
    select RaceId into Out_String from Personal where
      PersonalSysId = In_PersonalSysId      
   when 'Religion' then
    /*
    Get the latest Personal Record's Religion
    */
    select ReligionId into Out_String from Personal where
      PersonalSysId = In_PersonalSysId      
   when 'MaritalStatus' then
    /*
    Get the latest Employment Record's Marital Status
    */
    select MaritalStatusCode into Out_String from Personal where
      PersonalSysId = In_PersonalSysId
  end case
end
;

Commit Work;