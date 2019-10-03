if not exists(select * from registry where RegistryId = 'PhDMBProperty') then 
    Insert into Registry Values('PhDMBProperty','Phillipines De Minimis Benefits Property');
end if;

UPDATE PhTaxDetails SET PhExemption = 'Single' WHERE PhExemption = 'HeadOfFamily';
UPDATE PhTaxRecord SET PhExemption = 'Single' WHERE PhTaxYear = 2009 AND PhExemption = 'HeadOfFamily';
UPDATE PeriodPolicySummary SET CPFStatus = 'S' WHERE PayRecYear = 2009 AND LEFT(CPFStatus,2) = 'HF';

if not exists(select * from  SubRegistry WHERE RegistryId = 'PaySetupData' AND SubRegistryId = 'PhMWEOption') THEN
    Insert into SubRegistry VALUES('PaySetupData','PhMWEOption','Check','Minimum Wage Earner','BooleanAttr','N','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

UPDATE PhTaxRecord SET PhMWEOption = 0;

commit work;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchPhDeMinimisSetup') then
   drop procedure PatchPhDeMinimisSetup
end if
;

CREATE PROCEDURE "DBA"."PatchPhDeMinimisSetup"( )

BEGIN
Declare In_PhTaxPolicySysId integer;

Select PhTaxPolicySysId into In_PhTaxPolicySysId From PhTaxPolicyProg 
where PhTaxPolicyId = 'Default' And PhTaxPolicyEffDate = '2008-07-01'; 
if In_PhTaxPolicySysId is null then return; end if;


if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_MedCash') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_MedCash',0,0,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_LvConversion') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_LvConversion',125,1500,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_Rice') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_Rice',1500,0,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_Uniforms') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_Uniforms',0,4000,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_MedBenefits') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_MedBenefits',0,10000,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_Laundry') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_Laundry',300,0,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_Achievement') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_Achievement',0,10000,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_Gifts') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_Gifts',0,5000,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_Others') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_Others',0,0,0);
end if;

if not exists(select * from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId and DeMinimisProperty = 'PhDMB_OTMeal') then 
Insert into DeMinimisSetup Values(In_PhTaxPolicySysId,'PhDMB_OTMeal',0,0,25);
end if;

end;


Call PatchPhDeMinimisSetup();

DROP PROCEDURE DBA.PatchPhDeMinimisSetup;
Commit Work;
