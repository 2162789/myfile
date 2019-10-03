
/*-------------------------------------------------------------------------------------*/
/* To insert Malaysia Tax for Non-Resident 2017 (For TaxPolicyId = NonResidentDefault) */
/*-------------------------------------------------------------------------------------*/

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy') then
   drop PROCEDURE PatchMalaysiaTaxPolicy
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
 /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return;
  end if;

 /* Check Tax Policy*/
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'NonResidentDefault') then 
	return;
  end if;

 /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2017-01-01' and MalTaxPolicyId = 'NonResidentDefault') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'NonResYear2017') then
    insert into MalSTDPolicy values('NonResYear2017','Year 2017 MTD Formula for Non Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'NonResYear2017',0,999999999,0,28,0,0);
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
    values(In_MalTaxPolicyProgSysId+1,'NonResidentDefault','NonResYear2017','2017-01-01',0,0,0,0,0,0,0,0,0,0,0,0,0);

  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy();

drop procedure dba.PatchMalaysiaTaxPolicy;

/*----------------------------------------------------------------------------*/
/* To insert Malaysia Tax for Resident 2017 (For TaxPolicyId = DefaultPolicy) */
/*----------------------------------------------------------------------------*/

/* New Rebate Item*/

if not exists(select * from RebateItem where RebateID = 'Lifestyle Relief') then
  Insert into RebateItem (RebateID,RebateDesc,RebateERApproval,RebateProperty)
  Values('Lifestyle Relief','Lifestyle Relief',1,'');
end if;

if not exists(select * from RebateItem where RebateID = 'Kindergartens Fee') then
  Insert into RebateItem (RebateID,RebateDesc,RebateERApproval,RebateProperty)
  Values('Kindergartens Fee','Fees Paid to Child Care Centres and Kindergartens ',1,'');
end if;

if not exists(select * from RebateItem where RebateID = 'BreastFeedingEquip') then
  Insert into RebateItem (RebateID,RebateDesc,RebateERApproval,RebateProperty)
  Values('BreastFeedingEquip','Purchase of Breastfeeding Equipment ',1,'');
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy1') then
   drop PROCEDURE PatchMalaysiaTaxPolicy1
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy1"()
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
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2017-01-01' and MalTaxPolicyId = 'DefaultPolicy') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ResYear2017') then
    insert into MalSTDPolicy values('ResYear2017','Year 2017 MTD Formula for Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+2,'ResYear2017',5001,20000,5000,1,-400,-800);
    insert into MalSTDPolicyTable values(MaxID+3,'ResYear2017',20001,35000,20000,5,-250,-650);
    insert into MalSTDPolicyTable values(MaxID+4,'ResYear2017',35001,50000,35000,10,900,900);
    insert into MalSTDPolicyTable values(MaxID+5,'ResYear2017',50001,70000,50000,16,2400,2400);
    insert into MalSTDPolicyTable values(MaxID+6,'ResYear2017',70001,100000,70000,21,5600,5600);
    insert into MalSTDPolicyTable values(MaxID+7,'ResYear2017',100001,250000,100000,24,11900,11900);
    insert into MalSTDPolicyTable values(MaxID+8,'ResYear2017',250001,400000,250000,24.5,47900,47900);
    insert into MalSTDPolicyTable values(MaxID+9,'ResYear2017',400001,600000,400000,25,84650,84650);
    insert into MalSTDPolicyTable values(MaxID+10,'ResYear2017',600001,1000000,600000,26,134650,134650);
    insert into MalSTDPolicyTable values(MaxID+11,'ResYear2017',1000001,999999999,1000000,28,238650,238650);
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
    values(In_MalTaxPolicyProgSysId+1,'DefaultPolicy','ResYear2017','2017-01-01',4,4,3,0,0,0,0,0,0,0,0,0,10);

  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Individual',9000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Child',2000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parent Medical',5000,1,0);

  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Medical (Father)',1500,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Medical (Mother)',1500,1,0);

  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Supporting Equip',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Person',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Self Education',7000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Serious Medical',6000,1,0);


  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'SSPN',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Spouse',4000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Educ Med Insurance',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Spouse',3500,1,0);

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
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Compensation',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,2);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'House Loan Interest',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Alimony',4000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Zakat Claim',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Annuity',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'SOCSO Payment',250,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Perquisites',0,1,0);

//Newly added for 2017
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lifestyle Relief',2500,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'BreastFeedingEquip',1000,2,1);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Kindergartens Fee',1000,1,0);

//Removed from 2017 (Lifestyle Relief Replace the below 3 items)
  //insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Books',1000,1,0);
  //insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Sports Equip',300,1,0);
 //insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Computer',3000,3,1);


  /* Create Other Tax Formula - no change in rate, use 2013 formula*/
  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'REP','REPYear2013');
  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'ISKANDAR','ISKANDARYear2013');

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy1();
drop procedure dba.PatchMalaysiaTaxPolicy1;



commit work;


commit work;