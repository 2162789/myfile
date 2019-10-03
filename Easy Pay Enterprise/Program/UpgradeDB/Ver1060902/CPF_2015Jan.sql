/*-----------------------------------------------------------------------------------------------------------
	CPF Policy and Tables
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from CPFPolicy where CPFPolicyId = 'Year2015Jan' ) then
Insert into CPFPolicy Values('Year2015Jan',1,'17% Employer, 20% Employee wef 1 January 2015');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115ST') then
Insert into CPFTableCode Values('0115ST','Local','Private','Local Citizen Employer 17%, Employee 20% wef January 1, 2015',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115P1') then
Insert into CPFTableCode Values('0115P1','PR1','Private','PR 1st year - Employer Graduated 4%, Employee Graduated 5% wef January 1, 2015',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115P1');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115P2') then
Insert into CPFTableCode Values('0115P2','PR2','Private','PR 2nd year - Employer Graduated 9%, Employee Graduated 15% wef January 1, 2015',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115P2');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115P3') then
Insert into CPFTableCode Values('0115P3','PR3','Private','PR 3rd year and above - Employer 17%, Employee 20% wef January 1, 2015',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115P3');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115P1F') then
Insert into CPFTableCode Values('0115P1F','PR1','Private - Full','PR 1st year - Employer Full 17%, Employee Graduated 5% wef  January 1, 2015',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115P1F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115P2F') then
Insert into CPFTableCode Values('0115P2F','PR2','Private - Full','PR 2nd year - Employer Full 17%, Employee Graduated 15% wef  January 1, 2015',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115P2F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115EP') then
Insert into CPFTableCode Values('0115EP','EP','Private','Voluntary Contributions - user defined',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115EP');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0115FW') then
Insert into CPFTableCode Values('0115FW','FW','Private','Voluntary Contributions - user defined',5000,85000,0);
Insert into CPFPolicyMember Values('Year2015Jan','0115FW');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2015-01-01') then
Insert into CPFGovernmentProgression Values('2015-01-01','Year2015Jan',1,'');
end if;

/*-----------------------------------------------------------------------------------------------------------
	EP
-----------------------------------------------------------------------------------------------------------*/


if not exists(select * from Formula where Locate(FormulaId,'0115EPA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115EPA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115EPA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115EPA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115EPA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into FormulaRange Values('0115EPA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115EPA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115EPA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115EPA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115EP',0,0,'0115EPA0$0EEO','0115EPA0$0ERO',999999999,99,'0115EPA0$0EEA','0115EPA0$0ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0115FWA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115FWA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115FWA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115FWA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115FWA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into FormulaRange Values('0115FWA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115FWA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115FWA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115FWA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115FW',0,0,'0115FWA0$0EEO','0115FWA0$0ERO',999999999,99,'0115FWA0$0EEA','0115FWA0$0ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0115STA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115STA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115STA65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115STA65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115STA65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115STA65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115STA65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0115STA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$50ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$50ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$500ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$500ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',17,850,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$750ERA',1,0,0,' (C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',20,1000,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA0$750EEA',1,0,0,' (C1/100)*K3;',20,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.57,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.57,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',19,950,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA50$750EEA',1,0,0,' (C1/100)*K3;',19,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$50ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$50ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$500ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$500ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12,600,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$750ERA',1,0,0,' (C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',13,650,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA55$750EEA',1,0,0,' (C1/100)*K3;',13,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$50ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$50ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$500ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$500ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',8.5,425,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$750ERA',1,0,0,' (C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$50ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$50ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$500ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$500ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$750ERA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115STA65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115ST',0,0,'0115STA0$0EEO','0115STA0$0ERO',50,50,'0115STA0$0EEA','0115STA0$0ERA');
Insert Into  CPFTableComponent Values('0115ST',50,0,'0115STA0$50EEO','0115STA0$50ERO',500,50,'0115STA0$50EEA','0115STA0$50ERA');
Insert Into  CPFTableComponent Values('0115ST',500,0,'0115STA0$500EEO','0115STA0$500ERO',750,50,'0115STA0$500EEA','0115STA0$500ERA');
Insert Into  CPFTableComponent Values('0115ST',750,0,'0115STA0$750EEO','0115STA0$750ERO',999999999,50,'0115STA0$750EEA','0115STA0$750ERA');
Insert Into  CPFTableComponent Values('0115ST',0,50,'0115STA50$0EEO','0115STA50$0ERO',50,55,'0115STA50$0EEA','0115STA50$0ERA');
Insert Into  CPFTableComponent Values('0115ST',50,50,'0115STA50$50EEO','0115STA50$50ERO',500,55,'0115STA50$50EEA','0115STA50$50ERA');
Insert Into  CPFTableComponent Values('0115ST',500,50,'0115STA50$500EEO','0115STA50$500ERO',750,55,'0115STA50$500EEA','0115STA50$500ERA');
Insert Into  CPFTableComponent Values('0115ST',750,50,'0115STA50$750EEO','0115STA50$750ERO',999999999,55,'0115STA50$750EEA','0115STA50$750ERA');
Insert Into  CPFTableComponent Values('0115ST',0,55,'0115STA55$0EEO','0115STA55$0ERO',50,60,'0115STA55$0EEA','0115STA55$0ERA');
Insert Into  CPFTableComponent Values('0115ST',50,55,'0115STA55$50EEO','0115STA55$50ERO',500,60,'0115STA55$50EEA','0115STA55$50ERA');
Insert Into  CPFTableComponent Values('0115ST',500,55,'0115STA55$500EEO','0115STA55$500ERO',750,60,'0115STA55$500EEA','0115STA55$500ERA');
Insert Into  CPFTableComponent Values('0115ST',750,55,'0115STA55$750EEO','0115STA55$750ERO',999999999,60,'0115STA55$750EEA','0115STA55$750ERA');
Insert Into  CPFTableComponent Values('0115ST',0,60,'0115STA60$0EEO','0115STA60$0ERO',50,65,'0115STA60$0EEA','0115STA60$0ERA');
Insert Into  CPFTableComponent Values('0115ST',50,60,'0115STA60$50EEO','0115STA60$50ERO',500,65,'0115STA60$50EEA','0115STA60$50ERA');
Insert Into  CPFTableComponent Values('0115ST',500,60,'0115STA60$500EEO','0115STA60$500ERO',750,65,'0115STA60$500EEA','0115STA60$500ERA');
Insert Into  CPFTableComponent Values('0115ST',750,60,'0115STA60$750EEO','0115STA60$750ERO',999999999,65,'0115STA60$750EEA','0115STA60$750ERA');
Insert Into  CPFTableComponent Values('0115ST',0,65,'0115STA65$0EEO','0115STA65$0ERO',50,99,'0115STA65$0EEA','0115STA65$0ERA');
Insert Into  CPFTableComponent Values('0115ST',50,65,'0115STA65$50EEO','0115STA65$50ERO',500,99,'0115STA65$50EEA','0115STA65$50ERA');
Insert Into  CPFTableComponent Values('0115ST',500,65,'0115STA65$500EEO','0115STA65$500ERO',750,99,'0115STA65$500EEA','0115STA65$500ERA');
Insert Into  CPFTableComponent Values('0115ST',750,65,'0115STA65$750EEO','0115STA65$750ERO',999999999,99,'0115STA65$750EEA','0115STA65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 1 Full
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0115P1FA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115P1FA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1FA65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1FA65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1FA65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1FA65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0115P1FA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$50ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$50ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$500ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$500ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',17,850,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$750ERA',1,0,0,' (C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA0$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA50$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$50ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$50ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$500ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$500ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12,600,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$750ERA',1,0,0,' (C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA55$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$50ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$50ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$500ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$500ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',8.5,425,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$750ERA',1,0,0,' (C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA60$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$50ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$50ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$500ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$500ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$750ERA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1FA65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115P1F',0,0,'0115P1FA0$0EEO','0115P1FA0$0ERO',50,50,'0115P1FA0$0EEA','0115P1FA0$0ERA');
Insert Into  CPFTableComponent Values('0115P1F',50,0,'0115P1FA0$50EEO','0115P1FA0$50ERO',500,50,'0115P1FA0$50EEA','0115P1FA0$50ERA');
Insert Into  CPFTableComponent Values('0115P1F',500,0,'0115P1FA0$500EEO','0115P1FA0$500ERO',750,50,'0115P1FA0$500EEA','0115P1FA0$500ERA');
Insert Into  CPFTableComponent Values('0115P1F',750,0,'0115P1FA0$750EEO','0115P1FA0$750ERO',999999999,50,'0115P1FA0$750EEA','0115P1FA0$750ERA');
Insert Into  CPFTableComponent Values('0115P1F',0,50,'0115P1FA50$0EEO','0115P1FA50$0ERO',50,55,'0115P1FA50$0EEA','0115P1FA50$0ERA');
Insert Into  CPFTableComponent Values('0115P1F',50,50,'0115P1FA50$50EEO','0115P1FA50$50ERO',500,55,'0115P1FA50$50EEA','0115P1FA50$50ERA');
Insert Into  CPFTableComponent Values('0115P1F',500,50,'0115P1FA50$500EEO','0115P1FA50$500ERO',750,55,'0115P1FA50$500EEA','0115P1FA50$500ERA');
Insert Into  CPFTableComponent Values('0115P1F',750,50,'0115P1FA50$750EEO','0115P1FA50$750ERO',999999999,55,'0115P1FA50$750EEA','0115P1FA50$750ERA');
Insert Into  CPFTableComponent Values('0115P1F',0,55,'0115P1FA55$0EEO','0115P1FA55$0ERO',50,60,'0115P1FA55$0EEA','0115P1FA55$0ERA');
Insert Into  CPFTableComponent Values('0115P1F',50,55,'0115P1FA55$50EEO','0115P1FA55$50ERO',500,60,'0115P1FA55$50EEA','0115P1FA55$50ERA');
Insert Into  CPFTableComponent Values('0115P1F',500,55,'0115P1FA55$500EEO','0115P1FA55$500ERO',750,60,'0115P1FA55$500EEA','0115P1FA55$500ERA');
Insert Into  CPFTableComponent Values('0115P1F',750,55,'0115P1FA55$750EEO','0115P1FA55$750ERO',999999999,60,'0115P1FA55$750EEA','0115P1FA55$750ERA');
Insert Into  CPFTableComponent Values('0115P1F',0,60,'0115P1FA60$0EEO','0115P1FA60$0ERO',50,65,'0115P1FA60$0EEA','0115P1FA60$0ERA');
Insert Into  CPFTableComponent Values('0115P1F',50,60,'0115P1FA60$50EEO','0115P1FA60$50ERO',500,65,'0115P1FA60$50EEA','0115P1FA60$50ERA');
Insert Into  CPFTableComponent Values('0115P1F',500,60,'0115P1FA60$500EEO','0115P1FA60$500ERO',750,65,'0115P1FA60$500EEA','0115P1FA60$500ERA');
Insert Into  CPFTableComponent Values('0115P1F',750,60,'0115P1FA60$750EEO','0115P1FA60$750ERO',999999999,65,'0115P1FA60$750EEA','0115P1FA60$750ERA');
Insert Into  CPFTableComponent Values('0115P1F',0,65,'0115P1FA65$0EEO','0115P1FA65$0ERO',50,99,'0115P1FA65$0EEA','0115P1FA65$0ERA');
Insert Into  CPFTableComponent Values('0115P1F',50,65,'0115P1FA65$50EEO','0115P1FA65$50ERO',500,99,'0115P1FA65$50EEA','0115P1FA65$50ERA');
Insert Into  CPFTableComponent Values('0115P1F',500,65,'0115P1FA65$500EEO','0115P1FA65$500ERO',750,99,'0115P1FA65$500EEA','0115P1FA65$500ERA');
Insert Into  CPFTableComponent Values('0115P1F',750,65,'0115P1FA65$750EEO','0115P1FA65$750ERO',999999999,99,'0115P1FA65$750EEA','0115P1FA65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 1 Graduated
-----------------------------------------------------------------------------------------------------------*/


if not exists(select * from Formula where Locate(FormulaId,'0115P1A') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115P1A0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P1A65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P1A65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P1A65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P1A65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P1A65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0115P1A0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$50ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$50ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$500ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$500ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',4,200,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$750ERA',1,0,0,' (C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A0$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$50ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$50ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$500ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$500ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',4,200,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$750ERA',1,0,0,' (C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A50$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$50ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$50ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$500ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$500ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',4,200,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$750ERA',1,0,0,' (C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A55$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A60$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P1A65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115P1',0,0,'0115P1A0$0EEO','0115P1A0$0ERO',50,50,'0115P1A0$0EEA','0115P1A0$0ERA');
Insert Into  CPFTableComponent Values('0115P1',50,0,'0115P1A0$50EEO','0115P1A0$50ERO',500,50,'0115P1A0$50EEA','0115P1A0$50ERA');
Insert Into  CPFTableComponent Values('0115P1',500,0,'0115P1A0$500EEO','0115P1A0$500ERO',750,50,'0115P1A0$500EEA','0115P1A0$500ERA');
Insert Into  CPFTableComponent Values('0115P1',750,0,'0115P1A0$750EEO','0115P1A0$750ERO',999999999,50,'0115P1A0$750EEA','0115P1A0$750ERA');
Insert Into  CPFTableComponent Values('0115P1',0,50,'0115P1A50$0EEO','0115P1A50$0ERO',50,55,'0115P1A50$0EEA','0115P1A50$0ERA');
Insert Into  CPFTableComponent Values('0115P1',50,50,'0115P1A50$50EEO','0115P1A50$50ERO',500,55,'0115P1A50$50EEA','0115P1A50$50ERA');
Insert Into  CPFTableComponent Values('0115P1',500,50,'0115P1A50$500EEO','0115P1A50$500ERO',750,55,'0115P1A50$500EEA','0115P1A50$500ERA');
Insert Into  CPFTableComponent Values('0115P1',750,50,'0115P1A50$750EEO','0115P1A50$750ERO',999999999,55,'0115P1A50$750EEA','0115P1A50$750ERA');
Insert Into  CPFTableComponent Values('0115P1',0,55,'0115P1A55$0EEO','0115P1A55$0ERO',50,60,'0115P1A55$0EEA','0115P1A55$0ERA');
Insert Into  CPFTableComponent Values('0115P1',50,55,'0115P1A55$50EEO','0115P1A55$50ERO',500,60,'0115P1A55$50EEA','0115P1A55$50ERA');
Insert Into  CPFTableComponent Values('0115P1',500,55,'0115P1A55$500EEO','0115P1A55$500ERO',750,60,'0115P1A55$500EEA','0115P1A55$500ERA');
Insert Into  CPFTableComponent Values('0115P1',750,55,'0115P1A55$750EEO','0115P1A55$750ERO',999999999,60,'0115P1A55$750EEA','0115P1A55$750ERA');
Insert Into  CPFTableComponent Values('0115P1',0,60,'0115P1A60$0EEO','0115P1A60$0ERO',50,65,'0115P1A60$0EEA','0115P1A60$0ERA');
Insert Into  CPFTableComponent Values('0115P1',50,60,'0115P1A60$50EEO','0115P1A60$50ERO',500,65,'0115P1A60$50EEA','0115P1A60$50ERA');
Insert Into  CPFTableComponent Values('0115P1',500,60,'0115P1A60$500EEO','0115P1A60$500ERO',750,65,'0115P1A60$500EEA','0115P1A60$500ERA');
Insert Into  CPFTableComponent Values('0115P1',750,60,'0115P1A60$750EEO','0115P1A60$750ERO',999999999,65,'0115P1A60$750EEA','0115P1A60$750ERA');
Insert Into  CPFTableComponent Values('0115P1',0,65,'0115P1A65$0EEO','0115P1A65$0ERO',50,99,'0115P1A65$0EEA','0115P1A65$0ERA');
Insert Into  CPFTableComponent Values('0115P1',50,65,'0115P1A65$50EEO','0115P1A65$50ERO',500,99,'0115P1A65$50EEA','0115P1A65$50ERA');
Insert Into  CPFTableComponent Values('0115P1',500,65,'0115P1A65$500EEO','0115P1A65$500ERO',750,99,'0115P1A65$500EEA','0115P1A65$500ERA');
Insert Into  CPFTableComponent Values('0115P1',750,65,'0115P1A65$750EEO','0115P1A65$750ERO',999999999,99,'0115P1A65$750EEA','0115P1A65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 2 Full
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0115P2FA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115P2FA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2FA65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2FA65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2FA65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2FA65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0115P2FA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$50ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$50ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$500ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$500ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',17,850,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$750ERA',1,0,0,' (C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA0$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA50$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$50ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$50ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$500ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$500ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12,600,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$750ERA',1,0,0,' (C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12.5,625,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA55$750EEA',1,0,0,' (C1/100)*K3;',12.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$50ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$50ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$500ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$500ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',8.5,425,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$750ERA',1,0,0,' (C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$50ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$50ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$500ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$500ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$750ERA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2FA65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115P2F',0,0,'0115P2FA0$0EEO','0115P2FA0$0ERO',50,50,'0115P2FA0$0EEA','0115P2FA0$0ERA');
Insert Into  CPFTableComponent Values('0115P2F',50,0,'0115P2FA0$50EEO','0115P2FA0$50ERO',500,50,'0115P2FA0$50EEA','0115P2FA0$50ERA');
Insert Into  CPFTableComponent Values('0115P2F',500,0,'0115P2FA0$500EEO','0115P2FA0$500ERO',750,50,'0115P2FA0$500EEA','0115P2FA0$500ERA');
Insert Into  CPFTableComponent Values('0115P2F',750,0,'0115P2FA0$750EEO','0115P2FA0$750ERO',999999999,50,'0115P2FA0$750EEA','0115P2FA0$750ERA');
Insert Into  CPFTableComponent Values('0115P2F',0,50,'0115P2FA50$0EEO','0115P2FA50$0ERO',50,55,'0115P2FA50$0EEA','0115P2FA50$0ERA');
Insert Into  CPFTableComponent Values('0115P2F',50,50,'0115P2FA50$50EEO','0115P2FA50$50ERO',500,55,'0115P2FA50$50EEA','0115P2FA50$50ERA');
Insert Into  CPFTableComponent Values('0115P2F',500,50,'0115P2FA50$500EEO','0115P2FA50$500ERO',750,55,'0115P2FA50$500EEA','0115P2FA50$500ERA');
Insert Into  CPFTableComponent Values('0115P2F',750,50,'0115P2FA50$750EEO','0115P2FA50$750ERO',999999999,55,'0115P2FA50$750EEA','0115P2FA50$750ERA');
Insert Into  CPFTableComponent Values('0115P2F',0,55,'0115P2FA55$0EEO','0115P2FA55$0ERO',50,60,'0115P2FA55$0EEA','0115P2FA55$0ERA');
Insert Into  CPFTableComponent Values('0115P2F',50,55,'0115P2FA55$50EEO','0115P2FA55$50ERO',500,60,'0115P2FA55$50EEA','0115P2FA55$50ERA');
Insert Into  CPFTableComponent Values('0115P2F',500,55,'0115P2FA55$500EEO','0115P2FA55$500ERO',750,60,'0115P2FA55$500EEA','0115P2FA55$500ERA');
Insert Into  CPFTableComponent Values('0115P2F',750,55,'0115P2FA55$750EEO','0115P2FA55$750ERO',999999999,60,'0115P2FA55$750EEA','0115P2FA55$750ERA');
Insert Into  CPFTableComponent Values('0115P2F',0,60,'0115P2FA60$0EEO','0115P2FA60$0ERO',50,65,'0115P2FA60$0EEA','0115P2FA60$0ERA');
Insert Into  CPFTableComponent Values('0115P2F',50,60,'0115P2FA60$50EEO','0115P2FA60$50ERO',500,65,'0115P2FA60$50EEA','0115P2FA60$50ERA');
Insert Into  CPFTableComponent Values('0115P2F',500,60,'0115P2FA60$500EEO','0115P2FA60$500ERO',750,65,'0115P2FA60$500EEA','0115P2FA60$500ERA');
Insert Into  CPFTableComponent Values('0115P2F',750,60,'0115P2FA60$750EEO','0115P2FA60$750ERO',999999999,65,'0115P2FA60$750EEA','0115P2FA60$750ERA');
Insert Into  CPFTableComponent Values('0115P2F',0,65,'0115P2FA65$0EEO','0115P2FA65$0ERO',50,99,'0115P2FA65$0EEA','0115P2FA65$0ERA');
Insert Into  CPFTableComponent Values('0115P2F',50,65,'0115P2FA65$50EEO','0115P2FA65$50ERO',500,99,'0115P2FA65$50EEA','0115P2FA65$50ERA');
Insert Into  CPFTableComponent Values('0115P2F',500,65,'0115P2FA65$500EEO','0115P2FA65$500ERO',750,99,'0115P2FA65$500EEA','0115P2FA65$500ERA');
Insert Into  CPFTableComponent Values('0115P2F',750,65,'0115P2FA65$750EEO','0115P2FA65$750ERO',999999999,99,'0115P2FA65$750EEA','0115P2FA65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 2 Graduated
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0115P2A') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115P2A0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P2A65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P2A65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P2A65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P2A65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P2A65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0115P2A0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$50ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$50ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$500ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$500ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',9,450,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$750ERA',1,0,0,' (C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A0$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$50ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$50ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$500ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$500ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',9,450,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$750ERA',1,0,0,' (C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A50$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$50ERO',1,0,0,'(C1/100)*K2;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$50ERA',1,0,0,'(C1/100)*K3;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$500ERO',1,0,0,'(C1/100)*K2;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$500ERA',1,0,0,'(C1/100)*K3;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',6,300,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$750ERA',1,0,0,' (C1/100)*K3;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12.5,625,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A55$750EEA',1,0,0,' (C1/100)*K3;',12.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P2A65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115P2',0,0,'0115P2A0$0EEO','0115P2A0$0ERO',50,50,'0115P2A0$0EEA','0115P2A0$0ERA');
Insert Into  CPFTableComponent Values('0115P2',50,0,'0115P2A0$50EEO','0115P2A0$50ERO',500,50,'0115P2A0$50EEA','0115P2A0$50ERA');
Insert Into  CPFTableComponent Values('0115P2',500,0,'0115P2A0$500EEO','0115P2A0$500ERO',750,50,'0115P2A0$500EEA','0115P2A0$500ERA');
Insert Into  CPFTableComponent Values('0115P2',750,0,'0115P2A0$750EEO','0115P2A0$750ERO',999999999,50,'0115P2A0$750EEA','0115P2A0$750ERA');
Insert Into  CPFTableComponent Values('0115P2',0,50,'0115P2A50$0EEO','0115P2A50$0ERO',50,55,'0115P2A50$0EEA','0115P2A50$0ERA');
Insert Into  CPFTableComponent Values('0115P2',50,50,'0115P2A50$50EEO','0115P2A50$50ERO',500,55,'0115P2A50$50EEA','0115P2A50$50ERA');
Insert Into  CPFTableComponent Values('0115P2',500,50,'0115P2A50$500EEO','0115P2A50$500ERO',750,55,'0115P2A50$500EEA','0115P2A50$500ERA');
Insert Into  CPFTableComponent Values('0115P2',750,50,'0115P2A50$750EEO','0115P2A50$750ERO',999999999,55,'0115P2A50$750EEA','0115P2A50$750ERA');
Insert Into  CPFTableComponent Values('0115P2',0,55,'0115P2A55$0EEO','0115P2A55$0ERO',50,60,'0115P2A55$0EEA','0115P2A55$0ERA');
Insert Into  CPFTableComponent Values('0115P2',50,55,'0115P2A55$50EEO','0115P2A55$50ERO',500,60,'0115P2A55$50EEA','0115P2A55$50ERA');
Insert Into  CPFTableComponent Values('0115P2',500,55,'0115P2A55$500EEO','0115P2A55$500ERO',750,60,'0115P2A55$500EEA','0115P2A55$500ERA');
Insert Into  CPFTableComponent Values('0115P2',750,55,'0115P2A55$750EEO','0115P2A55$750ERO',999999999,60,'0115P2A55$750EEA','0115P2A55$750ERA');
Insert Into  CPFTableComponent Values('0115P2',0,60,'0115P2A60$0EEO','0115P2A60$0ERO',50,65,'0115P2A60$0EEA','0115P2A60$0ERA');
Insert Into  CPFTableComponent Values('0115P2',50,60,'0115P2A60$50EEO','0115P2A60$50ERO',500,65,'0115P2A60$50EEA','0115P2A60$50ERA');
Insert Into  CPFTableComponent Values('0115P2',500,60,'0115P2A60$500EEO','0115P2A60$500ERO',750,65,'0115P2A60$500EEA','0115P2A60$500ERA');
Insert Into  CPFTableComponent Values('0115P2',750,60,'0115P2A60$750EEO','0115P2A60$750ERO',999999999,65,'0115P2A60$750EEA','0115P2A60$750ERA');
Insert Into  CPFTableComponent Values('0115P2',0,65,'0115P2A65$0EEO','0115P2A65$0ERO',50,99,'0115P2A65$0EEA','0115P2A65$0ERA');
Insert Into  CPFTableComponent Values('0115P2',50,65,'0115P2A65$50EEO','0115P2A65$50ERO',500,99,'0115P2A65$50EEA','0115P2A65$50ERA');
Insert Into  CPFTableComponent Values('0115P2',500,65,'0115P2A65$500EEO','0115P2A65$500ERO',750,99,'0115P2A65$500EEA','0115P2A65$500ERA');
Insert Into  CPFTableComponent Values('0115P2',750,65,'0115P2A65$750EEO','0115P2A65$750ERO',999999999,99,'0115P2A65$750EEA','0115P2A65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 3
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0115P3A') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0115P3A0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0115P3A65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0115P3A65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0115P3A65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0115P3A65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0115P3A65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0115P3A0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$50ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$50ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$500ERO',1,0,0,'(C1/100)*K2;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$500ERA',1,0,0,'(C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',17,850,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$750ERA',1,0,0,' (C1/100)*K3;',17,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',20,1000,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A0$750EEA',1,0,0,' (C1/100)*K3;',20,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.57,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.57,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',19,950,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A50$750EEA',1,0,0,' (C1/100)*K3;',19,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$50ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$50ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$500ERO',1,0,0,'(C1/100)*K2;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$500ERA',1,0,0,'(C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12,600,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$750ERA',1,0,0,' (C1/100)*K3;',12,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',13,650,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A55$750EEA',1,0,0,' (C1/100)*K3;',13,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$50ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$50ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$500ERO',1,0,0,'(C1/100)*K2;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$500ERA',1,0,0,'(C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',8.5,425,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$750ERA',1,0,0,' (C1/100)*K3;',8.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$50ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$50ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$500ERO',1,0,0,'(C1/100)*K2;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$500ERA',1,0,0,'(C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$750ERA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0115P3A65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0115P3',0,0,'0115P3A0$0EEO','0115P3A0$0ERO',50,50,'0115P3A0$0EEA','0115P3A0$0ERA');
Insert Into  CPFTableComponent Values('0115P3',50,0,'0115P3A0$50EEO','0115P3A0$50ERO',500,50,'0115P3A0$50EEA','0115P3A0$50ERA');
Insert Into  CPFTableComponent Values('0115P3',500,0,'0115P3A0$500EEO','0115P3A0$500ERO',750,50,'0115P3A0$500EEA','0115P3A0$500ERA');
Insert Into  CPFTableComponent Values('0115P3',750,0,'0115P3A0$750EEO','0115P3A0$750ERO',999999999,50,'0115P3A0$750EEA','0115P3A0$750ERA');
Insert Into  CPFTableComponent Values('0115P3',0,50,'0115P3A50$0EEO','0115P3A50$0ERO',50,55,'0115P3A50$0EEA','0115P3A50$0ERA');
Insert Into  CPFTableComponent Values('0115P3',50,50,'0115P3A50$50EEO','0115P3A50$50ERO',500,55,'0115P3A50$50EEA','0115P3A50$50ERA');
Insert Into  CPFTableComponent Values('0115P3',500,50,'0115P3A50$500EEO','0115P3A50$500ERO',750,55,'0115P3A50$500EEA','0115P3A50$500ERA');
Insert Into  CPFTableComponent Values('0115P3',750,50,'0115P3A50$750EEO','0115P3A50$750ERO',999999999,55,'0115P3A50$750EEA','0115P3A50$750ERA');
Insert Into  CPFTableComponent Values('0115P3',0,55,'0115P3A55$0EEO','0115P3A55$0ERO',50,60,'0115P3A55$0EEA','0115P3A55$0ERA');
Insert Into  CPFTableComponent Values('0115P3',50,55,'0115P3A55$50EEO','0115P3A55$50ERO',500,60,'0115P3A55$50EEA','0115P3A55$50ERA');
Insert Into  CPFTableComponent Values('0115P3',500,55,'0115P3A55$500EEO','0115P3A55$500ERO',750,60,'0115P3A55$500EEA','0115P3A55$500ERA');
Insert Into  CPFTableComponent Values('0115P3',750,55,'0115P3A55$750EEO','0115P3A55$750ERO',999999999,60,'0115P3A55$750EEA','0115P3A55$750ERA');
Insert Into  CPFTableComponent Values('0115P3',0,60,'0115P3A60$0EEO','0115P3A60$0ERO',50,65,'0115P3A60$0EEA','0115P3A60$0ERA');
Insert Into  CPFTableComponent Values('0115P3',50,60,'0115P3A60$50EEO','0115P3A60$50ERO',500,65,'0115P3A60$50EEA','0115P3A60$50ERA');
Insert Into  CPFTableComponent Values('0115P3',500,60,'0115P3A60$500EEO','0115P3A60$500ERO',750,65,'0115P3A60$500EEA','0115P3A60$500ERA');
Insert Into  CPFTableComponent Values('0115P3',750,60,'0115P3A60$750EEO','0115P3A60$750ERO',999999999,65,'0115P3A60$750EEA','0115P3A60$750ERA');
Insert Into  CPFTableComponent Values('0115P3',0,65,'0115P3A65$0EEO','0115P3A65$0ERO',50,99,'0115P3A65$0EEA','0115P3A65$0ERA');
Insert Into  CPFTableComponent Values('0115P3',50,65,'0115P3A65$50EEO','0115P3A65$50ERO',500,99,'0115P3A65$50EEA','0115P3A65$50ERA');
Insert Into  CPFTableComponent Values('0115P3',500,65,'0115P3A65$500EEO','0115P3A65$500ERO',750,99,'0115P3A65$500EEA','0115P3A65$500ERA');
Insert Into  CPFTableComponent Values('0115P3',750,65,'0115P3A65$750EEO','0115P3A65$750ERO',999999999,99,'0115P3A65$750EEA','0115P3A65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	CPF Progression
-----------------------------------------------------------------------------------------------------------*/

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
CPFMedisavePaidByER)
Select CPFProgression.EmployeeSysId, 
'2015-01-01', 
'',
'Year2015Jan', 
0, 
CPFProgAccountNo, 
CPFProgSchemeId,
CPFMAWOption,
CPFMAWLimit,
'',
CPFMAWPeriodOrdWage,
CPFMedisavePaidByER
From PayEmployee join CPFProgression 
On PayEmployee.EmployeeSysId = CPFProgression.EmployeeSysId
Where CPFProgCurrent = 1 and CPFEffectiveDate < '2015-01-01' and CPFProgSchemeId != ''
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2015-01-01')
And Not exists(Select * From CPFProgression as CheckCPF where CheckCPF.CPFEffectiveDate = '2015-01-01' and CheckCPF.EmployeeSysID = CPFProgression.EmployeeSysId)
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='Year2015Jan'
Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';

