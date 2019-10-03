/*----------------------------
 Insert Policy
-----------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'PHICYr2014Jan' ) then
  Insert into CPFPolicy Values('PHICYr2014Jan',1,'PHIC for Year 2014');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'PHIC14') then
  Insert into CPFTableCode Values('PHIC14','Local','PHIC','',0,0,0);
  Insert into CPFPolicyMember Values('PHICYr2014Jan','PHIC14');
end if;

/*------------------------------
 Insert Formula
--------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'PHIC14') = 1 and FormulaCategory='ManContriFormula') then
/* Insert Formula */
Insert into Formula Values('PHIC14$0ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$9000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$10000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$11000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$12000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$13000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$14000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$15000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$16000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$17000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$18000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$19000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$20000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$21000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$22000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$23000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$24000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$25000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$26000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$27000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$28000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$29000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$30000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$31000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$32000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$33000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$34000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$35000ER',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$0EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$9000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$10000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$11000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$12000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$13000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$14000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$15000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$16000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$17000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$18000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$19000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$20000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$21000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$22000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$23000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$24000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$25000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$26000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$27000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$28000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$29000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$30000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$31000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$32000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$33000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$34000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$35000EE',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$0ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$9000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$10000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$11000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$12000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$13000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$14000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$15000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$16000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$17000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$18000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$19000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$20000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$21000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$22000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$23000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$24000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$25000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$26000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$27000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$28000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$29000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$30000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$31000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$32000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$33000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$34000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$35000ERF2',1,0,0,'ManContriFormula','ER','T2','','','',0,0);
Insert into Formula Values('PHIC14$0EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$9000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$10000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$11000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$12000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$13000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$14000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$15000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$16000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$17000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$18000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$19000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$20000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$21000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$22000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$23000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$24000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$25000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$26000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$27000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$28000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$29000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$30000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$31000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$32000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$33000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$34000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);
Insert into Formula Values('PHIC14$35000EEF2',1,0,0,'ManContriFormula','EE','T2','','','',0,0);

/* Insert FormulaRange */

Insert into FormulaRange Values('PHIC14$0ER',1,0,0,'C1 * (C2/100);',8000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$9000ER',1,0,0,'C1 * (C2/100);',9000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$10000ER',1,0,0,'C1 * (C2/100);',10000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$11000ER',1,0,0,'C1 * (C2/100);',11000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$12000ER',1,0,0,'C1 * (C2/100);',12000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$13000ER',1,0,0,'C1 * (C2/100);',13000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$14000ER',1,0,0,'C1 * (C2/100);',14000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$15000ER',1,0,0,'C1 * (C2/100);',15000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$16000ER',1,0,0,'C1 * (C2/100);',16000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$17000ER',1,0,0,'C1 * (C2/100);',17000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$18000ER',1,0,0,'C1 * (C2/100);',18000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$19000ER',1,0,0,'C1 * (C2/100);',19000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$20000ER',1,0,0,'C1 * (C2/100);',20000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$21000ER',1,0,0,'C1 * (C2/100);',21000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$22000ER',1,0,0,'C1 * (C2/100);',22000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$23000ER',1,0,0,'C1 * (C2/100);',23000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$24000ER',1,0,0,'C1 * (C2/100);',24000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$25000ER',1,0,0,'C1 * (C2/100);',25000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$26000ER',1,0,0,'C1 * (C2/100);',26000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$27000ER',1,0,0,'C1 * (C2/100);',27000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$28000ER',1,0,0,'C1 * (C2/100);',28000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$29000ER',1,0,0,'C1 * (C2/100);',29000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$30000ER',1,0,0,'C1 * (C2/100);',30000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$31000ER',1,0,0,'C1 * (C2/100);',31000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$32000ER',1,0,0,'C1 * (C2/100);',32000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$33000ER',1,0,0,'C1 * (C2/100);',33000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$34000ER',1,0,0,'C1 * (C2/100);',34000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$35000ER',1,0,0,'C1 * (C2/100);',35000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$0EE',1,0,0,'C1 * (C2/100);',8000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$9000EE',1,0,0,'C1 * (C2/100);',9000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$10000EE',1,0,0,'C1 * (C2/100);',10000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$11000EE',1,0,0,'C1 * (C2/100);',11000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$12000EE',1,0,0,'C1 * (C2/100);',12000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$13000EE',1,0,0,'C1 * (C2/100);',13000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$14000EE',1,0,0,'C1 * (C2/100);',14000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$15000EE',1,0,0,'C1 * (C2/100);',15000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$16000EE',1,0,0,'C1 * (C2/100);',16000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$17000EE',1,0,0,'C1 * (C2/100);',17000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$18000EE',1,0,0,'C1 * (C2/100);',18000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$19000EE',1,0,0,'C1 * (C2/100);',19000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$20000EE',1,0,0,'C1 * (C2/100);',20000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$21000EE',1,0,0,'C1 * (C2/100);',21000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$22000EE',1,0,0,'C1 * (C2/100);',22000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$23000EE',1,0,0,'C1 * (C2/100);',23000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$24000EE',1,0,0,'C1 * (C2/100);',24000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$25000EE',1,0,0,'C1 * (C2/100);',25000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$26000EE',1,0,0,'C1 * (C2/100);',26000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$27000EE',1,0,0,'C1 * (C2/100);',27000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$28000EE',1,0,0,'C1 * (C2/100);',28000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$29000EE',1,0,0,'C1 * (C2/100);',29000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$30000EE',1,0,0,'C1 * (C2/100);',30000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$31000EE',1,0,0,'C1 * (C2/100);',31000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$32000EE',1,0,0,'C1 * (C2/100);',32000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$33000EE',1,0,0,'C1 * (C2/100);',33000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$34000EE',1,0,0,'C1 * (C2/100);',34000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$35000EE',1,0,0,'C1 * (C2/100);',35000,1.25,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$0ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$9000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$10000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$11000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$12000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$13000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$14000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$15000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$16000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$17000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$18000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$19000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$20000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$21000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$22000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$23000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$24000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$25000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$26000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$27000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$28000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$29000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$30000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$31000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$32000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$33000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$34000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$35000ERF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$0EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$9000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$10000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$11000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$12000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$13000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$14000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$15000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$16000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$17000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$18000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$19000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$20000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$21000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$22000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$23000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$24000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$25000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$26000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$27000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$28000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$29000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$30000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$31000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$32000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$33000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$34000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('PHIC14$35000EEF2',1,0,0,'C1 * (C2/100);',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

/* Insert Table Component */

Insert Into CPFTableComponent Values('PHIC14',0,0,'PHIC14$0EE','PHIC14$0ER',9000,99,'PHIC14$0EEF2','PHIC14$0ERF2');
Insert Into CPFTableComponent Values('PHIC14',9000,0,'PHIC14$9000EE','PHIC14$9000ER',10000,99,'PHIC14$9000EEF2','PHIC14$9000ERF2');
Insert Into CPFTableComponent Values('PHIC14',10000,0,'PHIC14$10000EE','PHIC14$10000ER',11000,99,'PHIC14$10000EEF2','PHIC14$10000ERF2');
Insert Into CPFTableComponent Values('PHIC14',11000,0,'PHIC14$11000EE','PHIC14$11000ER',12000,99,'PHIC14$11000EEF2','PHIC14$11000ERF2');
Insert Into CPFTableComponent Values('PHIC14',12000,0,'PHIC14$12000EE','PHIC14$12000ER',13000,99,'PHIC14$12000EEF2','PHIC14$12000ERF2');
Insert Into CPFTableComponent Values('PHIC14',13000,0,'PHIC14$13000EE','PHIC14$13000ER',14000,99,'PHIC14$13000EEF2','PHIC14$13000ERF2');
Insert Into CPFTableComponent Values('PHIC14',14000,0,'PHIC14$14000EE','PHIC14$14000ER',15000,99,'PHIC14$14000EEF2','PHIC14$14000ERF2');
Insert Into CPFTableComponent Values('PHIC14',15000,0,'PHIC14$15000EE','PHIC14$15000ER',16000,99,'PHIC14$15000EEF2','PHIC14$15000ERF2');
Insert Into CPFTableComponent Values('PHIC14',16000,0,'PHIC14$16000EE','PHIC14$16000ER',17000,99,'PHIC14$16000EEF2','PHIC14$16000ERF2');
Insert Into CPFTableComponent Values('PHIC14',17000,0,'PHIC14$17000EE','PHIC14$17000ER',18000,99,'PHIC14$17000EEF2','PHIC14$17000ERF2');
Insert Into CPFTableComponent Values('PHIC14',18000,0,'PHIC14$18000EE','PHIC14$18000ER',19000,99,'PHIC14$18000EEF2','PHIC14$18000ERF2');
Insert Into CPFTableComponent Values('PHIC14',19000,0,'PHIC14$19000EE','PHIC14$19000ER',20000,99,'PHIC14$19000EEF2','PHIC14$19000ERF2');
Insert Into CPFTableComponent Values('PHIC14',20000,0,'PHIC14$20000EE','PHIC14$20000ER',21000,99,'PHIC14$20000EEF2','PHIC14$20000ERF2');
Insert Into CPFTableComponent Values('PHIC14',21000,0,'PHIC14$21000EE','PHIC14$21000ER',22000,99,'PHIC14$21000EEF2','PHIC14$21000ERF2');
Insert Into CPFTableComponent Values('PHIC14',22000,0,'PHIC14$22000EE','PHIC14$22000ER',23000,99,'PHIC14$22000EEF2','PHIC14$22000ERF2');
Insert Into CPFTableComponent Values('PHIC14',23000,0,'PHIC14$23000EE','PHIC14$23000ER',24000,99,'PHIC14$23000EEF2','PHIC14$23000ERF2');
Insert Into CPFTableComponent Values('PHIC14',24000,0,'PHIC14$24000EE','PHIC14$24000ER',25000,99,'PHIC14$24000EEF2','PHIC14$24000ERF2');
Insert Into CPFTableComponent Values('PHIC14',25000,0,'PHIC14$25000EE','PHIC14$25000ER',26000,99,'PHIC14$25000EEF2','PHIC14$25000ERF2');
Insert Into CPFTableComponent Values('PHIC14',26000,0,'PHIC14$26000EE','PHIC14$26000ER',27000,99,'PHIC14$26000EEF2','PHIC14$26000ERF2');
Insert Into CPFTableComponent Values('PHIC14',27000,0,'PHIC14$27000EE','PHIC14$27000ER',28000,99,'PHIC14$27000EEF2','PHIC14$27000ERF2');
Insert Into CPFTableComponent Values('PHIC14',28000,0,'PHIC14$28000EE','PHIC14$28000ER',29000,99,'PHIC14$28000EEF2','PHIC14$28000ERF2');
Insert Into CPFTableComponent Values('PHIC14',29000,0,'PHIC14$29000EE','PHIC14$29000ER',30000,99,'PHIC14$29000EEF2','PHIC14$29000ERF2');
Insert Into CPFTableComponent Values('PHIC14',30000,0,'PHIC14$30000EE','PHIC14$30000ER',31000,99,'PHIC14$30000EEF2','PHIC14$30000ERF2');
Insert Into CPFTableComponent Values('PHIC14',31000,0,'PHIC14$31000EE','PHIC14$31000ER',32000,99,'PHIC14$31000EEF2','PHIC14$31000ERF2');
Insert Into CPFTableComponent Values('PHIC14',32000,0,'PHIC14$32000EE','PHIC14$32000ER',33000,99,'PHIC14$32000EEF2','PHIC14$32000ERF2');
Insert Into CPFTableComponent Values('PHIC14',33000,0,'PHIC14$33000EE','PHIC14$33000ER',34000,99,'PHIC14$33000EEF2','PHIC14$33000ERF2');
Insert Into CPFTableComponent Values('PHIC14',34000,0,'PHIC14$34000EE','PHIC14$34000ER',35000,99,'PHIC14$34000EEF2','PHIC14$34000ERF2');
Insert Into CPFTableComponent Values('PHIC14',35000,0,'PHIC14$35000EE','PHIC14$35000ER',999999,99,'PHIC14$35000EEF2','PHIC14$35000ERF2');

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
'2014-01-01', 
'None',
'PHICYr2014Jan', 
0,
'',
'PHIC'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriEffDate < '2014-01-01' and MandContriSchemeId = 'PHIC'
And MandContriCurrent = 1
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2014-01-01')
And Not exists(Select * From MandatoryContributeProg as CheckManCon where CheckManCon.MandContriEffDate = '2014-01-01' and MandContriSchemeId = 'PHIC' and CheckManCon.EmployeeSysID = MandatoryContributeProg.EmployeeSysId)
;

/*----------------------------
 Update Pay Details Default
-----------------------------*/

Update SubRegistry Set ShortStringAttr='PHICYr2014Jan'
Where RegistryId='PaySetupData' And SubRegistryId='PHICProgPolicyId';



/*----------------------------
 Insert Policy
-----------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'SSSYr2014Jan' ) then
  Insert into CPFPolicy Values('SSSYr2014Jan',1,'SSS for Year 2014');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'SSS14') then
  Insert into CPFTableCode Values('SSS14','Local','SSS','',0,0,0);
  Insert into CPFPolicyMember Values('SSSYr2014Jan','SSS14');
end if;

/*------------------------------
 Insert Formula
--------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'SSS14') = 1 and FormulaCategory='ManContriFormula') then

/* Insert Formula */
Insert into Formula Values('SSS14$0ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$1000ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$1250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$1750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$2250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$2750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$3250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$3750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$4250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$4750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$5250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$5750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$6250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$6750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$7250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$7750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$8250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$8750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$9250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$9750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$10250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$10750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$11250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$11750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$12250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$12750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$13250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$13750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$14250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$14750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$15250ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$15750ERSS',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$0EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$1000EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$1250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$1750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$2250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$2750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$3250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$3750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$4250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$4750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$5250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$5750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$6250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$6750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$7250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$7750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$8250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$8750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$9250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$9750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$10250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$10750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$11250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$11750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$12250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$12750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$13250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$13750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$14250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$14750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$15250EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$15750EREC',1,0,0,'ManContriFormula','ER','T1','','','',0,0);
Insert into Formula Values('SSS14$0EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$1000EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$1250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$1750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$2250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$2750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$3250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$3750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$4250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$4750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$5250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$5750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$6250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$6750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$7250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$7750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$8250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$8750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$9250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$9750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$10250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$10750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$11250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$11750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$12250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$12750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$13250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$13750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$14250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$14750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$15250EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$15750EESS',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$0EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$1000EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$1250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$1750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$2250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$2750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$3250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$3750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$4250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$4750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$5250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$5750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$6250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$6750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$7250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$7750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$8250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$8750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$9250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$9750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$10250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$10750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$11250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$11750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$12250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$12750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$13250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$13750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$14250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$14750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$15250EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);
Insert into Formula Values('SSS14$15750EEF2',1,0,0,'ManContriFormula','EE','T1','','','',0,0);

/* Insert FormulaRange */
Insert into FormulaRange Values('SSS14$0ERSS',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1000ERSS',1,0,0,'C1;',73.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1250ERSS',1,0,0,'C1;',110.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1750ERSS',1,0,0,'C1;',147.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2250ERSS',1,0,0,'C1;',184.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2750ERSS',1,0,0,'C1;',221,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3250ERSS',1,0,0,'C1;',257.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3750ERSS',1,0,0,'C1;',294.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4250ERSS',1,0,0,'C1;',331.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4750ERSS',1,0,0,'C1;',368.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5250ERSS',1,0,0,'C1;',405.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5750ERSS',1,0,0,'C1;',442,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6250ERSS',1,0,0,'C1;',478.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6750ERSS',1,0,0,'C1;',515.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7250ERSS',1,0,0,'C1;',552.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7750ERSS',1,0,0,'C1;',589.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8250ERSS',1,0,0,'C1;',626.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8750ERSS',1,0,0,'C1;',663,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9250ERSS',1,0,0,'C1;',699.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9750ERSS',1,0,0,'C1;',736.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10250ERSS',1,0,0,'C1;',773.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10750ERSS',1,0,0,'C1;',810.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11250ERSS',1,0,0,'C1;',847.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11750ERSS',1,0,0,'C1;',884,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12250ERSS',1,0,0,'C1;',920.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12750ERSS',1,0,0,'C1;',957.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13250ERSS',1,0,0,'C1;',994.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13750ERSS',1,0,0,'C1;',1031.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14250ERSS',1,0,0,'C1;',1068.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14750ERSS',1,0,0,'C1;',1105,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15250ERSS',1,0,0,'C1;',1141.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15750ERSS',1,0,0,'C1;',1178.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$0EREC',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1000EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13750EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14250EREC',1,0,0,'C1;',10,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14750EREC',1,0,0,'C1;',30,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15250EREC',1,0,0,'C1;',30,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15750EREC',1,0,0,'C1;',30,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$0EESS',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1000EESS',1,0,0,'C1;',36.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1250EESS',1,0,0,'C1;',54.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1750EESS',1,0,0,'C1;',72.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2250EESS',1,0,0,'C1;',90.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2750EESS',1,0,0,'C1;',109,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3250EESS',1,0,0,'C1;',127.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3750EESS',1,0,0,'C1;',145.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4250EESS',1,0,0,'C1;',163.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4750EESS',1,0,0,'C1;',181.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5250EESS',1,0,0,'C1;',199.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5750EESS',1,0,0,'C1;',218,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6250EESS',1,0,0,'C1;',236.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6750EESS',1,0,0,'C1;',254.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7250EESS',1,0,0,'C1;',272.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7750EESS',1,0,0,'C1;',290.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8250EESS',1,0,0,'C1;',308.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8750EESS',1,0,0,'C1;',327,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9250EESS',1,0,0,'C1;',345.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9750EESS',1,0,0,'C1;',363.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10250EESS',1,0,0,'C1;',381.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10750EESS',1,0,0,'C1;',399.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11250EESS',1,0,0,'C1;',417.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11750EESS',1,0,0,'C1;',436,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12250EESS',1,0,0,'C1;',454.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12750EESS',1,0,0,'C1;',472.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13250EESS',1,0,0,'C1;',490.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13750EESS',1,0,0,'C1;',508.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14250EESS',1,0,0,'C1;',526.8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14750EESS',1,0,0,'C1;',545,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15250EESS',1,0,0,'C1;',563.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15750EESS',1,0,0,'C1;',581.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$0EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1000EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$1750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$2750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$3750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$4750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$5750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$6750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$7750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$8750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$9750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$10750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$11750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$12750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$13750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$14750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15250EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
Insert into FormulaRange Values('SSS14$15750EEF2',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

/* Insert Table Component */
Insert Into CPFTableComponent Values('SSS14',0,0,'SSS14$0EESS','SSS14$0ERSS',1000,99,'SSS14$0EEF2','SSS14$0EREC');
Insert Into CPFTableComponent Values('SSS14',1000,0,'SSS14$1000EESS','SSS14$1000ERSS',1250,99,'SSS14$1000EEF2','SSS14$1000EREC');
Insert Into CPFTableComponent Values('SSS14',1250,0,'SSS14$1250EESS','SSS14$1250ERSS',1750,99,'SSS14$1250EEF2','SSS14$1250EREC');
Insert Into CPFTableComponent Values('SSS14',1750,0,'SSS14$1750EESS','SSS14$1750ERSS',2250,99,'SSS14$1750EEF2','SSS14$1750EREC');
Insert Into CPFTableComponent Values('SSS14',2250,0,'SSS14$2250EESS','SSS14$2250ERSS',2750,99,'SSS14$2250EEF2','SSS14$2250EREC');
Insert Into CPFTableComponent Values('SSS14',2750,0,'SSS14$2750EESS','SSS14$2750ERSS',3250,99,'SSS14$2750EEF2','SSS14$2750EREC');
Insert Into CPFTableComponent Values('SSS14',3250,0,'SSS14$3250EESS','SSS14$3250ERSS',3750,99,'SSS14$3250EEF2','SSS14$3250EREC');
Insert Into CPFTableComponent Values('SSS14',3750,0,'SSS14$3750EESS','SSS14$3750ERSS',4250,99,'SSS14$3750EEF2','SSS14$3750EREC');
Insert Into CPFTableComponent Values('SSS14',4250,0,'SSS14$4250EESS','SSS14$4250ERSS',4750,99,'SSS14$4250EEF2','SSS14$4250EREC');
Insert Into CPFTableComponent Values('SSS14',4750,0,'SSS14$4750EESS','SSS14$4750ERSS',5250,99,'SSS14$4750EEF2','SSS14$4750EREC');
Insert Into CPFTableComponent Values('SSS14',5250,0,'SSS14$5250EESS','SSS14$5250ERSS',5750,99,'SSS14$5250EEF2','SSS14$5250EREC');
Insert Into CPFTableComponent Values('SSS14',5750,0,'SSS14$5750EESS','SSS14$5750ERSS',6250,99,'SSS14$5750EEF2','SSS14$5750EREC');
Insert Into CPFTableComponent Values('SSS14',6250,0,'SSS14$6250EESS','SSS14$6250ERSS',6750,99,'SSS14$6250EEF2','SSS14$6250EREC');
Insert Into CPFTableComponent Values('SSS14',6750,0,'SSS14$6750EESS','SSS14$6750ERSS',7250,99,'SSS14$6750EEF2','SSS14$6750EREC');
Insert Into CPFTableComponent Values('SSS14',7250,0,'SSS14$7250EESS','SSS14$7250ERSS',7750,99,'SSS14$7250EEF2','SSS14$7250EREC');
Insert Into CPFTableComponent Values('SSS14',7750,0,'SSS14$7750EESS','SSS14$7750ERSS',8250,99,'SSS14$7750EEF2','SSS14$7750EREC');
Insert Into CPFTableComponent Values('SSS14',8250,0,'SSS14$8250EESS','SSS14$8250ERSS',8750,99,'SSS14$8250EEF2','SSS14$8250EREC');
Insert Into CPFTableComponent Values('SSS14',8750,0,'SSS14$8750EESS','SSS14$8750ERSS',9250,99,'SSS14$8750EEF2','SSS14$8750EREC');
Insert Into CPFTableComponent Values('SSS14',9250,0,'SSS14$9250EESS','SSS14$9250ERSS',9750,99,'SSS14$9250EEF2','SSS14$9250EREC');
Insert Into CPFTableComponent Values('SSS14',9750,0,'SSS14$9750EESS','SSS14$9750ERSS',10250,99,'SSS14$9750EEF2','SSS14$9750EREC');
Insert Into CPFTableComponent Values('SSS14',10250,0,'SSS14$10250EESS','SSS14$10250ERSS',10750,99,'SSS14$10250EEF2','SSS14$10250EREC');
Insert Into CPFTableComponent Values('SSS14',10750,0,'SSS14$10750EESS','SSS14$10750ERSS',11250,99,'SSS14$10750EEF2','SSS14$10750EREC');
Insert Into CPFTableComponent Values('SSS14',11250,0,'SSS14$11250EESS','SSS14$11250ERSS',11750,99,'SSS14$11250EEF2','SSS14$11250EREC');
Insert Into CPFTableComponent Values('SSS14',11750,0,'SSS14$11750EESS','SSS14$11750ERSS',12250,99,'SSS14$11750EEF2','SSS14$11750EREC');
Insert Into CPFTableComponent Values('SSS14',12250,0,'SSS14$12250EESS','SSS14$12250ERSS',12750,99,'SSS14$12250EEF2','SSS14$12250EREC');
Insert Into CPFTableComponent Values('SSS14',12750,0,'SSS14$12750EESS','SSS14$12750ERSS',13250,99,'SSS14$12750EEF2','SSS14$12750EREC');
Insert Into CPFTableComponent Values('SSS14',13250,0,'SSS14$13250EESS','SSS14$13250ERSS',13750,99,'SSS14$13250EEF2','SSS14$13250EREC');
Insert Into CPFTableComponent Values('SSS14',13750,0,'SSS14$13750EESS','SSS14$13750ERSS',14250,99,'SSS14$13750EEF2','SSS14$13750EREC');
Insert Into CPFTableComponent Values('SSS14',14250,0,'SSS14$14250EESS','SSS14$14250ERSS',14750,99,'SSS14$14250EEF2','SSS14$14250EREC');
Insert Into CPFTableComponent Values('SSS14',14750,0,'SSS14$14750EESS','SSS14$14750ERSS',15250,99,'SSS14$14750EEF2','SSS14$14750EREC');
Insert Into CPFTableComponent Values('SSS14',15250,0,'SSS14$15250EESS','SSS14$15250ERSS',15750,99,'SSS14$15250EEF2','SSS14$15250EREC');
Insert Into CPFTableComponent Values('SSS14',15750,0,'SSS14$15750EESS','SSS14$15750ERSS',999999,99,'SSS14$15750EEF2','SSS14$15750EREC');

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
'2014-01-01', 
'None',
'SSSYr2014Jan', 
0,
'',
'SSS'
From PayEmployee join MandatoryContributeProg 
On PayEmployee.EmployeeSysId = MandatoryContributeProg.EmployeeSysId
Where MandContriEffDate < '2014-01-01' and MandContriSchemeId = 'SSS'
And MandContriCurrent = 1
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2014-01-01')
And Not exists(Select * From MandatoryContributeProg as CheckManCon where CheckManCon.MandContriEffDate = '2014-01-01' and MandContriSchemeId = 'SSS' and CheckManCon.EmployeeSysID = MandatoryContributeProg.EmployeeSysId);

Commit work;
