if not exists(select 1 from Formula where FormulaId = 'MOSQ2016') then
   Insert into Formula Values('MOSQ2016',1,0,0,'PayElement','Deduction','Tabulated','CPFContriWage','Mosque Mendaki Building Fund 2016','',30,1);
   Insert into FormulaRange Values('MOSQ2016',1,200.01,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',2,1000.01,200.01,'C1;',-1.75,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',3,2000.01,1000.01,'C1;',-3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',4,3000.01,2000.01,'C1;',-5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',5,4000.01,3000.01,'C1;',-11,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',6,6000.01,4000.01,'C1;',-13.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',7,8000.01,6000.01,'C1;',-14.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',8,10000.01,8000.01,'C1;',-16,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',9,99999999,10000.01,'C1;',-17.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select 1 from Formula where FormulaId = 'YMF2016') then
   Insert into Formula Values('YMF2016',1,0,0,'PayElement','Deduction','Tabulated','CPFContriWage','Yayasan Mendaki Fund 2016','',30,1);
   Insert into FormulaRange Values('YMF2016',1,200.01,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',2,1000.01,200.01,'C1;',-1.25,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',3,3000.01,1000.01,'C1;',-1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',4,4000.01,3000.01,'C1;',-4,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',5,6000.01,4000.01,'C1;',-6,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',6,8000.01,6000.01,'C1;',-7.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',7,10000.01,8000.01,'C1;',-8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',8,99999999,10000.01,'C1;',-8.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;

if not exists(select 1 from FormulaProperty where FormulaId = 'MOSQ2016' and KeyWordId = 'MBMFCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('MBMFCode','MOSQ2016');
end if;
if not exists(select 1 from FormulaProperty where FormulaId = 'MOSQ2016' and KeyWordId = 'DonationCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DonationCode','MOSQ2016');
end if;
if not exists(select 1 from FormulaProperty where FormulaId = 'MOSQ2016' and KeyWordId = 'DeductCap') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DeductCap','MOSQ2016');
end if;
if not exists(select 1 from FormulaProperty where FormulaId = 'YMF2016' and KeyWordId = 'YMFCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('YMFCode','YMF2016');
end if;
if not exists(select 1 from FormulaProperty where FormulaId = 'YMF2016' and KeyWordId = 'DonationCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DonationCode','YMF2016');
end if;
if not exists(select 1 from FormulaProperty where FormulaId = 'YMF2016' and KeyWordId = 'DeductCap') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DeductCap','YMF2016');
end if;

update MapDonation_mm Set FormulaId = 'MOSQ2016' from
(select MapDonation_mmSysId as OUT_MapDonation_mmSysId from MapDonation
inner join MapDonation_mm on MapDonation.MapDonationSysId = MapDonation_mm.MapDonationSysId
inner join FormulaProperty on MapDonation_mm.FormulaId = FormulaProperty.FormulaId
where (MapDonation.DonationBasis1 = 'Malay' or MapDonation.DonationBasis2 = 'Malay' or MapDonation.DonationBasis3 = 'Malay') and KeyWordId = 'MBMFCode') A
where MapDonation_mmSysId = A.OUT_MapDonation_mmSysId;

update MapDonation_mm Set FormulaId = 'YMF2016' from
(select MapDonation_mmSysId as OUT_MapDonation_mmSysId from MapDonation
inner join MapDonation_mm on MapDonation.MapDonationSysId = MapDonation_mm.MapDonationSysId
inner join FormulaProperty on MapDonation_mm.FormulaId = FormulaProperty.FormulaId
where (MapDonation.DonationBasis1 = 'Malay' or MapDonation.DonationBasis2 = 'Malay' or MapDonation.DonationBasis3 = 'Malay') and KeyWordId = 'YMFCode') A
where MapDonation_mmSysId = A.OUT_MapDonation_mmSysId;


/*Query Folder Data*/

if not exists(select * from QueryFolder where QueryFolderID='Key Employment Terms') then
   insert into QueryFolder(QueryFolderID,QueryFolderDesc,SourceTmplFolderID) 
   values('Key Employment Terms','Key Employment Terms - Singapore','Key Employment Terms');
end if;


/*Report Export Data*/

delete from reportaccess where ReportExportID='key employment terms';
delete from reportexport where ReportExportID in('key employment terms','0x545046300954707052');

INPUT INTO reportexport(ReportExportID,QueryFolderID,UserGroupId,ReportExportType,ReportDesc,LastModified,AppearIn,ReportExportDesign)
FROM 'UpgradeDB\\Ver1061205\\ReportExport.dat'
FORMAT ASCII;


/*Report Access data */

if not exists(select * from ReportAccess where ReportExportID='Key Employment Terms') then
   insert into ReportAccess(ReportExportID,UserGroupId) values('Key Employment Terms','MAG');
end if;

/*Custom Query data */

if not exists(select * from CustomQuery where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery') then
   insert into CustomQuery(QueryFolderID,CustomQueryID,QueryDesc,DistinctOption,GroupByOption,TableString,MasterQueryID) 
   values('Key Employment Terms','EmployeeQuery','Personal Employment Details',1,0,'Employee','');
end if;

if not exists(select * from CustomQuery where QueryFolderID='Key Employment Terms' and CustomQueryID='Company') then
   insert into CustomQuery(QueryFolderID,CustomQueryID,QueryDesc,DistinctOption,GroupByOption,TableString,MasterQueryID) 
   values('Key Employment Terms','Company','Company',0,0,'Company','');
end if;


/*Custom Table data */

if not exists(select * from CustomTable where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company'  ) then
   insert into CustomTable(QueryFolderID,CustomQueryID,CustomTableID,TableDesc,PhysicalName) 
   values('Key Employment Terms','Company','Company','Company Info','Company');
end if;

if not exists(select * from CustomTable where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee'  ) then
   insert into CustomTable(QueryFolderID,CustomQueryID,CustomTableID,TableDesc,PhysicalName) 
   values('Key Employment Terms','EmployeeQuery','Employee','Employee','Employee');
end if;

/*Custom Attributes data */

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Address') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Address','CompanyAddress','Company Address Line 1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Address2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Address2','CompanyAddress2','Company Address Line 2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Address3') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Address3','CompanyAddress3','Company Address Line 3','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='City') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','City','CompanyCity','Company City','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='CompanyAddress') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','CompanyAddress','','Company Address','Calculated','FGetCompanyAddress(''001'')',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='CompanyId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','CompanyId','CompanyId','Company Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='CompanyReg') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','CompanyReg','CompanyReg','Company Reg','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='CompanyTypeId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','CompanyTypeId','CompanyTypeId','Company Type Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Contact') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Contact','CompanyContact','Company Contact','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Country') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Country','CompanyCountry','Company Country','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='DateFormat') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','DateFormat','DateFormat','Date Format','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Fax') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Fax','CompanyFax','Company Fax','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Name') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Name','CompanyName','Company Name','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='PCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','PCode','CompanyPCode','Company PCode','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='ProbationPeriod') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','ProbationPeriod','CompanyProbationPeriod','Company Probation Period','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='ProbationUnit') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','ProbationUnit','CompanyProbationUnit','Company Probation Unit','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Remarks1') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Remarks1','Remarks1','Remarks1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='Remarks2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','Remarks2','Remarks2','Remarks2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='RetireAge') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','RetireAge','CompanyRetireAge','Company Retire Age','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='Company' and CustomTableID='Company' and CustomAttributeID='State') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','Company','Company','State','CompanyState','Company State','Physical','',0,0,0);
end if;


if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='HireDate') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','HireDate','HireDate','Hire Date','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustInteger3') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustInteger3','CustInteger3','CustInteger3','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='Age') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','Age','','Age','Calculated','FGetEmployeeAge(Employeesysid) ',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='BranchDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','BranchDesc','','BranchDesc','Calculated','FGetBranchName(BranchId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='BranchId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','BranchId','BranchId','Branch Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CategoryDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CategoryDesc','','CategoryDesc','Calculated','FGetCategoryDesc(CategoryId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CategoryId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CategoryId','CategoryId','Category Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CessationCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CessationCode','CessationCode','Cessation Code','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CessationCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CessationDate','CessationDate','Cessation Date','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CessCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CessCode','','Cessation Code','Calculated','FGetCessationDesc(CessationCode)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CessDateFormat') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CessDateFormat','','Cess Date Format','Calculated','FGetDateFormat(CessationDate)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ClassificationCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ClassificationCode','ClassificationCode','Classification Code','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ClassificationCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CompanyId','CompanyId','Company Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ConfirmationDate') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ConfirmationDate','ConfirmationDate','Confirmation Date','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ConfirmationDate') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ConfirmationDate','ConfirmationDate','Confirmation Date','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ConfirmDateFormat') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ConfirmDateFormat','','Confirm Date Format','Calculated','FGetDateFormat(ConfirmationDate)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ConfirmDue') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ConfirmDue','','Confirmation Due','Calculated','FGetDateFormat(FGetConfirmationDue(EmployeeSysId))',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CountryName') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CountryName','','Country Name','Calculated','FGetCountryName(CountryOfBirth)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CountryOfBirth') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CountryOfBirth','CountryOfBirth','Country Of Birth','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustBoolean1') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustBoolean1','CustBoolean1','CustBoolean1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustBoolean2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustBoolean2','CustBoolean2','CustBoolean2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustBoolean3') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustBoolean3','CustBoolean3','CustBoolean3','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustDate1') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustDate1','CustDate1','CustDate1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustDate2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustDate2','CustDate2','CustDate2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustDate3') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustDate3','CustDate3','CustDate3','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustInteger1') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustInteger1','CustInteger1','CustInteger1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustInteger2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustInteger2','CustInteger2','CustInteger2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustNumeric1') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustNumeric1','CustNumeric1','CustNumeric1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustNumeric2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustNumeric2','CustNumeric2','CustNumeric2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustNumeric3') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustNumeric3','CustNumeric3','CustNumeric3','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustString1') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustString1','CustString1','CustString1','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustString2') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustString2','CustString2','CustString2','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustString3') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustString3','CustString3','CustString3','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustString4') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustString4','CustString4','CustString4','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CustString5') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CustString5','CustString5','CustString5','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='DateOfBirth') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','DateOfBirth','DateOfBirth','Date Of Birth','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='DepartmentDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','DepartmentDesc','','Department Desc','Calculated','FGetDepartmentDesc(DepartmentId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='DepartmentId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','DepartmentId','DepartmentId','Department Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmpCode1Id') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmpCode1Id','EmpCode1Id','EmpCode1 Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmpCode2Id') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmpCode2Id','EmpCode2Id','EmpCode2 Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmpCode3Id') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmpCode3Id','EmpCode3Id','EmpCode3 Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmpCode4Id') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmpCode4Id','EmpCode4Id','EmpCode4 Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmpCode5Id') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmpCode5Id','EmpCode5Id','EmpCode5 Id','Physical','',0,0,0);
end if;


if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmpLocation1Id') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmpLocation1Id','EmpLocation1Id','EmpLocation1 Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmployeeId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmployeeId','EmployeeId','Employee Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmployeeName') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmployeeName','EmployeeName','Employee Name','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='EmployeeSysId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','EmployeeSysId','EmployeeSysId','Employee System Identifier','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='Gender') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','Gender','Gender','Gender','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='GenderDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','GenderDesc','','Gender Description','Calculated','FGetGenderDesc(Gender)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='HighestEduCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','HighestEduCode','HighestEduCode','Highest Education Code','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='HireDateFormat') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','HireDateFormat','','Hire Date Format','Calculated','FGetDateFormat(HireDate)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='IdentityNo') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','IdentityNo','IdentityNo','Identity No','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='IdentityTypeCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','IdentityTypeCode','IdentityTypeCode','Identity Type Code','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='IsSupervisor') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','IsSupervisor','IsSupervisor','Is Supervisor','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='IsSupervisorDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','IsSupervisorDesc','','Is Supervisor Description','Calculated','FGetYesNoDesc(IsSupervisor)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='MaritalStatusCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','MaritalStatusCode','MaritalStatusCode','Marital Status Code','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='MVCAccum') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','MVCAccum','','MVC Accumulated','Calculated','FGetMVCCurrentAccPercent(EmployeeSysId) ',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='Nationality') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','Nationality','Nationality','Nationality','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='PersonalSysId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','PersonalSysId','PersonalSysId','Personal System Identifier','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='PositionDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','PositionDesc','','Position Description','Calculated','FGetPositionDesc(PositionId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='PositionId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','PositionId','PositionId','Position Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='PreviousSvcYear') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','PreviousSvcYear','PreviousSvcYear','Previous Servic Year','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ProbationPeriod') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ProbationPeriod','ProbationPeriod','Probation Period','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ProbationUnit') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ProbationUnit','ProbationUnit','Probation Unit','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='RaceId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','RaceId','RaceId','Race Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ReligionID') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ReligionID','ReligionID','Religion ID','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ResidenceStatus') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ResidenceStatus','ResidenceStatus','Residence Status','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='RetireDue') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','RetireDue','','Retirement Due','Calculated','FGetDateFormat(FGetRetirementDue(EmployeeSysId))',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='RetirementAge') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','RetirementAge','RetirementAge','Retirement Age','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='RetirementDate') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','RetirementDate','RetirementDate','Retirement Date','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='RetirementDateFormat') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','RetirementDateFormat','','Retirement Date Format','Calculated','FGetDateFormat(RetirementDate)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='SalaryGradeId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','SalaryGradeId','SalaryGradeId','Salary Grade Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='SectionDesc') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','SectionDesc','','Section Description','Calculated','FGetSectionDesc(SectionId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='SectionId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','SectionId','SectionId','Section Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ServiceYear') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ServiceYear','','Service Year','Calculated','FGetEmployeeServiceYear(EmployeeSysId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='Supervisor') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','Supervisor','Supervisor','Supervisor','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='TitleId') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','TitleId','TitleId','Title Id','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='TotalWage') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','TotalWage','','Total Wage','Calculated','FGetEmployeeCurrentTotalWage(EmployeeSysId)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='ClassificationCode') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','ClassificationCode','ClassificationCode','Employment Type','Physical','',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='CompanyID') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','CompanyID','','Company Name','Calculated','FGetCompanyName(CompanyID)',0,0,0);
end if;

if not exists(select * from CustomAttribute where QueryFolderID='Key Employment Terms' and CustomQueryID='EmployeeQuery' and CustomTableID='Employee' and CustomAttributeID='AvgWorkDayPerWeek') then
   insert into CustomAttribute(QueryFolderID,CustomQueryID,CustomTableID,CustomAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula,GroupByPosition,SortByPosition,SortByType) 
   values('Key Employment Terms','EmployeeQuery','Employee','AvgWorkDayPerWeek','','Work Day Per Week','Calculated','Select AveWorkDaysPerWeek from calendar where calendarid=FGetEmployeeCalendarId(EmployeeSysID)',0,0,0);
end if; 

/*Custom Variables Data */

if not exists(select * from CustomVariables where QueryFolderID='Key Employment Terms') then
   insert into CustomVariables(QueryFolderID,DateVar1,DateVar2,Datevar1DefValue,Datevar2DefValue) 
   values('Key Employment Terms','Hire Date From','Hire Date To','1899-12-31','1899-12-31');
end if;

/*Custom Search Data */

if not exists(select * from CustomSearch where QueryFolderID='Key Employment Terms') then
   insert into CustomSearch(QueryFolderID,CustomQueryID,CustomSearchID,SearchCondition,SearchDesc,SearchType) 
   values('Key Employment Terms','EmployeeQuery','EmployeeQuery','HireDate Between <D1> And <D2>','Hire Date Range','S');
end if;

/*Template Folder Data*/

if not exists(select * from TmplFolder where TmplFolderID='Key Employment Terms') then
   insert into TmplFolder(TmplFolderID,TmplDesc,TmplNotes) 
   values('Key Employment Terms','Key Employment Terms - Singapore','KeyEmploymentTerms.doc');
end if;

/*Template Attributes data */

if not exists(select * from TmplAttribute where TmplQueryID='EmployeeQuery' and TmplTableID='Employee' and TmplAttributeID='ClassificationCode') then
   insert into TmplAttribute(TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula) 
   values('EmployeeQuery','Employee','ClassificationCode','ClassificationCode','Employment Type','Physical','');
end if;

if not exists(select * from TmplAttribute where TmplQueryID='EmployeeQuery' and TmplTableID='Employee' and TmplAttributeID='CompanyID') then
   insert into TmplAttribute(TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula) 
   values('EmployeeQuery','Employee','CompanyID','','Company Name','Calculated','FGetCompanyName(CompanyID)');
end if;

if not exists(select * from TmplAttribute where TmplQueryID='EmployeeQuery' and TmplTableID='Employee' and TmplAttributeID='AvgWorkDayPerWeek') then
   insert into TmplAttribute(TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeType,AttributeFormula) 
   values('EmployeeQuery','Employee','AvgWorkDayPerWeek','','Work Day Per Week','Calculated','Select AveWorkDaysPerWeek from calendar where calendarid=FGetEmployeeCalendarId(EmployeeSysID)');
end if;


/*Template Variables Data */

if not exists(select * from TmplVariables where TmplFolderID='Key Employment Terms') then
   insert into TmplVariables(TmplFolderID,DateVar1,DateVar2,Datevar1DefValue,Datevar2DefValue) 
   values('Key Employment Terms','Hire Date From','Hire Date To','1899-12-31','1899-12-31');
end if;


/*Template Member Data */

if not exists(select * from Tmplmember where TmplQueryID='Company' and TmplFolderID='Key Employment Terms') then
   insert into Tmplmember(TmplQueryID,TmplFolderID,MasterQueryID) 
   values('Company','Key Employment Terms','');
end if;

if not exists(select * from Tmplmember where TmplQueryID='EmployeeQuery' and TmplFolderID='Key Employment Terms') then
   insert into Tmplmember(TmplQueryID,TmplFolderID,MasterQueryID) 
   values('EmployeeQuery','Key Employment Terms','');
end if;

/*Template Folder Sample Data */

if not exists(select * from TmplFolderSample where TmplFolderID='Key Employment Terms') then
   insert into TmplFolderSample(TmplFolderID,SampleSysID,SampleDesc,SamplePDFPath,SampleRTMPath) 
   values('Key Employment Terms','27','Key Employment Terms','KeyEmploymentTerms.pdf','KeyEmploymentTerms.rtm');
end if;

/*Template Search Data */

if not exists(select * from TmplSearch where TmplQueryID='EmployeeQuery') then
   insert into TmplSearch(TmplQueryID,TmplSearchID,SearchCondition,SearchDesc,SearchType) 
   values('EmployeeQuery','EmployeeQuery','HireDate Between <D1> And <D2>','Hire Date Range','S');
end if;


commit work;