/* New Rebate ID from Year 2019 onwards - KWSP (Malaysia EPF) */
if not exists(select * from RebateItem where RebateID = 'KWSP') then
	insert into RebateItem (RebateID, RebateDesc, RebateERApproval, RebateProperty) values ('KWSP', 'Employee Provident Fund',1, '')
end if;

/* Change the description for RebateID - Life Ins PF */
if exists(select * from RebateItem where RebateID = 'Life Ins PF') then
	Update RebateItem Set RebateDesc = 'Life Insurance' where RebateID = 'Life Ins PF'
end if;

/*-------------------------------------------------------------------------------------*/
/* To insert Malaysia Tax for Non-Resident 2019 (For TaxPolicyId = NonResidentDefault) */
/*-------------------------------------------------------------------------------------*/

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicyForNonRes') then
   drop PROCEDURE PatchMalaysiaTaxPolicyForNonRes
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicyForNonRes"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
  /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return;
  end if;

  /* Check Tax Policy */
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'NonResidentDefault') then 
	return;
  end if;

  /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2019-01-01' and MalTaxPolicyId = 'NonResidentDefault') then
    return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select * from MalSTDPolicy where MalSTDPolicyId = 'NonResYear2019') then
    insert into MalSTDPolicy(MalSTDPolicyId, MalSTDPolicyDesc, MalSTDFormula1Ratio, MalTaxScheme) values('NonResYear2019','Year 2019 MTD Formula for Non Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+1,'NonResYear2019',0,999999999,0,28,0,0);
  end if;


  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId) into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;

  insert into MalTaxPolicyProg(
	MalTaxPolicyProgSysId, 
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
	EPFCappingMOnthly, 
	MalTaxCompenPerYr, 
	MalTaxMinTaxAmt)  
    values(In_MalTaxPolicyProgSysId+1,'NonResidentDefault','NonResYear2019','2019-01-01',0,0,0,0,0,0,0,0,0,0,0,0,0);

  /* Create Rebate Setup */
  /*
	Life insurance used to be a total of 6000, but now it has been split into 2
		1. Existing Life Ins PF capping from 6000 to 3000
		2. New KWSP capping is 4000
  */
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',3000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'KWSP',4000,1,0);
  commit work;

end;

call dba.PatchMalaysiaTaxPolicyForNonRes();

drop procedure dba.PatchMalaysiaTaxPolicyForNonRes;

/*----------------------------------------------------------------------------*/
/* To insert Malaysia Tax for Resident 2019 (For TaxPolicyId = DefaultPolicy) */
/*----------------------------------------------------------------------------*/

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicyForRes') then
   drop PROCEDURE PatchMalaysiaTaxPolicyForRes
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicyForRes"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
  /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return
  end if;

  /* Check Tax Policy */
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'DefaultPolicy') then 
	return;
  end if;

  /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2019-01-01' and MalTaxPolicyId = 'DefaultPolicy') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ResYear2019') then
    insert into MalSTDPolicy(MalSTDPolicyId, MalSTDPolicyDesc, MalSTDFormula1Ratio, MalTaxScheme) values('ResYear2019','Year 2019 MTD Formula for Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID from MalSTDPolicyTable;
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+1,'ResYear2019',5001,20000,5000,1,-400,-800);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+2,'ResYear2019',20001,35000,20000,3,-250,-650);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+3,'ResYear2019',35001,50000,35000,8,600,600);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+4,'ResYear2019',50001,70000,50000,14,1800,1800);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+5,'ResYear2019',70001,100000,70000,21,4600,4600);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+6,'ResYear2019',100001,250000,100000,24,10900,10900);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+7,'ResYear2019',250001,400000,250000,24.5,46900,46900);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+8,'ResYear2019',400001,600000,400000,25,83650,83650);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+9,'ResYear2019',600001,1000000,600000,26,133650,133650);
    insert into MalSTDPolicyTable(MalSTDPolicySysId, MalSTDPolicyId, Mal_PFrom, Mal_PTo, Mal_M, Mal_R, Mal_BCat13, Mal_BCat2) values(MaxID+10,'ResYear2019',1000001,999999999,1000000,28,237650,237650);
  end if;

  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId) into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;

  insert into MalTaxPolicyProg(
	MalTaxPolicyProgSysId, 
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
	EPFCappingMOnthly, 
	MalTaxCompenPerYr, 
	MalTaxMinTaxAmt)  
    values(In_MalTaxPolicyProgSysId+1,'DefaultPolicy','ResYear2019','2019-01-01',4,4,3,0,0,0,0,0,0,0,0,0,10);

  /* Create Rebate Setup - A few changes as compared to 2018 */
  /*
		Existing SSPN capping from 6000 to 8000
		
		Life insurance used to be a total of 6000, but now it has been split into 2
		   1. Existing Life Ins PF capping from 6000 to 3000
		   2. New KWSP capping is 4000
	
	Remember to exclude Books, Computer and Sport Equip
    Include BreastFeedingEquip, Kindergartens Fees, Lifestyle Relief and Prerequisites 
  */
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Individual',9000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Child',2000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',3000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Parent Medical',5000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Medical (Father)',1500,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Medical (Mother)',1500,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Supporting Equip',6000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Disabled Person',6000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Self Education',7000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Serious Medical',6000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'SSPN',8000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Spouse',4000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Educ Med Insurance',3000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Disabled Spouse',3500,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Petrol Official',6000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Parking',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Meal',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Childcare',2400,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Communication',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Employer Goods',1000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Employer Service',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Loan Interest',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Other Medical',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Innovation',2000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Compensation',10000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,2);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'House Loan Interest',10000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Alimony',4000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Zakat Claim',0,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Annuity',3000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'SOCSO Payment',250,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'KWSP',4000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'BreastFeedingEquip',1000,2,1);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Kindergartens Fee',1000,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Lifestyle Relief',2500,1,0);
  insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) values(In_MalTaxPolicyProgSysId+1,'Perquisites',0,1,0);

  /* Create Other Tax Formula - no change in rate, use 2013 formula */
  insert into MalTaxFormula(MalTaxPolicyProgSysId, PolicyProgTaxScheme, MalSTDPolicyId) values(In_MalTaxPolicyProgSysId+1,'REP','REPYear2013');
  insert into MalTaxFormula(MalTaxPolicyProgSysId, PolicyProgTaxScheme, MalSTDPolicyId) values(In_MalTaxPolicyProgSysId+1,'ISKANDAR','ISKANDARYear2013');

  commit work;

end;

call dba.PatchMalaysiaTaxPolicyForRes();
drop procedure dba.PatchMalaysiaTaxPolicyForRes;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Bank Islam (Salary Credit)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Bank Islam (Salary Credit)', 'RMalayBankFormatBankIslamSalaryCredit.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;