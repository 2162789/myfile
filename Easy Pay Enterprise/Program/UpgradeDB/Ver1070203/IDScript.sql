// Pay Detail Export - Tax Gross Salary & Tax Amount
update KeyWord set KeyWordDesc = 'CurOrdinaryWage', KeyWordSubProperty = 2 Where KeyWordId = 'EX_SDFWage';
update KeyWord set KeyWordDesc = 'CurAdditionalWage', KeyWordSubProperty = 2 Where KeyWordId = 'EX_CalSDF';
update ExportPayitems set ExPayItemCategory = 2 where ExPayItems in ('Tax Amount', 'Tax Gross Salary');
update KeyWord set KeyWordDesc = 'CurOrdinaryWage', KeyWordSubProperty = 8 Where KeyWordId = 'EX_SDFWage_PREV';
update KeyWord set KeyWordDesc = 'CurAdditionalWage', KeyWordSubProperty = 8 Where KeyWordId = 'EX_CalSDF_PREV';
update ExportPayitems set ExPayItemCategory = 8 where ExPayItems in ('Tax Amount (Prev)', 'Tax Gross Salary (Prev)');


/*-----------------------------------------------------------------------------------------------------------
	BPJS TK Policy
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp1-2017Mar' ) then
  Insert into CPFPolicy Values('BPJS-TKGrp1-2017Mar',1,'3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 March 2017');
end if;

if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp2-2017Mar' ) then
  Insert into CPFPolicy Values('BPJS-TKGrp2-2017Mar',1,'3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 March 2017');
end if;

if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp3-2017Mar' ) then
  Insert into CPFPolicy Values('BPJS-TKGrp3-2017Mar',1,'3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 March 2017');
end if;

if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp4-2017Mar' ) then
  Insert into CPFPolicy Values('BPJS-TKGrp4-2017Mar',1,'3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 March 2017');
end if;

if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-TKGrp5-2017Mar' ) then
  Insert into CPFPolicy Values('BPJS-TKGrp5-2017Mar',1,'3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 March 2017');
end if;

/*-----------------------------------------------------------------------------------------------------------
	BPJS TK Table Code & Policy Member
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp1-0317ST') then
  Insert into CPFTableCode Values('BPJS-TKGrp1-0317ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp1-2017Mar','BPJS-TKGrp1-0317ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp1-0317PR') then
  Insert into CPFTableCode Values('BPJS-TKGrp1-0317PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp1-2017Mar','BPJS-TKGrp1-0317PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp1-0317FW') then
  Insert into CPFTableCode Values('BPJS-TKGrp1-0317FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.24% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp1-2017Mar','BPJS-TKGrp1-0317FW');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp2-0317ST') then
  Insert into CPFTableCode Values('BPJS-TKGrp2-0317ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp2-2017Mar','BPJS-TKGrp2-0317ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp2-0317PR') then
  Insert into CPFTableCode Values('BPJS-TKGrp2-0317PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp2-2017Mar','BPJS-TKGrp2-0317PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp2-0317FW') then
  Insert into CPFTableCode Values('BPJS-TKGrp2-0317FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.54% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp2-2017Mar','BPJS-TKGrp2-0317FW');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp3-0317ST') then
  Insert into CPFTableCode Values('BPJS-TKGrp3-0317ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp3-2017Mar','BPJS-TKGrp3-0317ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp3-0317PR') then
  Insert into CPFTableCode Values('BPJS-TKGrp3-0317PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp3-2017Mar','BPJS-TKGrp3-0317PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp3-0317FW') then
  Insert into CPFTableCode Values('BPJS-TKGrp3-0317FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 0.89% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp3-2017Mar','BPJS-TKGrp3-0317FW');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp4-0317ST') then
  Insert into CPFTableCode Values('BPJS-TKGrp4-0317ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp4-2017Mar','BPJS-TKGrp4-0317ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp4-0317PR') then
  Insert into CPFTableCode Values('BPJS-TKGrp4-0317PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp4-2017Mar','BPJS-TKGrp4-0317PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp4-0317FW') then
  Insert into CPFTableCode Values('BPJS-TKGrp4-0317FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 1.27% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp4-2017Mar','BPJS-TKGrp4-0317FW');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp5-0317ST') then
  Insert into CPFTableCode Values('BPJS-TKGrp5-0317ST','Local','BPJSTK','Local Citizen - 3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp5-2017Mar','BPJS-TKGrp5-0317ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp5-0317PR') then
  Insert into CPFTableCode Values('BPJS-TKGrp5-0317PR','PR','BPJSTK','Permanent Residence - 3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp5-2017Mar','BPJS-TKGrp5-0317PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-TKGrp5-0317FW') then
  Insert into CPFTableCode Values('BPJS-TKGrp5-0317FW','FW','BPJSTK','Foreign Worker - 3.7% ER Old Age, 2% EE Old Age, 1.74% ER Accident, 0.3% ER Death wef 1 March 2017',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-TKGrp5-2017Mar','BPJS-TKGrp5-0317FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local Group 1
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0317ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp1-0317ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp1-0317ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,3355750,9999999999,8054,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp1-0317ST',0,0,'BPJSGrp1-0317ST0$0EE','BPJSGrp1-0317ST0$0OL',9999999999,99,'BPJSGrp1-0317ST0$0AC','BPJSGrp1-0317ST0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR Group 1
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0317PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp1-0317PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp1-0317PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,3355750,9999999999,8054,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp1-0317PR',0,0,'BPJSGrp1-0317PR0$0EE','BPJSGrp1-0317PR0$0OL',9999999999,99,'BPJSGrp1-0317PR0$0AC','BPJSGrp1-0317PR0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW Group 1
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp1-0317FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp1-0317FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp1-0317FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp1-0317FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.24,3355750,9999999999,8054,24000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp1-0317FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp1-0317FW',0,0,'BPJSGrp1-0317FW0$0EE','BPJSGrp1-0317FW0$0OL',9999999999,99,'BPJSGrp1-0317FW0$0AC','BPJSGrp1-0317FW0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local Group 2
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp2-0317ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp2-0317ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp2-0317ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.54,3355750,9999999999,18121,54000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp2-0317ST',0,0,'BPJSGrp2-0317ST0$0EE','BPJSGrp2-0317ST0$0OL',9999999999,99,'BPJSGrp2-0317ST0$0AC','BPJSGrp2-0317ST0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR Group 2
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp2-0317PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp2-0317PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp2-0317PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.54,3355750,9999999999,18121,54000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp2-0317PR',0,0,'BPJSGrp2-0317PR0$0EE','BPJSGrp2-0317PR0$0OL',9999999999,99,'BPJSGrp2-0317PR0$0AC','BPJSGrp2-0317PR0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW Group 2
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp2-0317FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp2-0317FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp2-0317FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp2-0317FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.54,3355750,9999999999,18121,54000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp2-0317FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp2-0317FW',0,0,'BPJSGrp2-0317FW0$0EE','BPJSGrp2-0317FW0$0OL',9999999999,99,'BPJSGrp2-0317FW0$0AC','BPJSGrp2-0317FW0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local Group 3
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp3-0317ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp3-0317ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp3-0317ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.89,3355750,9999999999,29866,89000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp3-0317ST',0,0,'BPJSGrp3-0317ST0$0EE','BPJSGrp3-0317ST0$0OL',9999999999,99,'BPJSGrp3-0317ST0$0AC','BPJSGrp3-0317ST0$0DT');
end if;
/*-----------------------------------------------------------------------------------------------------------
	PR Group 3
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp3-0317PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp3-0317PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp3-0317PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.89,3355750,9999999999,29866,89000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp3-0317PR',0,0,'BPJSGrp3-0317PR0$0EE','BPJSGrp3-0317PR0$0OL',9999999999,99,'BPJSGrp3-0317PR0$0AC','BPJSGrp3-0317PR0$0DT');
end if;
/*-----------------------------------------------------------------------------------------------------------
	FW Group 3
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp3-0317FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp3-0317FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp3-0317FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp3-0317FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',0.89,3355750,9999999999,29866,89000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp3-0317FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp3-0317FW',0,0,'BPJSGrp3-0317FW0$0EE','BPJSGrp3-0317FW0$0OL',9999999999,99,'BPJSGrp3-0317FW0$0AC','BPJSGrp3-0317FW0$0DT');
end if;
/*-----------------------------------------------------------------------------------------------------------
	Local Group 4
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp4-0317ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp4-0317ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp4-0317ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.27,3355750,9999999999,42618,127000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp4-0317ST',0,0,'BPJSGrp4-0317ST0$0EE','BPJSGrp4-0317ST0$0OL',9999999999,99,'BPJSGrp4-0317ST0$0AC','BPJSGrp4-0317ST0$0DT');
end if;
/*-----------------------------------------------------------------------------------------------------------
	PR Group 4
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp4-0317PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp4-0317PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp4-0317PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.27,3355750,9999999999,42618,127000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp4-0317PR',0,0,'BPJSGrp4-0317PR0$0EE','BPJSGrp4-0317PR0$0OL',9999999999,99,'BPJSGrp4-0317PR0$0AC','BPJSGrp4-0317PR0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW Group 4
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp4-0317FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp4-0317FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp4-0317FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp4-0317FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.27,3355750,9999999999,42618,127000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp4-0317FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp4-0317FW',0,0,'BPJSGrp4-0317FW0$0EE','BPJSGrp4-0317FW0$0OL',9999999999,99,'BPJSGrp4-0317FW0$0AC','BPJSGrp4-0317FW0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local Group 5
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp5-0317ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp5-0317ST0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317ST0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317ST0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317ST0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp5-0317ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317ST0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317ST0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.74,3355750,9999999999,58390,174000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317ST0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp5-0317ST',0,0,'BPJSGrp5-0317ST0$0EE','BPJSGrp5-0317ST0$0OL',9999999999,99,'BPJSGrp5-0317ST0$0AC','BPJSGrp5-0317ST0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR Group 5
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp5-0317PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp5-0317PR0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317PR0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317PR0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317PR0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp5-0317PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317PR0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317PR0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.74,3355750,9999999999,58390,174000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317PR0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp5-0317PR',0,0,'BPJSGrp5-0317PR0$0EE','BPJSGrp5-0317PR0$0OL',9999999999,99,'BPJSGrp5-0317PR0$0AC','BPJSGrp5-0317PR0$0DT');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW Group 5
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJSGrp5-0317FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJSGrp5-0317FW0$0EE',1,0,0,'JamsoFormula','','EEJamso','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317FW0$0OL',1,0,0,'JamsoFormula','','OldAge','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317FW0$0AC',1,0,0,'JamsoFormula','','Accident','','','',0,0);
  Insert into Formula Values('BPJSGrp5-0317FW0$0DT',1,0,0,'JamsoFormula','','Death','','','',0,0);

  Insert into FormulaRange Values('BPJSGrp5-0317FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',2,3355750,9999999999,67115,200000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317FW0$0OL',1,0,0,'@ROUND(U1 * (C1/100),0);',3.7,3355750,9999999999,124163,370000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317FW0$0AC',1,0,0,'@ROUND(U1 * (C1/100),0);',1.74,3355750,9999999999,58390,174000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJSGrp5-0317FW0$0DT',1,0,0,'@ROUND(U1 * (C1/100),0);',0.3,3355750,9999999999,10067,30000000,'JamsostekWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');

  Insert Into CPFTableComponent Values('BPJS-TKGrp5-0317FW',0,0,'BPJSGrp5-0317FW0$0EE','BPJSGrp5-0317FW0$0OL',9999999999,99,'BPJSGrp5-0317FW0$0AC','BPJSGrp5-0317FW0$0DT');
end if;
/*-----------------------------------------------------------------------------------------------------------
	Statutory Government Steup
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from CPFGovernmentProgression Where CPFGovtEffectiveDate = '2017-03-01' and CPFGovtSchemeId = 'BPJSTK') then
   Insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   Values('2017-03-01','BPJSTK','BPJS-TKGrp3-2017Mar',1,'');
end if;

/*-----------------------------------------------------------------------------------------------------------
	BPJS TK Progression
-----------------------------------------------------------------------------------------------------------*/

Insert into CPFProgression (EmployeeSysId, 
CPFCAREERID, 
CPFEFFECTIVEDATE,
CPFPROGPOLICYID,
CPFPROGSCHEMEID,
CPFPROGREMARKS,
CPFPROGCURRENT,
CPFPROGACCOUNTNO,
CPFMAWOPTION,
CPFMAWLIMIT,
CPFMAWPERIODORDWAGE,
CPFMedisaveSchemeId
)
Select CPFProgression.EmployeeSysId, 
'',
'2017-03-01', 
'BPJS-TKGrp3-2017Mar', 
'BPJSTK',
'',
0,
'',
-1,
0,
0,
''

From PayEmployee join CPFProgression 
On PayEmployee.EmployeeSysId = CPFProgression.EmployeeSysId
Where CPFPROGCURRENT = 1 and CPFEFFECTIVEDATE < '2017-03-01' and CPFPROGSCHEMEID = 'BPJSTK'
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2017-03-01')
And Not exists(Select * From CPFProgression as CheckBPJSTK where CheckBPJSTK.CPFEFFECTIVEDATE = '2017-03-01' and CheckBPJSTK.EmployeeSysID = CPFProgression.EmployeeSysId
and CheckBPJSTK.CPFPROGSCHEMEID = 'BPJSTK')
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='BPJS-TKGrp3-2017Mar' 
Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';

commit work;

commit work;