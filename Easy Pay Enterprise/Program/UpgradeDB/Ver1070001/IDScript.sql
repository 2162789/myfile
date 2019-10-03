/* Non Occupational Expense Code */
if not exists(select * from Keyword Where KeyWordId = 'NonOccuExpenseCode') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('NonOccuExpenseCode','Non Occupational Expense Code','Non Occupational Expense Code','System',1,0,0,'',0,0,0,'G')
end if;

/* Add Employer BPJS Pensiun for YTD Policy under Import Designer */
if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'EmployerBPJSPensiun') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','EmployerBPJSPensiun','Employer BPJS Pensiun','Numeric',0);
end if;

/* Add NPWP Policy with effective from 2016-07-01 */
if exists(select * from IndoTaxPolicy where IndoTaxPolicyId = 'Default Policy') then
  if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'Default Policy' and IndoTaxEffectiveDate = '2016-07-01') then
      insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxRegionId,IndoTaxMonthlyId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
	  values('Default Policy','Default Region','Rate2009','2016-07-01',0,5,6000000,5,2400000,54000000,4500000,4500000,3);
  end if;
end if;

/* Add No NPWP Policy with effective from 2016-07-01 */
if exists(select * from IndoTaxPolicy where IndoTaxPolicyId = 'No NPWP Policy') then
  if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'No NPWP Policy' and IndoTaxEffectiveDate = '2016-07-01') then
      insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxRegionId,IndoTaxMonthlyId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
	  values('No NPWP Policy','Default Region','Rate2009NoNPWP','2016-07-01',0,5,6000000,5,2400000,54000000,4500000,4500000,3);
  end if;
end if;

commit work;