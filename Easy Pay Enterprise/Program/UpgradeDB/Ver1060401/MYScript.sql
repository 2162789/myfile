if not exists(Select * from BankSubmitFormat Where  BankSubmitSubmitForId='Salary' and FormatName='AM Bank (E-AM Pay Day)' ) then 

Insert Into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1)
Values ('Salary','AM Bank (E-AM Pay Day)','RMalayBankFormatAMBankEAMPayDay.dll','InvokeSalaryFormatter',0)

end if;

Commit work;