if not exists(select * from CPFPolicy where CPFPolicyId = 'EPFYr2019Jan') then
	Insert into CPFPolicy Values('EPFYr2019Jan',1,'13% Employer,11% Employee');
	Update SubRegistry Set ShortStringAttr = 'EPFYr2019Jan' Where RegistryId = 'PaySetupData' and SubRegistryId = 'EPFProgPolicyId';

	/* Insert EPF Table for EP19ST */
	if not exists(select * from CPFTableCode where CPFTableCodeId = 'EP19ST') then
		Insert into CPFTableCode Values('EP19ST','Local','EPFMandatory','Malaysian Standard Rate - Employer 13% and Employee 11%',0,0,0);
		Insert into CPFPolicyMember Values('EPFYr2019Jan','EP19ST');
	end if;

	/* Insert EPF Table for EP19PR */
	if not exists(select * from CPFTableCode where CPFTableCodeId = 'EP19PR') then
		Insert into CPFTableCode Values('EP19PR','PR','EPFMandatory','PR Standard Rate - Employer 13% and Employee 11%',0,0,0);
		Insert into CPFPolicyMember Values('EPFYr2019Jan','EP19PR');
	end if;

	/* Insert EPF Table for EP19EX */
	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EP19EX') then
		Insert into CPFTableCode Values('EP19EX','FW','EPFMandatory','Foreign Workers and Expatriates Rate - Employer RM5 and Employee 11% ',0,0,0);
		Insert into CPFPolicyMember Values('EPFYr2019Jan','EP19EX');
	end if;

	/*========== Create Formula for EP19ST ===========*/
	if not exists(select * from Formula where Locate(FormulaId,'EP19ST') = 1 and FormulaCategory = 'EPFFormula') then

		/* Insert Formula ER Mandatory */
		Insert into Formula Values('EP19STA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19STA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19STA60$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA60$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');

		/* Insert Formula EE Mandatory */
		Insert into Formula Values('EP19STA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19STA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19STA60$10EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19STA60$5000EEM',1,0,0,'EPFFormula','EE','T4','','','','','');

		/* Insert Formula ER Voluntary */
		Insert into Formula Values('EP19STA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19STA60$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

		/* Insert Formula EE Voluntary */
		Insert into Formula Values('EP19STA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19STA60$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

		/* Insert FormulaRange ER Mandatory */
		Insert into FormulaRange Values('EP19STA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',4,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',4,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange EE Mandatory */
		Insert into FormulaRange Values('EP19STA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$10EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$5000EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange ER Voluntary */
		Insert into FormulaRange Values('EP19STA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange EE Voluntary */
		Insert into FormulaRange Values('EP19STA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19STA60$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert EPF Table Component */
		Insert Into CPFTableComponent Values('EP19ST',0,0,'EP19STA0$0EEM','EP19STA0$0ERM',10,60,'EP19STA0$0EEV','EP19STA0$0ERV');
		Insert Into CPFTableComponent Values('EP19ST',10,0,'EP19STA0$10EEM','EP19STA0$10ERM',5000,60,'EP19STA0$10EEV','EP19STA0$10ERV');
		Insert Into CPFTableComponent Values('EP19ST',5000,0,'EP19STA0$5000EEM','EP19STA0$5000ERM',9999999,60,'EP19STA0$5000EEV','EP19STA0$5000ERV');
		Insert Into CPFTableComponent Values('EP19ST',0,60,'EP19STA60$0EEM','EP19STA60$0ERM',10,75,'EP19STA60$0EEV','EP19STA60$0ERV');
		Insert Into CPFTableComponent Values('EP19ST',10,60,'EP19STA60$10EEM','EP19STA60$10ERM',5000,75,'EP19STA60$10EEV','EP19STA60$10ERV');
		Insert Into CPFTableComponent Values('EP19ST',5000,60,'EP19STA60$5000EEM','EP19STA60$5000ERM',9999999,75,'EP19STA60$5000EEV','EP19STA60$5000ERV');

	end if;

	/*========== Create Formula for EP19PR ===========*/
	if not exists(select * from Formula where Locate(FormulaId,'EP19PR') = 1 and FormulaCategory = 'EPFFormula') then

		/* Insert Formula ER Mandatory */
		Insert into Formula Values('EP19PRA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19PRA0$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA0$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19PRA60$10ERM',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA60$5000ERM',1,0,0,'EPFFormula','ER','T1','','','','','');

		/* Insert Formula EE Mandatory */
		Insert into Formula Values('EP19PRA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19PRA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA0$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19PRA60$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA60$5000EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

		/* Insert Formula ER Voluntary */
		Insert into Formula Values('EP19PRA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA0$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19PRA60$5000ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

		/* Insert Formula EE Voluntary */
		Insert into Formula Values('EP19PRA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA0$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19PRA60$5000EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

		/* Insert FormulaRange ER Mandatory */
		Insert into FormulaRange Values('EP19PRA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',13,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',12,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$10ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$5000ERM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @IF(K5>5000,@RNDNEAR(K1,100),K1) ),@RNDNEAR(K1,20)));',6,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange EE Mandatory */
		Insert into FormulaRange Values('EP19PRA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$5000EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange ER Voluntary */
		Insert into FormulaRange Values('EP19PRA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$5000ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange EE Voluntary */
		Insert into FormulaRange Values('EP19PRA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA0$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19PRA60$5000EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert EPF Table Component */
		Insert Into CPFTableComponent Values('EP19PR',0,0,'EP19PRA0$0EEM','EP19PRA0$0ERM',10,60,'EP19PRA0$0EEV','EP19PRA0$0ERV');
		Insert Into CPFTableComponent Values('EP19PR',10,0,'EP19PRA0$10EEM','EP19PRA0$10ERM',5000,60,'EP19PRA0$10EEV','EP19PRA0$10ERV');
		Insert Into CPFTableComponent Values('EP19PR',5000,0,'EP19PRA0$5000EEM','EP19PRA0$5000ERM',9999999,60,'EP19PRA0$5000EEV','EP19PRA0$5000ERV');
		Insert Into CPFTableComponent Values('EP19PR',0,60,'EP19PRA60$0EEM','EP19PRA60$0ERM',10,75,'EP19PRA60$0EEV','EP19PRA60$0ERV');
		Insert Into CPFTableComponent Values('EP19PR',10,60,'EP19PRA60$10EEM','EP19PRA60$10ERM',5000,75,'EP19PRA60$10EEV','EP19PRA60$10ERV');
		Insert Into CPFTableComponent Values('EP19PR',5000,60,'EP19PRA60$5000EEM','EP19PRA60$5000ERM',9999999,75,'EP19PRA60$5000EEV','EP19PRA60$5000ERV');

	end if;

	/*========== Create Formula for EP19EX ===========*/
	if not exists(select * from Formula where Locate(FormulaId,'EP19EX') = 1 and FormulaCategory = 'EPFFormula') then

		/* Insert Formula ER Mandatory */
		Insert into Formula Values('EP19EXA0$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19EXA0$10ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19EXA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
		Insert into Formula Values('EP19EXA60$10ERM',1,0,0,'EPFFormula','ER','T4','','','','','');

		/* Insert Formula EE Mandatory */
		Insert into Formula Values('EP19EXA0$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19EXA0$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19EXA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
		Insert into Formula Values('EP19EXA60$10EEM',1,0,0,'EPFFormula','EE','T1','','','','','');

		/* Insert Formula ER Voluntary */
		Insert into Formula Values('EP19EXA0$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19EXA0$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19EXA60$0ERV',1,0,0,'EPFFormula','ER','T1','','','','','');
		Insert into Formula Values('EP19EXA60$10ERV',1,0,0,'EPFFormula','ER','T1','','','','','');

		/* Insert Formula EE Voluntary */
		Insert into Formula Values('EP19EXA0$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19EXA0$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19EXA60$0EEV',1,0,0,'EPFFormula','EE','T1','','','','','');
		Insert into Formula Values('EP19EXA60$10EEV',1,0,0,'EPFFormula','EE','T1','','','','','');

		/* Insert FormulaRange ER Mandatory */
		Insert into FormulaRange Values('EP19EXA0$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA0$10ERM',1,0,0,'C1;',5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$0ERM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$10ERM',1,0,0,'C1;',5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange EE Mandatory */
		Insert into FormulaRange Values('EP19EXA0$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA0$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',11,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$0EEM',1,0,0,'C1;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$10EEM',1,0,0,'@CEILING((C1/100)*@IF(K1>5000,@IF(K1>20000, (K1) , @RNDNEAR(K1,100)),@RNDNEAR(K1,20)));',5.5,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','CEILING','RNDNEAR','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange ER Voluntary */
		Insert into FormulaRange Values('EP19EXA0$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA0$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$0ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$10ERV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert FormulaRange EE Voluntary */
		Insert into FormulaRange Values('EP19EXA0$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA0$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$0EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('EP19EXA60$10EEV',1,0,0,'0;',0,0,0,0,0,'MandatoryWage','VolEPF','VoluntaryWage','VolEPFAmt','NonBonusWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		/* Insert EPF Table Component */
		Insert Into CPFTableComponent Values('EP19EX',0,0,'EP19EXA0$0EEM','EP19EXA0$0ERM',10,60,'EP19EXA0$0EEV','EP19EXA0$0ERV');
		Insert Into CPFTableComponent Values('EP19EX',10,0,'EP19EXA0$10EEM','EP19EXA0$10ERM',9999999,60,'EP19EXA0$10EEV','EP19EXA0$10ERV');
		Insert Into CPFTableComponent Values('EP19EX',0,60,'EP19EXA60$0EEM','EP19EXA60$0ERM',10,75,'EP19EXA60$0EEV','EP19EXA60$0ERV');
		Insert Into CPFTableComponent Values('EP19EX',10,60,'EP19EXA60$10EEM','EP19EXA60$10ERM',9999999,75,'EP19EXA60$10EEV','EP19EXA60$10ERV');

	end if;

	/* Update FormulaType, Formula, UserDef1 and UserDef2 based on formula of previous year if formula type is T1, T2 or T3. */
	if exists(select * from SubRegistry where RegistryId = 'PaySetupData' and SubRegistryId = 'EPFProgSchemeId' and ShortStringAttr = 'EPFManVol') then
		update CPFTableCode set CPFSchemeId = 'EPFManVol' from (
			select replace(CPFTableCodeId, '18', '19') as EPFTableCodeId from CPFTableCode
			where CPFTableCodeId in ('EP18ST', 'EP18PR', 'EP18EX') and CPFSchemeId = 'EPFManVol') a
		where CPFTableCodeId = a.EPFTableCodeId;
		update Formula set FormulaType = a.FType from (
			select replace(f.FormulaId, '18', '19') as FId, f.FormulaType as FType from Formula f
			join CPFTableComponent ctc on f.FormulaId in (ctc.EEOrdCPFFormula, ctc.EROrdCPFFormula, ctc.EEAddCPFFormula, ctc.ERAddCPFFormula)
			join CPFTableCode cc on ctc.CPFTableCodeId = cc.CPFTableCodeId
			where cc.CPFTableCodeId in ('EP18ST', 'EP18PR', 'EP18EX') and cc.CPFSchemeId = 'EPFManVol' and f.FormulaType not in ('T4', 'Adv') and f.FormulaId like 'EP18%A%$%E%') a
		where FormulaId = a.FId and FormulaType not in ('T4', 'Adv');
		update FormulaRange set Formula = a.Fm, UserDef1 = a.UDef1, UserDef2 = a.UDef2 from (
			select replace(fr.FormulaId, '18', '19') as FId, fr.Formula as Fm, fr.UserDef1 as UDef1, fr.UserDef2 as UDef2
			from FormulaRange fr join Formula f on fr.FormulaId = f.FormulaId
			join CPFTableComponent ctc on f.FormulaId in (ctc.EEOrdCPFFormula, ctc.EROrdCPFFormula, ctc.EEAddCPFFormula, ctc.ERAddCPFFormula)
			join CPFTableCode cc on ctc.CPFTableCodeId = cc.CPFTableCodeId
			where cc.CPFTableCodeId in ('EP18ST', 'EP18PR', 'EP18EX') and cc.CPFSchemeId = 'EPFManVol' and f.FormulaType not in ('T4', 'Adv') and fr.FormulaId like 'EP18%A%$%E%') a
		where FormulaId = a.FId and (select FormulaType from Formula where FormulaId = a.FId) not in ('T4', 'Adv');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		EPF Progression
	-----------------------------------------------------------------------------------------------------------*/
	update EPFProgression set EPFProgPolicyId = 'EPFYr2019Jan' where EPFEffectiveDate >= '2019-01-01' and EPFProgPolicyId = 'EPFYr2018Jan' and EPFProgSchemeId <> '';

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
		'2019-01-01',
		'',
		'EPFYr2019Jan',
		EP1.EPFProgSchemeId,
		EP1.EPFEEVolPercent,
		EP1.EPFERVolPercent,
		EP1.EPFEEVolAmt,
		EP1.EPFERVolAmt,
		'',
		0
	from EPFProgression EP1
	join PayEmployee PE on EP1.EmployeeSysId = PE.EmployeeSysId
	left join EPFProgression EP2 on EP1.EmployeeSysId = EP2.EmployeeSysId and EP2.EPFEffectiveDate >= '2019-01-01'
	where EP1.EPFEffectiveDate < '2019-01-01' and EP1.EPFProgCurrent = 1 and
		EP1.EPFProgPolicyId <> '' and EP1.EPFProgSchemeId <> '' and EP2.EmployeeSysId is null
		and (PE.LastPayDate = '1899-12-30' or PE.LastPayDate >= '2019-01-01');
end if;

commit work;