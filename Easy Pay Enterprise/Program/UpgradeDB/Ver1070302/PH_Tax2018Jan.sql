begin
declare @PhTaxPolicySysId int;
if exists (select 1 from PhTaxPolicy where PhTaxPolicyId = 'Default') then
  if not exists (select 1 from PhTaxPolicyProg where PhTaxPolicyId = 'Default' and PhTaxPolicyEffDate = '2018-01-01') then
    insert into PhTaxPolicyProg (PhTaxPolicyId, PhTaxPolicyEffDate, PhTaxBonusExceed, PhSingleEx, PhHeadEx, PhMarriedEx, PhDependentEx, PhDependentMax, PhInsuranceEx, PhTaxIncentivesEx)
    values ('Default','2018-01-01',90000,0,0,0,0,0,0,25000);
    select @@identity into @PhTaxPolicySysId;
  else
    select PhTaxPolicySysId into @PhTaxPolicySysId from PhTaxPolicyProg where PhTaxPolicyId = 'Default' and PhTaxPolicyEffDate = '2018-01-01'
  end if;

  if not exists (select 1 from PhTaxComputation where PhTaxPolicySysId = @PhTaxPolicySysId) then
    insert into PhTaxComputation (PhTaxPolicySysId, PhTaxCompSysId, PhTaxOver, PhTaxMinTax, PhTaxPercentage) values (@PhTaxPolicySysId,1,0,0,0);
    insert into PhTaxComputation (PhTaxPolicySysId, PhTaxCompSysId, PhTaxOver, PhTaxMinTax, PhTaxPercentage) values (@PhTaxPolicySysId,2,250000,0,20);
    insert into PhTaxComputation (PhTaxPolicySysId, PhTaxCompSysId, PhTaxOver, PhTaxMinTax, PhTaxPercentage) values (@PhTaxPolicySysId,3,400000,30000,25);
    insert into PhTaxComputation (PhTaxPolicySysId, PhTaxCompSysId, PhTaxOver, PhTaxMinTax, PhTaxPercentage) values (@PhTaxPolicySysId,4,800000,130000,30);
    insert into PhTaxComputation (PhTaxPolicySysId, PhTaxCompSysId, PhTaxOver, PhTaxMinTax, PhTaxPercentage) values (@PhTaxPolicySysId,5,2000000,490000,32);
    insert into PhTaxComputation (PhTaxPolicySysId, PhTaxCompSysId, PhTaxOver, PhTaxMinTax, PhTaxPercentage) values (@PhTaxPolicySysId,6,8000000,2410000,35);
  end if;

  if not exists (select 1 from DeMinimisSetup where PhTaxPolicySysId = @PhTaxPolicySysId) then
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_MedCash',0,0,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_LvConversion',125,1500,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_Rice',1500,0,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_Uniforms',0,4000,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_MedBenefits',0,10000,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_Laundry',300,0,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_Achievement',0,10000,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_Gifts',0,5000,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_Others',0,0,0);
    insert into DeMinimisSetup (PhTaxPolicySysId, DeMinimisProperty, DMBMthCap, DMBYearCap, DMBPercentMW) values (@PhTaxPolicySysId,'PhDMB_OTMeal',0,0,25);
  end if;
end if;
end;

commit work;