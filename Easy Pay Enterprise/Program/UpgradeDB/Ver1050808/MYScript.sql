IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'CP39' AND FormatName = 'EON Bank' )
   THEN 
     INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
     Values ('CP39','EON Bank','RMalayBankFormatEON.dll','InvokeCP39Formatter')
END IF; 

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'EPF' AND FormatName = 'EON Bank' )
   THEN 
     INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
     Values ('EPF','EON Bank','RMalayBankFormatEON.dll','InvokeEPFFormatter')
END IF; 

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'Salary' AND FormatName = 'EON Bank (Online)')
   THEN 
     INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
     Values ('Salary','EON Bank (Online)','RMalayBankFormatEON.dll','InvokeSalaryFormatter')
END IF; 

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'SOCSO' AND  FormatName = 'EON Bank' )
   THEN 
     INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
     Values ('SOCSO','EON Bank','RMalayBankFormatEON.dll','InvokeSOCSOFormatter')
END IF;
 
commit work;
