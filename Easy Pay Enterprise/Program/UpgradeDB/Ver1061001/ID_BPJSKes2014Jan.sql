if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Kes2014Jan' ) then
  Insert into CPFPolicy Values('BPJS-Kes2014Jan',1,'4% Employer, 0.5% Employee wef 1 January 2014');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0114ST') then
  Insert into CPFTableCode Values('BPJS-Kes0114ST','Local','BPJSKesehatan','Local Citizen - Employer 4%, Employee 0.5% wef January 1, 2014',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2014Jan','BPJS-Kes0114ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0114PR') then
  Insert into CPFTableCode Values('BPJS-Kes0114PR','PR','BPJSKesehatan','Permanent Residence - Employer 4%, Employee 0.5% wef January 1, 2014',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2014Jan','BPJS-Kes0114PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Kes0114FW') then
  Insert into CPFTableCode Values('BPJS-Kes0114FW','FW','BPJSKesehatan','Foreign Worker - Employer 4%, Employee 0.5% wef January 1, 2014',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Kes2014Jan','BPJS-Kes0114FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0114ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0114ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0114ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0114ST0$0EE',1,0,0,'@ROUND(@MAX(@MIN(K1 * (C1/100), C2) ,C3),0);',0.5,13500,23625,2700000,4725000,'BPJSKesehatanWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0114ST0$0ER',1,0,0,'@ROUND(@MAX(@MIN(K1 * (C1/100), C2) ,C3),0);',4,108000,189000,2700000,4725000,'BPJSKesehatanWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0114ST',0,0,'BPJS-Kes0114ST0$0EE','BPJS-Kes0114ST0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0114PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0114PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0114PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0114PR0$0EE',1,0,0,'@ROUND(@MAX(@MIN(K1 * (C1/100), C2) ,C3),0);',0.5,13500,23625,2700000,4725000,'BPJSKesehatanWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0114PR0$0ER',1,0,0,'@ROUND(@MAX(@MIN(K1 * (C1/100), C2) ,C3),0);',4,108000,189000,2700000,4725000,'BPJSKesehatanWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0114PR',0,0,'BPJS-Kes0114PR0$0EE','BPJS-Kes0114PR0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Kes0114FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Kes0114FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSKS','','','',0,0);
  Insert into Formula Values('BPJS-Kes0114FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSKS','','','',0,0);
  Insert into FormulaRange Values('BPJS-Kes0114FW0$0EE',1,0,0,'@ROUND(@MAX(@MIN(K1 * (C1/100), C2) ,C3),0);',0.5,13500,23625,2700000,4725000,'BPJSKesehatanWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Kes0114FW0$0ER',1,0,0,'@ROUND(@MAX(@MIN(K1 * (C1/100), C2) ,C3),0);',4,108000,189000,2700000,4725000,'BPJSKesehatanWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Kes0114FW',0,0,'BPJS-Kes0114FW0$0EE','BPJS-Kes0114FW0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/
Update SubRegistry Set ShortStringAttr='BPJS-Kes2014Jan'
Where RegistryId='PaySetupData' And SubRegistryId='BPJSKSProgPolicyId';

commit work;