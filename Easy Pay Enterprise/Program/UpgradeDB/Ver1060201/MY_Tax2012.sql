
if not exists(select * From CoreKeyWord Where CoreKeywordCategory = 'MalTaxScheme') then 
    insert into CoreKeyword values('STD','MalTaxScheme','STD','STD','');
    insert into CoreKeyword values('Resident','MalTaxScheme','Resident','Resident','');
    insert into CoreKeyword values('REP','MalTaxScheme','REP','REP','');
    insert into CoreKeyword values('ISKANDAR','MalTaxScheme','ISKANDAR','ISKANDAR','');
end if;


Update MalSTDPolicy Set MalTaxScheme = 'STD' where MalTaxScheme is null;

Update SubRegistry set
RegProperty7 = 'SELECT CoreKeywordId, CoreUserDefinedName FROM CoreKeyword WHERE CoreKeywordCategory = ''CPFClass'' Or CoreKeywordCategory = ''MalTaxScheme'' ORDER BY CoreUserDefinedName',
RegProperty3 = 'Residence Status / Tax Scheme'
where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxResidenceStatus';

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy') then
   drop PROCEDURE PatchMalaysiaTaxPolicy
end if
;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
 /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return
  end if;

 /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2012-01-01' and MalTaxPolicyId = 'DefaultPolicy') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ResYear2012') then
    insert into MalSTDPolicy values('ResYear2012','Year 2012 MTD Formula for Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'ResYear2012',2500,5000,2500,1,-400,-800);
    insert into MalSTDPolicyTable values(MaxID+2,'ResYear2012',5001,20000,5000,3,-375,-775);
    insert into MalSTDPolicyTable values(MaxID+3,'ResYear2012',20001,35000,20000,7,75,-325);
    insert into MalSTDPolicyTable values(MaxID+4,'ResYear2012',35001,50000,35000,12,1525,1525);
    insert into MalSTDPolicyTable values(MaxID+5,'ResYear2012',50001,70000,50000,19,3325,3325);
    insert into MalSTDPolicyTable values(MaxID+6,'ResYear2012',70001,100000,70000,24,7125,7125);
    insert into MalSTDPolicyTable values(MaxID+7,'ResYear2012',100001,999999999,100000,26,14325,14325);
  end if;

  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'REPYear2012') then
    insert into MalSTDPolicy values('REPYear2012','Year 2012 MTD Formula for Returning Expert Program',0,'REP');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'REPYear2012',0,35000,0,15,400,800);
    insert into MalSTDPolicyTable values(MaxID+2,'REPYear2012',35001,999999999,0,15,0,0);
  end if;

  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ISKANDARYear2012') then
    insert into MalSTDPolicy values('ISKANDARYear2012','Year 2012 MTD Formula for Knowledge Worker in ISKANDAR',0,'ISKANDAR');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'ISKANDARYear2012',0,999999999,0,15,0,0);
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
    values(In_MalTaxPolicyProgSysId+1,'DefaultPolicy','ResYear2012','2012-01-01',4,4,5,0,0,0,0,0,0,0,0,0,10);

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
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Compensation',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,2);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'House Loan Interest',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Alimony',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Zakat Claim',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Annuity',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Broadband',500,1,0);

  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'REP','REPYear2012');
  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'ISKANDAR','ISKANDARYear2012');

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy();

drop procedure dba.PatchMalaysiaTaxPolicy;
