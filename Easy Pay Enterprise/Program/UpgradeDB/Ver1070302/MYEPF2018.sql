// Insert EPF Policy
if not exists(select * from CPFPolicy where CPFPolicyId = 'EPFYr2018Jan') then
	Insert into CPFPolicy Values('EPFYr2018Jan',1,'13% Employer,11% Employee');
	Update SubRegistry Set ShortStringAttr = 'EPFYr2018Jan' Where RegistryId = 'PaySetupData' and SubRegistryId = 'EPFProgPolicyId';
	
	// Insert EPF Table for EP18ST
	if not exists(select * from CPFTableCode where CPFTableCodeId = 'EP18ST') then
		Insert into CPFTableCode Values('EP18ST','Local','EPFMandatory','Malaysian Standard Rate - Employer 13% and Employee 11%',0,0,0);
		Insert into CPFPolicyMember Values('EPFYr2018Jan','EP18ST');
	end if;

	// Insert EPF Table for EP18PR
	if not exists(select * from CPFTableCode where CPFTableCodeId = 'EP18PR') then
		Insert into CPFTableCode Values('EP18PR','PR','EPFMandatory','PR Standard Rate - Employer 13% and Employee 11%',0,0,0);
		Insert into CPFPolicyMember Values('EPFYr2018Jan','EP18PR');
	end if;

	// Insert EPF Table for EP18EX
	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP18EX') then
		Insert into CPFTableCode Values('EP18EX','FW','EPFMandatory','Foreign Workers and Expatriates Rate - Employer RM5 and Employee 11% ',0,0,0);
		Insert into CPFPolicyMember Values('EPFYr2018Jan','EP18EX');
	end if;


	//========== Create Formula for EP18ST ===========
	if not exists(select * from Formula where Locate(FormulaId,'EP18ST') = 1 and FormulaCategory = 'EPFFormula') then

		// Insert Formula ER Mandatory
		Insert into Formula Values('EP18STA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP18STA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP18STA60$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA60$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');

		// Insert Formula EE Mandatory
		Insert into Formula Values('EP18STA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP18STA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP18STA60$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA60$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

		// Insert Formula ER Voluntary
		Insert into Formula Values('EP18STA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18STA60$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

		// Insert Formula EE Voluntary
		Insert into Formula Values('EP18STA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18STA60$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

		// Insert FormulaRange ER Mandatory
		Insert into FormulaRange Values('EP18STA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert FormulaRange EE Mandatory
		Insert into FormulaRange Values('EP18STA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert FormulaRange ER Voluntary
		Insert into FormulaRange Values('EP18STA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert FormulaRange EE Voluntary
		Insert into FormulaRange Values('EP18STA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18STA60$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert EPF Table Component
		Insert Into CPFTableComponent Values('EP18ST',0,0,'EP18STA0$0EEM','EP18STA0$0ERM',10,60,'EP18STA0$0EEV','EP18STA0$0ERV');
		Insert Into CPFTableComponent Values('EP18ST',10,0,'EP18STA0$10EEM','EP18STA0$10ERM',5000,60,'EP18STA0$10EEV','EP18STA0$10ERV');
		Insert Into CPFTableComponent Values('EP18ST',5000,0,'EP18STA0$5000EEM','EP18STA0$5000ERM',9999999,60,'EP18STA0$5000EEV','EP18STA0$5000ERV');
		Insert Into CPFTableComponent Values('EP18ST',0,60,'EP18STA60$0EEM','EP18STA60$0ERM',10,75,'EP18STA60$0EEV','EP18STA60$0ERV');
		Insert Into CPFTableComponent Values('EP18ST',10,60,'EP18STA60$10EEM','EP18STA60$10ERM',5000,75,'EP18STA60$10EEV','EP18STA60$10ERV');
		Insert Into CPFTableComponent Values('EP18ST',5000,60,'EP18STA60$5000EEM','EP18STA60$5000ERM',9999999,75,'EP18STA60$5000EEV','EP18STA60$5000ERV');

	end if;


	//========== Create Formula for EP18PR ===========
	if not exists(select * from Formula where Locate(FormulaId,'EP18PR') = 1 and FormulaCategory = 'EPFFormula') then

		// Insert Formula ER Mandatory
		Insert into Formula Values('EP18PRA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP18PRA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP18PRA60$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA60$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');

		// Insert Formula EE Mandatory
		Insert into Formula Values('EP18PRA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP18PRA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP18PRA60$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA60$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

		// Insert Formula ER Voluntary
		Insert into Formula Values('EP18PRA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18PRA60$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

		// Insert Formula EE Voluntary
		Insert into Formula Values('EP18PRA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18PRA60$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

		// Insert FormulaRange ER Mandatory
		Insert into FormulaRange Values('EP18PRA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert FormulaRange EE Mandatory
		Insert into FormulaRange Values('EP18PRA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert FormulaRange ER Voluntary
		Insert into FormulaRange Values('EP18PRA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert FormulaRange EE Voluntary
		Insert into FormulaRange Values('EP18PRA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18PRA60$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert EPF Table Component
		Insert Into  CPFTableComponent Values('EP18PR',0,0,'EP18PRA0$0EEM','EP18PRA0$0ERM',10,60,'EP18PRA0$0EEV','EP18PRA0$0ERV');
		Insert Into  CPFTableComponent Values('EP18PR',10,0,'EP18PRA0$10EEM','EP18PRA0$10ERM',5000,60,'EP18PRA0$10EEV','EP18PRA0$10ERV');
		Insert Into  CPFTableComponent Values('EP18PR',5000,0,'EP18PRA0$5000EEM','EP18PRA0$5000ERM',9999999,60,'EP18PRA0$5000EEV','EP18PRA0$5000ERV');
		Insert Into  CPFTableComponent Values('EP18PR',0,60,'EP18PRA60$0EEM','EP18PRA60$0ERM',10,75,'EP18PRA60$0EEV','EP18PRA60$0ERV');
		Insert Into  CPFTableComponent Values('EP18PR',10,60,'EP18PRA60$10EEM','EP18PRA60$10ERM',5000,75,'EP18PRA60$10EEV','EP18PRA60$10ERV');
		Insert Into  CPFTableComponent Values('EP18PR',5000,60,'EP18PRA60$5000EEM','EP18PRA60$5000ERM',9999999,75,'EP18PRA60$5000EEV','EP18PRA60$5000ERV');

	end if;


	//========== Create Formula for EP18EX ===========
	if not exists(select * from Formula where Locate(FormulaId,'EP18EX') = 1 and FormulaCategory = 'EPFFormula') then

		// Insert Formula
		Insert into Formula Values('EP18EXA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP18EXA0$0EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP18EXA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP18EXA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

		// Insert FormulaRange
		Insert into FormulaRange Values('EP18EXA0$0ERM',1,0,0,'C1;',5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18EXA0$0EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18EXA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP18EXA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		// Insert EPF Table Component
		Insert Into CPFTableComponent Values('EP18EX',0,0,'EP18EXA0$0EEM','EP18EXA0$0ERM',9999999,75,'EP18EXA0$0EEV','EP18EXA0$0ERV');

	end if;

	/*-----------------------------------------------------------------------------------------------------------
		EPF Progression
	-----------------------------------------------------------------------------------------------------------*/
	insert into EPFProgression(EmployeeSysId,
		EPFEffectiveDate,
		EPFCareerId,
		EPFProgPolicyId,
		EPFProgSchemeId,
		EPFEEVolPercent,
		EPFERVolPercent,
		EPFEEVolAmt,
		EPFERVolAmt,
		EPFProgRemarks,
		EPFProgCurrent)
	select EP1.EmployeeSysId,
		'2018-01-01',
		'',
		'EPFYr2018Jan',
		EP1.EPFProgSchemeId,
		EP1.EPFEEVolPercent,
		EP1.EPFERVolPercent,
		EP1.EPFEEVolAmt,
		EP1.EPFERVolAmt,
		'',
		0
	from EPFProgression EP1
	join PayEmployee PE on EP1.EmployeeSysId = PE.EmployeeSysId
	left join EPFProgression EP2 on EP1.EmployeeSysId = EP2.EmployeeSysId and EP2.EPFEffectiveDate >= '2018-01-01'
	where EP1.EPFEffectiveDate < '2018-01-01' and EP1.EPFProgCurrent = 1 and
		EP1.EPFProgPolicyId <> '' and EP1.EPFProgSchemeId <> '' and EP2.EmployeeSysId is null
		and (PE.LastPayDate = '1899-12-30' or PE.LastPayDate >= '2018-01-01');
	
end if;



Commit work;