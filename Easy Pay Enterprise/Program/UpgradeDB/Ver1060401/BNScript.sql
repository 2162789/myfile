if not exists(Select * from BankSubmitFormat Where  BankSubmitSubmitForId='Salary' and FormatName='HSBC ACH' ) then 

Insert Into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1)
Values ('Salary','HSBC ACH','RBankFormatHSBCACH.dll','InvokeSalaryFormatter',0)

end if ;

Commit work;