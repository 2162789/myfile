if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='SALARY' and formatname='BOT Mitsubishi') Then
   insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('Salary','BOT Mitsubishi','RMalayBankFormatBOTMitsubishi.dll','InvokeSalaryFormatter',0);
end if;



UPDATE FormulaRange SET Formula='@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));' WHERE FormulaId IN
(
SELECT FormulaId FROM Formula WHERE FormulaID IN 
('EP13STA0$10EEM',
'EP13STA0$5000EEM',
'EP13STA60$10EEM',
'EP13STA60$5000EEM',
'EP13PRA0$10EEM',
'EP13PRA0$5000EEM',
'EP13PRA60$10EEM',
'EP13PRA60$5000EEM',
'EP13EXA0$0EEM') AND FormulaType IN ('T1','T3')
);


UPDATE FormulaRange SET Formula='@CEILING(((C1+K2)/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20))+K4);' WHERE FormulaId IN
(
SELECT FormulaId FROM Formula WHERE FormulaID IN 
('EP13STA0$10EEM',
'EP13STA0$5000EEM',
'EP13STA60$10EEM',
'EP13STA60$5000EEM',
'EP13PRA0$10EEM',
'EP13PRA0$5000EEM',
'EP13PRA60$10EEM',
'EP13PRA60$5000EEM',
'EP13EXA0$0EEM') AND FormulaType IN ('T2')
);

commit work;

