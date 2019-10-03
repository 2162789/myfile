if not exists(select * from keyword where keywordId='OffPetrolCode') then 
	INSERT INTO Keyword VALUES ('OffPetrolCode','Official Petrol Code','Official Petrol Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='NonOffPetrolCode') then 
	INSERT INTO Keyword VALUES ('NonOffPetrolCode','Non Official Petrol Code','Non Official Petrol Code','System',1,0,0,'',0,0,0,'G');
end if;

UPDATE SubRegistry SET IntegerAttr =6 WHERE SubRegistryId='TaxEPFRelief';
UPDATE SubRegistry SET IntegerAttr =7 WHERE SubRegistryId='TaxZakatRelief';
UPDATE SubRegistry SET IntegerAttr =8 WHERE SubRegistryId='TaxResidenceStatus';
UPDATE SubRegistry SET IntegerAttr =9 WHERE SubRegistryId='TaxStatus';

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxOPetrolRelief') then 
INSERT INTO SubRegistry VALUES ('PayPeriodPolicy','TaxOPetrolRelief','Local','OtherInfo','Tax Official Petrol Relief','TotalYMF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxNOPetrolRelief') then 
INSERT INTO SubRegistry VALUES ('PayPeriodPolicy','TaxNOPetrolRelief','Local','OtherInfo','Tax Non Official Petrol Relief','TotalMOSQ','','','','','','',0,5,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;


// Revert Petrol Relief Changes

if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolOCappingOption') then
	ALTER TABLE DBA.MalTaxPolicyProg DROP PetrolOCappingOption;
end if;

if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolOCappingYearly') then
	ALTER TABLE DBA.MalTaxPolicyProg DROP PetrolOCappingYearly;
end if;

if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolOCappingMonthly') then
	ALTER TABLE DBA.MalTaxPolicyProg DROP PetrolOCappingMonthly;
end if;

if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolNOCappingOption') then
	ALTER TABLE DBA.MalTaxPolicyProg DROP PetrolNOCappingOption;
end if;

if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolNOCappingYearly') then
	ALTER TABLE DBA.MalTaxPolicyProg DROP PetrolNOCappingYearly;
end if;

if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolNOCappingMonthly') then
	ALTER TABLE DBA.MalTaxPolicyProg DROP PetrolNOCappingMonthly;
end if;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxPolicyProg') then
   drop procedure InsertNewMalTaxPolicyProg
end if
;

create procedure
dba.InsertNewMalTaxPolicyProg(in In_MalTaxPolicyId char(20),in In_MalSTDPolicyId char(20),in In_MalTaxPolicyEffDate date,in In_MalChildOutside integer,in In_MalChildInside integer,in In_MalChildDisabled integer,in In_MalCat1Relief double,in In_MalCat2ChildRelief double,in In_MalCat2Relief double,in In_MalCat3ChildRelief double,in In_MalCat3Relief double,in In_EPFCappingOption smallint,in In_EPFCappingYearly double,in In_EPFCappingMonthly double,in In_MalTaxCompenPerYr double,in In_MalTaxMinTaxAmt double,out Out_MalTaxPolicyProgSysId integer,out Out_ErrorCode integer)
begin
  select max(MalTaxPolicyProgSysId) into Out_MalTaxPolicyProgSysId from MalTaxPolicyProg;
  if(Out_MalTaxPolicyProgSysId is null) then
    set Out_MalTaxPolicyProgSysId=0
  end if;
  if not exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
    insert into MalTaxPolicyProg(MalTaxPolicyProgSysId,
      MalTaxPolicyId,
      MalSTDPolicyId,
      MalTaxPolicyEffDate,
      MalChildOutside,
      MalChildInside,
      MalChildDisabled,
      MalCat1Relief,
      MalCat2ChildRelief,
      MalCat2Relief,
      MalCat3ChildRelief,
      MalCat3Relief,
      EPFCappingOption,
      EPFCappingYearly,
      EPFCappingMonthly,
      MalTaxCompenPerYr,
      MalTaxMinTaxAmt) values(
      Out_MalTaxPolicyProgSysId+1,
      In_MalTaxPolicyId,
      In_MalSTDPolicyId,
      In_MalTaxPolicyEffDate,
      In_MalChildOutside,
      In_MalChildInside,
      In_MalChildDisabled,
      In_MalCat1Relief,
      In_MalCat2ChildRelief,
      In_MalCat2Relief,
      In_MalCat3ChildRelief,
      In_MalCat3Relief,
      In_EPFCappingOption,
      In_EPFCappingYearly,
      In_EPFCappingMonthly,
      In_MalTaxCompenPerYr,
      In_MalTaxMinTaxAmt);
    commit work;
    if not exists(select* from MalTaxPolicyProg where
        MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
      set Out_MalTaxPolicyProgSysId=null;
      set Out_ErrorCode=0
    else
      set Out_MalTaxPolicyProgSysId=Out_MalTaxPolicyProgSysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_MalTaxPolicyProgSysId=null;
    set Out_ErrorCode=0
  end if
end;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalTaxPolicyProg') then
   drop procedure UpdateMalTaxPolicyProg
end if
;

create procedure
dba.UpdateMalTaxPolicyProg(in In_MalTaxPolicyProgSysId integer,in In_MalTaxPolicyId char(20),in In_MalSTDPolicyId char(20),in In_MalTaxPolicyEffDate date,in In_MalChildOutside integer,in In_MalChildInside integer,in In_MalChildDisabled integer,in In_MalCat1Relief double,in In_MalCat2ChildRelief double,in In_MalCat2Relief double,in In_MalCat3ChildRelief double,in In_MalCat3Relief double,in In_EPFCappingOption smallint,in In_EPFCappingYearly double,in In_EPFCappingMonthly double,in In_MalTaxCompenPerYr double,in In_MalTaxMinTaxAmt double,out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    update MalTaxPolicyProg set
      MalTaxPolicyId = In_MalTaxPolicyId,
      MalSTDPolicyId = In_MalSTDPolicyId,
      MalTaxPolicyEffDate = In_MalTaxPolicyEffDate,
      MalChildOutside = In_MalChildOutside,
      MalChildInside = In_MalChildInside,
      MalChildDisabled = In_MalChildDisabled,
      MalCat1Relief = In_MalCat1Relief,
      MalCat2ChildRelief = In_MalCat2ChildRelief,
      MalCat2Relief = In_MalCat2Relief,
      MalCat3ChildRelief = In_MalCat3ChildRelief,
      MalCat3Relief = In_MalCat3Relief,
      EPFCappingOption = In_EPFCappingOption,
      EPFCappingYearly = In_EPFCappingYearly,
      EPFCappingMonthly = In_EPFCappingMonthly,
      MalTaxCompenPerYr = In_MalTaxCompenPerYr,
      MalTaxMinTaxAmt = In_MalTaxMinTaxAmt where
      MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalMthNonOfficialPetrolRelief') then
   drop procedure FGetMalMthNonOfficialPetrolRelief
end if
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalMthOfficialPetrolRelief') then
   drop procedure FGetMalMthOfficialPetrolRelief
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalYTDNonOfficialPetrolRelief') then
   drop procedure FGetMalYTDNonOfficialPetrolRelief
end if
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalYTDOfficialPetrolRelief') then
   drop procedure FGetMalYTDOfficialPetrolRelief
end if
;

//
// Rebate Item
//
If (Not Exists(Select RebateID From RebateItem Where RebateID='Individual')) Then Insert into RebateItem Values('Individual','Individual',0,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Child')) Then Insert into RebateItem Values('Child','Per Child ',0,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Life Ins PF')) Then Insert into RebateItem Values('Life Ins PF','Life Insurance and Provident Fund',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Parent Medical')) Then Insert into RebateItem Values('Parent Medical','Medical Expenses For Own Parents',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Supporting Equip')) Then Insert into RebateItem Values('Supporting Equip','Basic Supporting Equipment',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Disabled Person')) Then Insert into RebateItem Values('Disabled Person','Disabled Person',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Self Education')) Then Insert into RebateItem Values('Self Education','Education Fees (Self)',1,'EducationCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Serious Medical')) Then Insert into RebateItem Values('Serious Medical','Medical Expenses On Serious Disease / Complete Medical Examination',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Books')) Then Insert into RebateItem Values('Books','Purchase Of Books / Magazines / Journals / Similar Publications',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Computer')) Then Insert into RebateItem Values('Computer','Purchase Of Personal Computer For Individual',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='SSPN')) Then Insert into RebateItem Values('SSPN','Net Deposit In Skim Simpanan Pendidikan Nasional (SSPN)',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Spouse')) Then Insert into RebateItem Values('Spouse','Husband / Wife / Payment Of Alimony To Former Wife',0,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Educ Med Insurance')) Then Insert into RebateItem Values('Educ Med Insurance','Education And Medical Insurance',1,'InsuranceCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Disabled Spouse')) Then Insert into RebateItem Values('Disabled Spouse','Disable Husband / Wife',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Sports Equip')) Then Insert into RebateItem Values('Sports Equip','Purchase Of Sports Equipment',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Fee')) Then Insert into RebateItem Values('Fee','Fees / Levy',1,'LevyCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Petrol Non Official')) Then Insert into RebateItem Values('Petrol Non Official','Petrol Card / Petrol Allowance / Travel Allowance (Home – Work)',1,'NonOffPetrolCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Petrol Official')) Then Insert into RebateItem Values('Petrol Official','Petrol Card / Petrol Allowance / Travel Allowance (Official Duties)',1,'OffPetrolCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Parking')) Then Insert into RebateItem Values('Parking','Allowance or Fees for parking',1,'ParkingCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Meal')) Then Insert into RebateItem Values('Meal','Meal Allowance',1,'MealAllowanceCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Childcare')) Then Insert into RebateItem Values('Childcare','Allowance or subsidies for childcare',1,'ChildCareCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Communication')) Then Insert into RebateItem Values('Communication','Telephone and mobile phone, telephone bills, pager, PDA & Internet subscription',1,'CommunicationCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Employer Goods')) Then Insert into RebateItem Values('Employer Goods','Employers’ own goods (free / discounted)',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Employer Service')) Then Insert into RebateItem Values('Employer Service','Employer’s own services (free / discounted)',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Loan Interest')) Then Insert into RebateItem Values('Loan Interest','Subsidies on interest on loans up to RM300,000 (housing, passenger motor vehicle & education)',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Other Medical')) Then Insert into RebateItem Values('Other Medical','Medical benefit extended to maternity, ayurvedic and acupuncture',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Innovation')) Then Insert into RebateItem Values('Innovation','Perquisites extended to award related to innovation, productivity & efficiency',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Compensation')) Then Insert into RebateItem Values('Compensation','Compensation for loss of Employment',1,'CompensationCode'); End If;


//
// Pay Element Setup
//
if not exists(select * from keyword where keywordId='OffPetrolCode') then 
	INSERT INTO Keyword VALUES ('OffPetrolCode','Official Petrol Code','Official Petrol Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='NonOffPetrolCode') then 
	INSERT INTO Keyword VALUES ('NonOffPetrolCode','Non Official Petrol Code','Non Official Petrol Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='ParkingCode') then 
	INSERT INTO Keyword VALUES ('ParkingCode','Parking Code','Parking Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='ChildCareCode') then 
	INSERT INTO Keyword VALUES ('ChildCareCode','Child Care Code','Child Care Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='CommunicationCode') then 
	INSERT INTO Keyword VALUES ('CommunicationCode','Communication Code','Communication Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='TaxReportingCode') then 
	INSERT INTO Keyword VALUES ('TaxReportingCode','Tax Reporting Code','Tax Reporting Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='LoanInterestCode') then 
	INSERT INTO Keyword VALUES ('LoanInterestCode','Loan Interest Code','Loan Interest Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='PerquisitesCode') then 
	INSERT INTO Keyword VALUES ('PerquisitesCode','Perquisites Code','Perquisites Code','System',1,0,0,'',0,0,0,'G');
end if;



//
// Pay Record
//
delete  from SubRegistry where RegistryId='PayRecordPolicy' and (RegProperty2='EPF' OR RegProperty2='EPFMandatory' OR RegProperty2='EPFVoluntary')
Commit Work;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEPFMandatory') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEPFMandatory','Local','EPF','Current Mandatory','','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEEManWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEEManWage','Local','CurrEPFMandatory','Employee Wage','CurrEEManWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEEManContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEEManContri','Local','CurrEPFMandatory','Employee EPF Submission','CurrEEManContri','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEEManAddContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEEManAddContri','Local','CurrEPFMandatory','Employee Standard EPF','CurBackPayMVC','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrERManWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrERManWage','Local','CurrEPFMandatory','Employer Wage','CurrERManWage','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrERManContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrERManContri','Local','CurrEPFMandatory','Employer EPF Submission','CurrERManContri','','','','','','',0,4,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEPFMandatory') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEPFMandatory','Local','EPF','Previous Mandatory','','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEEManWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEEManWage','Local','PrevEPFMandatory','Employee Wage','PrevEEManWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEEManContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEEManContri','Local','PrevEPFMandatory','Employee EPF Submission','PrevEEManContri','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEEManAddContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEEManAddContri','Local','PrevEPFMandatory','Employee Standard EPF','PrevBackPayMVC','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevERManWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevERManWage','Local','PrevEPFMandatory','Employer Wage','PrevERManWage','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevERManContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevERManContri','Local','PrevEPFMandatory','Employer EPF Submission','PrevERManContri','','','','','','',0,4,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEPFVoluntary') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEPFVoluntary','Local','EPF','Current Voluntary','','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEEVolWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEEVolWage','Local','CurrEPFVoluntary','Employee Wage','CurrEEVolWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEEVolContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEEVolContri','Local','CurrEPFVoluntary','Employee EPF Submission','CurrEEVolContri','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrEEVolAddContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrEEVolAddContri','Local','CurrEPFVoluntary','Employee Standard EPF','CurBackPayNWC','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrERVolWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrERVolWage','Local','CurrEPFVoluntary','Employer Wage','CurrERVolWage','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='CurrERVolContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','CurrERVolContri','Local','CurrEPFVoluntary','Employer EPF Submission','CurrERVolContri','','','','','','',0,4,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEPFVoluntary') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEPFVoluntary','Local','EPF','Previous Voluntary','','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEEVolWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEEVolWage','Local','PrevEPFVoluntary','Employee Wage','PrevEEVolWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEEVolContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEEVolContri','Local','PrevEPFVoluntary','Employee EPF Submission','PrevEEVolContri','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevEEVolAddContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevEEVolAddContri','Local','PrevEPFVoluntary','Employee Standard EPF','PrevBackPayNWC','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevERVolWage') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevERVolWage','Local','PrevEPFVoluntary','Employer Wage','PrevERVolWage','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayRecordPolicy' and SubRegistryId='PrevERVolContri') then 
INSERT INTO SubRegistry VALUES('PayRecordPolicy','PrevERVolContri','Local','PrevEPFVoluntary','Employer EPF Submission','PrevERVolContri','','','','','','',0,4,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

Commit Work;

//
// Pay Period 
//
delete  from SubRegistry where RegistryId='PayPeriodPolicy' and (RegProperty2='EPF' OR RegProperty2='EPFMandatory' OR RegProperty2='EPFVoluntary')
Commit Work;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEPFMandatory') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEPFMandatory','Local','EPF','Current Mandatory','','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEEManWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEEManWage','Local','CurrEPFMandatory','Employee Wage','SupIR8AActOrdEECPF','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEEManContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEEManContri','Local','CurrEPFMandatory','Employee EPF Submission','ActualOrdEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEEManAddContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEEManAddContri','Local','CurrEPFMandatory','Employee Standard EPF','MAWContriCurAddWage','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrERManWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrERManWage','Local','CurrEPFMandatory','Employer Wage','SupIR8AActOrdERCPF','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrERManContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrERManContri','Local','CurrEPFMandatory','Employer EPF Submission','ActualOrdERCPF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEPFMandatory') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEPFMandatory','Local','EPF','Previous Mandatory','','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEEManWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEEManWage','Local','PrevEPFMandatory','Employee Wage','SupIR8AActAddEECPF','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEEManContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEEManContri','Local','PrevEPFMandatory','Employee EPF Submission','ActualAddEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEEManAddContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEEManAddContri','Local','PrevEPFMandatory','Employee Standard EPF','MAWContriPrevAddWage','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevERManWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevERManWage','Local','PrevEPFMandatory','Employer Wage','SupIR8AActAddERCPF','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevERManContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevERManContri','Local','PrevEPFMandatory','Employer EPF Submission','ActualAddERCPF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEPFVoluntary') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEPFVoluntary','Local','EPF','Current Voluntary','','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEEVolWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEEVolWage','Local','CurrEPFVoluntary','Employee Wage','SupIR8ACurOrdWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEEVolContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEEVolContri','Local','CurrEPFVoluntary','Employee EPF Submission','VolOrdEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrEEVolAddContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrEEVolAddContri','Local','CurrEPFVoluntary','Employee Standard EPF','MAWBalCurAddWage','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrERVolWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrERVolWage','Local','CurrEPFVoluntary','Employer Wage','SupIR8ACurAddWage','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='CurrERVolContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','CurrERVolContri','Local','CurrEPFVoluntary','Employer EPF Submission','VolOrdERCPF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEPFVoluntary') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEPFVoluntary','Local','EPF','Previous Voluntary','','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEEVolWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEEVolWage','Local','PrevEPFVoluntary','Employee Wage','SupIR8APrevOrdWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEEVolContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEEVolContri','Local','PrevEPFVoluntary','Employee EPF Submission','VolAddEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevEEVolAddContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevEEVolAddContri','Local','PrevEPFVoluntary','Employee Standard EPF','MAWBalPrevAddWage','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevERVolWage') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevERVolWage','Local','PrevEPFVoluntary','Employer Wage','SupIR8APrevAddWage','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='PrevERVolContri') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','PrevERVolContri','Local','PrevEPFVoluntary','Employer EPF Submission','VolAddERCPF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

Commit Work;

delete  from SubRegistry where RegistryId='PayPeriodPolicy' and (RegProperty2='TaxZakatReliefGroup' OR RegProperty2='OtherInfo')
delete  from SubRegistry where RegistryId='PayPeriodPolicy' and (SubRegistryId='TaxZakatReliefGroup' OR SubRegistryId='OtherInfo')
Commit Work;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxReliefGroup') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxReliefGroup','Local','IncomeTax','Tax Relief','','','','','','','',0,8,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxChildRelief') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxChildRelief','Local','TaxReliefGroup','Child Relief Point','TaxChildRelief','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxPrevEPFRelief') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxPrevEPFRelief','Local','TaxReliefGroup','Previous EPF Relief','MAWContriLimit','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxEPFRelief') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxEPFRelief','Local','TaxReliefGroup','Current EPF Relief','TaxEPFRelief','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxPrevAddEPFRelief') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxPrevAddEPFRelief','Local','TaxReliefGroup','Previous Additional EPF Relief','CompanyAddERCPF','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxCurrAddEPFRelief') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxCurrAddEPFRelief','Local','TaxReliefGroup','Current Additional EPF Relief','CompanyAddEECPF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxZakatRelief') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxZakatRelief','Local','TaxReliefGroup','Zakat Relief','TaxZakatRelief','','','','','','',0,5,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='OtherInfo') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','OtherInfo','Local','IncomeTax','Other Information','','','','','','','',0,9,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxCategory') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxCategory','Local','OtherInfo','Tax Category','TaxCategory','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxMaritalStatus') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxMaritalStatus','Local','OtherInfo','Marital Status','TaxMaritalStatus','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxBenefit') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxBenefit','Local','OtherInfo','Tax Benefit','TaxBenefit','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxResidenceStatus') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxResidenceStatus','Local','OtherInfo','Residence Status','CPFClass','','','SELECT CoreKeywordId, CoreUserDefinedName FROM CoreKeyword WHERE CoreKeywordCategory = ''CPFClass'' ORDER BY CoreUserDefinedName','','','',0,3,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxStatus') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TaxStatus','Local','OtherInfo','Tax Status','CPFStatus','','','SELECT KeywordId, KeywordUserDefinedName FROM Keyword WHERE KeywordCategory = ''CPFStatus'' ORDER BY KeywordUserDefinedName','','','',0,4,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TotalZakat') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TotalZakat','Local','OtherInfo','Total Zakat','TotalCDAC','','','','','','',0,5,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TotalWP39') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TotalWP39','Local','OtherInfo','Total WP39','TotalSINDA','','','','','','',0,6,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TotalCP38') then 
INSERT INTO SubRegistry VALUES('PayPeriodPolicy','TotalCP38','Local','OtherInfo','Total CP38','TotalEUCF','','','','','','',0,7,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

Commit Work;




//
// Module Screen Group
//
if not exists(SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId='PayMalIncomeTax' AND Mod_ModuleScreenId='PayModules') then
INSERT INTO ModuleScreenGroup VALUES ('PayMalIncomeTax','PayModules','Income Tax','Pay',0,0);
end if;

if exists(SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId='PayMalTaxDetails' AND Mod_ModuleScreenId='PayModules') then
UPDATE ModuleScreenGroup SET Mod_ModuleScreenId='PayMalIncomeTax' WHERE ModuleScreenId='PayMalTaxDetails' AND Mod_ModuleScreenId='PayModules';
end if;

if not exists(SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId='PayPrevEREntry' AND Mod_ModuleScreenId='PayMalIncomeTax') then
INSERT INTO ModuleScreenGroup VALUES ('PayPrevEREntry','PayMalIncomeTax','Previous Employer Entry','Pay',0,0);
end if;

if not exists(SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId='PayRebateGranted' AND Mod_ModuleScreenId='PayMalIncomeTax') then
INSERT INTO ModuleScreenGroup VALUES ('PayRebateGranted','PayMalIncomeTax','Rebate Granted','Pay',0,0);
end if;

if not exists(SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId='PayRebateClaimRecord' AND Mod_ModuleScreenId='PayMalIncomeTax') then
INSERT INTO ModuleScreenGroup VALUES ('PayRebateClaimRecord','PayMalIncomeTax','Rebate Claim Record','Pay',0,0);
end if;


if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy') then
   drop procedure PatchMalaysiaTaxPolicy
end if
;

create procedure dba.PatchMalaysiaTaxPolicy()
begin
  declare In_Country char(20);
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
  /* Check for Malaysia DB */
  select FGetDBCountry(*) into In_Country;
  if In_Country <> 'Malaysia' then return
  end if;
  /* Check for Default Tax Policy */
  if not exists(select* from MalTaxPolicy where MalTaxPolicyId = 'DefaultPolicy') then return
  end if;
  /* Check for Tax Policy Progression*/
  if exists(select* from MalTaxPolicyProg where MalTaxPolicyEffDate = '2009-01-01' and MalTaxPolicyId = 'DefaultPolicy') then
    select MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyEffDate = '2009-01-01' and MalTaxPolicyId = 'DefaultPolicy';
    call DeleteMalTaxPolicyProg(In_MalTaxPolicyProgSysId,Out_ErrorCode)
  end if;
  /* Check for STD Policy */
  if exists(select* from MalSTDPolicy where MalSTDPolicyId = 'STDYear2009') then
    call DeleteMalSTDPolicy('STDYear2009',Out_ErrorCode)
  end if;
  /* Create STD Policy */
  insert into MalSTDPolicy values('STDYear2009','Year 2009 Default STD Policy',0);
  select Max(MalSTDPolicySysId) into MaxID from MalSTDPolicyTable;
  insert into MalSTDPolicyTable values(MaxID+1,'STDYear2009',2500,5000,2500,1,-400,-800);
  insert into MalSTDPolicyTable values(MaxID+2,'STDYear2009',5001,20000,5000,3,-375,-775);
  insert into MalSTDPolicyTable values(MaxID+3,'STDYear2009',20001,35000,20000,7,75,-325);
  insert into MalSTDPolicyTable values(MaxID+4,'STDYear2009',35001,50000,35000,12,1525,1525);
  insert into MalSTDPolicyTable values(MaxID+5,'STDYear2009',50001,70000,50000,19,3325,3325);
  insert into MalSTDPolicyTable values(MaxID+6,'STDYear2009',70001,100000,70000,24,7125,7125);
  insert into MalSTDPolicyTable values(MaxID+7,'STDYear2009',100001,999999999,100000,27,14325,14325);
  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId) into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;
  insert into MalTaxPolicyProg(
  MalTaxPolicyProgSysId,
  MalSTDPolicyId,
  MalTaxPolicyId,
  MalTaxPolicyEffDate,
  MalChildOutside,
  MalChildInside,
  MalChildDisabled,
  MalCat1Relief,
  MalCat2ChildRelief,
  MalCat2Relief,
  MalCat3ChildRelief,
  MalCat3Relief,
  EPFCappingOption,
  EPFCappingYearly,
  EPFCappingMonthly,
  MalTaxCompenPerYr,
  MalTaxMinTaxAmt)
  values(In_MalTaxPolicyProgSysId+1,'STDYear2009','DefaultPolicy','2009-01-01',1,4,5,0,0,0,0,0,0,0,0,0,21);
  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Individual',8000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Child',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parent Medical',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Supporting Equip',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Person',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Self Education',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Serious Medical',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Books',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Computer',3000,3,1);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'SSPN',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Spouse',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Educ Med Insurance',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Spouse',3500,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Sports Equip',300,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Fee',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Petrol Non Official',2400,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Petrol Official',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parking',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Meal',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Childcare',2400,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Communication',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Employer Goods',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Employer Service',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Loan Interest',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Other Medical',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Innovation',2000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Compensation',6000,1,0);
  commit work
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaEPF2009') then
   drop procedure PatchMalaysiaEPF2009
end if
;

create procedure dba.PatchMalaysiaEPF2009()
begin
  declare In_Country char(20);
  /* Check for Malaysia DB */
  select FGetDBCountry(*) into In_Country;
  if In_Country <> 'Malaysia' then return
  end if;

 if(exists(Select * From CPFPolicy Where Locate(CPFPolicyId,'2009') > 0 and Locate(CPFPolicyId,'EPF') > 0)) then return end if;

  insert into CPFTableCode(CPFTableCodeId,CPFResidenceTypeId,CPFSchemeId,CPFTableDesc,CPFPeriodCapping,CPFLessThanCapping,CPFGreaterThanCapping) values('EP09ST','Local','EPFMandatory','Malaysian Standard Rate - Employer 12% and Employee 8%',0,0,0);
  insert into CPFTableCode(CPFTableCodeId,CPFResidenceTypeId,CPFSchemeId,CPFTableDesc,CPFPeriodCapping,CPFLessThanCapping,CPFGreaterThanCapping) values('EP09PR','PR','EPFMandatory','PR Standard Rate - Employer 12% and Employee 8%',0,0,0);
  insert into CPFTableCode(CPFTableCodeId,CPFResidenceTypeId,CPFSchemeId,CPFTableDesc,CPFPeriodCapping,CPFLessThanCapping,CPFGreaterThanCapping) values('EP09EX','FW','EPFMandatory','Foreign Workers and Expatriates Rate - Employee 8% Employer RM5',0,0,0);
  insert into CPFTableComponent(CPFTableCodeId,MinSalary,MinCPFAge,EEOrdCPFFormula,EROrdCPFFormula,MaxSalary,MaxCPFAge,EEAddCPFFormula,ERAddCPFFormula) values('EP09ST',0,0,'EP09STA0$0EEM','EP09STA0$0ERM',10,99,'EP09STA0$0EEV','EP09STA0$0ERV');
  insert into CPFTableComponent(CPFTableCodeId,MinSalary,MinCPFAge,EEOrdCPFFormula,EROrdCPFFormula,MaxSalary,MaxCPFAge,EEAddCPFFormula,ERAddCPFFormula) values('EP09ST',10,0,'EP09STA0$10EEM','EP09STA0$10ERM',9999999,99,'EP09STA0$10EEV','EP09STA0$10ERV');
  insert into CPFTableComponent(CPFTableCodeId,MinSalary,MinCPFAge,EEOrdCPFFormula,EROrdCPFFormula,MaxSalary,MaxCPFAge,EEAddCPFFormula,ERAddCPFFormula) values('EP09PR',0,0,'EP09PRA0$0EEM','EP09PRA0$0ERM',10,99,'EP09PRA0$0EEV','EP09PRA0$0ERV');
  insert into CPFTableComponent(CPFTableCodeId,MinSalary,MinCPFAge,EEOrdCPFFormula,EROrdCPFFormula,MaxSalary,MaxCPFAge,EEAddCPFFormula,ERAddCPFFormula) values('EP09PR',10,0,'EP09PRA0$10EEM','EP09PRA0$10ERM',9999999,99,'EP09PRA0$10EEV','EP09PRA0$10ERV');
  insert into CPFTableComponent(CPFTableCodeId,MinSalary,MinCPFAge,EEOrdCPFFormula,EROrdCPFFormula,MaxSalary,MaxCPFAge,EEAddCPFFormula,ERAddCPFFormula) values('EP09EX',0,0,'EP09EXA0$0EEM','EP09EXA0$0ERM',9999999,99,'EP09EXA0$0EEV','EP09EXA0$0ERV');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09EXA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09EXA0$0EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09EXA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09STA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09PRA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values('EP09EXA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$10ERM',1,0,0,'@CEILING((C1 / 100) * @IF(K1>5000,@RNDNEAR(K1,100),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$10ERM',1,0,0,'@CEILING((C1 / 100) * @IF(K1>5000,@RNDNEAR(K1,100),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09EXA0$0ERM',1,0,0,'C1;',5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$10EEM',1,0,0,'@CEILING((C1 / 100) * @IF(K1>5000,@RNDNEAR(K1,100),@RNDNEAR(K1,20)));',8,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$10EEM',1,0,0,'@CEILING((C1 / 100) * @IF(K1>5000,@RNDNEAR(K1,100),@RNDNEAR(K1,20)));',8,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09EXA0$0EEM',1,0,0,'@CEILING((C1 / 100) * @IF(K1>5000,@RNDNEAR(K1,100),@RNDNEAR(K1,20)));',8,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','ROUND','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09EXA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09STA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09PRA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values('EP09EXA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  insert into CPFPolicy(CPFPolicyId,CPFGovernment,CPFPolicyDesc) values('EPFYr2009Jan',1,'12% Employer,8% Employee');
  insert into CPFPolicyMember(CPFPolicyId,CPFTableCodeId) values('EPFYr2009Jan','EP09ST');
  insert into CPFPolicyMember(CPFPolicyId,CPFTableCodeId) values('EPFYr2009Jan','EP09PR');
  insert into CPFPolicyMember(CPFPolicyId,CPFTableCodeId) values('EPFYr2009Jan','EP09EX');
  commit work
end;

//call PatchMalaysiaTaxPolicy();
call PatchMalaysiaEPF2009();

drop procedure PatchMalaysiaTaxPolicy;
drop procedure PatchMalaysiaEPF2009;


