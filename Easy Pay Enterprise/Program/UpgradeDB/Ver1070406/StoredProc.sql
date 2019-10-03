If exists(select 1 from sys.sysprocedure where proc_name = 'FGetCareerNewValueDesc') then
  drop function FGetCareerNewValueDesc
end if;

CREATE FUNCTION "DBA"."FGetCareerNewValueDesc"(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerAttributeID char(20))
returns char(150)
begin
  declare Out_NewValueDescription char(150);
  declare NewValue char(150);
  select CareerNewValue into NewValue from CareerAttribute where
    CareerAttribute.EmployeeSysId = In_EmployeeSysId and
    CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
    CareerAttribute.CareerAttributeID = In_CareerAttributeID;
  if(In_CareerAttributeID = 'CareerBranch') then
    select BranchName into Out_NewValueDescription
      from Branch where Branch.BranchId = NewValue
  elseif(In_CareerAttributeID = 'CareerCategory') then
    select CategoryDesc into Out_NewValueDescription
      from Category where Category.CategoryId = NewValue
  elseif(In_CareerAttributeID = 'CareerDepartment') then
    select DepartmentDesc into Out_NewValueDescription
      from Department where Department.DepartmentId = NewValue
  elseif(In_CareerAttributeID = 'CareerPosition') then
    select PositionDesc into Out_NewValueDescription
      from PositionCode where PositionCode.PositionId = NewValue
  elseif(In_CareerAttributeID = 'CareerSection') then
    select SectionDesc into Out_NewValueDescription
      from Section where Section.SectionId = NewValue
  elseif(In_CareerAttributeID = 'CareerSupervisorID') then
    set Out_NewValueDescription=NewValue
  elseif(In_CareerAttributeID = 'CareerWTCalendar') then
    select WTCalendarDesc into Out_NewValueDescription
      from WTCalendar where WTCalendar.WTCalendarId = NewValue
  elseif(In_CareerAttributeID = 'SalaryGradeId') then
    select SalaryGradeDesc into Out_NewValueDescription
      from SalaryGrade where SalaryGradeId = NewValue
  elseif(In_CareerAttributeID = 'ClassificationCode') then
    select ClassificationDesc into Out_NewValueDescription
      from Classification where ClassificationCode = NewValue
  elseif(In_CareerAttributeID = 'CareerLeaveGroup') then
    select LeaveGroupDesc into Out_NewValueDescription
      from LeaveGroup where LeaveGroupId = NewValue
  elseif(In_CareerAttributeID = 'EmpCode1Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode1 where EmpCode1Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode2Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode2 where EmpCode2Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode3Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode3 where EmpCode3Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode4Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode4 where EmpCode4Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode5Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode5 where EmpCode5Id = NewValue
  elseif(In_CareerAttributeID = 'EmpLocation1Id') then
    select CustLocationDesc into Out_NewValueDescription
      from EmpLocation1 where EmpLocation1Id = NewValue
  end if;
  return(Out_NewValueDescription);
end;

commit work;
