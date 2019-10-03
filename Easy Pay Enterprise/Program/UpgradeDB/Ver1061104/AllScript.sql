Read UpgradeDB\Ver1061104\Entity.sql;

if exists (select * from sys.sysprocedure where proc_name = 'FGetYTDPayment') then
  drop function FGetYTDPayment
end if;
create function dba.FGetYTDPayment(
in In_LoanSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Tmp_PayRecPayment double;
  declare Tmp_PrevPayment double;
  declare Out_YTDPayment double;
  if(In_PayRecYear <> 0 and In_PayRecPeriod <> 0) then
    select Sum(AllowanceAmount) into Tmp_PayRecPayment from AllowanceRecord where
      IsPeriodLessThan(PayRecYear,PayRecPeriod,In_PayRecYear,In_PayRecPeriod) = 1 and
      AllowanceCustSysId = In_LoanSysId and AllowanceCreatedBy = 'Loan'
  else
    select Sum(AllowanceAmount) into Tmp_PayRecPayment from AllowanceRecord where
      AllowanceCustSysId = In_LoanSysId and AllowanceCreatedBy = 'Loan'
  end if;
  select Sum(LoanYTDPaidAmt) into Tmp_PrevPayment from LoanYTD where
    LoanSysId = In_LoanSysId;
  set Out_YTDPayment=FConvertNull(Tmp_PayRecPayment)+FConvertNull(Tmp_PrevPayment);
  return Out_YTDPayment
end
;

--Employee Training Report setup
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'Bond') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','Bond','Bond','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'Course') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','Course','Course','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'CourseCategory') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','CourseCategory','Course Category','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'CourseFamily') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','CourseFamily','Course Family','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'CourseSchedule') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','CourseSchedule','Course Schedule','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'CourseSkillType') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','CourseSkillType','Course Skill Type','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'Employee') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','Employee','Employee','Human Resource',1);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'GovernmentGrant') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','GovernmentGrant','Government Grant','Human Resource',0);
end if;
if not exists  (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'Grade') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','Grade','Grade','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'Personal') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','Personal','Personal','Human Resource',1);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'SponsorShip') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','SponsorShip','Sponsorship','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'Training') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','Training','Training','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'TrainingHistory') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','TrainingHistory','Training History','Human Resource',0);
end if;
if not exists (select 1 from ExcelEmpRptTables where ExcelEmpRptId = 'TrainingRpt' and ExcelEmpRptTblId = 'TrainingType') then
  insert into ExcelEmpRptTables (ExcelEmpRptId,ExcelEmpRptTblId,ExcelEmpRptTblDesc,ExcelEmpRptTblModule,ExcelEmpRptTblIsSortGrp)
  values ('TrainingRpt','TrainingType','Training Type','Human Resource',0);
end if;

--Custom Report Default Data for Confirmation & Employment Letter

IF EXISTS(Select QUERYFOLDERID From QueryFolder where QUERYFOLDERID='Confirmation Letter') THEN
IF NOT EXISTS(Select CustomAttributeId from CustomAttribute where CustomQueryID='ConfirmedEmp' and CustomAttributeId='ProbationPeriod') THEN
  Insert Into CustomAttribute (QUERYFOLDERID,CUSTOMQUERYID,CUSTOMTABLEID,CUSTOMATTRIBUTEID,PHYSICALNAME,ATTRIBUTEDESC,ATTRIBUTETYPE,ATTRIBUTEFORMULA,GROUPBYPOSITION,SORTBYPOSITION,SORTBYTYPE)
  Values ('Confirmation Letter','ConfirmedEmp','ConfirmedEmp','ProbationPeriod','ProbationPeriod','Probation Period','Physical','',0,0,0);
END IF;
END IF;

IF EXISTS(Select QUERYFOLDERID From QueryFolder where QUERYFOLDERID='Employment Letter') THEN
IF NOT EXISTS(Select CustomAttributeId from CustomAttribute where CustomQueryID='EmploymentEmp' and CustomAttributeId='TitleID') THEN
  Insert Into CustomAttribute (QUERYFOLDERID,CUSTOMQUERYID,CUSTOMTABLEID,CUSTOMATTRIBUTEID,PHYSICALNAME,ATTRIBUTEDESC,ATTRIBUTETYPE,ATTRIBUTEFORMULA,GROUPBYPOSITION,SORTBYPOSITION,SORTBYTYPE)
  Values ('Employment Letter','EmploymentEmp','EmploymentEmp','TitleID','TitleID','Salutation','Physical','',0,0,0);
END IF;
END IF;

IF EXISTS(Select QUERYFOLDERID From QueryFolder where QUERYFOLDERID='Employment Letter') THEN
IF NOT EXISTS(Select CustomAttributeId from CustomAttribute where CustomQueryID='EmploymentEmp' and CustomAttributeId='IdentityTypeCode') THEN
  Insert Into CustomAttribute (QUERYFOLDERID,CUSTOMQUERYID,CUSTOMTABLEID,CUSTOMATTRIBUTEID,PHYSICALNAME,ATTRIBUTEDESC,ATTRIBUTETYPE,ATTRIBUTEFORMULA,GROUPBYPOSITION,SORTBYPOSITION,SORTBYTYPE)
  Values ('Employment Letter','EmploymentEmp','EmploymentEmp','IdentityTypeCode','IdentityTypeCode','Identity Type','Physical','',0,0,0);
END IF;
END IF;

IF EXISTS(Select QUERYFOLDERID From QueryFolder where QUERYFOLDERID='Employment Letter') THEN
IF NOT EXISTS(Select CustomAttributeId from CustomAttribute where CustomQueryID='EmploymentEmp' and CustomAttributeId='IdentityNo') THEN
  Insert Into CustomAttribute (QUERYFOLDERID,CUSTOMQUERYID,CUSTOMTABLEID,CUSTOMATTRIBUTEID,PHYSICALNAME,ATTRIBUTEDESC,ATTRIBUTETYPE,ATTRIBUTEFORMULA,GROUPBYPOSITION,SORTBYPOSITION,SORTBYTYPE)
  Values ('Employment Letter','EmploymentEmp','EmploymentEmp','IdentityNo','IdentityNo','Identity Number','Physical','',0,0,0);
END IF;
END IF;
IF EXISTS(Select QUERYFOLDERID From QueryFolder where QUERYFOLDERID='Employment Letter') THEN
IF NOT EXISTS(Select CustomAttributeId from CustomAttribute where CustomQueryID='EmploymentEmp' and CustomAttributeId='CessationDate') THEN
  Insert Into CustomAttribute (QUERYFOLDERID,CUSTOMQUERYID,CUSTOMTABLEID,CUSTOMATTRIBUTEID,PHYSICALNAME,ATTRIBUTEDESC,ATTRIBUTETYPE,ATTRIBUTEFORMULA,GROUPBYPOSITION,SORTBYPOSITION,SORTBYTYPE)
  Values ('Employment Letter','EmploymentEmp','EmploymentEmp','CessationDate','CessationDate','Cessation Date','Physical','',0,0,0);
END IF;
END IF;

IF NOT EXISTS(Select TmplAttributeId from TmplAttribute where TmplQueryID='ConfirmedEmp' and TmplTableID='ConfirmedEmp' and TmplAttributeID='ProbationPeriod') THEN
  Insert Into TmplAttribute (TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeFormula,AttributeType)
  Values ('ConfirmedEmp','ConfirmedEmp','ProbationPeriod','ProbationPeriod','Probation Period','','Physical');
END IF;

IF NOT EXISTS(Select TmplAttributeId from TmplAttribute where TmplQueryID='EmploymentEmp' and TmplTableID='EmploymentEmp' and TmplAttributeID='TitleID') THEN
  Insert Into TmplAttribute (TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeFormula,AttributeType)
  Values ('EmploymentEmp','EmploymentEmp','TitleID','TitleID','Salutation','','Physical');
END IF;

IF NOT EXISTS(Select TmplAttributeId from TmplAttribute where TmplQueryID='EmploymentEmp' and TmplTableID='EmploymentEmp' and TmplAttributeID='IdentityTypeCode') THEN
  Insert Into TmplAttribute (TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeFormula,AttributeType)
  Values ('EmploymentEmp','EmploymentEmp','IdentityTypeCode','IdentityTypeCode','Identity Type','','Physical');
END IF;

IF NOT EXISTS(Select TmplAttributeId from TmplAttribute where TmplQueryID='EmploymentEmp' and TmplTableID='EmploymentEmp' and TmplAttributeID='IdentityNo') THEN
  Insert Into TmplAttribute (TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeFormula,AttributeType)
  Values ('EmploymentEmp','EmploymentEmp','IdentityNo','IdentityNo','Identity Number','','Physical');
END IF;

IF NOT EXISTS(Select TmplAttributeId from TmplAttribute where TmplQueryID='EmploymentEmp' and TmplTableID='EmploymentEmp' and TmplAttributeID='CessationDate') THEN
  Insert Into TmplAttribute (TmplQueryID,TmplTableID,TmplAttributeID,PhysicalName,AttributeDesc,AttributeFormula,AttributeType)
  Values ('EmploymentEmp','EmploymentEmp','CessationDate','CessationDate','Cessation Date','case when Length(FGetInvalidDate(CessationDate))>0 then dateformat(FGetInvalidDate(CessationDate),''dd Mmm yyyy'')  end','Calculated');
END IF;


update subregistry set RegProperty1 = 'http://www.sageasiapac.com/products/sage-easypay' where Registryid='System' and SubRegistryID='CompanyWebSite';

update EmployeeRpt set EmployeeRptFilterCond = '' where EmpInfoRptId = 'Training';

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'ExportWizard') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('ExportWizard','ExportSetup','Export Wizard','ExportDesigner',0,0,0,'');
end if;
if not exists (select 1 from CoreKeyWord where CoreKeyWordId = 'TCourseStartDate') then
  insert into CoreKeyWord (CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
  values ('TCourseStartDate','ExpTraining','Course Start Date','Course Start Date','CourseSchedule.CourseStartDate');
end if;
if not exists (select 1 from CoreKeyWord where CoreKeyWordId = 'TPlanDate') then
  insert into CoreKeyWord (CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
  values ('TPlanDate','ExpTraining','Plan Date','Plan Date','Training.PlanDate');
end if;
if not exists (select 1 from CoreKeyWord where CoreKeyWordId = 'TCertExpiryDate') then
  insert into CoreKeyWord (CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
  values ('TCertExpiryDate','ExpTraining','Certificate Expiry Date','Certificate Expiry Date','Training.CertificateExpiryDate');
end if;

commit work;