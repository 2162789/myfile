if not exists(select * from CPFPolicy where CPFPolicyId = 'BPJS-Pensiun2015Jul' ) then
  Insert into CPFPolicy Values('BPJS-Pensiun2015Jul',1,'2% Employer, 1% Employee wef 1 July 2015');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0715ST') then
  Insert into CPFTableCode Values('BPJS-Pensiun0715ST','Local','BPJSPensiun','Local Citizen - Employer 2%, Employee 1% wef July 1, 2015',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Pensiun2015Jul','BPJS-Pensiun0715ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0715PR') then
  Insert into CPFTableCode Values('BPJS-Pensiun0715PR','PR','BPJSPensiun','Permanent Residence - Employer 2%, Employee 1% wef July 1, 2015',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Pensiun2015Jul','BPJS-Pensiun0715PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'BPJS-Pensiun0715FW') then
  Insert into CPFTableCode Values('BPJS-Pensiun0715FW','FW','BPJSPensiun','Foreign Worker - Employer 2%, Employee 1% wef July 1, 2015',0,0,0);
  Insert into CPFPolicyMember Values('BPJS-Pensiun2015Jul','BPJS-Pensiun0715FW');
end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0715ST') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Pens0715ST0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
  Insert into Formula Values('BPJS-Pens0715ST0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
  Insert into FormulaRange Values('BPJS-Pens0715ST0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,0,7000000,0,70000,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Pens0715ST0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,7000000,0,140000,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Pensiun0715ST',0,0,'BPJS-Pens0715ST0$0EE','BPJS-Pens0715ST0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	PR
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0715PR') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Pens0715PR0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
  Insert into Formula Values('BPJS-Pens0715PR0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
  Insert into FormulaRange Values('BPJS-Pens0715PR0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,0,7000000,0,70000,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Pens0715PR0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,7000000,0,140000,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Pensiun0715PR',0,0,'BPJS-Pens0715PR0$0EE','BPJS-Pens0715PR0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/
if not exists(select * from Formula where Locate(FormulaId,'BPJS-Pens0715FW') = 1 and FormulaCategory='JamsoFormula') then
  Insert into Formula Values('BPJS-Pens0715FW0$0EE',1,0,0,'JamsoFormula','','EEBPJSPensiun','','','',0,0);
  Insert into Formula Values('BPJS-Pens0715FW0$0ER',1,0,0,'JamsoFormula','','ERBPJSPensiun','','','',0,0);
  Insert into FormulaRange Values('BPJS-Pens0715FW0$0EE',1,0,0,'@ROUND(U1 * (C1/100),0);',1,0,7000000,0,70000,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert into FormulaRange Values('BPJS-Pens0715FW0$0ER',1,0,0,'@ROUND(U1 * (C1/100),0);',2,0,7000000,0,140000,'BPJSPensiunWage','','','','','','','','','','@LIMIT(K1,C2,C3);','','','','','','','','','','','','','','','','','','','','','','','','');
  Insert Into CPFTableComponent Values('BPJS-Pensiun0715FW',0,0,'BPJS-Pens0715FW0$0EE','BPJS-Pens0715FW0$0ER',9999999999,99,'','');
end if;

/*-----------------------------------------------------------------------------------------------------------
	BPJS Pensiun Progression
-----------------------------------------------------------------------------------------------------------*/
BPJSPensProgLoop: for BPJSPensProgForLoop as Cur_BPJSPensProg dynamic scroll cursor for
     select EmployeeSysId as In_EmployeeSysId 
	 from PayEmployee Where (LastPayDate = '1899-12-30' Or LastPayDate >= '2015-07-01') do 
	    if not exists(select* from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and MandContriEffDate = '2015-07-01' and ManContriActSchemeId = 'BPJSPensiun') then
		    insert into MandatoryContributeProg(EmployeeSysId,MandContriCareerId,MandContriEffDate,MandContriPolicyId,MandContriSchemeId,MandContriRemarks,MandContriCurrent,ManContriActSchemeId)
			values(In_EmployeeSysId,'FirstRecord','2015-07-01','BPJS-Pensiun2015Jul','BPJSPensiun','',1,'BPJSPensiun');
		end if;       	 
end for;

commit work;