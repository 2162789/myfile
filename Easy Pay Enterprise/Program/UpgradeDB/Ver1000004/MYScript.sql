Update RebateSetup
Set RebateCapAmt=10000
Where RebateId='Compensation' and 
MalTaxPolicyProgSysId = (Select MalTaxPolicyProgSysId From MalTaxPolicyProg
Where MalTaxPolicyEffDate = '2009-01-01' And MalTaxPolicyId='DefaultPolicy');

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchHousingLoanRebate') then
   drop procedure PatchHousingLoanRebate;
end if;

create procedure dba.PatchHousingLoanRebate()
begin
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
end;

Call PatchHousingLoanRebate();

Drop Procedure PatchHousingLoanRebate;

if NOT Exists(Select * From KeyWord Where KeyWordId='LvePassageCode') then
Insert into KeyWord(
KeyWordId,
KeyWordDefaultName,
KeyWordUserDefinedName,
KeyWordCategory,
KeyWordPropertySelection,
KeyWordFormulaSelection,
KeyWordRangeSelection,
KeyWordDesc,
KeyWordSubCategory,
KeyWordSubProperty,
KeyWordStage,
KeyWordGroup) 
Values('LvePassageCode','Leave Passage Code','Leave Passage Code','System',1,0,0,'',0,0,0,'G');
end if;

if NOT Exists(Select * From KeyWord Where KeyWordId='LvePassageOverCode') then
Insert into KeyWord(
KeyWordId,
KeyWordDefaultName,
KeyWordUserDefinedName,
KeyWordCategory,
KeyWordPropertySelection,
KeyWordFormulaSelection,
KeyWordRangeSelection,
KeyWordDesc,
KeyWordSubCategory,
KeyWordSubProperty,
KeyWordStage,
KeyWordGroup) 
Values('LvePassageOverCode','Leave Passage Overseas Code','Leave Passage Overseas Code','System',1,0,0,'',0,0,0,'G');
end if;

Update RebateItem 
Set RebateProperty='LvePassageCode'
Where RebateId='Lve Passage';

Update RebateItem 
Set RebateProperty='LvePassageOverCode'
Where RebateId='Lve Passage Overseas';

