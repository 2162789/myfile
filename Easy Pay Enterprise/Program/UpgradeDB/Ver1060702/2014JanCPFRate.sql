/*-----------------------------------------------------------------------------------------------------------
	CPF Policy and Tables
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from CPFPolicy where CPFPolicyId = 'Year2014Jan' ) then
Insert into CPFPolicy Values('Year2014Jan',1,'16% Employer, 20% Employee wef 1 January 2014');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114ST') then
Insert into CPFTableCode Values('0114ST','Local','Private','Local Citizen Employer 16%, Employee 20% wef January 1, 2014',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114P1') then
Insert into CPFTableCode Values('0114P1','PR1','Private','PR 1st year - Employer Graduated 4%, Employee Graduated 5% wef January 1, 2014',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114P1');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114P2') then
Insert into CPFTableCode Values('0114P2','PR2','Private','PR 2nd year - Employer Graduated 9%, Employee Graduated 15% wef January 1, 2014',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114P2');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114P3') then
Insert into CPFTableCode Values('0114P3','PR3','Private','PR 3rd year and above - Employer 16%, Employee 20% wef January 1, 2014',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114P3');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114P1F') then
Insert into CPFTableCode Values('0114P1F','PR1','Private - Full','PR 1st year - Employer Full 16%, Employee Graduated 5% wef  January 1, 2014',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114P1F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114P2F') then
Insert into CPFTableCode Values('0114P2F','PR2','Private - Full','PR 2nd year - Employer Full 16%, Employee Graduated 15% wef  January 1, 2014',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114P2F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114EP') then
Insert into CPFTableCode Values('0114EP','EP','Private','Voluntary Contributions - user defined',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114EP');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0114FW') then
Insert into CPFTableCode Values('0114FW','FW','Private','Voluntary Contributions - user defined',5000,85000,0);
Insert into CPFPolicyMember Values('Year2014Jan','0114FW');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2014-01-01') then
Insert into CPFGovernmentProgression Values('2014-01-01','Year2014Jan',1,'');
end if;

/*-----------------------------------------------------------------------------------------------------------
	EP
-----------------------------------------------------------------------------------------------------------*/


if not exists(select * from Formula where Locate(FormulaId,'0114EPA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114EPA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114EPA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114EPA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114EPA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into FormulaRange Values('0114EPA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114EPA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114EPA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114EPA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114EP',0,0,'0114EPA0$0EEO','0114EPA0$0ERO',9999999,99,'0114EPA0$0EEA','0114EPA0$0ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	FW
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0114FWA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114FWA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114FWA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114FWA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114FWA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into FormulaRange Values('0114FWA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114FWA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114FWA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114FWA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114FW',0,0,'0114FWA0$0EEO','0114FWA0$0ERO',9999999,99,'0114FWA0$0EEA','0114FWA0$0ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	Local
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0114STA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114STA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114STA65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114STA65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114STA65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114STA65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114STA65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0114STA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',20,1000,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA0$750EEA',1,0,0,' (C1/100)*K3;',20,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$50ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$50ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$500ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$500ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.555,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.555,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',14,700,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$750ERA',1,0,0,' (C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',18.5,925,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA50$750EEA',1,0,0,' (C1/100)*K3;',18.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$50ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$50ERA',1,0,0,'(C1/100)*K3;',10.5,50,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$500ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$500ERA',1,0,0,'(C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',10.5,525,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$750ERA',1,0,0,' (C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',13,650,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA55$750EEA',1,0,0,' (C1/100)*K3;',13,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$50ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$50ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$500ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$500ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7,350,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$750ERA',1,0,0,' (C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$50ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$50ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$500ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$500ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',6.5,325,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$750ERA',1,0,0,' (C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114STA65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114ST',0,0,'0114STA0$0EEO','0114STA0$0ERO',50,50,'0114STA0$0EEA','0114STA0$0ERA');
Insert Into  CPFTableComponent Values('0114ST',50,0,'0114STA0$50EEO','0114STA0$50ERO',500,50,'0114STA0$50EEA','0114STA0$50ERA');
Insert Into  CPFTableComponent Values('0114ST',500,0,'0114STA0$500EEO','0114STA0$500ERO',750,50,'0114STA0$500EEA','0114STA0$500ERA');
Insert Into  CPFTableComponent Values('0114ST',750,0,'0114STA0$750EEO','0114STA0$750ERO',9999999,50,'0114STA0$750EEA','0114STA0$750ERA');
Insert Into  CPFTableComponent Values('0114ST',0,50,'0114STA50$0EEO','0114STA50$0ERO',50,55,'0114STA50$0EEA','0114STA50$0ERA');
Insert Into  CPFTableComponent Values('0114ST',50,50,'0114STA50$50EEO','0114STA50$50ERO',500,55,'0114STA50$50EEA','0114STA50$50ERA');
Insert Into  CPFTableComponent Values('0114ST',500,50,'0114STA50$500EEO','0114STA50$500ERO',750,55,'0114STA50$500EEA','0114STA50$500ERA');
Insert Into  CPFTableComponent Values('0114ST',750,50,'0114STA50$750EEO','0114STA50$750ERO',9999999,55,'0114STA50$750EEA','0114STA50$750ERA');
Insert Into  CPFTableComponent Values('0114ST',0,55,'0114STA55$0EEO','0114STA55$0ERO',50,60,'0114STA55$0EEA','0114STA55$0ERA');
Insert Into  CPFTableComponent Values('0114ST',50,55,'0114STA55$50EEO','0114STA55$50ERO',500,60,'0114STA55$50EEA','0114STA55$50ERA');
Insert Into  CPFTableComponent Values('0114ST',500,55,'0114STA55$500EEO','0114STA55$500ERO',750,60,'0114STA55$500EEA','0114STA55$500ERA');
Insert Into  CPFTableComponent Values('0114ST',750,55,'0114STA55$750EEO','0114STA55$750ERO',9999999,60,'0114STA55$750EEA','0114STA55$750ERA');
Insert Into  CPFTableComponent Values('0114ST',0,60,'0114STA60$0EEO','0114STA60$0ERO',50,65,'0114STA60$0EEA','0114STA60$0ERA');
Insert Into  CPFTableComponent Values('0114ST',50,60,'0114STA60$50EEO','0114STA60$50ERO',500,65,'0114STA60$50EEA','0114STA60$50ERA');
Insert Into  CPFTableComponent Values('0114ST',500,60,'0114STA60$500EEO','0114STA60$500ERO',750,65,'0114STA60$500EEA','0114STA60$500ERA');
Insert Into  CPFTableComponent Values('0114ST',750,60,'0114STA60$750EEO','0114STA60$750ERO',9999999,65,'0114STA60$750EEA','0114STA60$750ERA');
Insert Into  CPFTableComponent Values('0114ST',0,65,'0114STA65$0EEO','0114STA65$0ERO',50,99,'0114STA65$0EEA','0114STA65$0ERA');
Insert Into  CPFTableComponent Values('0114ST',50,65,'0114STA65$50EEO','0114STA65$50ERO',500,99,'0114STA65$50EEA','0114STA65$50ERA');
Insert Into  CPFTableComponent Values('0114ST',500,65,'0114STA65$500EEO','0114STA65$500ERO',750,99,'0114STA65$500EEA','0114STA65$500ERA');
Insert Into  CPFTableComponent Values('0114ST',750,65,'0114STA65$750EEO','0114STA65$750ERO',9999999,99,'0114STA65$750EEA','0114STA65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 1 Full
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0114P1FA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114P1FA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1FA65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1FA65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1FA65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1FA65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0114P1FA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA0$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$50ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$50ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$500ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$500ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',14,700,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$750ERA',1,0,0,' (C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA50$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$50ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$50ERA',1,0,0,'(C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$500ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$500ERA',1,0,0,'(C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',10.5,525,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$750ERA',1,0,0,' (C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA55$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$50ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$50ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$500ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$500ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7,350,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$750ERA',1,0,0,' (C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA60$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$50ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$50ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$500ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$500ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',6.5,325,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$750ERA',1,0,0,' (C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1FA65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114P1F',0,0,'0114P1FA0$0EEO','0114P1FA0$0ERO',50,50,'0114P1FA0$0EEA','0114P1FA0$0ERA');
Insert Into  CPFTableComponent Values('0114P1F',50,0,'0114P1FA0$50EEO','0114P1FA0$50ERO',500,50,'0114P1FA0$50EEA','0114P1FA0$50ERA');
Insert Into  CPFTableComponent Values('0114P1F',500,0,'0114P1FA0$500EEO','0114P1FA0$500ERO',750,50,'0114P1FA0$500EEA','0114P1FA0$500ERA');
Insert Into  CPFTableComponent Values('0114P1F',750,0,'0114P1FA0$750EEO','0114P1FA0$750ERO',9999999,50,'0114P1FA0$750EEA','0114P1FA0$750ERA');
Insert Into  CPFTableComponent Values('0114P1F',0,50,'0114P1FA50$0EEO','0114P1FA50$0ERO',50,55,'0114P1FA50$0EEA','0114P1FA50$0ERA');
Insert Into  CPFTableComponent Values('0114P1F',50,50,'0114P1FA50$50EEO','0114P1FA50$50ERO',500,55,'0114P1FA50$50EEA','0114P1FA50$50ERA');
Insert Into  CPFTableComponent Values('0114P1F',500,50,'0114P1FA50$500EEO','0114P1FA50$500ERO',750,55,'0114P1FA50$500EEA','0114P1FA50$500ERA');
Insert Into  CPFTableComponent Values('0114P1F',750,50,'0114P1FA50$750EEO','0114P1FA50$750ERO',9999999,55,'0114P1FA50$750EEA','0114P1FA50$750ERA');
Insert Into  CPFTableComponent Values('0114P1F',0,55,'0114P1FA55$0EEO','0114P1FA55$0ERO',50,60,'0114P1FA55$0EEA','0114P1FA55$0ERA');
Insert Into  CPFTableComponent Values('0114P1F',50,55,'0114P1FA55$50EEO','0114P1FA55$50ERO',500,60,'0114P1FA55$50EEA','0114P1FA55$50ERA');
Insert Into  CPFTableComponent Values('0114P1F',500,55,'0114P1FA55$500EEO','0114P1FA55$500ERO',750,60,'0114P1FA55$500EEA','0114P1FA55$500ERA');
Insert Into  CPFTableComponent Values('0114P1F',750,55,'0114P1FA55$750EEO','0114P1FA55$750ERO',9999999,60,'0114P1FA55$750EEA','0114P1FA55$750ERA');
Insert Into  CPFTableComponent Values('0114P1F',0,60,'0114P1FA60$0EEO','0114P1FA60$0ERO',50,65,'0114P1FA60$0EEA','0114P1FA60$0ERA');
Insert Into  CPFTableComponent Values('0114P1F',50,60,'0114P1FA60$50EEO','0114P1FA60$50ERO',500,65,'0114P1FA60$50EEA','0114P1FA60$50ERA');
Insert Into  CPFTableComponent Values('0114P1F',500,60,'0114P1FA60$500EEO','0114P1FA60$500ERO',750,65,'0114P1FA60$500EEA','0114P1FA60$500ERA');
Insert Into  CPFTableComponent Values('0114P1F',750,60,'0114P1FA60$750EEO','0114P1FA60$750ERO',9999999,65,'0114P1FA60$750EEA','0114P1FA60$750ERA');
Insert Into  CPFTableComponent Values('0114P1F',0,65,'0114P1FA65$0EEO','0114P1FA65$0ERO',50,99,'0114P1FA65$0EEA','0114P1FA65$0ERA');
Insert Into  CPFTableComponent Values('0114P1F',50,65,'0114P1FA65$50EEO','0114P1FA65$50ERO',500,99,'0114P1FA65$50EEA','0114P1FA65$50ERA');
Insert Into  CPFTableComponent Values('0114P1F',500,65,'0114P1FA65$500EEO','0114P1FA65$500ERO',750,99,'0114P1FA65$500EEA','0114P1FA65$500ERA');
Insert Into  CPFTableComponent Values('0114P1F',750,65,'0114P1FA65$750EEO','0114P1FA65$750ERO',9999999,99,'0114P1FA65$750EEA','0114P1FA65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 1 Graduated
-----------------------------------------------------------------------------------------------------------*/


if not exists(select * from Formula where Locate(FormulaId,'0114P1A') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114P1A0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P1A65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P1A65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P1A65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P1A65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P1A65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0114P1A0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$50ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$50ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$500ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$500ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',4,200,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$750ERA',1,0,0,' (C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A0$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$50ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$50ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$500ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$500ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',4,200,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$750ERA',1,0,0,' (C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A50$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$50ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$50ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$500ERO',1,0,0,'(C1/100)*K2;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$500ERA',1,0,0,'(C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',4,200,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$750ERA',1,0,0,' (C1/100)*K3;',4,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A55$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A60$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P1A65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114P1',0,0,'0114P1A0$0EEO','0114P1A0$0ERO',50,50,'0114P1A0$0EEA','0114P1A0$0ERA');
Insert Into  CPFTableComponent Values('0114P1',50,0,'0114P1A0$50EEO','0114P1A0$50ERO',500,50,'0114P1A0$50EEA','0114P1A0$50ERA');
Insert Into  CPFTableComponent Values('0114P1',500,0,'0114P1A0$500EEO','0114P1A0$500ERO',750,50,'0114P1A0$500EEA','0114P1A0$500ERA');
Insert Into  CPFTableComponent Values('0114P1',750,0,'0114P1A0$750EEO','0114P1A0$750ERO',9999999,50,'0114P1A0$750EEA','0114P1A0$750ERA');
Insert Into  CPFTableComponent Values('0114P1',0,50,'0114P1A50$0EEO','0114P1A50$0ERO',50,55,'0114P1A50$0EEA','0114P1A50$0ERA');
Insert Into  CPFTableComponent Values('0114P1',50,50,'0114P1A50$50EEO','0114P1A50$50ERO',500,55,'0114P1A50$50EEA','0114P1A50$50ERA');
Insert Into  CPFTableComponent Values('0114P1',500,50,'0114P1A50$500EEO','0114P1A50$500ERO',750,55,'0114P1A50$500EEA','0114P1A50$500ERA');
Insert Into  CPFTableComponent Values('0114P1',750,50,'0114P1A50$750EEO','0114P1A50$750ERO',9999999,55,'0114P1A50$750EEA','0114P1A50$750ERA');
Insert Into  CPFTableComponent Values('0114P1',0,55,'0114P1A55$0EEO','0114P1A55$0ERO',50,60,'0114P1A55$0EEA','0114P1A55$0ERA');
Insert Into  CPFTableComponent Values('0114P1',50,55,'0114P1A55$50EEO','0114P1A55$50ERO',500,60,'0114P1A55$50EEA','0114P1A55$50ERA');
Insert Into  CPFTableComponent Values('0114P1',500,55,'0114P1A55$500EEO','0114P1A55$500ERO',750,60,'0114P1A55$500EEA','0114P1A55$500ERA');
Insert Into  CPFTableComponent Values('0114P1',750,55,'0114P1A55$750EEO','0114P1A55$750ERO',9999999,60,'0114P1A55$750EEA','0114P1A55$750ERA');
Insert Into  CPFTableComponent Values('0114P1',0,60,'0114P1A60$0EEO','0114P1A60$0ERO',50,65,'0114P1A60$0EEA','0114P1A60$0ERA');
Insert Into  CPFTableComponent Values('0114P1',50,60,'0114P1A60$50EEO','0114P1A60$50ERO',500,65,'0114P1A60$50EEA','0114P1A60$50ERA');
Insert Into  CPFTableComponent Values('0114P1',500,60,'0114P1A60$500EEO','0114P1A60$500ERO',750,65,'0114P1A60$500EEA','0114P1A60$500ERA');
Insert Into  CPFTableComponent Values('0114P1',750,60,'0114P1A60$750EEO','0114P1A60$750ERO',9999999,65,'0114P1A60$750EEA','0114P1A60$750ERA');
Insert Into  CPFTableComponent Values('0114P1',0,65,'0114P1A65$0EEO','0114P1A65$0ERO',50,99,'0114P1A65$0EEA','0114P1A65$0ERA');
Insert Into  CPFTableComponent Values('0114P1',50,65,'0114P1A65$50EEO','0114P1A65$50ERO',500,99,'0114P1A65$50EEA','0114P1A65$50ERA');
Insert Into  CPFTableComponent Values('0114P1',500,65,'0114P1A65$500EEO','0114P1A65$500ERO',750,99,'0114P1A65$500EEA','0114P1A65$500ERA');
Insert Into  CPFTableComponent Values('0114P1',750,65,'0114P1A65$750EEO','0114P1A65$750ERO',9999999,99,'0114P1A65$750EEA','0114P1A65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 2 Full
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0114P2FA') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114P2FA0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2FA65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2FA65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2FA65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2FA65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0114P2FA0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA0$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$50ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$50ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$500ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$500ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',14,700,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$750ERA',1,0,0,' (C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA50$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$50ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$50ERA',1,0,0,'(C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$500ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$500ERA',1,0,0,'(C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',10.5,525,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$750ERA',1,0,0,' (C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12.5,625,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA55$750EEA',1,0,0,' (C1/100)*K3;',12.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$50ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$50ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$500ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$500ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7,350,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$750ERA',1,0,0,' (C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$50ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$50ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$500ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$500ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',6.5,325,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$750ERA',1,0,0,' (C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2FA65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114P2F',0,0,'0114P2FA0$0EEO','0114P2FA0$0ERO',50,50,'0114P2FA0$0EEA','0114P2FA0$0ERA');
Insert Into  CPFTableComponent Values('0114P2F',50,0,'0114P2FA0$50EEO','0114P2FA0$50ERO',500,50,'0114P2FA0$50EEA','0114P2FA0$50ERA');
Insert Into  CPFTableComponent Values('0114P2F',500,0,'0114P2FA0$500EEO','0114P2FA0$500ERO',750,50,'0114P2FA0$500EEA','0114P2FA0$500ERA');
Insert Into  CPFTableComponent Values('0114P2F',750,0,'0114P2FA0$750EEO','0114P2FA0$750ERO',9999999,50,'0114P2FA0$750EEA','0114P2FA0$750ERA');
Insert Into  CPFTableComponent Values('0114P2F',0,50,'0114P2FA50$0EEO','0114P2FA50$0ERO',50,55,'0114P2FA50$0EEA','0114P2FA50$0ERA');
Insert Into  CPFTableComponent Values('0114P2F',50,50,'0114P2FA50$50EEO','0114P2FA50$50ERO',500,55,'0114P2FA50$50EEA','0114P2FA50$50ERA');
Insert Into  CPFTableComponent Values('0114P2F',500,50,'0114P2FA50$500EEO','0114P2FA50$500ERO',750,55,'0114P2FA50$500EEA','0114P2FA50$500ERA');
Insert Into  CPFTableComponent Values('0114P2F',750,50,'0114P2FA50$750EEO','0114P2FA50$750ERO',9999999,55,'0114P2FA50$750EEA','0114P2FA50$750ERA');
Insert Into  CPFTableComponent Values('0114P2F',0,55,'0114P2FA55$0EEO','0114P2FA55$0ERO',50,60,'0114P2FA55$0EEA','0114P2FA55$0ERA');
Insert Into  CPFTableComponent Values('0114P2F',50,55,'0114P2FA55$50EEO','0114P2FA55$50ERO',500,60,'0114P2FA55$50EEA','0114P2FA55$50ERA');
Insert Into  CPFTableComponent Values('0114P2F',500,55,'0114P2FA55$500EEO','0114P2FA55$500ERO',750,60,'0114P2FA55$500EEA','0114P2FA55$500ERA');
Insert Into  CPFTableComponent Values('0114P2F',750,55,'0114P2FA55$750EEO','0114P2FA55$750ERO',9999999,60,'0114P2FA55$750EEA','0114P2FA55$750ERA');
Insert Into  CPFTableComponent Values('0114P2F',0,60,'0114P2FA60$0EEO','0114P2FA60$0ERO',50,65,'0114P2FA60$0EEA','0114P2FA60$0ERA');
Insert Into  CPFTableComponent Values('0114P2F',50,60,'0114P2FA60$50EEO','0114P2FA60$50ERO',500,65,'0114P2FA60$50EEA','0114P2FA60$50ERA');
Insert Into  CPFTableComponent Values('0114P2F',500,60,'0114P2FA60$500EEO','0114P2FA60$500ERO',750,65,'0114P2FA60$500EEA','0114P2FA60$500ERA');
Insert Into  CPFTableComponent Values('0114P2F',750,60,'0114P2FA60$750EEO','0114P2FA60$750ERO',9999999,65,'0114P2FA60$750EEA','0114P2FA60$750ERA');
Insert Into  CPFTableComponent Values('0114P2F',0,65,'0114P2FA65$0EEO','0114P2FA65$0ERO',50,99,'0114P2FA65$0EEA','0114P2FA65$0ERA');
Insert Into  CPFTableComponent Values('0114P2F',50,65,'0114P2FA65$50EEO','0114P2FA65$50ERO',500,99,'0114P2FA65$50EEA','0114P2FA65$50ERA');
Insert Into  CPFTableComponent Values('0114P2F',500,65,'0114P2FA65$500EEO','0114P2FA65$500ERO',750,99,'0114P2FA65$500EEA','0114P2FA65$500ERA');
Insert Into  CPFTableComponent Values('0114P2F',750,65,'0114P2FA65$750EEO','0114P2FA65$750ERO',9999999,99,'0114P2FA65$750EEA','0114P2FA65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 2 Graduated
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0114P2A') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114P2A0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P2A65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P2A65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P2A65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P2A65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P2A65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0114P2A0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$50ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$50ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$500ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$500ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',9,450,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$750ERA',1,0,0,' (C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A0$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$50ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$50ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$500ERO',1,0,0,'(C1/100)*K2;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$500ERA',1,0,0,'(C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.45,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',9,450,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$750ERA',1,0,0,' (C1/100)*K3;',9,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',15,750,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A50$750EEA',1,0,0,' (C1/100)*K3;',15,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$50ERO',1,0,0,'(C1/100)*K2;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$50ERA',1,0,0,'(C1/100)*K3;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$500ERO',1,0,0,'(C1/100)*K2;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$500ERA',1,0,0,'(C1/100)*K3;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.375,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',6,300,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$750ERA',1,0,0,' (C1/100)*K3;',6,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',12.5,625,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A55$750EEA',1,0,0,' (C1/100)*K3;',12.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$50ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$50ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$500ERO',1,0,0,'(C1/100)*K2;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$500ERA',1,0,0,'(C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',3.5,175,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$750ERA',1,0,0,' (C1/100)*K3;',3.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P2A65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114P2',0,0,'0114P2A0$0EEO','0114P2A0$0ERO',50,50,'0114P2A0$0EEA','0114P2A0$0ERA');
Insert Into  CPFTableComponent Values('0114P2',50,0,'0114P2A0$50EEO','0114P2A0$50ERO',500,50,'0114P2A0$50EEA','0114P2A0$50ERA');
Insert Into  CPFTableComponent Values('0114P2',500,0,'0114P2A0$500EEO','0114P2A0$500ERO',750,50,'0114P2A0$500EEA','0114P2A0$500ERA');
Insert Into  CPFTableComponent Values('0114P2',750,0,'0114P2A0$750EEO','0114P2A0$750ERO',9999999,50,'0114P2A0$750EEA','0114P2A0$750ERA');
Insert Into  CPFTableComponent Values('0114P2',0,50,'0114P2A50$0EEO','0114P2A50$0ERO',50,55,'0114P2A50$0EEA','0114P2A50$0ERA');
Insert Into  CPFTableComponent Values('0114P2',50,50,'0114P2A50$50EEO','0114P2A50$50ERO',500,55,'0114P2A50$50EEA','0114P2A50$50ERA');
Insert Into  CPFTableComponent Values('0114P2',500,50,'0114P2A50$500EEO','0114P2A50$500ERO',750,55,'0114P2A50$500EEA','0114P2A50$500ERA');
Insert Into  CPFTableComponent Values('0114P2',750,50,'0114P2A50$750EEO','0114P2A50$750ERO',9999999,55,'0114P2A50$750EEA','0114P2A50$750ERA');
Insert Into  CPFTableComponent Values('0114P2',0,55,'0114P2A55$0EEO','0114P2A55$0ERO',50,60,'0114P2A55$0EEA','0114P2A55$0ERA');
Insert Into  CPFTableComponent Values('0114P2',50,55,'0114P2A55$50EEO','0114P2A55$50ERO',500,60,'0114P2A55$50EEA','0114P2A55$50ERA');
Insert Into  CPFTableComponent Values('0114P2',500,55,'0114P2A55$500EEO','0114P2A55$500ERO',750,60,'0114P2A55$500EEA','0114P2A55$500ERA');
Insert Into  CPFTableComponent Values('0114P2',750,55,'0114P2A55$750EEO','0114P2A55$750ERO',9999999,60,'0114P2A55$750EEA','0114P2A55$750ERA');
Insert Into  CPFTableComponent Values('0114P2',0,60,'0114P2A60$0EEO','0114P2A60$0ERO',50,65,'0114P2A60$0EEA','0114P2A60$0ERA');
Insert Into  CPFTableComponent Values('0114P2',50,60,'0114P2A60$50EEO','0114P2A60$50ERO',500,65,'0114P2A60$50EEA','0114P2A60$50ERA');
Insert Into  CPFTableComponent Values('0114P2',500,60,'0114P2A60$500EEO','0114P2A60$500ERO',750,65,'0114P2A60$500EEA','0114P2A60$500ERA');
Insert Into  CPFTableComponent Values('0114P2',750,60,'0114P2A60$750EEO','0114P2A60$750ERO',9999999,65,'0114P2A60$750EEA','0114P2A60$750ERA');
Insert Into  CPFTableComponent Values('0114P2',0,65,'0114P2A65$0EEO','0114P2A65$0ERO',50,99,'0114P2A65$0EEA','0114P2A65$0ERA');
Insert Into  CPFTableComponent Values('0114P2',50,65,'0114P2A65$50EEO','0114P2A65$50ERO',500,99,'0114P2A65$50EEA','0114P2A65$50ERA');
Insert Into  CPFTableComponent Values('0114P2',500,65,'0114P2A65$500EEO','0114P2A65$500ERO',750,99,'0114P2A65$500EEA','0114P2A65$500ERA');
Insert Into  CPFTableComponent Values('0114P2',750,65,'0114P2A65$750EEO','0114P2A65$750ERO',9999999,99,'0114P2A65$750EEA','0114P2A65$750ERA');

end if;

/*-----------------------------------------------------------------------------------------------------------
	PR 3
-----------------------------------------------------------------------------------------------------------*/

if not exists(select * from Formula where Locate(FormulaId,'0114P3A') = 1 and FormulaCategory='CPFFormula1') then

Insert into Formula Values('0114P3A0$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A0$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A0$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A0$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A0$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A0$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A0$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A0$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A0$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A0$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A0$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A0$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A0$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A0$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A0$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A0$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A50$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A50$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A50$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A50$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A50$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A50$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A50$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A50$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A50$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A50$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A50$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A50$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A50$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A50$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A50$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A50$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A55$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A55$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A55$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A55$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A55$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A55$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A55$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A55$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A55$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A55$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A55$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A55$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A55$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A55$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A55$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A55$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A60$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A60$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A60$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A60$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A60$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A60$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A60$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A60$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A60$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A60$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A60$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A60$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A60$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A60$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A60$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A60$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A65$0ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A65$0ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A65$0EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A65$0EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A65$50ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A65$50ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A65$50EEO',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A65$50EEA',1,0,0,'CPFFormula1','EE','T1','','','',0,0);
Insert into Formula Values('0114P3A65$500ERO',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A65$500ERA',1,0,0,'CPFFormula1','ER','T1','','','',0,0);
Insert into Formula Values('0114P3A65$500EEO',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A65$500EEA',1,0,0,'CPFFormula1','EE','T4','','','',0,0);
Insert into Formula Values('0114P3A65$750ERO',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A65$750ERA',1,0,0,'CPFFormula1','ER','T3','','','',0,0);
Insert into Formula Values('0114P3A65$750EEO',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into Formula Values('0114P3A65$750EEA',1,0,0,'CPFFormula1','EE','T3','','','',0,0);
Insert into FormulaRange Values('0114P3A0$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$50ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$50ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$500ERO',1,0,0,'(C1/100)*K2;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$500ERA',1,0,0,'(C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.6,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',16,800,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$750ERA',1,0,0,' (C1/100)*K3;',16,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',20,1000,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A0$750EEA',1,0,0,' (C1/100)*K3;',20,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$50ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$50ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$500ERO',1,0,0,'(C1/100)*K2;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$500ERA',1,0,0,'(C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.555,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.555,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',14,700,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$750ERA',1,0,0,' (C1/100)*K3;',14,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',18.5,925,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A50$750EEA',1,0,0,' (C1/100)*K3;',18.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$50ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$50ERA',1,0,0,'(C1/100)*K3;',10.5,50,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$500ERO',1,0,0,'(C1/100)*K2;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$500ERA',1,0,0,'(C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.39,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',10.5,525,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$750ERA',1,0,0,' (C1/100)*K3;',10.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',13,650,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A55$750EEA',1,0,0,' (C1/100)*K3;',13,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$50ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$50ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$500ERO',1,0,0,'(C1/100)*K2;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$500ERA',1,0,0,'(C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.225,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.225,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7,350,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$750ERA',1,0,0,' (C1/100)*K3;',7,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',7.5,375,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A60$750EEA',1,0,0,' (C1/100)*K3;',7.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$0ERO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$0ERA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$0EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$0EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$50ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$50ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$50EEO',1,0,0,'(C1/100)*K2;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$50EEA',1,0,0,'(C1/100)*K3;',0,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$500ERO',1,0,0,'(C1/100)*K2;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$500ERA',1,0,0,'(C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$500EEO',1,0,0,'(K2/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$500EEA',1,0,0,'(K3/K1)*(C1 * (K1 - C2) + C3);',0.15,500,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$750ERO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',6.5,325,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$750ERA',1,0,0,' (C1/100)*K3;',6.5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$750EEO',1,0,0,'@MAX( (C1/100)*K2 , C2 );',5,250,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert into FormulaRange Values('0114P3A65$750EEA',1,0,0,' (C1/100)*K3;',5,0,0,0,0,'CPFWage','OrdWage','AddWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''       );
Insert Into  CPFTableComponent Values('0114P3',0,0,'0114P3A0$0EEO','0114P3A0$0ERO',50,50,'0114P3A0$0EEA','0114P3A0$0ERA');
Insert Into  CPFTableComponent Values('0114P3',50,0,'0114P3A0$50EEO','0114P3A0$50ERO',500,50,'0114P3A0$50EEA','0114P3A0$50ERA');
Insert Into  CPFTableComponent Values('0114P3',500,0,'0114P3A0$500EEO','0114P3A0$500ERO',750,50,'0114P3A0$500EEA','0114P3A0$500ERA');
Insert Into  CPFTableComponent Values('0114P3',750,0,'0114P3A0$750EEO','0114P3A0$750ERO',9999999,50,'0114P3A0$750EEA','0114P3A0$750ERA');
Insert Into  CPFTableComponent Values('0114P3',0,50,'0114P3A50$0EEO','0114P3A50$0ERO',50,55,'0114P3A50$0EEA','0114P3A50$0ERA');
Insert Into  CPFTableComponent Values('0114P3',50,50,'0114P3A50$50EEO','0114P3A50$50ERO',500,55,'0114P3A50$50EEA','0114P3A50$50ERA');
Insert Into  CPFTableComponent Values('0114P3',500,50,'0114P3A50$500EEO','0114P3A50$500ERO',750,55,'0114P3A50$500EEA','0114P3A50$500ERA');
Insert Into  CPFTableComponent Values('0114P3',750,50,'0114P3A50$750EEO','0114P3A50$750ERO',9999999,55,'0114P3A50$750EEA','0114P3A50$750ERA');
Insert Into  CPFTableComponent Values('0114P3',0,55,'0114P3A55$0EEO','0114P3A55$0ERO',50,60,'0114P3A55$0EEA','0114P3A55$0ERA');
Insert Into  CPFTableComponent Values('0114P3',50,55,'0114P3A55$50EEO','0114P3A55$50ERO',500,60,'0114P3A55$50EEA','0114P3A55$50ERA');
Insert Into  CPFTableComponent Values('0114P3',500,55,'0114P3A55$500EEO','0114P3A55$500ERO',750,60,'0114P3A55$500EEA','0114P3A55$500ERA');
Insert Into  CPFTableComponent Values('0114P3',750,55,'0114P3A55$750EEO','0114P3A55$750ERO',9999999,60,'0114P3A55$750EEA','0114P3A55$750ERA');
Insert Into  CPFTableComponent Values('0114P3',0,60,'0114P3A60$0EEO','0114P3A60$0ERO',50,65,'0114P3A60$0EEA','0114P3A60$0ERA');
Insert Into  CPFTableComponent Values('0114P3',50,60,'0114P3A60$50EEO','0114P3A60$50ERO',500,65,'0114P3A60$50EEA','0114P3A60$50ERA');
Insert Into  CPFTableComponent Values('0114P3',500,60,'0114P3A60$500EEO','0114P3A60$500ERO',750,65,'0114P3A60$500EEA','0114P3A60$500ERA');
Insert Into  CPFTableComponent Values('0114P3',750,60,'0114P3A60$750EEO','0114P3A60$750ERO',9999999,65,'0114P3A60$750EEA','0114P3A60$750ERA');
Insert Into  CPFTableComponent Values('0114P3',0,65,'0114P3A65$0EEO','0114P3A65$0ERO',50,99,'0114P3A65$0EEA','0114P3A65$0ERA');
Insert Into  CPFTableComponent Values('0114P3',50,65,'0114P3A65$50EEO','0114P3A65$50ERO',500,99,'0114P3A65$50EEA','0114P3A65$50ERA');
Insert Into  CPFTableComponent Values('0114P3',500,65,'0114P3A65$500EEO','0114P3A65$500ERO',750,99,'0114P3A65$500EEA','0114P3A65$500ERA');
Insert Into  CPFTableComponent Values('0114P3',750,65,'0114P3A65$750EEO','0114P3A65$750ERO',9999999,99,'0114P3A65$750EEA','0114P3A65$750ERA');

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
'2014-01-01', 
'',
'Year2014Jan', 
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
Where CPFProgCurrent = 1 and CPFEffectiveDate < '2014-01-01' and CPFProgSchemeId != ''
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2014-01-01')
And Not exists(Select * From CPFProgression as CheckCPF where CheckCPF.CPFEffectiveDate = '2014-01-01' and CheckCPF.EmployeeSysID = CPFProgression.EmployeeSysId)
;

/*-----------------------------------------------------------------------------------------------------------
	Pay Details Default
-----------------------------------------------------------------------------------------------------------*/

Update SubRegistry Set ShortStringAttr='Year2014Jan'
Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';
;

commit work;
