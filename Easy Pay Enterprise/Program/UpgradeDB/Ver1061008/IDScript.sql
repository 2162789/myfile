Update CPFTableCode Set CPFResidenceTypeId = 'PR' Where CPFTableCodeId = 'BPJS-TKGrp1-0104PR';
Update CPFTableCode Set CPFResidenceTypeId = 'FW' Where CPFTableCodeId = 'BPJS-TKGrp1-0104FW';
Update CPFTableCode Set CPFResidenceTypeId = 'PR' Where CPFTableCodeId = 'BPJS-TKGrp2-0104PR';
Update CPFTableCode Set CPFResidenceTypeId = 'FW' Where CPFTableCodeId = 'BPJS-TKGrp2-0104FW';
Update CPFTableCode Set CPFResidenceTypeId = 'PR' Where CPFTableCodeId = 'BPJS-TKGrp3-0104PR';
Update CPFTableCode Set CPFResidenceTypeId = 'FW' Where CPFTableCodeId = 'BPJS-TKGrp3-0104FW';
Update CPFTableCode Set CPFResidenceTypeId = 'PR' Where CPFTableCodeId = 'BPJS-TKGrp4-0104PR';
Update CPFTableCode Set CPFResidenceTypeId = 'FW' Where CPFTableCodeId = 'BPJS-TKGrp4-0104FW';
Update CPFTableCode Set CPFResidenceTypeId = 'PR' Where CPFTableCodeId = 'BPJS-TKGrp5-0104PR';
Update CPFTableCode Set CPFResidenceTypeId = 'FW' Where CPFTableCodeId = 'BPJS-TKGrp5-0104FW';

/* Add No NPWP Policy with effective from 2013-01-01 */
if exists(select * from IndoTaxPolicy where IndoTaxPolicyId = 'No NPWP Policy') then
  if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'No NPWP Policy' and IndoTaxEffectiveDate = '2013-01-01') then
      insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxRegionId,IndoTaxMonthlyId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
	  values('No NPWP Policy','Default Region','Rate2009NoNPWP','2013-01-01',0,5,6000000,5,2400000,24300000,2025000,2025000,3);
  end if;
end if;

commit work;