if not exists(select * from CPFPolicy where CPFPolicyId = 'PHICYr2013JanB' ) then
  Insert into CPFPolicy Values('PHICYr2013JanB',1,'PHIC for Year 2013');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'PHIC13B') then
  Insert into CPFTableCode Values('PHIC13B','Local','PHIC','',0,0,0);
  Insert into CPFPolicyMember Values('PHICYr2013JanB','PHIC13B');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'PHIC13B') = 1 and FormulaCategory='ManContriFormula') then

Insert into Formula Values('PHIC13B$0ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$8000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$9000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$10000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$11000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$12000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$13000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$14000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$15000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$16000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$17000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$18000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$19000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$20000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$21000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$22000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$23000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$24000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$25000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$26000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$27000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$28000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$29000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$30000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$31000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$32000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$33000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$34000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$35000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$0EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$8000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$9000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$10000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$11000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$12000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$13000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$14000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$15000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$16000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$17000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$18000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$19000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$20000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$21000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$22000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$23000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$24000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$25000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$26000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$27000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$28000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$29000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$30000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$31000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$32000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$33000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$34000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$35000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$0ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$8000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$9000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$10000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$11000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$12000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$13000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$14000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$15000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$16000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$17000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$18000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$19000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$20000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$21000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$22000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$23000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$24000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$25000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$26000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$27000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$28000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$29000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$30000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$31000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$32000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$33000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$34000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$35000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC13B$0EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$8000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$9000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$10000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$11000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$12000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$13000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$14000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$15000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$16000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$17000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$18000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$19000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$20000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$21000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$22000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$23000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$24000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$25000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$26000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$27000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$28000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$29000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$30000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$31000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$32000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$33000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$34000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC13B$35000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into FormulaRange Values('PHIC13B$0ER',1,0,0,'C1 * (C2/100);',7000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$8000ER',1,0,0,'C1 * (C2/100);',8000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$9000ER',1,0,0,'C1 * (C2/100);',9000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$10000ER',1,0,0,'C1 * (C2/100);',10000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$11000ER',1,0,0,'C1 * (C2/100);',11000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$12000ER',1,0,0,'C1 * (C2/100);',12000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$13000ER',1,0,0,'C1 * (C2/100);',13000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$14000ER',1,0,0,'C1 * (C2/100);',14000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$15000ER',1,0,0,'C1 * (C2/100);',15000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$16000ER',1,0,0,'C1 * (C2/100);',16000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$17000ER',1,0,0,'C1 * (C2/100);',17000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$18000ER',1,0,0,'C1 * (C2/100);',18000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$19000ER',1,0,0,'C1 * (C2/100);',19000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$20000ER',1,0,0,'C1 * (C2/100);',20000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$21000ER',1,0,0,'C1 * (C2/100);',21000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$22000ER',1,0,0,'C1 * (C2/100);',22000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$23000ER',1,0,0,'C1 * (C2/100);',23000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$24000ER',1,0,0,'C1 * (C2/100);',24000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$25000ER',1,0,0,'C1 * (C2/100);',25000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$26000ER',1,0,0,'C1 * (C2/100);',26000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$27000ER',1,0,0,'C1 * (C2/100);',27000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$28000ER',1,0,0,'C1 * (C2/100);',28000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$29000ER',1,0,0,'C1 * (C2/100);',29000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$30000ER',1,0,0,'C1 * (C2/100);',30000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$31000ER',1,0,0,'C1 * (C2/100);',31000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$32000ER',1,0,0,'C1 * (C2/100);',32000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$33000ER',1,0,0,'C1 * (C2/100);',33000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$34000ER',1,0,0,'C1 * (C2/100);',34000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$35000ER',1,0,0,'C1 * (C2/100);',35000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$0EE',1,0,0,'C1 * (C2/100);',7000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$8000EE',1,0,0,'C1 * (C2/100);',8000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$9000EE',1,0,0,'C1 * (C2/100);',9000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$10000EE',1,0,0,'C1 * (C2/100);',10000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$11000EE',1,0,0,'C1 * (C2/100);',11000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$12000EE',1,0,0,'C1 * (C2/100);',12000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$13000EE',1,0,0,'C1 * (C2/100);',13000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$14000EE',1,0,0,'C1 * (C2/100);',14000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$15000EE',1,0,0,'C1 * (C2/100);',15000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$16000EE',1,0,0,'C1 * (C2/100);',16000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$17000EE',1,0,0,'C1 * (C2/100);',17000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$18000EE',1,0,0,'C1 * (C2/100);',18000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$19000EE',1,0,0,'C1 * (C2/100);',19000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$20000EE',1,0,0,'C1 * (C2/100);',20000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$21000EE',1,0,0,'C1 * (C2/100);',21000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$22000EE',1,0,0,'C1 * (C2/100);',22000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$23000EE',1,0,0,'C1 * (C2/100);',23000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$24000EE',1,0,0,'C1 * (C2/100);',24000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$25000EE',1,0,0,'C1 * (C2/100);',25000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$26000EE',1,0,0,'C1 * (C2/100);',26000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$27000EE',1,0,0,'C1 * (C2/100);',27000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$28000EE',1,0,0,'C1 * (C2/100);',28000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$29000EE',1,0,0,'C1 * (C2/100);',29000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$30000EE',1,0,0,'C1 * (C2/100);',30000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$31000EE',1,0,0,'C1 * (C2/100);',31000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$32000EE',1,0,0,'C1 * (C2/100);',32000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$33000EE',1,0,0,'C1 * (C2/100);',33000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$34000EE',1,0,0,'C1 * (C2/100);',34000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$35000EE',1,0,0,'C1 * (C2/100);',35000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$0ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$8000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$9000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$10000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$11000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$12000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$13000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$14000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$15000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$16000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$17000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$18000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$19000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$20000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$21000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$22000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$23000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$24000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$25000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$26000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$27000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$28000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$29000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$30000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$31000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$32000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$33000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$34000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$35000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$0EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$8000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$9000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$10000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$11000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$12000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$13000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$14000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$15000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$16000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$17000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$18000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$19000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$20000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$21000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$22000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$23000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$24000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$25000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$26000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$27000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$28000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$29000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$30000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$31000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$32000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$33000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$34000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC13B$35000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert Into CPFTableComponent Values('PHIC13B',0,0,'PHIC13B$0EE','PHIC13B$0ER',8000,99,'PHIC13B$0EEF2','PHIC13B$0ERF2');
Insert Into CPFTableComponent Values('PHIC13B',8000,0,'PHIC13B$8000EE','PHIC13B$8000ER',9000,99,'PHIC13B$8000EEF2','PHIC13B$8000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',9000,0,'PHIC13B$9000EE','PHIC13B$9000ER',10000,99,'PHIC13B$9000EEF2','PHIC13B$9000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',10000,0,'PHIC13B$10000EE','PHIC13B$10000ER',11000,99,'PHIC13B$10000EEF2','PHIC13B$10000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',11000,0,'PHIC13B$11000EE','PHIC13B$11000ER',12000,99,'PHIC13B$11000EEF2','PHIC13B$11000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',12000,0,'PHIC13B$12000EE','PHIC13B$12000ER',13000,99,'PHIC13B$12000EEF2','PHIC13B$12000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',13000,0,'PHIC13B$13000EE','PHIC13B$13000ER',14000,99,'PHIC13B$13000EEF2','PHIC13B$13000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',14000,0,'PHIC13B$14000EE','PHIC13B$14000ER',15000,99,'PHIC13B$14000EEF2','PHIC13B$14000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',15000,0,'PHIC13B$15000EE','PHIC13B$15000ER',16000,99,'PHIC13B$15000EEF2','PHIC13B$15000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',16000,0,'PHIC13B$16000EE','PHIC13B$16000ER',17000,99,'PHIC13B$16000EEF2','PHIC13B$16000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',17000,0,'PHIC13B$17000EE','PHIC13B$17000ER',18000,99,'PHIC13B$17000EEF2','PHIC13B$17000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',18000,0,'PHIC13B$18000EE','PHIC13B$18000ER',19000,99,'PHIC13B$18000EEF2','PHIC13B$18000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',19000,0,'PHIC13B$19000EE','PHIC13B$19000ER',20000,99,'PHIC13B$19000EEF2','PHIC13B$19000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',20000,0,'PHIC13B$20000EE','PHIC13B$20000ER',21000,99,'PHIC13B$20000EEF2','PHIC13B$20000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',21000,0,'PHIC13B$21000EE','PHIC13B$21000ER',22000,99,'PHIC13B$21000EEF2','PHIC13B$21000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',22000,0,'PHIC13B$22000EE','PHIC13B$22000ER',23000,99,'PHIC13B$22000EEF2','PHIC13B$22000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',23000,0,'PHIC13B$23000EE','PHIC13B$23000ER',24000,99,'PHIC13B$23000EEF2','PHIC13B$23000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',24000,0,'PHIC13B$24000EE','PHIC13B$24000ER',25000,99,'PHIC13B$24000EEF2','PHIC13B$24000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',25000,0,'PHIC13B$25000EE','PHIC13B$25000ER',26000,99,'PHIC13B$25000EEF2','PHIC13B$25000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',26000,0,'PHIC13B$26000EE','PHIC13B$26000ER',27000,99,'PHIC13B$26000EEF2','PHIC13B$26000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',27000,0,'PHIC13B$27000EE','PHIC13B$27000ER',28000,99,'PHIC13B$27000EEF2','PHIC13B$27000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',28000,0,'PHIC13B$28000EE','PHIC13B$28000ER',29000,99,'PHIC13B$28000EEF2','PHIC13B$28000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',29000,0,'PHIC13B$29000EE','PHIC13B$29000ER',30000,99,'PHIC13B$29000EEF2','PHIC13B$29000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',30000,0,'PHIC13B$30000EE','PHIC13B$30000ER',31000,99,'PHIC13B$30000EEF2','PHIC13B$30000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',31000,0,'PHIC13B$31000EE','PHIC13B$31000ER',32000,99,'PHIC13B$31000EEF2','PHIC13B$31000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',32000,0,'PHIC13B$32000EE','PHIC13B$32000ER',33000,99,'PHIC13B$32000EEF2','PHIC13B$32000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',33000,0,'PHIC13B$33000EE','PHIC13B$33000ER',34000,99,'PHIC13B$33000EEF2','PHIC13B$33000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',34000,0,'PHIC13B$34000EE','PHIC13B$34000ER',35000,99,'PHIC13B$34000EEF2','PHIC13B$34000ERF2');
Insert Into CPFTableComponent Values('PHIC13B',35000,0,'PHIC13B$35000EE','PHIC13B$35000ER',999999,99,'PHIC13B$35000EEF2','PHIC13B$35000ERF2');

end if;

IF NOT EXISTS(SELECT * FROM Career WHERE CareerId = 'None') then
   Insert into Career(CareerId,CareerDesc) Values('None','None');
End if;

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
'2013-01-02', 
'None',
'PHICYr2013JanB', 
0,
'',
'PHIC'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriEffDate < '2013-01-02' and MandContriSchemeId = 'PHIC'
And MandContriCurrent = 1
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2013-01-02')
And Not exists(Select * From MandatoryContributeProg as CheckManCon where CheckManCon.MandContriEffDate = '2013-01-02' and CheckManCon.EmployeeSysID = MandatoryContributeProg.EmployeeSysId)
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='PHICYr2013JanB'
Where RegistryId='PaySetupData' And SubRegistryId='PHICProgPolicyId';
;

commit work;
