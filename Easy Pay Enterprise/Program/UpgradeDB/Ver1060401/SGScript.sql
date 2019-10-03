if not exists(Select * from BankSubmitFormat Where BankSubmitSubmitForId='Salary' and FormatName='Standard Chartered (S2B Lite)' ) then 

Insert Into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1)
Values ('Salary','Standard Chartered (S2B Lite)','RSingBankFormatStandardCharteredS2B.dll','InvokeSalaryFormatter',0)

end if ;

commit work;