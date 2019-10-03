if not exists(select * from Formula where Locate(FormulaId,'0911FWA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0911FWA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0911FWA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0911FWA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0911FWA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into FormulaRange Values('0911FWA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0911FWA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0911FWA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0911FWA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0911FW',0,0,'0911FWA0$0EEO','0911FWA0$0ERO',9999999,99,'0911FWA0$0EEA','0911FWA0$0ERA');

end if;