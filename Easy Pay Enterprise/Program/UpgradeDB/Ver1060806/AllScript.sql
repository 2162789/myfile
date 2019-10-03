READ UpgradeDB\Ver1060806\entity.sql;

//-----------------------------------
// Create/Update View_TMS_AllowanceID
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_AllowanceID')
then
   DROP VIEW "DBA"."View_TMS_AllowanceID" ;
CREATE VIEW "DBA"."View_TMS_AllowanceID"
   AS
   SELECT FormulaId as PayElementId, FormulaDesc as PayElementDesc FROM Formula WHERE FormulaSubCategory='Allowance';
else
   CREATE VIEW "DBA"."View_TMS_AllowanceID"
   AS
   SELECT FormulaId as PayElementId, FormulaDesc as PayElementDesc FROM Formula WHERE FormulaSubCategory='Allowance';
end if;
//-----------------------------------
// Create/Update View_TMS_Holidays
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_Holidays')
then
   DROP VIEW "DBA"."View_TMS_Holidays" ;
   CREATE VIEW "DBA"."View_TMS_Holidays"
   AS
   SELECT CountryId, HolidayId, HolidayDesc, HolidayStartDate, HolidayEndDate FROM Holidays;
else
   CREATE VIEW "DBA"."View_TMS_Holidays"
   AS
   SELECT CountryId, HolidayId, HolidayDesc, HolidayStartDate, HolidayEndDate FROM Holidays;
end if;

//-----------------------------------
// Create/Update View_TMS_JobCode
//-----------------------------------

if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_JobCode')
then
   DROP VIEW "DBA"."View_TMS_JobCode" ;
CREATE VIEW "DBA"."View_TMS_JobCode"
   AS
   SELECT JobCode, JobCodeDesc FROM JobCode;

else
   CREATE VIEW "DBA"."View_TMS_JobCode"
   AS
   SELECT JobCode, JobCodeDesc FROM JobCode;
end if;


//-----------------------------------
// Create/Update View_TMS_LeaveType
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_LeaveType')
then
   DROP VIEW "DBA"."View_TMS_LeaveType" ;
   CREATE VIEW "DBA"."View_TMS_LeaveType"
   AS
   SELECT LeaveType.LeaveTypeID, LeaveTypeDesc, LeaveFunctionId, LeaveCredit from LeaveType JOIN LeaveComputation;
else
   CREATE VIEW "DBA"."View_TMS_LeaveType"
   AS
   SELECT LeaveType.LeaveTypeID, LeaveTypeDesc, LeaveFunctionId,LeaveCredit from LeaveType JOIN LeaveComputation;
end if;

//-----------------------------------
// Create/Update View_TMS_OTRate
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_OTRate')
then
   DROP VIEW "DBA"."View_TMS_OTRate" ;
   CREATE VIEW "DBA"."View_TMS_OTRate"
   AS
   SELECT  Formula.FormulaId as OTRateId, FormulaDesc as OTRateDesc, FormulaSubCategory as OTRateType, Constant1 AS FactorAmount FROM Formula JOIN FormulaRange WHERE FormulaCategory='OT';
else
   CREATE VIEW "DBA"."View_TMS_OTRate"
   AS
   SELECT  Formula.FormulaId as OTRateId, FormulaDesc as OTRateDesc, FormulaSubCategory as OTRateType, Constant1 AS FactorAmount FROM Formula JOIN FormulaRange WHERE FormulaCategory='OT';
end if;

//-----------------------------------
// Create/Update View_TMS_PayRecID
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_PayRecID')
then
   DROP VIEW "DBA"."View_TMS_PayRecID" ;
   CREATE VIEW "DBA"."View_TMS_PayRecID"
   AS
   SELECT DISTINCT PayRecId FROM "DBA"."PAYRECORD";
else
   CREATE VIEW "DBA"."View_TMS_PayRecID"
   AS
   SELECT DISTINCT PayRecId FROM "DBA"."PAYRECORD";
end if;

//-----------------------------------
// Create/Update View_TMS_Query
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_Query')
then
   DROP VIEW "DBA"."View_TMS_Query" ;
   CREATE VIEW "DBA"."View_TMS_Query"
   AS
   SELECT Employee.EmployeeId,Employee.EmployeeName,Employee.EmployeeSysId,Personal.PersonalSysId,Personal.IdentityNo  FROM DBA.Personal left outer join(DBA.Employee join DBA.PayEmployee join DBA.PayEmployeePolicy)  WHERE 1=1;
else
   CREATE VIEW "DBA"."View_TMS_Query"
   AS
   SELECT Employee.EmployeeId,Employee.EmployeeName,Employee.EmployeeSysId,Personal.PersonalSysId,Personal.IdentityNo  FROM DBA.Personal left outer join(DBA.Employee join DBA.PayEmployee join DBA.PayEmployeePolicy)  WHERE 1=1;
end if;

//-----------------------------------
// Create/Update View_TMS_SmartTouch_BasicRateProgression
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_SmartTouch_BasicRateProgression')
then
 DROP VIEW "DBA"."View_TMS_SmartTouch_BasicRateProgression" ;
   CREATE VIEW "DBA"."View_TMS_SmartTouch_BasicRateProgression"
     as select EmployeeId,
       BRProgDate,
       BRProgEffectiveDate,
       BRProgPrevBasicRate,
       BRProgNewBasicRate,
       BRProgBasicRateType AS SalaryTypeId from
       DBA.BasicRateProgression natural join DBA.Employee
    WHERE
       EmployeeId in (Select EmployeeID from DBA.View_TMS_Query);
else
   CREATE VIEW "DBA"."View_TMS_SmartTouch_BasicRateProgression"
     as select EmployeeId,
       BRProgDate,
       BRProgEffectiveDate,
       BRProgPrevBasicRate,
       BRProgNewBasicRate,
       BRProgBasicRateType AS SalaryTypeId from
       DBA.BasicRateProgression natural join DBA.Employee
    WHERE
       EmployeeId in (Select EmployeeID from DBA.View_TMS_Query);
end if;

//-----------------------------------
// Create/Update View_TMS_SmartTouch_Employee
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_SmartTouch_Employee')
then
   DROP VIEW "DBA"."View_TMS_SmartTouch_Employee" ;
   CREATE VIEW "DBA"."View_TMS_SmartTouch_Employee"
     as SELECT EmployeeId,
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
       EmployeeId in (Select EmployeeID from DBA.View_TMS_Query);
else
   CREATE VIEW "DBA"."View_TMS_SmartTouch_Employee"
     as SELECT EmployeeId,
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
       EmployeeId in (Select EmployeeID from DBA.View_TMS_Query);
end if;

//-----------------------------------
// Create/Update View_TMS_SmartTouch_LeaveRecord
//-----------------------------------
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_SmartTouch_LeaveRecord')
then
   DROP VIEW "DBA"."View_TMS_SmartTouch_LeaveRecord" ;
   CREATE VIEW "DBA"."View_TMS_SmartTouch_LeaveRecord"
     as select EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
       LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours, LeaveReasonId from(
       DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
       LveRecApproved = 1
       AND EmployeeId in (Select EmployeeID from DBA.View_TMS_Query);
else
   CREATE VIEW "DBA"."View_TMS_SmartTouch_LeaveRecord"
     as select EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
       LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours, LeaveReasonId from(
       DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
       LveRecApproved = 1
       AND EmployeeId in (Select EmployeeID from DBA.View_TMS_Query);
end if;




commit work;



if not exists(select * from eportalversion where EPE = '1060900') then
  insert into eportalversion(EPE,ePortal)
  values('1060900','1030000');
end if; 


commit work;