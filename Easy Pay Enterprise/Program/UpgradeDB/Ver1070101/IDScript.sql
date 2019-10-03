/*-----------------------------------------------------------------------------------------------------------
	BPJS Kesehatan Policy
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Kes2017Jan' ) then
  Insert into CPFPolicy Values('BPJS-Kes2017Jan',1,'4% Employer, 1% Employee wef 1 January 2017');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0117ST') then
  Insert into CPFTableCode Values('BPJS-Kes0117ST','Local','BPJSKesehatan','Local Citizen - Employer 4%, Employee 1% wef January 1, 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2017Jan','BPJS-Kes0117ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0117PR') then
  Insert into CPFTableCode Values('BPJS-Kes0117PR','PR','BPJSKesehatan','Permanent Residence - Employer 4%, Employee 1% wef January 1, 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2017Jan','BPJS-Kes0117PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0117FW') then
  Insert into CPFTableCode Values('BPJS-Kes0117FW','FW','BPJSKesehatan','Foreign Worker - Employer 4%, Employee 1% wef January 1, 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2017Jan','BPJS-Kes0117FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0117ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0117ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0117ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0117ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3355750,8000000,33558,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0117ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,3355750,8000000,134230,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0117ST',0,0,'BPJS-Kes0117ST0$0EE','BPJS-Kes0117ST0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0117PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0117PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0117PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0117PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3355750,8000000,33558,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0117PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,3355750,8000000,134230,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0117PR',0,0,'BPJS-Kes0117PR0$0EE','BPJS-Kes0117PR0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0117FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0117FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0117FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0117FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,3355750,8000000,33558,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0117FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,3355750,8000000,134230,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0117FW',0,0,'BPJS-Kes0117FW0$0EE','BPJS-Kes0117FW0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Statutory Government Steup
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2017-01-01' and CPFGovtSchemeId = 'BPJSKesehatan') then
   Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   Values('2017-01-01','BPJSKesehatan','BPJS-Kes2017Jan','1','');
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
'2017-01-01', 
'BPJS-Kes2017Jan', 
MandContriSchemeId,
'',
0,
'BPJSKesehatan'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriCurrent = 1 and MandContriEffDate < '2017-01-01' and MandContriSchemeId != '' and ManContriActSchemeId = 'BPJSKesehatan'
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2017-01-01')
And Not exists(Select * From MandatoryContributeProg as CheckBPJSKes where CheckBPJSKes.MandContriEffDate = '2017-01-01' and CheckBPJSKes.EmployeeSysID = MandatoryContributeProg.EmployeeSysId
and CheckBPJSKes.ManContriActSchemeId = 'BPJSKesehatan')
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='BPJS-Kes2017Jan'
Where RegistryId='PaySetupData' And SubRegistryId='BPJSKSProgPolicyId';

commit work;