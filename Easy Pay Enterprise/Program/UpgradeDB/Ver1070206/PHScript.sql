if not exists(select 1 from BankSubmit where BankSubmitSubmitForId='HDMF Loan') then
Insert into BankSubmit(BankSubmitSubmitForId,BankSubmitSubmitForDesc) Values('HDMF Loan','HDMF Loan');
end if;

if not exists(select 1 from BankSubmitFormat where BankSubmitSubmitForId='HDMF Loan' and FormatName='Security Bank') then
Insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised) Values('HDMF Loan','Security Bank','RPhilipBankFormatSecurityBank.dll','InvokeHDMFMCLFormatter',0);
end if;

commit work;