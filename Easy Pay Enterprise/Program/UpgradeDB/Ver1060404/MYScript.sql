//EPF
if not exists (Select * from DBA.BankSubmitFormat Where BankSubmitSubmitForId = 'EPF' and FormatName = 'Citibank')
then
  Insert Into DBA.BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1)
  Values ('EPF','Citibank','RMalayBankFormatCitiBank.dll','InvokeEPFFormatter',0);
end if;

//SOCSO
if not exists (Select * from DBA.BankSubmitFormat Where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'Citibank')
then
  Insert Into DBA.BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1)
  Values ('SOCSO','Citibank','RMalayBankFormatCitiBank.dll','InvokeSOCSOFormatter',0);
end if;

//CP39
if not exists (Select * from DBA.BankSubmitFormat Where BankSubmitSubmitForId = 'CP39' and FormatName = 'Citibank')
then
  Insert Into DBA.BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,BooleanField1)
  Values ('CP39','Citibank','RMalayBankFormatCitiBank.dll','InvokeCP39Formatter',0);
end if;

commit work;