if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'RBS (SPP G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'RBS (SPP G3)', 'RSingBankFormatRBSSPPG3.dll', 'InvokeSalaryFormatter', 0)
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Mizuho (Giro G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Mizuho (Giro G3)', 'RSingBankFormatMizuhoGiroG3.dll', 'InvokeSalaryFormatter', 0)
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Sumitomo (SMBC G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Sumitomo (SMBC G3)', 'RSingBankFormatSumitomoSMBCG3.dll', 'InvokeSalaryFormatter', 0)
end if;

If Not Exists(select * from SYSTEMRPTCOMP where SYSRPTID='Payslip - Laser' and SYSRPTCOMPNAME='ShowRemark_CheckBox') Then
Insert Into SYSTEMRPTCOMP(SYSRPTID,SYSRPTCOMPNAME,SYSRPTCOMPDESC,SYSRPTCOMPTYPE,ISRPTKEY,RPTKEYINDEX)
Values('Payslip - Laser','ShowRemark_CheckBox','Show Pay Element Remark','int',0,NULL);
End if;

If Not Exists(select * from RptCompConfig where RPTCOMPSYSID='Sys_204') Then
Insert Into RptCompConfig(RPTCOMPSYSID,RPTCONFIGID,SYSRPTID,SYSRPTCOMPNAME)
Values('Sys_204','_Payslip - Laser','Payslip - Laser','ShowRemark_CheckBox');
End if;

If Not Exists(select * from RptCompItemConfig where RPTCOMPSYSID='Sys_204') Then
Insert Into RptCompItemConfig(RPTCOMPSYSID,RPTCOMPITEMSYSID,ITEMVALUE)
Values('Sys_204','1','0');
End if;



commit work;