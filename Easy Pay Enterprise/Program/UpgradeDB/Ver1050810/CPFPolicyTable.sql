if not exists(select * from CPFPolicy where CPFPolicyId = 'Year2011Sep') then
Insert into CPFPolicy Values('Year2011Sep',1,'16% Employer, 20% Employee wef 1 September 2011');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911ST') then
Insert into CPFTableCode Values('0911ST','Local','Private','Local Citizen Employer 16%, Employee 20% wef September 1, 2011',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911P1') then
Insert into CPFTableCode Values('0911P1','PR1','Private','PR 1st year - Employer Graduated 4%, Employee Graduated 5% wef September 1, 2011',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911P1');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911P2') then
Insert into CPFTableCode Values('0911P2','PR2','Private','PR 2nd year - Employer Graduated 9%, Employee Graduated 15% wef September 1, 2011',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911P2');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911P3') then
Insert into CPFTableCode Values('0911P3','PR3','Private','PR 3rd year and above - Employer 16%, Employee 20% wef September 1, 2011',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911P3');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911P1F') then
Insert into CPFTableCode Values('0911P1F','PR1','Private - Full','PR 1st year - Employer Full 16%, Employee Graduated 5% wef  September 1, 2011',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911P1F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911P2F') then
Insert into CPFTableCode Values('0911P2F','PR2','Private - Full','PR 2nd year - Employer Full 16%, Employee Graduated 15% wef  September 1, 2011',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911P2F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911EP') then
Insert into CPFTableCode Values('0911EP','EP','Private','Voluntary Contributions - user defined',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911EP');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0911FW') then
Insert into CPFTableCode Values('0911FW','FW','Private','Voluntary Contributions - user defined',5000,79333,0);
Insert into CPFPolicyMember Values('Year2011Sep','0911FW');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2011-09-01') then
Insert into CPFGovernmentProgression Values('2011-09-01','Year2011Sep',1,'');
end if;