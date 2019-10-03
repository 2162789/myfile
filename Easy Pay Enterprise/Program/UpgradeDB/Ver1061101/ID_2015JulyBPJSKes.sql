/*-----------------------------------------------------------------------------------------------------------
	2015 July BPJS Kesehatan Policy
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Kes2015Jul' ) then
  Insert into CPFPolicy Values('BPJS-Kes2015Jul',1,'4% Employer, 1% Employee wef 1 July 2015');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0715ST') then
  Insert into CPFTableCode Values('BPJS-Kes0715ST','Local','BPJSKesehatan','Local Citizen - Employer 4%, Employee 1% wef July 1, 2015',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2015Jul','BPJS-Kes0715ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0715PR') then
  Insert into CPFTableCode Values('BPJS-Kes0715PR','PR','BPJSKesehatan','Permanent Residence - Employer 4%, Employee 1% wef July 1, 2015',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2015Jul','BPJS-Kes0715PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0715FW') then
  Insert into CPFTableCode Values('BPJS-Kes0715FW','FW','BPJSKesehatan','Foreign Worker - Employer 4%, Employee 1% wef July 1, 2015',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2015Jul','BPJS-Kes0715FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0715ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0715ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0715ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0715ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,2700000,4725000,27000,47250,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0715ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,2700000,4725000,108000,189000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0715ST',0,0,'BPJS-Kes0715ST0$0EE','BPJS-Kes0715ST0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0715PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0715PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0715PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0715PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,2700000,4725000,27000,47250,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0715PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,2700000,4725000,108000,189000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0715PR',0,0,'BPJS-Kes0715PR0$0EE','BPJS-Kes0715PR0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0715FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0715FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0715FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0715FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,2700000,4725000,27000,47250,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0715FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',4,2700000,4725000,108000,189000,'BPJSKesehatanWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0715FW',0,0,'BPJS-Kes0715FW0$0EE','BPJS-Kes0715FW0$0ER',9999999999,99,'','');  
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
MandContriCurrent)
Select MandatoryContributeProg.EmployeeSysId, 
'',
'2015-07-01', 
'BPJS-Kes2015Jul', 
MandContriSchemeId,
'',
0
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriCurrent = 1 and MandContriEffDate < '2015-07-01' and MandContriSchemeId != ''
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2015-07-01')
And Not exists(Select * From MandatoryContributeProg as CheckBPJSKes where CheckBPJSKes.MandContriEffDate = '2015-07-01' and CheckBPJSKes.EmployeeSysID = MandatoryContributeProg.EmployeeSysId)
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='BPJS-Kes2015Jul'
Where RegistryId='PaySetupData' And SubRegistryId='BPJSKSProgPolicyId';

Commit work;