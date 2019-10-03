if (FGetDBCountry()='HongKong') then 

   if not exists(select * from CPFPolicy where CPFPolicyId = 'Year2011Nov') then
      Insert into CPFPolicy Values('Year2011Nov',1,' 5% Employer, 5% Employee and Minimum Income 6500 wef 1 Nov 11');
   end if;

   if not exists(select * from CPFTableCode  where CPFTableCodeId = '1111ST') then
      Insert into CPFTableCode Values('1111ST','Local','MPF','Local Citizen Employer 5%, Employee 5% and Minimum Income 6500 wef Nov 1, 2011',0,60,30);
      Insert into CPFPolicyMember Values('Year2011Nov','1111ST');
   end if;

   if not exists(select * from Formula where Locate(FormulaId,'1111STA') = 1 and FormulaCategory='MPFFormula1') then

      Insert into Formula Values('1111STA0$0ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA0$0EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
      Insert into Formula Values('1111STA0$6500ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA0$6500EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
      Insert into Formula Values('1111STA0$20000ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA0$20000EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
      Insert into Formula Values('1111STA18$0ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA18$0EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
      Insert into Formula Values('1111STA18$6500ER',1,0,0,'MPFFormula1','ER','T2','','','',0,0);
      Insert into Formula Values('1111STA18$6500EE',1,0,0,'MPFFormula1','EE','T2','','','',0,0);
      Insert into Formula Values('1111STA18$20000ER',1,0,0,'MPFFormula1','ER','T2','','','',0,0);
      Insert into Formula Values('1111STA18$20000EE',1,0,0,'MPFFormula1','EE','T2','','','',0,0);
      Insert into Formula Values('1111STA65$0ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA65$0EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
      Insert into Formula Values('1111STA65$6500ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA65$6500EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
      Insert into Formula Values('1111STA65$20000ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
      Insert into Formula Values('1111STA65$20000EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);

      Insert into FormulaRange Values('1111STA0$0ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA0$0EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA0$6500ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA0$6500EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA0$20000ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA0$20000EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA18$0ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',5,5,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA18$0EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA18$6500ER',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1000,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA18$6500EE',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1000,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA18$20000ER',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1000,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA18$20000EE',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1000,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA65$0ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA65$0EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA65$6500ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA65$6500EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA65$20000ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
      Insert into FormulaRange Values('1111STA65$20000EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');

      Insert Into  CPFTableComponent Values('1111ST',0,0,'1111STA0$0EE','1111STA0$0ER',6500,18,'','');
      Insert Into  CPFTableComponent Values('1111ST',6500,0,'1111STA0$6500EE','1111STA0$6500ER',20000,18,'','');
      Insert Into  CPFTableComponent Values('1111ST',20000,0,'1111STA0$20000EE','1111STA0$20000ER',999999999,18,'','');
      Insert Into  CPFTableComponent Values('1111ST',0,18,'1111STA18$0EE','1111STA18$0ER',6500,65,'','');
      Insert Into  CPFTableComponent Values('1111ST',6500,18,'1111STA18$6500EE','1111STA18$6500ER',20000,65,'','');
      Insert Into  CPFTableComponent Values('1111ST',20000,18,'1111STA18$20000EE','1111STA18$20000ER',999999999,65,'','');
      Insert Into  CPFTableComponent Values('1111ST',0,65,'1111STA65$0EE','1111STA65$0ER',6500,99,'','');
      Insert Into  CPFTableComponent Values('1111ST',6500,65,'1111STA65$6500EE','1111STA65$6500ER',20000,99,'','');
      Insert Into  CPFTableComponent Values('1111ST',20000,65,'1111STA65$20000EE','1111STA65$20000ER',999999999,99,'','');

   end if;

commit work;

end if;
