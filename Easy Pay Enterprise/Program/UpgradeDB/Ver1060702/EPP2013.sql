// Insert EPF Policy
if not exists(select * from CPFPolicy where CPFPolicyId = 'EPFYr2013Aug') then
	Insert into CPFPolicy Values('EPFYr2013Aug',1,'13% Employer,11% Employee');	
	Update SubRegistry Set ShortStringAttr='EPFYr2013Aug' Where RegistryId='PaySetupData' and SubRegistryId='EPFProgPolicyId';
end if;

// Insert EPF Table for EP13ST
if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP13ST') then
	Insert into CPFTableCode Values('EP13ST','Local','EPFMandatory','Malaysian Standard Rate - Employer 13% and Employee 11%',0,0,0);	
	Insert into CPFPolicyMember Values('EPFYr2013Aug','EP13ST');
end if;

// Insert EPF Table for EP13PR
if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP13PR') then
	Insert into CPFTableCode Values('EP13PR','PR','EPFMandatory','PR Standard Rate - Employer 13% and Employee 11%',0,0,0);	
	Insert into CPFPolicyMember Values('EPFYr2013Aug','EP13PR');
end if;

// Insert EPF Table for EP13EX
if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP13EX') then
	Insert into CPFTableCode Values('EP13EX','FW','EPFMandatory','Foreign Workers and Expatriates Rate - Employer RM5 and Employee 11% ',0,0,0);	
	Insert into CPFPolicyMember Values('EPFYr2013Aug','EP13EX');
end if;


//========== Create Formula for EP13ST ===========
if not exists(select * from Formula where Locate(FormulaId,'EP13ST') = 1 and FormulaCategory='EPFFormula') then
	// Insert Formula ER Mandatory
	Insert into Formula Values('EP13STA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP13STA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP13STA60$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA60$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');

	// Insert Formula EE Mandatory
	Insert into Formula Values('EP13STA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP13STA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP13STA60$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA60$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

	// Insert Formula ER Voluntary
	Insert into Formula Values('EP13STA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13STA60$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

	// Insert Formula EE Voluntary
	Insert into Formula Values('EP13STA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13STA60$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

	// Insert FormulaRange ER Mandatory
	Insert into FormulaRange Values('EP13STA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert FormulaRange EE Mandatory
	Insert into FormulaRange Values('EP13STA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert FormulaRange ER Voluntary
	Insert into FormulaRange Values('EP13STA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert FormulaRange EE Voluntary
	Insert into FormulaRange Values('EP13STA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13STA60$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert EPF Table Component
	Insert Into  CPFTableComponent Values('EP13ST',0,0,'EP13STA0$0EEM','EP13STA0$0ERM',10,60,'EP13STA0$0EEV','EP13STA0$0ERV');
	Insert Into  CPFTableComponent Values('EP13ST',10,0,'EP13STA0$10EEM','EP13STA0$10ERM',5000,60,'EP13STA0$10EEV','EP13STA0$10ERV');
	Insert Into  CPFTableComponent Values('EP13ST',5000,0,'EP13STA0$5000EEM','EP13STA0$5000ERM',9999999,60,'EP13STA0$5000EEV','EP13STA0$5000ERV');
	Insert Into  CPFTableComponent Values('EP13ST',0,60,'EP13STA60$0EEM','EP13STA60$0ERM',10,99,'EP13STA60$0EEV','EP13STA60$0ERV');
	Insert Into  CPFTableComponent Values('EP13ST',10,60,'EP13STA60$10EEM','EP13STA60$10ERM',5000,99,'EP13STA60$10EEV','EP13STA60$10ERV');
	Insert Into  CPFTableComponent Values('EP13ST',5000,60,'EP13STA60$5000EEM','EP13STA60$5000ERM',9999999,99,'EP13STA60$5000EEV','EP13STA60$5000ERV');
end if;


//========== Create Formula for EP13PR ===========
if not exists(select * from Formula where Locate(FormulaId,'EP13PR') = 1 and FormulaCategory='EPFFormula') then
	// Insert Formula ER Mandatory
	Insert into Formula Values('EP13PRA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP13PRA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP13PRA60$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA60$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');

	// Insert Formula EE Mandatory
	Insert into Formula Values('EP13PRA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP13PRA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	Insert into Formula Values('EP13PRA60$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA60$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

	// Insert Formula ER Voluntary
	Insert into Formula Values('EP13PRA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13PRA60$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

	// Insert Formula EE Voluntary
	Insert into Formula Values('EP13PRA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13PRA60$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');


	// Insert FormulaRange ER Mandatory
	Insert into FormulaRange Values('EP13PRA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert FormulaRange EE Mandatory
	Insert into FormulaRange Values('EP13PRA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert FormulaRange ER Voluntary
	Insert into FormulaRange Values('EP13PRA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert FormulaRange EE Voluntary
	Insert into FormulaRange Values('EP13PRA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13PRA60$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert EPF Table Component
	Insert Into  CPFTableComponent Values('EP13PR',0,0,'EP13PRA0$0EEM','EP13PRA0$0ERM',10,60,'EP13PRA0$0EEV','EP13PRA0$0ERV');
	Insert Into  CPFTableComponent Values('EP13PR',10,0,'EP13PRA0$10EEM','EP13PRA0$10ERM',5000,60,'EP13PRA0$10EEV','EP13PRA0$10ERV');
	Insert Into  CPFTableComponent Values('EP13PR',5000,0,'EP13PRA0$5000EEM','EP13PRA0$5000ERM',9999999,60,'EP13PRA0$5000EEV','EP13PRA0$5000ERV');
	Insert Into  CPFTableComponent Values('EP13PR',0,60,'EP13PRA60$0EEM','EP13PRA60$0ERM',10,99,'EP13PRA60$0EEV','EP13PRA60$0ERV');
	Insert Into  CPFTableComponent Values('EP13PR',10,60,'EP13PRA60$10EEM','EP13PRA60$10ERM',5000,99,'EP13PRA60$10EEV','EP13PRA60$10ERV');
	Insert Into  CPFTableComponent Values('EP13PR',5000,60,'EP13PRA60$5000EEM','EP13PRA60$5000ERM',9999999,99,'EP13PRA60$5000EEV','EP13PRA60$5000ERV');
end if;


//========== Create Formula for EP13EX ===========
if not exists(select * from Formula where Locate(FormulaId,'EP13EX') = 1 and FormulaCategory='EPFFormula') then
	// Insert Formula 
	Insert into Formula Values('EP13EXA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	Insert into Formula Values('EP13EXA0$0EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
	Insert into Formula Values('EP13EXA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
	Insert into Formula Values('EP13EXA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');


	// Insert FormulaRange
	Insert into FormulaRange Values('EP13EXA0$0ERM',1,0,0,'C1;',5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13EXA0$0EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13EXA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('EP13EXA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


	// Insert EPF Table Component
	Insert Into  CPFTableComponent Values('EP13EX',0,0,'EP13EXA0$0EEM','EP13EXA0$0ERM',9999999,99,'EP13EXA0$0EEV','EP13EXA0$0ERV');
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
      (LastPayDate = '1899-12-30' or LastPayDate >= In_EffectiveDate)
	AND EmployeeSysId In (select EmployeeSysId from EPFProgression where EPFProgPolicyId IN ('EPFYr2008Feb','EPFYr2012Jan'))
 do
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

call PatchInsertEPFProgression('2013-08-01','EPFYr2013Aug');
Drop procedure PatchInsertEPFProgression;

Commit work;                       