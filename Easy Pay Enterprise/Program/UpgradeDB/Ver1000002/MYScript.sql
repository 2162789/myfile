/*
if not exists (SELECT 1 from RebateClaimRecord) then
if not exists (SELECT 1 from RebateGranted) then
	Delete RebateSetup;
	Delete RebateItem;
end if;
end if;
*/

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
If (Not Exists(Select RebateID From RebateItem Where RebateID='Loan Interest')) Then Insert into RebateItem Values('Loan Interest','Subsidies on interest on loans up to RM300,000 (housing, passenger motor vehicle & education)',1,'LoanInterestCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Other Medical')) Then Insert into RebateItem Values('Other Medical','Medical benefit extended to maternity, ayurvedic and acupuncture',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Innovation')) Then Insert into RebateItem Values('Innovation','Perquisites extended to award related to innovation, productivity & efficiency',1,'PerquisitesCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Compensation')) Then Insert into RebateItem Values('Compensation','Compensation for loss of Employment',1,'CompensationCode'); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Gift New Computer')) Then Insert into RebateItem Values ('Gift New Computer','Gift of new personal computer',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Lve Passage')) Then Insert into RebateItem Values ('Lve Passage','Leave passages Within Malaysia',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Lve Passage Overseas')) Then Insert into RebateItem Values ('Lve Passage Overseas','Leave passages Outside Malaysia',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Foreign Insurance')) Then Insert into RebateItem Values ('Foreign Insurance','Compulsory insurance premium paid for foreign employees in lieu of SOCSO payment',1,''); End If;
If (Not Exists(Select RebateID From RebateItem Where RebateID='Group Insurance')) Then Insert into RebateItem Values ('Group Insurance','Group insurance premium to protect the employees in the event of accident',1,''); End If;

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
    select MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyEffDate = '2009-01-01'  and MalTaxPolicyId = 'DefaultPolicy';
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
	insert into MalTaxPolicyProg(MalTaxPolicyProgSysId,MalSTDPolicyId,MalTaxPolicyId,MalTaxPolicyEffDate
		,MalChildOutside,MalChildInside,MalChildDisabled,MalCat1Relief,MalCat2ChildRelief,MalCat2Relief
		,MalCat3ChildRelief,MalCat3Relief,EPFCappingOption,EPFCappingYearly,EPFCappingMonthly,MalTaxCompenPerYr,MalTaxMinTaxAmt
	) values(In_MalTaxPolicyProgSysId+1,'STDYear2009','DefaultPolicy','2009-01-01',1,4,5,0,0,0,0,0,0,0,0,0,10);
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
  insert into RebateSetup Values(In_MalTaxPolicyProgSysId+1,'Gift New Computer',0,1,0);
  insert into RebateSetup Values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,0);
  insert into RebateSetup Values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup Values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup Values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  commit work
end;

//call dba.PatchMalaysiaTaxPolicy();

drop procedure PatchMalaysiaTaxPolicy;