if not exists(select * from CPFPolicy where CPFPolicyId = 'EPFYr2012Jan') then
	Insert into CPFPolicy Values('EPFYr2012Jan',1,'13% Employer,11% Employee');
	Update SubRegistry Set ShortStringAttr='EPFYr2012Jan' Where RegistryId='PaySetupData' and SubRegistryId='EPFProgPolicyId';
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP12ST') then
Insert into CPFTableCode Values('EP12ST','Local','EPFMandatory','Malaysian Standard Rate - Employer 13% and Employee 11%',0,0,0);
	Insert into CPFPolicyMember Values('EPFYr2012Jan','EP12ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP12PR') then
	Insert into CPFTableCode Values('EP12PR','PR','EPFMandatory','PR Standard Rate - Employer 13% and Employee 11%',0,0,0);
	Insert into CPFPolicyMember Values('EPFYr2012Jan','EP12PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP12EX') then
	Insert into CPFTableCode Values('EP12EX','FW','EPFMandatory','Foreign Workers and Expatriates Rate - Employer RM5 and Employee 8% ',0,0,0);
	Insert into CPFPolicyMember Values('EPFYr2012Jan','EP12EX');
end if;


if not exists(select * from Formula where Locate(FormulaId,'EP12ST') = 1 and FormulaCategory='EPFFormula') then

	Insert into Formula Values('EP12STA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP12STA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA55$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP12STA55$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA55$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP12STA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA55$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP12STA55$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA55$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

	Insert into Formula Values('EP12STA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA55$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA55$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA55$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12STA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA55$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA55$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12STA55$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

	Insert into FormulaRange Values('EP12STA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

	Insert into FormulaRange Values('EP12STA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12STA55$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

	Insert Into  CPFTableComponent Values('EP12ST',0,0,'EP12STA0$0EEM','EP12STA0$0ERM',10,55,'EP12STA0$0EEV','EP12STA0$0ERV');
	Insert Into  CPFTableComponent Values('EP12ST',10,0,'EP12STA0$10EEM','EP12STA0$10ERM',5000,55,'EP12STA0$10EEV','EP12STA0$10ERV');
	Insert Into  CPFTableComponent Values('EP12ST',5000,0,'EP12STA0$5000EEM','EP12STA0$5000ERM',9999999,55,'EP12STA0$5000EEV','EP12STA0$5000ERV');
	Insert Into  CPFTableComponent Values('EP12ST',0,55,'EP12STA55$0EEM','EP12STA55$0ERM',10,99,'EP12STA55$0EEV','EP12STA55$0ERV');
	Insert Into  CPFTableComponent Values('EP12ST',10,55,'EP12STA55$10EEM','EP12STA55$10ERM',5000,99,'EP12STA55$10EEV','EP12STA55$10ERV');
	Insert Into  CPFTableComponent Values('EP12ST',5000,55,'EP12STA55$5000EEM','EP12STA55$5000ERM',9999999,99,'EP12STA55$5000EEV','EP12STA55$5000ERV');

end if;

if not exists(select * from Formula where Locate(FormulaId,'EP12PR') = 1 and FormulaCategory='EPFFormula') then

	Insert into Formula Values('EP12PRA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP12PRA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA55$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP12PRA55$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA55$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP12PRA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA55$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP12PRA55$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA55$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	
	Insert into Formula Values('EP12PRA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA55$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA55$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA55$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12PRA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA55$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA55$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12PRA55$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

	Insert into FormulaRange Values('EP12PRA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

	Insert into FormulaRange Values('EP12PRA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12PRA55$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


	Insert Into  CPFTableComponent Values('EP12PR',0,0,'EP12PRA0$0EEM','EP12PRA0$0ERM',10,55,'EP12PRA0$0EEV','EP12PRA0$0ERV');
	Insert Into  CPFTableComponent Values('EP12PR',10,0,'EP12PRA0$10EEM','EP12PRA0$10ERM',5000,55,'EP12PRA0$10EEV','EP12PRA0$10ERV');
	Insert Into  CPFTableComponent Values('EP12PR',5000,0,'EP12PRA0$5000EEM','EP12PRA0$5000ERM',9999999,55,'EP12PRA0$5000EEV','EP12PRA0$5000ERV');
	Insert Into  CPFTableComponent Values('EP12PR',0,55,'EP12PRA55$0EEM','EP12PRA55$0ERM',10,99,'EP12PRA55$0EEV','EP12PRA55$0ERV');
	Insert Into  CPFTableComponent Values('EP12PR',10,55,'EP12PRA55$10EEM','EP12PRA55$10ERM',5000,99,'EP12PRA55$10EEV','EP12PRA55$10ERV');
	Insert Into  CPFTableComponent Values('EP12PR',5000,55,'EP12PRA55$5000EEM','EP12PRA55$5000ERM',9999999,99,'EP12PRA55$5000EEV','EP12PRA55$5000ERV');

end if;

if not exists(select * from Formula where Locate(FormulaId,'EP12EX') = 1 and FormulaCategory='EPFFormula') then

	Insert into Formula Values('EP12EXA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP12EXA0$0EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP12EXA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP12EXA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	
	Insert into FormulaRange Values('EP12EXA0$0ERM',1,0,0,'C1;',5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12EXA0$0EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000,@TRUNC(K1),@RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12EXA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP12EXA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

	Insert Into  CPFTableComponent Values('EP12EX',0,0,'EP12EXA0$0EEM','EP12EXA0$0ERM',9999999,99,'EP12EXA0$0EEV','EP12EXA0$0ERV');

end if;




If exists (select 1 from sys.sysprocedure where proc_name = 'PatchInsertEPFProgression') then
   Drop procedure PatchInsertEPFProgression
end if;


create procedure DBA.PatchInsertEPFProgression(in In_EffectiveDate date,in In_EPFProgPolicyId char(20))
begin
  declare Out_EPFEffectiveDate date;
  declare Out_EPFCareerId char(20);
  declare Out_EPFProgSchemeId char(20); 
  declare Out_EPFEEVolPercent double; 
  declare Out_EPFERVolPercent double; 
  declare Out_EPFEEVolAmt double; 
  declare Out_EPFERVolAmt double; 

  /*  Get Employee that have payment */
  EmployeeLoop: for EmployeeFor as curs dynamic scroll cursor for
    select EmployeeSysId as Out_EmployeeSysId,
      LastPayDate as Out_LastPayDate from
      PayEmployee where
      (LastPayDate = '1899-12-30' or LastPayDate >= In_EffectiveDate) do
    /*  Record not inserted yet */
    if not exists(select* from EPFProgression where EPFEffectiveDate = In_EffectiveDate and EmployeeSysID = Out_EmployeeSysId) then
      /* Get the nearest CPF Progression Record */ 
      set Out_EPFEffectiveDate = null;
      select first EPFEffectiveDate,
        EPFCareerId,
        EPFProgSchemeId,
        EPFEEVolPercent,
        EPFERVolPercent,
        EPFEEVolAmt,
        EPFERVolAmt
        into Out_EPFEffectiveDate,
        Out_EPFCareerId,
        Out_EPFProgSchemeId,
        Out_EPFEEVolPercent,
        Out_EPFERVolPercent,
        Out_EPFEEVolAmt,
        Out_EPFERVolAmt
        from EPFProgression where
        EmployeeSysID = Out_EmployeeSysId and
        EPFEffectiveDate < In_EffectiveDate and
        EPFProgPolicyId <> '' and
        EPFProgSchemeId <> '' order by
        EPFEffectiveDate desc;
      /* Nearest CPF Progression Record is found */
      if(Out_EPFEffectiveDate is not null) then
        call InsertNewEPFProgression(
        Out_EmployeeSysId,
        In_EffectiveDate,
        Out_EPFCareerId,
        In_EPFProgPolicyId,
        Out_EPFProgSchemeId,
        Out_EPFEEVolPercent,
        Out_EPFERVolPercent,
        Out_EPFEEVolAmt,
        Out_EPFERVolAmt,'',0)
      end if
    end if end for
end;

call PatchInsertEPFProgression('2012-01-01','EPFYr2012Jan');
Drop procedure PatchInsertEPFProgression;

Commit work;


