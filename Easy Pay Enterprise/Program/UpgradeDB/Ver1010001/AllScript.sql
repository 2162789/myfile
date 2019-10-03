if not exists (select * from "DBA"."Registry" where RegistryId  = 'MalBIKProperty')
then
insert into Registry (RegistryId, RegistryDesc) 
values ('MalBIKProperty', 'Malaysia BIK Property');
end if;

commit work;

if (IsEPClassicDB()=1) then
    if exists (select * from "DBA"."SubRegistry" WHERE RegistryId = 'CareerAttribute' AND SubRegistryId = 'CareerWTCalendar') then
        DELETE FROM SubRegistry WHERE RegistryId = 'CareerAttribute' AND SubRegistryId = 'CareerWTCalendar';
    end if;
    if exists (select * from "DBA"."SubRegistry" WHERE CareerAttributeID = 'CareerWTCalendar') then
        DELETE FROM CareerAttribute WHERE CareerAttributeID = 'CareerWTCalendar';
    end if;
end if;
COMMIT WORK;


if exists (select * from "DBA"."ModuleScreenGroup" WHERE ModuleScreenId IN ('EC_ProcessLvCosting','EC_ProcessLvGlobalCost'))
then
    DELETE FROM ModuleScreenGroup WHERE ModuleScreenId IN ('EC_ProcessLvCosting','EC_ProcessLvGlobalCost');
end if;

UPDATE ModuleScreenGroup 
SET EC_ModuleScreenId = '' 
WHERE ModuleScreenId IN ('ProcessLvCosting','ProcessLvGlobalCost');


// SystemUser - User Password
if not exists(select * from  SystemAttribute WHERE SysTableId = 'SystemUser' AND SysAttributeId = 'UserPassword') THEN
    INSERT INTO SystemAttribute VALUES ('SystemUser','UserPassword','User Password','0','','','','','');
    Commit Work;
end if;

// UserGroup
if not exists(select * from  SystemTable WHERE SysTableId = 'UserGroup') THEN
    INSERT INTO SystemTable VALUES ('UserGroup','User Group','0','Control','SecuritySetup');
    Commit Work;
    INSERT INTO SystemAttribute VALUES ('UserGroup','UserGroupId','User Group ID','0','','','','','');
    INSERT INTO SystemAttribute VALUES ('UserGroup','UserGroupDesc','User Group Description','0','','','','','');
    INSERT INTO SystemAttribute VALUES ('UserGroup','UserGroupHideWage','User Group Hide Wage','0','','','','','');
    Commit Work;
end if;

// UserGroup
if not exists(select * from  SystemTable WHERE SysTableId = 'UserModuleNoAccess') THEN
// UserModuleNoAccess
    INSERT INTO SystemTable VALUES ('UserModuleNoAccess','User Module No Access','0','Control','SecuritySetup');
    Commit Work;
    INSERT INTO SystemAttribute VALUES ('UserModuleNoAccess','UserModNoAccessId','User Module No Access ID','0','','','','','');
    INSERT INTO SystemAttribute VALUES ('UserModuleNoAccess','UserGroupId','User Group ID','0','','','','','');
    INSERT INTO SystemAttribute VALUES ('UserModuleNoAccess','ModuleScreenId','Module Screen ID','0','','','','','');
    Commit Work;
end if;

// To auto turn on Interface Process (EPETransfer - HRProcess)
UPDATE InterfaceProcess SET IntProcActivate=1 WHERE InterfaceProjectId='EPETransfer' AND InterfaceProcessId='HR Process';

if not exists(select * from  ExcelEmpRpt WHERE ExcelEmpRptId = 'CPFProgRpt') THEN
	insert into ExcelEmpRpt values ('CPFProgRpt', 'CPF Progression', '(CPFProgression LEFT OUTER JOIN CPFPolicy ON (CPFProgression.CPFProgPolicyId = CPFPolicy.CPFPolicyId) LEFT OUTER JOIN Career ON (CPFProgression.CPFCareerId = Career.CareerId))', 'JOIN (Employee JOIN Personal) ON (CPFProgression.EmployeeSysId = Employee.EmployeeSysId)', '', 1);
end if;

if not exists(select * from  ExcelEmpRpt WHERE ExcelEmpRptId = 'EPProgRpt') THEN
	insert into ExcelEmpRpt values ('EPProgRpt', 'Employee Pass Progression', '(EmployPassProgression LEFT OUTER JOIN Career ON (EmployPassProgression.EPCareerId = Career.CareerId)) JOIN (Employee JOIN Personal) ON (EmployPassProgression.EmployeeSysId = Employee.EmployeeSysId)', '', '', 1);
end if;

if not exists(select * from  ExcelEmpRpt WHERE ExcelEmpRptId = 'FWLProgRpt') THEN
	insert into ExcelEmpRpt values ('FWLProgRpt', 'FWL Progression', '(FWLProgression LEFT OUTER JOIN Career ON (FWLProgression.FWLCareerId = Career.CareerId)) JOIN (Employee JOIN Personal) ON (FWLProgression.EmployeeSysId = Employee.EmployeeSysId)', '', '', 1);
end if;

if not exists(select * from  ExcelEmpRptTables WHERE ExcelEmpRptId = 'CPFProgRpt') THEN
	insert into ExcelEmpRptTables values ('CPFProgRpt','Employee', 'Employee', 'Core', 1);
	insert into ExcelEmpRptTables values ('CPFProgRpt','Personal', 'Personal', 'Core', 1);
	insert into ExcelEmpRptTables values ('CPFProgRpt','CPFProgression', 'CPF Progression', 'Pay', 0);
	insert into ExcelEmpRptTables values ('CPFProgRpt','CPFPolicy', 'CPF Policy', 'Pay', 0);
	insert into ExcelEmpRptTables values ('CPFProgRpt','Career', 'Career', 'Pay', 0);
end if;

if not exists(select * from  ExcelEmpRptTables WHERE ExcelEmpRptId = 'EPProgRpt') THEN
	insert into ExcelEmpRptTables values ('EPProgRpt','Employee', 'Employee', 'Core', 1);
	insert into ExcelEmpRptTables values ('EPProgRpt','Personal', 'Personal', 'Core', 1);
	insert into ExcelEmpRptTables values ('EPProgRpt','EmployPassProgression', 'Employee Pass Progression', 'Pay', 0);
	insert into ExcelEmpRptTables values ('EPProgRpt','Career', 'Career', 'Pay', 0);
end if;

if not exists(select * from  ExcelEmpRptTables WHERE ExcelEmpRptId = 'FWLProgRpt') THEN
	insert into ExcelEmpRptTables values ('FWLProgRpt','Employee', 'Employee', 'Core', 1);
	insert into ExcelEmpRptTables values ('FWLProgRpt','Personal', 'Personal', 'Core', 1);
	insert into ExcelEmpRptTables values ('FWLProgRpt','FWLProgression', 'FWL Progression', 'Pay', 0);
	insert into ExcelEmpRptTables values ('FWLProgRpt','Career', 'Career', 'Pay', 0);
end if;

commit work;

