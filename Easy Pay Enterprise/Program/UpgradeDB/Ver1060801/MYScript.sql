if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='EPF' and formatname='HSBC') Then
   insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('EPF','HSBC','RBankSubmitHSBCMY.dll','InvokeEPFFormatter',0);
end if;

if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='SOCSO' and formatname='HSBC') Then
   insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('SOCSO','HSBC','RBankSubmitHSBCMY.dll','InvokeSOCSOFormatter',0);
end if;

if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='ZAKAT' and formatname='HSBC') Then
   insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('ZAKAT','HSBC','RBankSubmitHSBCMY.dll','InvokeZAKATFormatter',0);
end if;
if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='CP39' and formatname='HSBC') Then
   insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('CP39','HSBC','RBankSubmitHSBCMY.dll','InvokeCP39Formatter',0);
end if;


Commit work;