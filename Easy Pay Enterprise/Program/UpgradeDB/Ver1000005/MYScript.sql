/* Malaysia */
UPDATE ModuleScreenGroup SET EC_ModuleScreenId = 'EC_EmployeeOtherInfo' WHERE ModuleScreenId = 'CoreEmpeeOtherInfo';
COMMIT WORK;


if exists(select 1 from sys.sysprocedure where proc_name = 'PatchAlimonyZakatRebate') then
   drop procedure PatchAlimonyZakatRebate;
end if;

create procedure dba.PatchAlimonyZakatRebate()
begin

  declare In_MalTaxPolicyProgSysId integer;

  Update RebateItem Set RebateDesc='Husband / Wife' where RebateId='Spouse';
  commit work;

  select MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where
    MalTaxPolicyEffDate = '2009-01-01' and MalTaxPolicyId = 'DefaultPolicy';

  if(In_MalTaxPolicyProgSysId is null) then return
  end if;

  if not exists(select* from RebateItem where RebateId = 'Zakat Claim') then 

	insert into RebateItem values('Zakat Claim','Zakat Claim',1,'');

  	insert into RebateSetup		(RebateId,MalTaxPolicyProgSysId,RebateCapAmt,RebateCapDuration,RebatePaymentOption) 		
	values('Zakat Claim',In_MalTaxPolicyProgSysId,0,1,0);

  end if;

  if not exists(select* from RebateItem where RebateId = 'Alimony') then 

	insert into RebateItem values('Alimony','Payment Of Alimony To Former Wife',1,'');

  	insert into RebateSetup		(RebateId,MalTaxPolicyProgSysId,RebateCapAmt,RebateCapDuration,RebatePaymentOption) 		
	values('Alimony',In_MalTaxPolicyProgSysId,3000,1,0);

  end if;

  commit work

end;


Call PatchAlimonyZakatRebate();

Drop Procedure PatchAlimonyZakatRebate;


Update RebateItem Set RebateProperty='' where RebateId in ('Educ Med Insurance','Self Education');
Update RebateItem set RebateProperty = 'LoanInterestCode' where RebateId = 'Loan Interest';
Update RebateItem set RebateProperty = 'PerquisitesCode' where RebateId = 'Innovation';

commit work;

