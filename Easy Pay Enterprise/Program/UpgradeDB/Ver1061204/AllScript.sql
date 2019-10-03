Read UpgradeDB\Ver1061204\Entity.sql;

/* Hide Wage Security Control for Export Designer */
update ModuleScreenGroup set HideScreenForWage = 1 where ModuleScreenId = 'ColourScheme';
update ModuleScreenGroup set HideScreenForWage = 1 where ModuleScreenId = 'FinRptLayout';
update ModuleScreenGroup set HideScreenForWage = 1 where ModuleScreenId = 'EmpRptLayout';
update ModuleScreenGroup set HideScreenForWage = 1 where ModuleScreenId = 'ExcelSpreadsheet';
update ModuleScreenGroup set HideScreenForWage = 1 where ModuleScreenId = 'ExportWizard';
update ModuleScreenGroup set HideScreenForWage = 0 where ModuleScreenId = 'ProcExcelExpDetails';
insert into UserModuleNoAccess (UserGroupId, ModuleScreenId)
select UserGroup.UserGroupId, 'ColourScheme' as ModuleScreenId from UserGroup left join UserModuleNoAccess on UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'ColourScheme'
where UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null
union
select UserGroup.UserGroupId, 'FinRptLayout' as ModuleScreenId from UserGroup left join UserModuleNoAccess on UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'FinRptLayout'
where UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null
union
select UserGroup.UserGroupId, 'EmpRptLayout' as ModuleScreenId from UserGroup left join UserModuleNoAccess on UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'EmpRptLayout'
where UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null
union
select UserGroup.UserGroupId, 'ExcelSpreadsheet' as ModuleScreenId from UserGroup left join UserModuleNoAccess on UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'ExcelSpreadsheet'
where UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null
union
select UserGroup.UserGroupId, 'ExportWizard' as ModuleScreenId from UserGroup left join UserModuleNoAccess on UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'ExportWizard'
where UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null;

/* Add Default Hour Rate (Casual Pay) field for Pay Employee Interface */
if not exists (select 1 from sys.syscolumns where tname = 'iPayEmployee' and cname = 'DefaultHourRate') then
  alter table iPayEmployee add DefaultHourRate double;
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iPayEmployee' and FieldNamePhysical = 'DefaultHourRate') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values ('iPayEmployee','DefaultHourRate','Default Hour Rate (Casual Pay)','Numeric',0);
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceAttribute' and SubRegistryId = 'DefaultHourRate') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceAttribute','DefaultHourRate','PayEmployee','','','','','','DefaultHourRate','Default Hour Rate (Casual Pay)','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;
insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
select InterfaceProject.InterfaceProjectID,'DefaultHourRate','PayEmployee',0,'DefaultHourRate' from InterfaceProject left join InterfaceAttribute
on InterfaceProject.InterfaceProjectID = InterfaceAttribute.InterfaceProjectID and InterfaceAttribute.InterfaceAttributeID = 'DefaultHourRate' and InterfaceAttrTableID = 'PayEmployee'
where InterfaceAttribute.InterfaceProjectID is null;


/*--- Create tigger to synchronous Personal.Alias and Personal.PersonalTypeId to EasyTime ---*/
if exists(select * from sys.systrigger where trigger_name = 'SyncPersonalUpdate') then
   drop trigger SyncPersonalUpdate;
end if;
   
CREATE TRIGGER "SyncPersonalUpdate" AFTER UPDATE OF "Alias", "PersonalTypeId"
   ORDER 22 ON "DBA"."Personal"
    REFERENCING OLD AS old_Personal NEW AS new_Personal
   FOR EACH ROW
   BEGIN
       EmployeeLoop: for EmployeeFor as EmployeeCurs dynamic scroll cursor for
         select EmployeeSysId as Out_EmployeeSysId from Employee join Personal where Personal.PersonalSysId = new_Personal.PersonalSysID do
         Call ASQLSyncApp(Out_EmployeeSysId,'Update','Employee','');
       end for;
   END;

/*--- Create tigger to synchronous PayEmployee.CasualPayment to EasyTime ---*/
if exists(select * from sys.systrigger where trigger_name = 'SyncPayEmployeeUpdate') then
   drop trigger SyncPayEmployeeUpdate;
end if;

Create TRIGGER "SyncPayEmployeeUpdate" AFTER UPDATE OF "CasualPayment"
   ORDER 23 ON "DBA"."PayEmployee"
    REFERENCING OLD AS old_PayEmployee NEW AS new_PayEmployee
   FOR EACH ROW
   BEGIN
       Call ASQLSyncApp(new_PayEmployee.EmployeeSysID,'Update','Employee','');
   END;

/*--- Update TMS Employee View with Alias, PersonalTypeId and CasualPayment ---*/
if exists(select * from sys.systrigger where trigger_name = 'SyncPersonalUpdate') then
  ALTER VIEW "DBA"."View_TMS_SmartTouch_Employee"
     as SELECT 
      Employee.EmployeeSysId,
      Employee.EmployeeId,
      EmployeeName,
      Alias, 
      PersonalTypeId, /* Personnel Type [Staff/Regular & Casual/Casual Only/Staff - Time Sheet] */
      CasualPayment, /* For Casual staff only [0/1]: 0=By Bank Allocation, 1=By Cash Only */
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
      Employee.IdentityNo,
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
       DBA.Employee JOIN EmpeeWkCalen JOIN Calendar JOIN Personal JOIN PayEmployee
    WHERE
       Employee.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query);
else
  CREATE VIEW "DBA"."View_TMS_SmartTouch_Employee"
     as SELECT 
      Employee.EmployeeSysId,
      Employee.EmployeeId,
      EmployeeName,
      Alias, 
      PersonalTypeId, /* Personnel Type [Staff/Regular & Casual/Casual Only/Staff - Time Sheet] */
      CasualPayment, /* For Casual staff only [0/1]: 0=By Bank Allocation, 1=By Cash Only */
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
      Employee.IdentityNo,
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
       DBA.Employee JOIN EmpeeWkCalen JOIN Calendar JOIN Personal JOIN PayEmployee
    WHERE
       Employee.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query);
end if;


commit work;