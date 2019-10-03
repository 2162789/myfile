/* New Rebate ID for Life Insurance to cover Public Servant under Pension Scheme */
if not exists(select * from RebateItem where RebateID = 'Life Ins (P Pension)') then
	Insert into RebateItem(RebateID, RebateDesc, RebateERApproval, RebateProperty) values ('Life Ins (P Pension)', 'Life Insurance for Public Servant under Pension Scheme', 1, '')
end if;

/* Remove Life Ins PF from Non Resident Policy */
Delete from RebateSetup where RebateSetup.MalTaxPolicyProgSysId = (select MalTaxPolicyProgSysId from MalTaxPolicyProg 
where MalTaxPolicyId = 'NonResidentDefault' and MalTaxPolicyEffDate = '2019-01-01') and RebateId = 'Life Ins PF';

/* Remove Interst On house loan from Default Resident Policy */
Delete from RebateSetup where RebateSetup.MalTaxPolicyProgSysId = (select MalTaxPolicyProgSysId from MalTaxPolicyProg 
where MalTaxPolicyId = 'DefaultPolicy' and MalTaxPolicyEffDate = '2019-01-01') and RebateId = 'House Loan Interest';

/* Add Life Ins (P Pension into Rebate Setup */
if not exists(select * from rebateSetup join MalTaxPolicyProg ON rebateSetup.MalTaxPolicyProgSysId = MalTaxPolicyProg.MalTaxPolicyProgSysId 
				where rebateId = 'Life Ins (P Pension)' and MalTaxPolicyId = 'DefaultPolicy' and MalTaxPolicyEffDate = '2019-01-01') then
	insert into RebateSetup(MalTaxPolicyProgSysId, RebateID, RebateCapAmt, RebateCapDuration, RebatePaymentOption) 
	select Max(MalTaxPolicyProgSysId), 'Life Ins (P Pension)',7000,1,0
	from MalTaxPolicyProg 
    where MalTaxPolicyId = 'DefaultPolicy' and MalTaxPolicyEffDate = '2019-01-01';
end if;

/* EIS for Maybank 2E-RC */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EIS' and FormatName = 'Maybank 2E-RC') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EIS', 'Maybank 2E-RC', 'RMalayBankFormatMaybank2ERC.dll', 'InvokeEISFormatter', 0);
end if;

/* HLB (ConnectFirst) */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'HLB (ConnectFirst)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'HLB (ConnectFirst)', 'RMalayBankFormatHLBConnectFirst.dll', 'InvokeSalaryFormatter', 0);
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'CP39' and FormatName = 'HLB (ConnectFirst)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('CP39', 'HLB (ConnectFirst)', 'RMalayBankFormatHLBConnectFirst.dll', 'InvokeCP39Formatter', 0);
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EPF' and FormatName = 'HLB (ConnectFirst)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EPF', 'HLB (ConnectFirst)', 'RMalayBankFormatHLBConnectFirst.dll', 'InvokeEPFFormatter', 0);
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'HLB (ConnectFirst)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('SOCSO', 'HLB (ConnectFirst)', 'RMalayBankFormatHLBConnectFirst.dll', 'InvokeSOCSOFormatter', 0);
end if;

commit work;