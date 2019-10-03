/* Check for Tax Policy Progression*/
if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'Default Policy' and IndoTaxEffectiveDate = '2013-01-01') then
    insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxRegionId,IndoTaxMonthlyId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
    values('Default Policy','Default Region','Rate2009','2013-01-01',0,5,1296000,5,432000,24300000,2025000,2025000,3);
end if;

commit work;






