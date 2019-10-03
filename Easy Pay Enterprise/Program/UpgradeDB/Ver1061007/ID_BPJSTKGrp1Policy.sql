if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp1-2004Jan' ) then
  Insert into CPFPolicy Values('BPJS-TKGrp1-2004Jan',1,'3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2004');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp1-0104ST') then
  Insert into CPFTableCode Values('BPJS-TKGrp1-0104ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2004',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp1-2004Jan','BPJS-TKGrp1-0104ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp1-0104PR') then
  Insert into CPFTableCode Values('BPJS-TKGrp1-0104PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2004',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp1-2004Jan','BPJS-TKGrp1-0104PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp1-0104FW') then
  Insert into CPFTableCode Values('BPJS-TKGrp1-0104FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2004',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp1-2004Jan','BPJS-TKGrp1-0104FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0104ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp1-0104ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
  Insert into FormulaRange Values('BPJSGrp1-0104ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,9999999999,0,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,0,9999999999,0,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,0,9999999999,0,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,0,9999999999,0,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-TKGrp1-0104ST',0,0,'BPJSGrp1-0104ST0$0EE','BPJSGrp1-0104ST0$0OL',9999999999,99,'BPJSGrp1-0104ST0$0AC','BPJSGrp1-0104ST0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0104PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp1-0104PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
  Insert into FormulaRange Values('BPJSGrp1-0104PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,9999999999,0,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,0,9999999999,0,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,0,9999999999,0,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,0,9999999999,0,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-TKGrp1-0104PR',0,0,'BPJSGrp1-0104PR0$0EE','BPJSGrp1-0104PR0$0OL',9999999999,99,'BPJSGrp1-0104PR0$0AC','BPJSGrp1-0104PR0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0104FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp1-0104FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0104FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
  Insert into FormulaRange Values('BPJSGrp1-0104FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,9999999999,0,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,0,9999999999,0,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,0,9999999999,0,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0104FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,0,9999999999,0,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-TKGrp1-0104FW',0,0,'BPJSGrp1-0104FW0$0EE','BPJSGrp1-0104FW0$0OL',9999999999,99,'BPJSGrp1-0104FW0$0AC','BPJSGrp1-0104FW0$0DT');
end if;

commit work;