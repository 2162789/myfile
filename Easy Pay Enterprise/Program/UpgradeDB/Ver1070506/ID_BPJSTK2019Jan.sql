/*-----------------------------------------------------------------------------------------------------------
	BPJSTK rate with effective from 1 January 2019
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId in ('BPJS-TKGrp1-2019Jan','BPJS-TKGrp2-2019Jan','BPJS-TKGrp3-2019Jan','BPJS-TKGrp4-2019Jan','BPJS-TKGrp5-2019Jan')) then
  /* BPJS-TKGrp1-2019Jan */
	if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp1-2019Jan') then
      Insert into CPFPolicy Values('BPJS-TKGrp1-2019Jan',1,'3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2019');

			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp1-0119ST') then
				Insert into CPFTableCode Values('BPJS-TKGrp1-0119ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp1-2019Jan','BPJS-TKGrp1-0119ST');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp1-0119PR') then
				Insert into CPFTableCode Values('BPJS-TKGrp1-0119PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp1-2019Jan','BPJS-TKGrp1-0119PR');
			end if;	 
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp1-0119FW') then
				Insert into CPFTableCode Values('BPJS-TKGrp1-0119FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp1-2019Jan','BPJS-TKGrp1-0119FW');
			end if;	 	
			 
			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0119ST') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp1-0119ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp1-0119ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,3940973,9999999999,9458,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp1-0119ST',0,0,'BPJSGrp1-0119ST0$0EE','BPJSGrp1-0119ST0$0OL',9999999999,99,'BPJSGrp1-0119ST0$0AC','BPJSGrp1-0119ST0$0DT');
			end if;
			
			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0119PR') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp1-0119PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);				
				Insert into FormulaRange Values('BPJSGrp1-0119PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,3940973,9999999999,9458,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp1-0119PR',0,0,'BPJSGrp1-0119PR0$0EE','BPJSGrp1-0119PR0$0OL',9999999999,99,'BPJSGrp1-0119PR0$0AC','BPJSGrp1-0119PR0$0DT');
			end if;
			
			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0119FW') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp1-0119FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp1-0119FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);		
				Insert into FormulaRange Values('BPJSGrp1-0119FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,3940973,9999999999,9458,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp1-0119FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp1-0119FW',0,0,'BPJSGrp1-0119FW0$0EE','BPJSGrp1-0119FW0$0OL',9999999999,99,'BPJSGrp1-0119FW0$0AC','BPJSGrp1-0119FW0$0DT');
			end if;
	end if;
	
	/* BPJS-TKGrp2-2019Jan */
	if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp2-2019Jan') then
	    Insert into CPFPolicy Values('BPJS-TKGrp2-2019Jan',1,'3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 January 2019');
			
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp2-0119ST') then
				Insert into CPFTableCode Values('BPJS-TKGrp2-0119ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp2-2019Jan','BPJS-TKGrp2-0119ST');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp2-0119PR') then
				Insert into CPFTableCode Values('BPJS-TKGrp2-0119PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp2-2019Jan','BPJS-TKGrp2-0119PR');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp2-0119FW') then
				Insert into CPFTableCode Values('BPJS-TKGrp2-0119FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp2-2019Jan','BPJS-TKGrp2-0119FW');
			end if;	

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp2-0119ST') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp2-0119ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp2-0119ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.54,3940973,9999999999,21281,54000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp2-0119ST',0,0,'BPJSGrp2-0119ST0$0EE','BPJSGrp2-0119ST0$0OL',9999999999,99,'BPJSGrp2-0119ST0$0AC','BPJSGrp2-0119ST0$0DT');
			end if;

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp2-0119PR') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp2-0119PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp2-0119PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.54,3940973,9999999999,21281,54000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp2-0119PR',0,0,'BPJSGrp2-0119PR0$0EE','BPJSGrp2-0119PR0$0OL',9999999999,99,'BPJSGrp2-0119PR0$0AC','BPJSGrp2-0119PR0$0DT');
			end if;		

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp2-0119FW') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp2-0119FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp2-0119FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp2-0119FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.54,3940973,9999999999,21281,54000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp2-0119FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp2-0119FW',0,0,'BPJSGrp2-0119FW0$0EE','BPJSGrp2-0119FW0$0OL',9999999999,99,'BPJSGrp2-0119FW0$0AC','BPJSGrp2-0119FW0$0DT');
			end if;
	end if;
	 
	/* BPJS-TKGrp3-2019Jan */
	if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp3-2019Jan') then
	    Insert into CPFPolicy Values('BPJS-TKGrp3-2019Jan',1,'3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 January 2019');
			
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp3-0119ST') then
				Insert into CPFTableCode Values('BPJS-TKGrp3-0119ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp3-2019Jan','BPJS-TKGrp3-0119ST');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp3-0119PR') then
				Insert into CPFTableCode Values('BPJS-TKGrp3-0119PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp3-2019Jan','BPJS-TKGrp3-0119PR');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp3-0119FW') then
				Insert into CPFTableCode Values('BPJS-TKGrp3-0119FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp3-2019Jan','BPJS-TKGrp3-0119FW');
			end if;	

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp3-0119ST') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp3-0119ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp3-0119ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.89,3940973,9999999999,35075,89000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp3-0119ST',0,0,'BPJSGrp3-0119ST0$0EE','BPJSGrp3-0119ST0$0OL',9999999999,99,'BPJSGrp3-0119ST0$0AC','BPJSGrp3-0119ST0$0DT');
			end if;

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp3-0119PR') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp3-0119PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp3-0119PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.89,3940973,9999999999,35075,89000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp3-0119PR',0,0,'BPJSGrp3-0119PR0$0EE','BPJSGrp3-0119PR0$0OL',9999999999,99,'BPJSGrp3-0119PR0$0AC','BPJSGrp3-0119PR0$0DT');			
			end if;		

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp3-0119FW') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp3-0119FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp3-0119FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp3-0119FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.89,3940973,9999999999,35075,89000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp3-0119FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp3-0119FW',0,0,'BPJSGrp3-0119FW0$0EE','BPJSGrp3-0119FW0$0OL',9999999999,99,'BPJSGrp3-0119FW0$0AC','BPJSGrp3-0119FW0$0DT');
			end if;
	end if;

	/* BPJS-TKGrp4-2019Jan */
	if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp4-2019Jan') then
	    Insert into CPFPolicy Values('BPJS-TKGrp4-2019Jan',1,'3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 January 2019');
	
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp4-0119ST') then
				Insert into CPFTableCode Values('BPJS-TKGrp4-0119ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp4-2019Jan','BPJS-TKGrp4-0119ST');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp4-0119PR') then
				Insert into CPFTableCode Values('BPJS-TKGrp4-0119PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp4-2019Jan','BPJS-TKGrp4-0119PR');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp4-0119FW') then
				Insert into CPFTableCode Values('BPJS-TKGrp4-0119FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp4-2019Jan','BPJS-TKGrp4-0119FW');
			end if;	

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp4-0119ST') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp4-0119ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp4-0119ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.27,3940973,9999999999,50050,127000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp4-0119ST',0,0,'BPJSGrp4-0119ST0$0EE','BPJSGrp4-0119ST0$0OL',9999999999,99,'BPJSGrp4-0119ST0$0AC','BPJSGrp4-0119ST0$0DT');
			end if;

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp4-0119PR') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp4-0119PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp4-0119PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.27,3940973,9999999999,50050,127000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp4-0119PR',0,0,'BPJSGrp4-0119PR0$0EE','BPJSGrp4-0119PR0$0OL',9999999999,99,'BPJSGrp4-0119PR0$0AC','BPJSGrp4-0119PR0$0DT');
			end if;		

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp4-0119FW') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp4-0119FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp4-0119FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp4-0119FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.27,3940973,9999999999,50050,127000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp4-0119FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp4-0119FW',0,0,'BPJSGrp4-0119FW0$0EE','BPJSGrp4-0119FW0$0OL',9999999999,99,'BPJSGrp4-0119FW0$0AC','BPJSGrp4-0119FW0$0DT');
			end if;
	end if;

	/* BPJS-TKGrp5-2019Jan */
	if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp5-2019Jan') then
	    Insert into CPFPolicy Values('BPJS-TKGrp5-2019Jan',1,'3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 January 2019');
	
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp5-0119ST') then
				Insert into CPFTableCode Values('BPJS-TKGrp5-0119ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp5-2019Jan','BPJS-TKGrp5-0119ST');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp5-0119PR') then
				Insert into CPFTableCode Values('BPJS-TKGrp5-0119PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp5-2019Jan','BPJS-TKGrp5-0119PR');
			end if;
			if not exists(select * from CPFTableCode where CPFTableCodeId = 'BPJS-TKGrp5-0119FW') then
				Insert into CPFTableCode Values('BPJS-TKGrp5-0119FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 January 2019',0,0,0);
				Insert into CPFPolicyMember Values('BPJS-TKGrp5-2019Jan','BPJS-TKGrp5-0119FW');
			end if;	

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp5-0119ST') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp5-0119ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp5-0119ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.74,3940973,9999999999,68573,174000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp5-0119ST',0,0,'BPJSGrp5-0119ST0$0EE','BPJSGrp5-0119ST0$0OL',9999999999,99,'BPJSGrp5-0119ST0$0AC','BPJSGrp5-0119ST0$0DT');
			end if;

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp5-0119PR') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp5-0119PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp5-0119PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.74,3940973,9999999999,68573,174000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp5-0119PR',0,0,'BPJSGrp5-0119PR0$0EE','BPJSGrp5-0119PR0$0OL',9999999999,99,'BPJSGrp5-0119PR0$0AC','BPJSGrp5-0119PR0$0DT');
			end if;		

			if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp5-0119FW') = 1 and FormulaCategory='JamsoFormula') then
				Insert into Formula Values('BPJSGrp5-0119FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
				Insert into Formula Values('BPJSGrp5-0119FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);
				Insert into FormulaRange Values('BPJSGrp5-0119FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3940973,9999999999,78819,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3940973,9999999999,145816,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.74,3940973,9999999999,68573,174000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert into FormulaRange Values('BPJSGrp5-0119FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3940973,9999999999,11823,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
				Insert Into CPFTableComponent Values('BPJS-TKGrp5-0119FW',0,0,'BPJSGrp5-0119FW0$0EE','BPJSGrp5-0119FW0$0OL',9999999999,99,'BPJSGrp5-0119FW0$0AC','BPJSGrp5-0119FW0$0DT');
			end if;
	end if;
	
	/* Get the correct new Policy based on the old policy */
	IF EXISTS (SELECT * from sys.sysprocedure WHERE proc_name = 'TempFGetBPJSTKPolicy') THEN
	   DROP FUNCTION DBA.TempFGetBPJSTKPolicy
	END IF;
	CREATE FUNCTION DBA.TempFGetBPJSTKPolicy
	(
	IN In_OldBPJSTKPolicy char(20)
	)
	RETURNS char(20)
	BEGIN
	   DECLARE OUT_NEWBPJSTKPolicy char(20);
		 
	   SET OUT_NEWBPJSTKPolicy = (CASE In_OldBPJSTKPolicy 
		                          WHEN 'BPJS-TKGrp1-2017Mar' THEN 'BPJS-TKGrp1-2019Jan' 
														  WHEN 'BPJS-TKGrp2-2017Mar' THEN 'BPJS-TKGrp2-2019Jan'
														  WHEN 'BPJS-TKGrp4-2017Mar' THEN 'BPJS-TKGrp4-2019Jan'
														  WHEN 'BPJS-TKGrp5-2017Mar' THEN 'BPJS-TKGrp5-2019Jan'
														  ELSE 'BPJS-TKGrp3-2019Jan' END );
		 
	   RETURN OUT_NEWBPJSTKPolicy;
	END;
	
	/*-----------------------------------------------------------------------------------------------------------
	Statutory Government Setup
	-----------------------------------------------------------------------------------------------------------*/
	if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2019-01-01' and CPFGovtSchemeId = 'BPJSTK') then
		 Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
		 Select first '2019-01-01','BPJSTK',TempFGetBPJSTKPolicy(CPFGovtPolicyId),1,''
		 FROM CPFGovernmentProgression 
		 Where CPFGovtSchemeId = 'BPJSTK'
		 Order by CPFGovtEffectiveDate desc;
	end if;
	
	/*-----------------------------------------------------------------------------------------------------------
		BPJSTK Progression
	-----------------------------------------------------------------------------------------------------------*/
	/* Insert BPJSTK Progression if current progression's effective date is earlier than 2019-01-01, BPJSTK scheme is not blank */
	Insert into CPFProgression (EmployeeSysId, 
	CPFEffectiveDate, 
	CPFCareerId,
	CPFProgPolicyId,
	CPFProgCurrent,
	CPFProgAccountNo,
	CPFProgSchemeId,
	CPFMAWOption,
	CPFMAWLimit,
	CPFProgRemarks,
	CPFMAWPeriodOrdWage,
	CPFMedisavePaidByER,
	CPFMedisaveSchemeId,
	CPFMAWIncRecPayElement
	)
	Select CPFProg1.EmployeeSysId, 
	'2019-01-01',
	'', 
	TempFGetBPJSTKPolicy(CPFProg1.CPFProgPolicyId), 
	0,
	CPFProg1.CPFProgAccountNo,
	'BPJSTK',
	-1,
	0,
	'',
	0,
	0,
	'',
	0
	From PayEmployee PE join CPFProgression CPFProg1
	On PE.EmployeeSysId = CPFProg1.EmployeeSysId
	Left Join CPFProgression CPFProg2 ON CPFProg1.EmployeeSysId = CPFProg2.EmployeeSysId and CPFProg2.CPFEffectiveDate >= '2019-01-01'
	Where CPFProg1.CPFProgCurrent = 1 and CPFProg1.CPFEffectiveDate < '2019-01-01' and CPFProg1.CPFProgSchemeId != ''
	And CPFProg2.EmployeeSysId is null
	And (PE.LastPayDate = '1899-12-30' Or PE.LastPayDate >= '2019-01-01');
	
	/* Update BPJSTK progression if progression’s effective date is equal or greater than 2019-01-01, BPJSTK scheme is not blank & policy is BPJS-TKGrp1-2017Mar to BPJS-TKGrp5-2017Mar */
	Update CPFProgression
	Set CPFProgPolicyId =TempFGetBPJSTKPolicy(CPFProgression.CPFProgPolicyId)
	Where CPFEffectiveDate >= '2019-01-01' 
	AND CPFProgPolicyId in ('BPJS-TKGrp1-2017Mar','BPJS-TKGrp2-2017Mar','BPJS-TKGrp3-2017Mar','BPJS-TKGrp4-2017Mar','BPJS-TKGrp5-2017Mar')
	AND CPFProgSchemeId != '';
	
	/*-----------------------------------------------------------------------------------------------------------
		Pay Details Default
	-----------------------------------------------------------------------------------------------------------*/
	Update SubRegistry Set ShortStringAttr= TempFGetBPJSTKPolicy(ShortStringAttr)
	Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';

	DROP FUNCTION DBA.TempFGetBPJSTKPolicy;
end if;

commit work;