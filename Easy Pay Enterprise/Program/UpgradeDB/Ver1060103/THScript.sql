if not exists (Select * from BankSubmitFormat Where FormatName='HSBC(Autopay)' and DllName='RThaiBankFormatHSBC.dll') then
   Insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
   Values('Salary','HSBC(Autopay)','RThaiBankFormatHSBC.dll','InvokeSalaryFormatter')
end if;

Commit work;