if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Pensiun2018Mar' ) then
	Insert into CPFPolicy Values('BPJS-Pensiun2018Mar',1,'2% Employer, 1% Employee wef 1 March 2018');

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0318ST') then
		Insert into CPFTableCode Values('BPJS-Pensiun0318ST','Local','BPJSPensiun','Local Citizen - Employer 2%, Employee 1% wef March 1, 2018',0,0,0);
		Insert into CPFPolicyMember Values('BPJS-Pensiun2018Mar','BPJS-Pensiun0318ST');
	end if;

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0318PR') then
		Insert into CPFTableCode Values('BPJS-Pensiun0318PR','PR','BPJSPensiun','Permanent Residence - Employer 2%, Employee 1% wef March 1, 2018',0,0,0);
		Insert into CPFPolicyMember Values('BPJS-Pensiun2018Mar','BPJS-Pensiun0318PR');
	end if;

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0318FW') then
		Insert into CPFTableCode Values('BPJS-Pensiun0318FW','FW','BPJSPensiun','Foreign Worker - Employer 2%, Employee 1% wef March 1, 2018',0,0,0);
		Insert into CPFPolicyMember Values('BPJS-Pensiun2018Mar','BPJS-Pensiun0318FW');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		Local
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0318ST') = 1 and FormulaCategory='JamsoFormula') then
		Insert into Formula Values('BPJS-Pens0318ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
		Insert into Formula Values('BPJS-Pens0318ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
		Insert into FormulaRange Values('BPJS-Pens0318ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648036,8094000,36480,80940,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('BPJS-Pens0318ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3648036,8094000,72961,161880,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert Into CPFTableComponent Values('BPJS-Pensiun0318ST',0,0,'BPJS-Pens0318ST0$0EE','BPJS-Pens0318ST0$0ER',9999999999,56,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		PR
	-----------------------------------------------------------------------------------------------------------*/

	if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0318PR') = 1 and FormulaCategory='JamsoFormula') then
		Insert into Formula Values('BPJS-Pens0318PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
		Insert into Formula Values('BPJS-Pens0318PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
		Insert into FormulaRange Values('BPJS-Pens0318PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648036,8094000,36480,80940,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('BPJS-Pens0318PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3648036,8094000,72961,161880,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert Into CPFTableComponent Values('BPJS-Pensiun0318PR',0,0,'BPJS-Pens0318PR0$0EE','BPJS-Pens0318PR0$0ER',9999999999,56,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		FW
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0318FW') = 1 and FormulaCategory='JamsoFormula') then
		Insert into Formula Values('BPJS-Pens0318FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
		Insert into Formula Values('BPJS-Pens0318FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
		Insert into FormulaRange Values('BPJS-Pens0318FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648036,8094000,36480,80940,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('BPJS-Pens0318FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3648036,8094000,72961,161880,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert Into CPFTableComponent Values('BPJS-Pensiun0318FW',0,0,'BPJS-Pens0318FW0$0EE','BPJS-Pens0318FW0$0ER',9999999999,56,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		Statutory Government Setup
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2018-03-01' and CPFGovtSchemeId = 'BPJSPensiun') then
		 Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
		 Values('2018-03-01','BPJSPensiun','BPJS-Pensiun2018Mar',1,'');
	end if;

	Insert into MandatoryContributeProg (EmployeeSysId, 
	MandContriCareerId, 
	MandContriEffDate,
	MandContriPolicyId,
	MandContriSchemeId,
	MandContriRemarks,
	MandContriCurrent,
	ManContriActSchemeId)
	Select MandatoryContributeProg.EmployeeSysId, 
	'',
	'2018-03-01', 
	'BPJS-Pensiun2018Mar', 
	MandContriSchemeId,
	'',
	0,
	'BPJSPensiun'
	From PayEmployee join MandatoryContributeProg 
	On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
	Where MandContriCurrent = 1 and MandContriEffDate < '2018-03-01' and MandContriSchemeId != '' and ManContriActSchemeId = 'BPJSPensiun'
	And (LastPayDate = '1899-12-30' Or LastPayDate >= '2018-03-01')
	And Not exists(Select * From MandatoryContributeProg as CheckBPJSPens where CheckBPJSPens.MandContriEffDate = '2018-03-01' and CheckBPJSPens.EmployeeSysID = MandatoryContributeProg.EmployeeSysId
	and CheckBPJSPens.ManContriActSchemeId = 'BPJSPensiun')
	;
	
	/*-----------------------------------------------------------------------------------------------------------
		Pay Details Default
	-----------------------------------------------------------------------------------------------------------*/

	Update SubRegistry Set ShortStringAttr='BPJS-Pensiun2018Mar'
	Where RegistryId='PaySetupData' And SubRegistryId='BPJSPensProgPolicyId';

end if;

commit work;