/*Begin of head for every patch*/
if exists(select * from "DBA"."subRegistry" WHERE registryid='System'and subregistryid='Patch')
then  
   Delete from SubRegistry where registryid='System'and subregistryid='Patch'
end if;
/*End of head for every patch*/

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
  if FGetDBCountry(*) <> 'Malaysia' then return;
  end if;

 /* Check Tax Policy*/
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'NonResidentDefault') then 
	return;
  end if;

 /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2015-01-01' and MalTaxPolicyId = 'NonResidentDefault') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'NonResYear2015') then
    insert into MalSTDPolicy values('NonResYear2015','Year 2015 MTD Formula for Non Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'NonResYear2015',0,999999999,0,25,0,0);
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
    values(In_MalTaxPolicyProgSysId+1,'NonResidentDefault','NonResYear2015','2015-01-01',0,0,0,0,0,0,0,0,0,0,0,0,0);

  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy();

drop procedure dba.PatchMalaysiaTaxPolicy;

/*Begin of tailor for every patch*/
INSERT into "DBA"."subRegistry"(registryid,subregistryid,IntegerAttr) values('System','Patch',1);
commit work;
/*End of tailor for every patch*/