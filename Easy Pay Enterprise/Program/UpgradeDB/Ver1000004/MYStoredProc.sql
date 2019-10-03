if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxEmployer') then
   drop procedure DeleteMalTaxEmployer
end if
;

CREATE PROCEDURE "DBA"."DeleteMalTaxEmployer"(in In_MalTaxEmployerId char(20),out ErrorCode integer)
BEGIN
    delete from MalTaxReceipt where MalTaxEmployerId = In_MalTaxEmployerId;
  DeleteTaxEmployee: for DeleteEmployerFor as curs dynamic scroll cursor for
    select PersonalSysId as P_PersonalSysId,MalTaxYear as P_MalTaxYear from MalTaxRecord where MalTaxEmployerId = In_MalTaxEmployerId do
    delete from MalTaxEmployee where MalTaxEmployee.PersonalSysId = P_PersonalSysId and MalTaxEmployee.MalTaxYear = P_MalTaxYear end for;
  delete from MalTaxRecord where MalTaxEmployerId = In_MalTaxEmployerId;
  delete from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId;
  set ErrorCode=1
END
;


if exists(select 1 from sys.sysprocedure where proc_name = 'PatchHousingLoanRebate') then
   drop procedure PatchHousingLoanRebate
end if
;

CREATE PROCEDURE "DBA"."PatchHousingLoanRebate"()
BEGIN
  declare In_MalTaxPolicyProgSysId integer;
  if exists(select* from RebateItem where RebateId = 'House Loan Interest') then return
  end if;
  select MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where
    MalTaxPolicyEffDate = '2009-01-01' and MalTaxPolicyId = 'DefaultPolicy';
  if(In_MalTaxPolicyProgSysId is null) then return
  end if;
  insert into RebateItem values('House Loan Interest','Housing Loan Interest',1,'');
  insert into RebateSetup(RebateId,MalTaxPolicyProgSysId,RebateCapAmt,RebateCapDuration,RebatePaymentOption) values('House Loan Interest',
    In_MalTaxPolicyProgSysId,10000,1,0);
  commit work
END
;
