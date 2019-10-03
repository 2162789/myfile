if not exists(select * from CPFPolicy where CPFPolicyId = 'PHICYr2013Jan' ) then
  Insert into CPFPolicy Values('PHICYr2013Jan',1,'PHIC for Year 2013');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'PHIC13') then
  Insert into CPFTableCode Values('PHIC13','Local','PHIC','',0,0,0);
  Insert into CPFPolicyMember Values('PHICYr2013Jan','PHIC13');
end if;

/* Formula Table*/
if not exists(select * from formula where formulaid = 'PHIC13$0ER') then
  Insert into Formula Values('PHIC13$0ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$7000ER') then
  Insert into Formula Values('PHIC13$7000ER',1,0,0,'ManContriFormula','ER','Adv','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$50000ER') then
  Insert into Formula Values('PHIC13$50000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$0EE') then
  Insert into Formula Values('PHIC13$0EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$7000EE') then
  Insert into Formula Values('PHIC13$7000EE',1,0,0,'ManContriFormula','EE','Adv','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$50000EE') then
  Insert into Formula Values('PHIC13$50000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$0ERF2') then
  Insert into Formula Values('PHIC13$0ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$7000ERF2') then
  Insert into Formula Values('PHIC13$7000ERF2',1,0,0,'ManContriFormula','ER','Adv','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$50000ERF2') then
  Insert into Formula Values('PHIC13$50000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$0EEF2') then
  Insert into Formula Values('PHIC13$0EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$7000EEF2') then
  Insert into Formula Values('PHIC13$7000EEF2',1,0,0,'ManContriFormula','EE','Adv','','','',0,0);
end if;
if not exists(select * from formula where formulaid = 'PHIC13$50000EEF2') then
  Insert into Formula Values('PHIC13$50000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
end if;


/* FormulaRange Table*/
if not exists(select * from FormulaRange where formulaid = 'PHIC13$0ER' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$0ER',1,0,0,'C1 * (C2/100);',7000,1.5,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$7000ER' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$7000ER',1,0,0,'(1.5/100) * K1;',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$50000ER' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$50000ER',1,0,0,'C1 * (C2/100);',50000,1.5,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$0EE' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$0EE',1,0,0,'C1 * (C2/100);',7000,1.5,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$7000EE' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$7000EE',1,0,0,'(1.5/100) * K1;',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$50000EE' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$50000EE',1,0,0,'C1 * (C2/100);',50000,1.5,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$0ERF2' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$0ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$7000ERF2' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$7000ERF2',1,0,0,'(0/100) * K1;',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$50000ERF2' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$50000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$0EEF2' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$0EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$7000EEF2' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$7000EEF2',1,0,0,'(0/100) * K1;',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if not exists(select * from FormulaRange where formulaid = 'PHIC13$50000EEF2' and formulaRangeid = '1') then
  Insert into FormulaRange Values('PHIC13$50000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;

/* CPFTableComponent*/
if not exists(select * from CPFTableComponent where CPFTableCodeId = 'PHIC13' and MinSalary = '0' and MinCPFAge = '0') then
  Insert Into CPFTableComponent Values('PHIC13',0,0,'PHIC13$0EE','PHIC13$0ER',7000,99,'PHIC13$0EEF2','PHIC13$0ERF2');
end if;
if not exists(select * from CPFTableComponent where CPFTableCodeId = 'PHIC13' and MinSalary = '7000' and MinCPFAge = '0') then
  Insert Into CPFTableComponent Values('PHIC13',7000,0,'PHIC13$7000EE','PHIC13$7000ER',50000,99,'PHIC13$7000EEF2','PHIC13$7000ERF2');
end if;
if not exists(select * from CPFTableComponent where CPFTableCodeId = 'PHIC13' and MinSalary = '50000' and MinCPFAge = '0') then
  Insert Into CPFTableComponent Values('PHIC13',50000,0,'PHIC13$50000EE','PHIC13$50000ER',999999,99,'PHIC13$50000EEF2','PHIC13$50000ERF2');
end if;

/* Statutory Contribution Progression*/ 
Insert into MandatoryContributeProg (EmployeeSysId, 
MandContriEffDate,
MandContriCareerId, 
MandContriPolicyId, 
MandContriCurrent,
MandContriRemarks,
MandContriSchemeId
)
Select MandatoryContributeProg.EmployeeSysId, 
'2013-01-01', 
'',
'PHICYr2013Jan', 
0,
'',
'PHIC'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriEffDate < '2013-01-01' and MandContriSchemeId = 'PHIC'
And MandContriCurrent = 1
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2013-01-01')
And Not exists(Select * From MandatoryContributeProg as CheckManCon where CheckManCon.MandContriEffDate = '2013-01-01' and CheckManCon.EmployeeSysID = MandatoryContributeProg.EmployeeSysId)
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='PHICYr2013Jan'
Where RegistryId='PaySetupData' And SubRegistryId='PHICProgPolicyId';

commit work;

