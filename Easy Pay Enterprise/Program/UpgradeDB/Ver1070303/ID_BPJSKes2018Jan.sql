/*-----------------------------------------------------------------------------------------------------------
	BPJS Kesehatan Policy
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Kes2018Jan' ) then
  Insert into CPFPolicy Values('BPJS-Kes2018Jan',1,'4% Employer, 1% Employee wef 1 January 2018');
  
  if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0118ST') then
	  Insert into CPFTableCode Values('BPJS-Kes0118ST','Local','BPJSKesehatan','Local Citizen - Employer 4%, Employee 1% wef January 1, 2018',0,0,0);
	  Insert into CPFPolicyMember Values('BPJS-Kes2018Jan','BPJS-Kes0118ST');
	end if;

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0118PR') then
	  Insert into CPFTableCode Values('BPJS-Kes0118PR','PR','BPJSKesehatan','Permanent Residence - Employer 4%, Employee 1% wef January 1, 2018',0,0,0);
	  Insert into CPFPolicyMember Values('BPJS-Kes2018Jan','BPJS-Kes0118PR');
	end if;

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0118FW') then
	  Insert into CPFTableCode Values('BPJS-Kes0118FW','FW','BPJSKesehatan','Foreign Worker - Employer 4%, Employee 1% wef January 1, 2018',0,0,0);
	  Insert into CPFPolicyMember Values('BPJS-Kes2018Jan','BPJS-Kes0118FW');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		Local
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0118ST') = 1 and FormulaCategory='JamsoFormula') then
		Insert into Formula Values('BPJS-Kes0118ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
		Insert into Formula Values('BPJS-Kes0118ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
		Insert into FormulaRange Values('BPJS-Kes0118ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648039,8000000,36480,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('BPJS-Kes0118ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,3648039,8000000,145922,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert Into CPFTableComponent Values('BPJS-Kes0118ST',0,0,'BPJS-Kes0118ST0$0EE','BPJS-Kes0118ST0$0ER',9999999999,99,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		PR
	-----------------------------------------------------------------------------------------------------------*/

	if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0118PR') = 1 and FormulaCategory='JamsoFormula') then
		Insert into Formula Values('BPJS-Kes0118PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
		Insert into Formula Values('BPJS-Kes0118PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
		Insert into FormulaRange Values('BPJS-Kes0118PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648039,8000000,36480,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('BPJS-Kes0118PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,3648039,8000000,145922,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert Into CPFTableComponent Values('BPJS-Kes0118PR',0,0,'BPJS-Kes0118PR0$0EE','BPJS-Kes0118PR0$0ER',9999999999,99,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		FW
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0118FW') = 1 and FormulaCategory='JamsoFormula') then
		Insert into Formula Values('BPJS-Kes0118FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
		Insert into Formula Values('BPJS-Kes0118FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
		Insert into FormulaRange Values('BPJS-Kes0118FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3648039,8000000,36480,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('BPJS-Kes0118FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,3648039,8000000,145922,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert Into CPFTableComponent Values('BPJS-Kes0118FW',0,0,'BPJS-Kes0118FW0$0EE','BPJS-Kes0118FW0$0ER',9999999999,99,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		Statutory Government Steup
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2018-01-01' and CPFGovtSchemeId = 'BPJSKesehatan') then
	   Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
	   Values('2018-01-01','BPJSKesehatan','BPJS-Kes2018Jan','1','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		BPJS Kesehatan Progression
	-----------------------------------------------------------------------------------------------------------*/
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
	'2018-01-01', 
	'BPJS-Kes2018Jan', 
	MandContriSchemeId,
	'',
	0,
	'BPJSKesehatan'
	From PayEmployee join MandatoryContributeProg 
	On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
	Where MandContriCurrent = 1 and MandContriEffDate < '2018-01-01' and MandContriSchemeId != '' and ManContriActSchemeId = 'BPJSKesehatan'
	And (LastPayDate = '1899-12-30' Or LastPayDate >= '2018-01-01')
	And Not exists(Select * From MandatoryContributeProg as CheckBPJSKes where CheckBPJSKes.MandContriEffDate = '2018-01-01' and CheckBPJSKes.EmployeeSysID = MandatoryContributeProg.EmployeeSysId
	and CheckBPJSKes.ManContriActSchemeId = 'BPJSKesehatan')
	;

	/*-----------------------------------------------------------------------------------------------------------
		Pay Details Default
	-----------------------------------------------------------------------------------------------------------*/

	Update SubRegistry Set ShortStringAttr='BPJS-Kes2018Jan'
	Where RegistryId='PaySetupData' And SubRegistryId='BPJSKSProgPolicyId';	
		
end if;


commit work;