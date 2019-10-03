If not exists (Select * From BankSubmitFormat Where BankSubmitSubmitForId='Salary' And FormatName='AM E-AM Biz' And DllName='RMalayBankFormatAMBankEAMBiz.dll') then
  Insert BankSubmitFormat (BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
  Values ('Salary','AM E-AM Biz','RMalayBankFormatAMBankEAMBiz.dll','InvokeSalaryFormatter')
end if;

Commit Work;