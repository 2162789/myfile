if not exists(select * from CPFPolicy where CPFPolicyId = 'EISYr2018Jan' ) then
  Insert into CPFPolicy Values('EISYr2018Jan',1,'EIS wef 1st Jan 2018');
  
  if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EI18ST') then
	  Insert into CPFTableCode Values('EI18ST','Local','EIS','EIS for Malaysian',0,0,0);
	  Insert into CPFPolicyMember Values('EISYr2018Jan','EI18ST');
	end if;

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EI18PR') then
	  Insert into CPFTableCode Values('EI18PR','PR','EIS','EIS for PR',0,0,0);
	  Insert into CPFPolicyMember Values('EISYr2018Jan','EI18PR');
	end if;

	if not exists(select * from CPFTableCode  where CPFTableCodeId = 'EI18EX') then
	  Insert into CPFTableCode Values('EI18EX','FW','EIS','EIS for Foreigner',0,0,0);
	  Insert into CPFPolicyMember Values('EISYr2018Jan','EI18EX');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		Local
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'EI18STA') = 1 and FormulaCategory='EPFFormula') then
	  Insert into Formula Values('EI18STA0$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$30ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$50ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$70ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$140ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA18$4000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA60$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18STA0$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$30EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$50EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$70EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$140EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$1900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$2900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$3900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA18$4000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18STA60$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into FormulaRange Values('EI18STA0$0ER',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$0ER',1,0,0,'C1;',0.05,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$30ER',1,0,0,'C1;',0.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$50ER',1,0,0,'C1;',0.15,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$70ER',1,0,0,'C1;',0.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$100ER',1,0,0,'C1;',0.25,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$140ER',1,0,0,'C1;',0.35,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$200ER',1,0,0,'C1;',0.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$300ER',1,0,0,'C1;',0.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$400ER',1,0,0,'C1;',0.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$500ER',1,0,0,'C1;',1.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$600ER',1,0,0,'C1;',1.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$700ER',1,0,0,'C1;',1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$800ER',1,0,0,'C1;',1.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$900ER',1,0,0,'C1;',1.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1000ER',1,0,0,'C1;',2.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1100ER',1,0,0,'C1;',2.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1200ER',1,0,0,'C1;',2.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1300ER',1,0,0,'C1;',2.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1400ER',1,0,0,'C1;',2.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1500ER',1,0,0,'C1;',3.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1600ER',1,0,0,'C1;',3.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1700ER',1,0,0,'C1;',3.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1800ER',1,0,0,'C1;',3.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1900ER',1,0,0,'C1;',3.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2000ER',1,0,0,'C1;',4.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2100ER',1,0,0,'C1;',4.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2200ER',1,0,0,'C1;',4.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2300ER',1,0,0,'C1;',4.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2400ER',1,0,0,'C1;',4.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2500ER',1,0,0,'C1;',5.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2600ER',1,0,0,'C1;',5.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2700ER',1,0,0,'C1;',5.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2800ER',1,0,0,'C1;',5.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2900ER',1,0,0,'C1;',5.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3000ER',1,0,0,'C1;',6.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3100ER',1,0,0,'C1;',6.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3200ER',1,0,0,'C1;',6.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3300ER',1,0,0,'C1;',6.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3400ER',1,0,0,'C1;',6.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3500ER',1,0,0,'C1;',7.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3600ER',1,0,0,'C1;',7.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3700ER',1,0,0,'C1;',7.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3800ER',1,0,0,'C1;',7.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3900ER',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$4000ER',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA60$0ER',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA0$0EE',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$0EE',1,0,0,'C1;',0.05,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$30EE',1,0,0,'C1;',0.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$50EE',1,0,0,'C1;',0.15,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$70EE',1,0,0,'C1;',0.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$100EE',1,0,0,'C1;',0.25,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$140EE',1,0,0,'C1;',0.35,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$200EE',1,0,0,'C1;',0.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$300EE',1,0,0,'C1;',0.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$400EE',1,0,0,'C1;',0.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$500EE',1,0,0,'C1;',1.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$600EE',1,0,0,'C1;',1.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$700EE',1,0,0,'C1;',1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$800EE',1,0,0,'C1;',1.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$900EE',1,0,0,'C1;',1.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1000EE',1,0,0,'C1;',2.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1100EE',1,0,0,'C1;',2.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1200EE',1,0,0,'C1;',2.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1300EE',1,0,0,'C1;',2.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1400EE',1,0,0,'C1;',2.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1500EE',1,0,0,'C1;',3.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1600EE',1,0,0,'C1;',3.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1700EE',1,0,0,'C1;',3.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1800EE',1,0,0,'C1;',3.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$1900EE',1,0,0,'C1;',3.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2000EE',1,0,0,'C1;',4.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2100EE',1,0,0,'C1;',4.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2200EE',1,0,0,'C1;',4.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2300EE',1,0,0,'C1;',4.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2400EE',1,0,0,'C1;',4.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2500EE',1,0,0,'C1;',5.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2600EE',1,0,0,'C1;',5.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2700EE',1,0,0,'C1;',5.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2800EE',1,0,0,'C1;',5.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$2900EE',1,0,0,'C1;',5.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3000EE',1,0,0,'C1;',6.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3100EE',1,0,0,'C1;',6.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3200EE',1,0,0,'C1;',6.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3300EE',1,0,0,'C1;',6.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3400EE',1,0,0,'C1;',6.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3500EE',1,0,0,'C1;',7.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3600EE',1,0,0,'C1;',7.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3700EE',1,0,0,'C1;',7.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3800EE',1,0,0,'C1;',7.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$3900EE',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA18$4000EE',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18STA60$0EE',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into CPFTableComponent Values('EI18ST',0,0,'EI18STA0$0EE','EI18STA0$0ER',999999,18,'','');
	  Insert into CPFTableComponent Values('EI18ST',0,18,'EI18STA18$0EE','EI18STA18$0ER',30,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',30,18,'EI18STA18$30EE','EI18STA18$30ER',50,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',50,18,'EI18STA18$50EE','EI18STA18$50ER',70,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',70,18,'EI18STA18$70EE','EI18STA18$70ER',100,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',100,18,'EI18STA18$100EE','EI18STA18$100ER',140,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',140,18,'EI18STA18$140EE','EI18STA18$140ER',200,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',200,18,'EI18STA18$200EE','EI18STA18$200ER',300,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',300,18,'EI18STA18$300EE','EI18STA18$300ER',400,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',400,18,'EI18STA18$400EE','EI18STA18$400ER',500,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',500,18,'EI18STA18$500EE','EI18STA18$500ER',600,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',600,18,'EI18STA18$600EE','EI18STA18$600ER',700,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',700,18,'EI18STA18$700EE','EI18STA18$700ER',800,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',800,18,'EI18STA18$800EE','EI18STA18$800ER',900,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',900,18,'EI18STA18$900EE','EI18STA18$900ER',1000,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1000,18,'EI18STA18$1000EE','EI18STA18$1000ER',1100,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1100,18,'EI18STA18$1100EE','EI18STA18$1100ER',1200,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1200,18,'EI18STA18$1200EE','EI18STA18$1200ER',1300,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1300,18,'EI18STA18$1300EE','EI18STA18$1300ER',1400,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1400,18,'EI18STA18$1400EE','EI18STA18$1400ER',1500,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1500,18,'EI18STA18$1500EE','EI18STA18$1500ER',1600,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1600,18,'EI18STA18$1600EE','EI18STA18$1600ER',1700,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1700,18,'EI18STA18$1700EE','EI18STA18$1700ER',1800,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1800,18,'EI18STA18$1800EE','EI18STA18$1800ER',1900,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',1900,18,'EI18STA18$1900EE','EI18STA18$1900ER',2000,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2000,18,'EI18STA18$2000EE','EI18STA18$2000ER',2100,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2100,18,'EI18STA18$2100EE','EI18STA18$2100ER',2200,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2200,18,'EI18STA18$2200EE','EI18STA18$2200ER',2300,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2300,18,'EI18STA18$2300EE','EI18STA18$2300ER',2400,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2400,18,'EI18STA18$2400EE','EI18STA18$2400ER',2500,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2500,18,'EI18STA18$2500EE','EI18STA18$2500ER',2600,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2600,18,'EI18STA18$2600EE','EI18STA18$2600ER',2700,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2700,18,'EI18STA18$2700EE','EI18STA18$2700ER',2800,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2800,18,'EI18STA18$2800EE','EI18STA18$2800ER',2900,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',2900,18,'EI18STA18$2900EE','EI18STA18$2900ER',3000,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3000,18,'EI18STA18$3000EE','EI18STA18$3000ER',3100,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3100,18,'EI18STA18$3100EE','EI18STA18$3100ER',3200,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3200,18,'EI18STA18$3200EE','EI18STA18$3200ER',3300,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3300,18,'EI18STA18$3300EE','EI18STA18$3300ER',3400,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3400,18,'EI18STA18$3400EE','EI18STA18$3400ER',3500,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3500,18,'EI18STA18$3500EE','EI18STA18$3500ER',3600,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3600,18,'EI18STA18$3600EE','EI18STA18$3600ER',3700,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3700,18,'EI18STA18$3700EE','EI18STA18$3700ER',3800,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3800,18,'EI18STA18$3800EE','EI18STA18$3800ER',3900,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',3900,18,'EI18STA18$3900EE','EI18STA18$3900ER',4000,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',4000,18,'EI18STA18$4000EE','EI18STA18$4000ER',999999,60,'','');
	  Insert into CPFTableComponent Values('EI18ST',0,60,'EI18STA60$0EE','EI18STA60$0ER',999999,99,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		PR
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'EI18PRA') = 1 and FormulaCategory='EPFFormula') then
	  Insert into Formula Values('EI18PRA0$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$30ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$50ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$70ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$140ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3100ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3200ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3300ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3400ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3500ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3600ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3700ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3800ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3900ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$4000ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA60$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into Formula Values('EI18PRA0$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$30EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$50EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$70EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$140EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$1900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$2900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3100EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3200EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3300EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3400EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3500EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3600EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3700EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3800EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$3900EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA18$4000EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18PRA60$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into FormulaRange Values('EI18PRA0$0ER',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$0ER',1,0,0,'C1;',0.05,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$30ER',1,0,0,'C1;',0.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$50ER',1,0,0,'C1;',0.15,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$70ER',1,0,0,'C1;',0.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$100ER',1,0,0,'C1;',0.25,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$140ER',1,0,0,'C1;',0.35,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$200ER',1,0,0,'C1;',0.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$300ER',1,0,0,'C1;',0.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$400ER',1,0,0,'C1;',0.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$500ER',1,0,0,'C1;',1.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$600ER',1,0,0,'C1;',1.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$700ER',1,0,0,'C1;',1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$800ER',1,0,0,'C1;',1.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$900ER',1,0,0,'C1;',1.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1000ER',1,0,0,'C1;',2.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1100ER',1,0,0,'C1;',2.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1200ER',1,0,0,'C1;',2.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1300ER',1,0,0,'C1;',2.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1400ER',1,0,0,'C1;',2.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1500ER',1,0,0,'C1;',3.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1600ER',1,0,0,'C1;',3.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1700ER',1,0,0,'C1;',3.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1800ER',1,0,0,'C1;',3.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1900ER',1,0,0,'C1;',3.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2000ER',1,0,0,'C1;',4.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2100ER',1,0,0,'C1;',4.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2200ER',1,0,0,'C1;',4.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2300ER',1,0,0,'C1;',4.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2400ER',1,0,0,'C1;',4.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2500ER',1,0,0,'C1;',5.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2600ER',1,0,0,'C1;',5.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2700ER',1,0,0,'C1;',5.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2800ER',1,0,0,'C1;',5.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2900ER',1,0,0,'C1;',5.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3000ER',1,0,0,'C1;',6.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3100ER',1,0,0,'C1;',6.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3200ER',1,0,0,'C1;',6.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3300ER',1,0,0,'C1;',6.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3400ER',1,0,0,'C1;',6.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3500ER',1,0,0,'C1;',7.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3600ER',1,0,0,'C1;',7.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3700ER',1,0,0,'C1;',7.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3800ER',1,0,0,'C1;',7.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3900ER',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$4000ER',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA60$0ER',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA0$0EE',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$0EE',1,0,0,'C1;',0.05,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$30EE',1,0,0,'C1;',0.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$50EE',1,0,0,'C1;',0.15,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$70EE',1,0,0,'C1;',0.2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$100EE',1,0,0,'C1;',0.25,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$140EE',1,0,0,'C1;',0.35,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$200EE',1,0,0,'C1;',0.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$300EE',1,0,0,'C1;',0.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$400EE',1,0,0,'C1;',0.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$500EE',1,0,0,'C1;',1.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$600EE',1,0,0,'C1;',1.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$700EE',1,0,0,'C1;',1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$800EE',1,0,0,'C1;',1.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$900EE',1,0,0,'C1;',1.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1000EE',1,0,0,'C1;',2.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1100EE',1,0,0,'C1;',2.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1200EE',1,0,0,'C1;',2.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1300EE',1,0,0,'C1;',2.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1400EE',1,0,0,'C1;',2.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1500EE',1,0,0,'C1;',3.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1600EE',1,0,0,'C1;',3.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1700EE',1,0,0,'C1;',3.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1800EE',1,0,0,'C1;',3.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$1900EE',1,0,0,'C1;',3.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2000EE',1,0,0,'C1;',4.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2100EE',1,0,0,'C1;',4.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2200EE',1,0,0,'C1;',4.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2300EE',1,0,0,'C1;',4.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2400EE',1,0,0,'C1;',4.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2500EE',1,0,0,'C1;',5.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2600EE',1,0,0,'C1;',5.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2700EE',1,0,0,'C1;',5.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2800EE',1,0,0,'C1;',5.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$2900EE',1,0,0,'C1;',5.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3000EE',1,0,0,'C1;',6.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3100EE',1,0,0,'C1;',6.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3200EE',1,0,0,'C1;',6.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3300EE',1,0,0,'C1;',6.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3400EE',1,0,0,'C1;',6.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3500EE',1,0,0,'C1;',7.1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3600EE',1,0,0,'C1;',7.3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3700EE',1,0,0,'C1;',7.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3800EE',1,0,0,'C1;',7.7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$3900EE',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA18$4000EE',1,0,0,'C1;',7.9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18PRA60$0EE',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into CPFTableComponent Values('EI18PR',0,0,'EI18PRA0$0EE','EI18PRA0$0ER',999999,18,'','');
	  Insert into CPFTableComponent Values('EI18PR',0,18,'EI18PRA18$0EE','EI18PRA18$0ER',30,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',30,18,'EI18PRA18$30EE','EI18PRA18$30ER',50,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',50,18,'EI18PRA18$50EE','EI18PRA18$50ER',70,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',70,18,'EI18PRA18$70EE','EI18PRA18$70ER',100,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',100,18,'EI18PRA18$100EE','EI18PRA18$100ER',140,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',140,18,'EI18PRA18$140EE','EI18PRA18$140ER',200,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',200,18,'EI18PRA18$200EE','EI18PRA18$200ER',300,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',300,18,'EI18PRA18$300EE','EI18PRA18$300ER',400,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',400,18,'EI18PRA18$400EE','EI18PRA18$400ER',500,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',500,18,'EI18PRA18$500EE','EI18PRA18$500ER',600,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',600,18,'EI18PRA18$600EE','EI18PRA18$600ER',700,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',700,18,'EI18PRA18$700EE','EI18PRA18$700ER',800,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',800,18,'EI18PRA18$800EE','EI18PRA18$800ER',900,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',900,18,'EI18PRA18$900EE','EI18PRA18$900ER',1000,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1000,18,'EI18PRA18$1000EE','EI18PRA18$1000ER',1100,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1100,18,'EI18PRA18$1100EE','EI18PRA18$1100ER',1200,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1200,18,'EI18PRA18$1200EE','EI18PRA18$1200ER',1300,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1300,18,'EI18PRA18$1300EE','EI18PRA18$1300ER',1400,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1400,18,'EI18PRA18$1400EE','EI18PRA18$1400ER',1500,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1500,18,'EI18PRA18$1500EE','EI18PRA18$1500ER',1600,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1600,18,'EI18PRA18$1600EE','EI18PRA18$1600ER',1700,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1700,18,'EI18PRA18$1700EE','EI18PRA18$1700ER',1800,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1800,18,'EI18PRA18$1800EE','EI18PRA18$1800ER',1900,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',1900,18,'EI18PRA18$1900EE','EI18PRA18$1900ER',2000,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2000,18,'EI18PRA18$2000EE','EI18PRA18$2000ER',2100,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2100,18,'EI18PRA18$2100EE','EI18PRA18$2100ER',2200,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2200,18,'EI18PRA18$2200EE','EI18PRA18$2200ER',2300,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2300,18,'EI18PRA18$2300EE','EI18PRA18$2300ER',2400,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2400,18,'EI18PRA18$2400EE','EI18PRA18$2400ER',2500,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2500,18,'EI18PRA18$2500EE','EI18PRA18$2500ER',2600,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2600,18,'EI18PRA18$2600EE','EI18PRA18$2600ER',2700,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2700,18,'EI18PRA18$2700EE','EI18PRA18$2700ER',2800,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2800,18,'EI18PRA18$2800EE','EI18PRA18$2800ER',2900,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',2900,18,'EI18PRA18$2900EE','EI18PRA18$2900ER',3000,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3000,18,'EI18PRA18$3000EE','EI18PRA18$3000ER',3100,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3100,18,'EI18PRA18$3100EE','EI18PRA18$3100ER',3200,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3200,18,'EI18PRA18$3200EE','EI18PRA18$3200ER',3300,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3300,18,'EI18PRA18$3300EE','EI18PRA18$3300ER',3400,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3400,18,'EI18PRA18$3400EE','EI18PRA18$3400ER',3500,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3500,18,'EI18PRA18$3500EE','EI18PRA18$3500ER',3600,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3600,18,'EI18PRA18$3600EE','EI18PRA18$3600ER',3700,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3700,18,'EI18PRA18$3700EE','EI18PRA18$3700ER',3800,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3800,18,'EI18PRA18$3800EE','EI18PRA18$3800ER',3900,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',3900,18,'EI18PRA18$3900EE','EI18PRA18$3900ER',4000,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',4000,18,'EI18PRA18$4000EE','EI18PRA18$4000ER',999999,60,'','');
	  Insert into CPFTableComponent Values('EI18PR',0,60,'EI18PRA60$0EE','EI18PRA60$0ER',999999,99,'','');
	end if;
	/*-----------------------------------------------------------------------------------------------------------
		FW
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from Formula where Locate(FormulaId,'EI18EXA') = 1 and FormulaCategory='EPFFormula') then
	  Insert into Formula Values('EI18EXA0$0EE',1,0,0,'EPFFormula','EE','T4','','','','','');
	  Insert into Formula Values('EI18EXA0$0ER',1,0,0,'EPFFormula','ER','T4','','','','','');
	  Insert into FormulaRange Values('EI18EXA0$0EE',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into FormulaRange Values('EI18EXA0$0ER',1,0,0,'C1;',0,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	  Insert into CPFTableComponent Values('EI18EX',0,0,'EI18EXA0$0EE','EI18EXA0$0ER',999999,99,'','');
	end if;

	/*-----------------------------------------------------------------------------------------------------------
		EIS Progression
	-----------------------------------------------------------------------------------------------------------*/

	insert into MandatoryContributeProg (EmployeeSysId, 
	MandContriEffDate,
	MandContriCareerId, 
	MandContriPolicyId, 
	MandContriCurrent,
	MandContriRemarks,
	MandContriSchemeId,
	ManContriActSchemeId,
	ManContriP1Payment
	)
	select pe.EmployeeSysId, 
	'2018-01-01', 
	'FirstRecord',
	'EISYr2018Jan', 
	0,
	'',
	'EIS',
	'EIS',
	0
	from PayEmployee pe
	join Employee e on pe.EmployeeSysId = e.EmployeeSysId
	join (select distinct EmployeeSysId from SOCSOProgression) sp on e.EmployeeSysId = sp.EmployeeSysId
	left join MandatoryContributeProg mcg on e.EmployeeSysId = mcg.EmployeeSysId and mcg.MandContriEffDate = '2018-01-01' and mcg.ManContriActSchemeId = 'EIS'
	where (pe.LastPayDate = '1899-12-30' or pe.LastPayDate >= '2018-01-01')
	and e.ResidenceStatus in ('Local', 'PR') and mcg.MandContriSysId is null
	;

	/* Update Pay Detail Default */
	if not exists(select * from SubRegistry where RegistryId = 'PaySetupData' and SubRegistryId = 'EISProgSchemeId') then
	  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
							  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
	  values('PaySetupData','EISProgSchemeId','Combo','EIS Scheme','ShortStringAttr','Y','KeyWord','KeyWordId','Select * from KeyWord where KeyWordCategory=''EISScheme'';','KeyWordId	20	EIS Scheme	F','KeyWordDesc	80	Description	F','',0,0,'',0,'EIS','','1899-12-30','1899-12-30 00:00:00');
	end if;

	if not exists(select * from SubRegistry where RegistryId = 'PaySetupData' and SubRegistryId = 'EISProgPolicyId') then
	  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
							  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
	  values('PaySetupData','EISProgPolicyId','Combo','EIS Policy','ShortStringAttr','Y','CPFPolicy','CPFPolicyId','Select * from CPFPolicy;','CPFPolicyId	20	EIS Policy	F','CPFPolicyDesc	80	Description	F','',0,0,'',0,'EISYr2018Jan','','1899-12-30','1899-12-30 00:00:00');
	end if;
end if;

commit work;
