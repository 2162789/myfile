if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'EPF' and FormatName = 'OCBC Bank')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('EPF', 'OCBC Bank', 'RMalayBankFormatOCBC.dll', 'InvokeEPFFormatter');
end if;
commit work;

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
  if exists(select* from MalTaxPolicyProg where MalTaxPolicyEffDate = '2011-01-01' and MalTaxPolicyId = 'DefaultPolicy') then 
    select MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyEffDate = '2011-01-01' and   MalTaxPolicyId = 'DefaultPolicy';
    call DeleteMalTaxPolicyProg(In_MalTaxPolicyProgSysId,Out_ErrorCode)
   end if;
  
  /* Check for STD Policy */
  if exists(select* from MalSTDPolicy where MalSTDPolicyId = 'STDYear2011') then  
	call DeleteMalSTDPolicy('STDYear2011',Out_ErrorCode)
 end if;
 
  /* Create STD Policy */
  insert into MalSTDPolicy values('STDYear2011','Year 2011 Default STD Policy',0);
  select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
  insert into MalSTDPolicyTable values(MaxID+1,'STDYear2011',2500,5000,2500,1,-400,-800);
  insert into MalSTDPolicyTable values(MaxID+2,'STDYear2011',5001,20000,5000,3,-375,-775);
  insert into MalSTDPolicyTable values(MaxID+3,'STDYear2011',20001,35000,20000,7,75,-325);
  insert into MalSTDPolicyTable values(MaxID+4,'STDYear2011',35001,50000,35000,12,1525,1525);
  insert into MalSTDPolicyTable values(MaxID+5,'STDYear2011',50001,70000,50000,19,3325,3325);
  insert into MalSTDPolicyTable values(MaxID+6,'STDYear2011',70001,100000,70000,24,7125,7125);
  insert into MalSTDPolicyTable values(MaxID+7,'STDYear2011',100001,999999999,100000,26,14325,14325);

  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId)  into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;

  insert into MalTaxPolicyProg (
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
		values(
	In_MalTaxPolicyProgSysId+1, 
	'DefaultPolicy',
	'STDYear2011', 
	'2011-01-01',
	1,4,5,0,0,0,0,0,0,0,0,0,10);

  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Individual',9000,1,0);
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
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,2);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'House Loan Interest',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Alimony',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Zakat Claim',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Annuity',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Broadband',500,1,0);

  Update RebateItem set RebateDesc='Telephone and mobile phone, telephone bills, pager & PDA' where RebateID='Communication';

  commit work;

end;

//call dba.PatchMalaysiaTaxPolicy();

drop procedure dba.PatchMalaysiaTaxPolicy;

commit work;