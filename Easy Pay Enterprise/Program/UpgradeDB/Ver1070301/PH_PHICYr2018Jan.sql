if not exists(select * from CPFPolicy where CPFPolicyId = 'PHICYr2018Jan' ) then
	Insert into CPFPolicy Values('PHICYr2018Jan',1,'PHIC for year 2018');
	
	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'PHIC18') then
		Insert into CPFTableCode Values('PHIC18','Local','PHIC','',0,0,0);
		Insert into CPFPolicyMember Values('PHICYr2018Jan','PHIC18');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		Local
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'PHIC18') = 1 and FormulaCategory='ManContriFormula') then
		Insert into Formula Values('PHIC18$0ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
		Insert into Formula Values('PHIC18$10000ER',1,0,0,'ManContriFormula','ER','T5','','','',0,0);
		Insert into Formula Values('PHIC18$40000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
		Insert into Formula Values('PHIC18$0EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
		Insert into Formula Values('PHIC18$10000EE',1,0,0,'ManContriFormula','EE','T5','','','',0,0);
		Insert into Formula Values('PHIC18$40000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
		Insert into Formula Values('PHIC18$0ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
		Insert into Formula Values('PHIC18$10000ERF2',1,0,0,'ManContriFormula','ER','T5','','','',0,0);
		Insert into Formula Values('PHIC18$40000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
		Insert into Formula Values('PHIC18$0EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
		Insert into Formula Values('PHIC18$10000EEF2',1,0,0,'ManContriFormula','EE','T5','','','',0,0);
		Insert into Formula Values('PHIC18$40000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
		Insert into FormulaRange Values('PHIC18$0ER',1,0,0,'C1 * (C2/100);',10000,1.375,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$10000ER',1,0,0,'(C2/100)*K1;',0,1.375,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$40000ER',1,0,0,'C1 * (C2/100);',40000,1.375,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$0EE',1,0,0,'C1 * (C2/100);',10000,1.375,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$10000EE',1,0,0,'(C2/100)*K1;',0,1.375,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$40000EE',1,0,0,'C1 * (C2/100);',40000,1.375,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$0ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$10000ERF2',1,0,0,'(C2/100)*K1;',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$40000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$0EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$10000EEF2',1,0,0,'(C2/100)*K1;',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into FormulaRange Values('PHIC18$40000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'PHICWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
		Insert into CPFTableComponent  Values('PHIC18',0,0,'PHIC18$0EE','PHIC18$0ER',10000,99,'PHIC18$0EEF2','PHIC18$0ERF2');
		Insert into CPFTableComponent  Values('PHIC18',10000,0,'PHIC18$10000EE','PHIC18$10000ER',40000,99,'PHIC18$10000EEF2','PHIC18$10000ERF2');
		Insert into CPFTableComponent  Values('PHIC18',40000,0,'PHIC18$40000EE','PHIC18$40000ER',999999999,99,'PHIC18$40000EEF2','PHIC18$40000ERF2');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		PHIC Progression
	-----------------------------------------------------------------------------------------------------------*/
	Insert into MandatoryContributeProg (EmployeeSysId, 
		MandContriEffDate,
		MandContriCareerId, 
		MandContriPolicyId, 
		MandContriCurrent,
		MandContriRemarks,
		MandContriSchemeId
		)
		Select MandatoryContributeProg.EmployeeSysId, 
		'2018-01-01', 
		'None',
		'PHICYr2018Jan', 
		0,
		'',
		'PHIC'
		From PayEmployee join MandatoryContributeProg 
		On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
		Where MandContriEffDate < '2018-01-01' and MandContriSchemeId = 'PHIC'
		And MandContriCurrent = 1
		And (LastPayDate = '1899-12-30' Or LastPayDate >= '2018-01-01')
		And Not exists(Select * From MandatoryContributeProg as CheckManCon where CheckManCon.MandContriEffDate = '2018-01-01' and MandContriSchemeId = 'PHIC' and CheckManCon.EmployeeSysID = MandatoryContributeProg.EmployeeSysId)
		;
		
		/* Update Pay Detail Default */
		Update SubRegistry
		set ShortStringAttr = 'PHICYr2018Jan'
		Where RegistryId = 'PaySetupData' And SubRegistryId = 'PHICProgPolicyId';
end if;



commit work;
