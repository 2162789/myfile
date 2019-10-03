IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'Salary' AND FormatName = 'RSB' )
   THEN 
     INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
     Values ('Salary','RSB','RMalayBankFormatRSB.dll','InvokeSalaryFormatter')
END IF ;

COMMIT WORK;