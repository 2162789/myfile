/*-----------------------------------------------------------------------------------------------------------
	BPJS Pensiun Policy
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Pensiun2016Mar' ) then
  Insert into CPFPolicy Values('BPJS-Pensiun2016Mar',1,'2% Employer, 1% Employee wef 1 March 2016');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0316ST') then
  Insert into CPFTableCode Values('BPJS-Pensiun0316ST','Local','BPJSPensiun','Local Citizen - Employer 2%, Employee 1% wef March 1, 2016',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Pensiun2016Mar','BPJS-Pensiun0316ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0316PR') then
  Insert into CPFTableCode Values('BPJS-Pensiun0316PR','PR','BPJSPensiun','Permanent Residence - Employer 2%, Employee 1% wef March 1, 2016',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Pensiun2016Mar','BPJS-Pensiun0316PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0316FW') then
  Insert into CPFTableCode Values('BPJS-Pensiun0316FW','FW','BPJSPensiun','Foreign Worker - Employer 2%, Employee 1% wef March 1, 2016',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Pensiun2016Mar','BPJS-Pensiun0316FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0316ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Pens0316ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
  Insert into Formula Values('BPJS-Pens0316ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
  Insert into FormulaRange Values('BPJS-Pens0316ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,0,7335300,0,73353,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Pens0316ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,7335300,0,146706,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Pensiun0316ST',0,0,'BPJS-Pens0316ST0$0EE','BPJS-Pens0316ST0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0316PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Pens0316PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
  Insert into Formula Values('BPJS-Pens0316PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
  Insert into FormulaRange Values('BPJS-Pens0316PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,0,7335300,0,73353,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Pens0316PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,7335300,0,146706,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Pensiun0316PR',0,0,'BPJS-Pens0316PR0$0EE','BPJS-Pens0316PR0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0316FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Pens0316FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
  Insert into Formula Values('BPJS-Pens0316FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
  Insert into FormulaRange Values('BPJS-Pens0316FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,0,7335300,0,73353,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Pens0316FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,7335300,0,146706,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Pensiun0316FW',0,0,'BPJS-Pens0316FW0$0EE','BPJS-Pens0316FW0$0ER',9999999999,99,'',''); 
end if;

/*-----------------------------------------------------------------------------------------------------------
	Statutory Government Setup
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2016-03-01' and CPFGovtSchemeId = 'BPJSPensiun') then
   Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   Values('2016-03-01','BPJSPensiun','BPJS-Pensiun2016Mar',1,'');
end if;

/*-----------------------------------------------------------------------------------------------------------
	BPJS Pensiun Progression
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
'2016-03-01', 
'BPJS-Pensiun2016Mar', 
MandContriSchemeId,
'',
0,
'BPJSPensiun'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriCurrent = 1 and MandContriEffDate < '2016-03-01' and MandContriSchemeId != '' and ManContriActSchemeId = 'BPJSPensiun'
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2016-03-01')
And Not exists(Select * From MandatoryContributeProg as CheckBPJSPens where CheckBPJSPens.MandContriEffDate = '2016-03-01' and CheckBPJSPens.EmployeeSysID = MandatoryContributeProg.EmployeeSysId
and CheckBPJSPens.ManContriActSchemeId = 'BPJSPensiun')
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='BPJS-Pensiun2016Mar'
Where RegistryId='PaySetupData' And SubRegistryId='BPJSPensProgPolicyId';

commit work;