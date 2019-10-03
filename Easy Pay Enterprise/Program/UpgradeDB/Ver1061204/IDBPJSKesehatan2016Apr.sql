/*-----------------------------------------------------------------------------------------------------------
	BPJS Kesehatan Policy
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Kes2016Apr' ) then
  Insert into CPFPolicy Values('BPJS-Kes2016Apr',1,'4% Employer, 1% Employee wef 1 April 2016');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0416ST') then
  Insert into CPFTableCode Values('BPJS-Kes0416ST','Local','BPJSKesehatan','Local Citizen - Employer 4%, Employee 1% wef April 1, 2016',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2016Apr','BPJS-Kes0416ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0416PR') then
  Insert into CPFTableCode Values('BPJS-Kes0416PR','PR','BPJSKesehatan','Permanent Residence - Employer 4%, Employee 1% wef April 1, 2016',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2016Apr','BPJS-Kes0416PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0416FW') then
  Insert into CPFTableCode Values('BPJS-Kes0416FW','FW','BPJSKesehatan','Foreign Worker - Employer 4%, Employee 1% wef April 1, 2016',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2016Apr','BPJS-Kes0416FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0416ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0416ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0416ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0416ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,2700000,8000000,27000,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0416ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,2700000,8000000,108000,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0416ST',0,0,'BPJS-Kes0416ST0$0EE','BPJS-Kes0416ST0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0416PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0416PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0416PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0416PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,2700000,8000000,27000,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0416PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,2700000,8000000,108000,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0416PR',0,0,'BPJS-Kes0416PR0$0EE','BPJS-Kes0416PR0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0416FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0416FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0416FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0416FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,2700000,8000000,27000,80000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0416FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,2700000,8000000,108000,320000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0416FW',0,0,'BPJS-Kes0416FW0$0EE','BPJS-Kes0416FW0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Statutory Government Steup
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2016-04-01' and CPFGovtSchemeId = 'BPJSKesehatan') then
   Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   Values('2016-04-01','BPJSKesehatan','BPJS-Kes2016Apr',1,'');
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
'2016-04-01', 
'BPJS-Kes2016Apr', 
MandContriSchemeId,
'',
0,
'BPJSKesehatan'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriCurrent = 1 and MandContriEffDate < '2016-04-01' and MandContriSchemeId != '' and ManContriActSchemeId = 'BPJSKesehatan'
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2016-04-01')
And Not exists(Select * From MandatoryContributeProg as CheckBPJSPens where CheckBPJSPens.MandContriEffDate = '2016-04-01' and CheckBPJSPens.EmployeeSysID = MandatoryContributeProg.EmployeeSysId
and CheckBPJSPens.ManContriActSchemeId = 'BPJSKesehatan')
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='BPJS-Kes2016Apr'
Where RegistryId='PaySetupData' And SubRegistryId='BPJSKSProgPolicyId';

commit work;
