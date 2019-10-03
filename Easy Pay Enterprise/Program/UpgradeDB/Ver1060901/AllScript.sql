READ UpgradeDB\Ver1060901\Entity.sql;

if exists(select * from sys.systable where table_name = 'View_TMS_SmartTouch_BasicRateProgression') then
   drop view View_TMS_SmartTouch_BasicRateProgression;
end if;

CREATE VIEW "DBA"."View_TMS_SmartTouch_BasicRateProgression"
      as SELECT 
       Employee.EmployeeSysId,
       EmployeeId,
       BRProgDate,
       BRProgEffectiveDate,
       BRProgPrevBasicRate,
       BRProgNewBasicRate,
       (SELECT CurrentBasicRateType from PayEmployee where EmployeeSysID=Employee.EmployeeSysId) AS SalaryTypeId
    FROM
       DBA.BasicRateProgression natural join DBA.Employee
    WHERE
       Employee.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query);


if exists(select * from sys.systable where table_name = 'View_TMS_SmartTouch_Employee') then
   drop view View_TMS_SmartTouch_Employee;
end if;

CREATE VIEW "DBA"."View_TMS_SmartTouch_Employee"
     as SELECT 
      Employee.EmployeeSysId,
      EmployeeId,
      EmployeeName,
      CompanyId,
      (select Company.CompanyName from DBA.Company where Company.CompanyId = Employee.CompanyId) as CompDesc,
      DepartmentId,
      (select Department.DepartmentDesc from DBA.Department where Department.DepartmentId = Employee.DepartmentId) as DepartmentDesc,
      PositionId,
      (select PositionCode.PositionDesc from DBA.PositionCode where PositionCode.PositionId = Employee.PositionId) as PositionDesc,
      SectionId,
      (select Section.SectionDesc from DBA.Section where Section.SectionId = Employee.SectionId) as SectionDesc,
      CategoryId,
      (select Category.CategoryDesc from DBA.Category where Category.CategoryId = Employee.CategoryId) as CateDesc,
      HireDate,
      IdentityNo,
      CessationDate,

      (SELECT CareerEffectiveDate FROM DBA.CareerProgression where CareerCurrent=1 and CareerProgression.EmployeeSysId = Employee.EmployeeSysId) as CurCareerEffectiveDate,
      Employee.BranchId AS BranchId,
      (select Branch.BranchName from DBA.Branch where Branch.CompanyId = Employee.CompanyId and Branch.BranchId = Employee.BranchId) as BranchDesc,
      Employee.ClassificationCode AS ClassificationCode,
      (select Classification.ClassificationDesc from DBA.Classification where Classification.ClassificationCode = Employee.ClassificationCode) as ClassificationDesc,
      Employee.SalaryGradeId AS SalaryGradeId,
      (select SalaryGrade.SalaryGradeDesc from DBA.SalaryGrade where SalaryGrade.SalaryGradeId = Employee.SalaryGradeId) as SalaryGradeDesc,
      Employee.Supervisor AS SupervisorEmpId,

      Employee.CustBoolean1 AS CustBoolean1,
      Employee.CustBoolean2 AS CustBoolean2,
      Employee.CustBoolean3 AS CustBoolean3,

      Employee.CustDate1 AS CustDate1,
      Employee.CustDate2 AS CustDate2,
      Employee.CustDate3 AS CustDate3,

      Employee.CustInteger1 AS CustInteger1,
      Employee.CustInteger2 AS CustInteger2,
      Employee.CustInteger3 AS CustInteger3,

      Employee.CustNumeric1 AS CustNumeric1,
      Employee.CustNumeric2 AS CustNumeric2,
      Employee.CustNumeric3 AS CustNumeric3,

      Employee.CustString1 AS CustString1,
      Employee.CustString2 AS CustString2,
      Employee.CustString3 AS CustString3,
      Employee.CustString4 AS CustString4,
      Employee.CustString5 AS CustString5,

      Employee.EmpCode1Id AS CustCode1Id,
      (select EmpCode1.CustCodeDesc from DBA.EmpCode1 where EmpCode1.EmpCode1Id = Employee.EmpCode1Id) as CustCode1Desc,
      Employee.EmpCode2Id AS CustCode2Id,
      (select EmpCode2.CustCodeDesc from DBA.EmpCode2 where EmpCode2.EmpCode2Id = Employee.EmpCode2Id) as CustCode2Desc,
      Employee.EmpCode3Id AS CustCode3Id,
      (select EmpCode3.CustCodeDesc from DBA.EmpCode3 where EmpCode3.EmpCode3Id = Employee.EmpCode3Id) as CustCode3Desc,
      Employee.EmpCode4Id AS CustCode4Id,
      (select EmpCode4.CustCodeDesc from DBA.EmpCode4 where EmpCode4.EmpCode4Id = Employee.EmpCode4Id) as CustCode4Desc,
      Employee.EmpCode5Id AS CustCode5Id,
      (select EmpCode5.CustCodeDesc from DBA.EmpCode5 where EmpCode5.EmpCode5Id = Employee.EmpCode5Id) as CustCode5Desc,

       Calendar.CalendarID AS WorkCalendarID,
       Calendar.CalendarDesc AS WorkCalendarDesc,
       Calendar.CountryCode AS WorkCalendarCountryID
    FROM
       DBA.Employee JOIN EmpeeWkCalen JOIN Calendar
    WHERE
       Employee.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query);

if exists(select * from sys.systable where table_name = 'View_TMS_SmartTouch_LeaveRecord') then
   drop view View_TMS_SmartTouch_LeaveRecord;
end if;

CREATE VIEW "DBA"."View_TMS_SmartTouch_LeaveRecord"
     as SELECT C.EmployeeSysId, EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
       LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours, LeaveReasonId from(
       DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
       LveRecApproved = 1
       AND C.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query);


if not exists(select * from ContactLocation where ContactLocationId = 'Overseas') then
   insert into ContactLocation(ContactLocationId,ContactLocationDesc)
   values('Overseas','Overseas')
end if;

if exists(select * from LicenseRecord where CHARINDEX('TMS Vendor',functionlist) = 0) then 
  /*For Circle Enterprise*/
  if exists(select * from sys.systable where table_name = 'View_CE_Employee') then
     drop view View_CE_Employee;
  end if;

  if exists(select * from sys.systable where table_name = 'View_CE_Department') then
     drop view View_CE_Department;
  end if;

  if exists(select * from sys.systable where table_name = 'View_CE_Section') then
     drop view View_CE_Section;
  end if;

  /* Intercorp */
  update IntercorpTMSExport set InterStaffNoMapping = '';

end if;

commit work;