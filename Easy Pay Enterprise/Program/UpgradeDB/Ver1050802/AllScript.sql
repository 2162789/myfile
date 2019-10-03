if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeIdentityTypeCode') then
   drop procedure FGetEmployeeIdentityTypeCode
end if
;

CREATE FUNCTION DBA.FGetEmployeeIdentityTypeCode(
in In_EmployeeSysId integer)
RETURNS char(20)
BEGIN
	DECLARE Out_IdentityTypeCode char(20);
    Select IdentityTypeCode into Out_IdentityTypeCode from Employee
    where EmployeeSysId = In_EmployeeSysId;

	RETURN Out_IdentityTypeCode;
END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyGovAccNo') then
   drop procedure FGetCompanyGovAccNo
end if
;

CREATE FUNCTION DBA.FGetCompanyGovAccNo(
in In_CompanyId char(20),
in In_CompanyGovCode char(20))
RETURNS char(30)
BEGIN
	DECLARE Out_CompanyGovAccNo char(30);
	
    Select CompanyGovAccNo Into Out_CompanyGovAccNo From CompanyGov
    Where CompanyId = In_CompanyId And CompanyGovCode = In_CompanyGovCode;

	RETURN Out_CompanyGovAccNo;
END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBranchGovAccNo') then
   drop procedure FGetBranchGovAccNo
end if
;

CREATE FUNCTION DBA.FGetBranchGovAccNo(
in In_CompanyId char(20),
in In_BranchId char(20),
in In_BranchGovCode char(20))
RETURNS char(30)
BEGIN
	DECLARE Out_BranchGovAccNo char(30);
	
    Select BranchGovAccNo Into Out_BranchGovAccNo From Branch Join BranchGov
    Where Branch.CompanyId = In_CompanyId And Branch.BranchId = In_BranchId And BranchGovCode = In_BranchGovCode;
	
    RETURN Out_BranchGovAccNo;
END;

commit work;

if not exists (select 1 from ePortalVersion where EPE=8580 and ePortal=7600) then
  insert into ePortalVersion (EPE, ePortal) values (8580, 7600)
end if;

if not exists (select 1 from ePortalVersion where EPE=8600 and ePortal=7600) then
  insert into ePortalVersion (EPE, ePortal) values (8600, 7600)
end if;

if not exists (select 1 from ePortalVersion where EPE=1050700 and ePortal=1030000) then
  insert into ePortalVersion (EPE, ePortal) values (1050700,1030000)
end if;

if not exists (select 1 from ePortalVersion where EPE=1050800 and ePortal=1030000) then
  insert into ePortalVersion (EPE, ePortal) values (1050800,1030000)
end if;

if not exists (select 1 from ePortalVersion where EPE=1060000 and ePortal=1030000) then
  insert into ePortalVersion (EPE, ePortal) values (1060000,1030000)
end if;

commit work;

UPDATE UsageItem SET Query='SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, DATE(SUBSTR(StrKey2,7,4)+SUBSTR(StrKey2,4,2)+SUBSTR(StrKey2,1,2)) AS RetValue FROM LicenseRecord;' WHERE UsageItemID='LicenseExpiryDate';
Commit work;

if not exists (select * from "DBA"."Registry" where RegistryId = 'DBPatchNumber')
then
  insert into Registry
  values ('DBPatchNumber','DB Patch Numbering');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Generic')
then
  insert into SubRegistry
  values ('DBPatchNumber','Generic','001','049','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Singapore')
then
  insert into SubRegistry
  values ('DBPatchNumber','Singapore','100','149','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Brunei')
then
  insert into SubRegistry
  values ('DBPatchNumber','Brunei','150','199','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Indonesia')
then
  insert into SubRegistry
  values ('DBPatchNumber','Indonesia','200','249','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Malaysia')
then
  insert into SubRegistry
  values ('DBPatchNumber','Malaysia','250','299','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Philippines')
then
  insert into SubRegistry
  values ('DBPatchNumber','Philippines','300','349','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Vietnam')
then
  insert into SubRegistry
  values ('DBPatchNumber','Vietnam','350','399','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'HongKong')
then
  insert into SubRegistry
  values ('DBPatchNumber','HongKong','400','449','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Thailand')
then
  insert into SubRegistry
  values ('DBPatchNumber','Thailand','450','499','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'DBPatchNumber' and SubRegistryId = 'Special')
then
  insert into SubRegistry
  values ('DBPatchNumber','Special','900','999','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;

UPDATE UsageItem SET Query = 'SELECT CAST(PayRecYear AS CHAR(4)) AS Key1, CAST(PayRecPeriod AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(EmployeeSysID) AS RetValue FROM PayPeriodRecord GROUP BY PayRecYear, PayRecPeriod HAVING PayRecYear =(SELECT DISTINCT PayGroupYear ', QueryCond = 'FROM PayGroupPeriod where SubPeriodEndDate =(SELECT MAX(SubPeriodEndDate) FROM PayGroupPeriod)) AND PayRecPeriod =(SELECT DISTINCT PayGroupPeriod FROM PayGroupPeriod where SubPeriodEndDate =(SELECT MAX(SubPeriodEndDate) FROM PayGroupPeriod));' WHERE UsageItemId = 'PayRecordCount';
Commit Work;