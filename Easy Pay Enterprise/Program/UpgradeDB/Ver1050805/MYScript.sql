IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'SOCSO' AND FormatName = 'HLB Bank' )
   THEN 
     INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
     Values ('SOCSO','HLB Bank','RMalayBankFormatHongLeong.dll','InvokeSOCSOFormatter')
END IF;

COMMIT WORK;