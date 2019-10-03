if not exists (Select * from BankSubmitFormat Where FormatName='Alliance Online' and BankSubmitSubmitForId='CP39' and FormatterInvoke='InvokeOnlineCP39Formatter') then
  Insert Into BankSubmitFormat (BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1) 
  Values ('CP39','Alliance Online','RMalayBankFormatAllianceOnline.dll','InvokeOnlineCP39Formatter',0);
end if;

if not exists (Select * from BankSubmitFormat Where FormatName='Alliance Online' and BankSubmitSubmitForId='SOCSO' and FormatterInvoke='InvokeOnlineSOCSOFormatter') then
  Insert Into BankSubmitFormat (BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1) 
  Values ('SOCSO','Alliance Online','RMalayBankFormatAllianceOnline.dll','InvokeOnlineSOCSOFormatter',0)
end if;

if not exists (Select * from BankSubmitFormat Where FormatName='Alliance Online' and BankSubmitSubmitForId='EPF' and FormatterInvoke='InvokeEPFFormatter') then
  Insert Into BankSubmitFormat (BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1) 
  Values ('EPF','Alliance Online','RMalayBankFormatAlliance.dll','InvokeEPFFormatter',0)
end if;

commit work;