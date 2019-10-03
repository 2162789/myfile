if not exists(select * from CPFPolicy where CPFPolicyId = 'Year2012Jan') then
Insert into CPFPolicy Values('Year2012Jan',1,'16% Employer, 20% Employee wef 1 January 2012');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112ST') then
Insert into CPFTableCode Values('0112ST','Local','Private','Local Citizen Employer 16%, Employee 20% wef January 1, 2012',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112P1') then
Insert into CPFTableCode Values('0112P1','PR1','Private','PR 1st year - Employer Graduated 4%, Employee Graduated 5% wef January 1, 2012',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112P1');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112P2') then
Insert into CPFTableCode Values('0112P2','PR2','Private','PR 2nd year - Employer Graduated 9%, Employee Graduated 15% wef January 1, 2012',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112P2');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112P3') then
Insert into CPFTableCode Values('0112P3','PR3','Private','PR 3rd year and above - Employer 16%, Employee 20% wef January 1, 2012',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112P3');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112P1F') then
Insert into CPFTableCode Values('0112P1F','PR1','Private - Full','PR 1st year - Employer Full 16%, Employee Graduated 5% wef  January 1, 2012',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112P1F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112P2F') then
Insert into CPFTableCode Values('0112P2F','PR2','Private - Full','PR 2nd year - Employer Full 16%, Employee Graduated 15% wef  January 1, 2012',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112P2F');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112EP') then
Insert into CPFTableCode Values('0112EP','EP','Private','Voluntary Contributions - user defined',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112EP');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = '0112FW') then
Insert into CPFTableCode Values('0112FW','FW','Private','Voluntary Contributions - user defined',5000,85000,0);
Insert into CPFPolicyMember Values('Year2012Jan','0112FW');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2012-01-01') then
Insert into CPFGovernmentProgression Values('2012-01-01','Year2012Jan',1,'');
end if;
