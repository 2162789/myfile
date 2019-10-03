/*-----------------------------------------------------------------------------------------------------------
	BPJS Pensiun rate with effective from 1 March 2019
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Pensiun2019Mar') then
		Insert into CPFPolicy Values('BPJS-Pensiun2019Mar',1,'2% Employer, 1% Employee wef 1 March 2019');

		if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-Pensiun0319ST') then
			Insert into CPFTableCode Values('BPJS-Pensiun0319ST','Local','BPJSPensiun','Local Citizen - Employer 2%, Employee 1% wef March 1, 2019',0,0,0);
			Insert into CPFPolicyMember Values('BPJS-Pensiun2019Mar','BPJS-Pensiun0319ST');
		end if;
		if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-Pensiun0319PR') then
			Insert into CPFTableCode Values('BPJS-Pensiun0319PR','PR','BPJSPensiun','Permanent Residence - Employer 2%, Employee 1% wef March 1, 2019',0,0,0);
			Insert into CPFPolicyMember Values('BPJS-Pensiun2019Mar','BPJS-Pensiun0319PR');
		end if;	 
		if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-Pensiun0319FW') then
			Insert into CPFTableCode Values('BPJS-Pensiun0319FW','FW','BPJSPensiun','Foreign Worker - Employer 2%, Employee 1% wef March 1, 2019',0,0,0);
      Insert into CPFPolicyMember Values('BPJS-Pensiun2019Mar','BPJS-Pensiun0319FW');
		end if;	 	
		 
		if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0319ST') = 1 and FormulaCategory='JamsoFormula') then
			Insert into Formula Values('BPJS-Pens0319ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
      Insert into Formula Values('BPJS-Pens0319ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
			Insert into FormulaRange Values('BPJS-Pens0319ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648036,8512400,36480,85124,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('BPJS-Pens0319ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3648036,8512400,72961,170248,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
			Insert Into CPFTableComponent Values('BPJS-Pensiun0319ST',0,0,'BPJS-Pens0319ST0$0EE','BPJS-Pens0319ST0$0ER',9999999999,56,'','');
		end if;
		
		if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0319PR') = 1 and FormulaCategory='JamsoFormula') then
			Insert into Formula Values('BPJS-Pens0319PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
			Insert into Formula Values('BPJS-Pens0319PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
			Insert into FormulaRange Values('BPJS-Pens0319PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648036,8512400,36480,85124,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
			Insert into FormulaRange Values('BPJS-Pens0319PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3648036,8512400,72961,170248,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
			Insert Into CPFTableComponent Values('BPJS-Pensiun0319PR',0,0,'BPJS-Pens0319PR0$0EE','BPJS-Pens0319PR0$0ER',9999999999,56,'','');
		end if;
		
		if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0319FW') = 1 and FormulaCategory='JamsoFormula') then
			Insert into Formula Values('BPJS-Pens0319FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
			Insert into Formula Values('BPJS-Pens0319FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
			Insert into FormulaRange Values('BPJS-Pens0319FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648036,8512400,36480,85124,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
			Insert into FormulaRange Values('BPJS-Pens0319FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3648036,8512400,72961,170248,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
			Insert Into CPFTableComponent Values('BPJS-Pensiun0319FW',0,0,'BPJS-Pens0319FW0$0EE','BPJS-Pens0319FW0$0ER',9999999999,56,'','');
		end if;

	/*-----------------------------------------------------------------------------------------------------------
	Statutory Government Setup
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2019-03-01' and CPFGovtSchemeId = 'BPJSPensiun') then
		 Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
		 Values('2019-03-01','BPJSPensiun','BPJS-Pensiun2019Mar',1,'');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		BPJS Pensiun Progression
	-----------------------------------------------------------------------------------------------------------*/
	/* Insert Progression if current progression's effective date is earlier than 2019-03-01, scheme is not blank */
	Insert into MandatoryContributeProg (EmployeeSysId, 
	MandContriCareerId, 
	MandContriEffDate,
	MandContriPolicyId,
	MandContriSchemeId,
	MandContriRemarks,
	MandContriCurrent,
	ManContriActSchemeId
	)
	Select CurProg.EmployeeSysId, 
	'',
	'2019-03-01', 
	'BPJS-Pensiun2019Mar',
	'BPJSPensiun',
	'',
	0,
	'BPJSPensiun'	
	From PayEmployee PE join MandatoryContributeProg CurProg
	On PE.EmployeeSysId = CurProg.EmployeeSysId
	Left Join MandatoryContributeProg NewProg ON CurProg.EmployeeSysId = NewProg.EmployeeSysId and CurProg.ManContriActSchemeId = NewProg.ManContriActSchemeId 
	     and NewProg.MandContriEffDate = '2019-03-01'
	Where CurProg.MandContriCurrent = 1 and CurProg.MandContriEffDate < '2019-03-01' and CurProg.ManContriActSchemeId = 'BPJSPensiun' and CurProg.MandContriSchemeId != ''
	And NewProg.EmployeeSysId is null
	And (PE.LastPayDate = '1899-12-30' Or PE.LastPayDate >= '2019-03-01');

	/* Update progression if progression’s effective date is equal or greater than 2019-03-01, scheme is not blank & policy is BPJS-Pensiun2018Mar */
	Update MandatoryContributeProg
	Set MandContriPolicyId = 'BPJS-Pensiun2019Mar'
	Where MandContriEffDate >= '2019-03-01' 
	AND MandContriPolicyId = 'BPJS-Pensiun2018Mar' And ManContriActSchemeId = 'BPJSPensiun'
	AND MandContriSchemeId != '';

	/*-----------------------------------------------------------------------------------------------------------
		Pay Details Default
	-----------------------------------------------------------------------------------------------------------*/
	Update SubRegistry Set ShortStringAttr= 'BPJS-Pensiun2019Mar'
	Where RegistryId='PaySetupData' And SubRegistryId='BPJSPensProgPolicyId';

end if;

commit work;