/* Keyword */
if not exists(select * from KeyWord where KeyWordId = 'ERBPJSKesehatan') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('ERBPJSKesehatan','Employer BPJS Kesehatan','Employer BPJS Kesehatan','System',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'ERBPJSPensiun') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('ERBPJSPensiun','Employer BPJS Pensiun','Employer BPJS Pensiun','System',0,0,0,'',0,0,0,'');
end if;

/* WageProperty */
if not exists(select * from WageProperty where KeyWordId = 'ERBPJSKesehatan' and WageId = 'NTGWage') then
  insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
  values('ERBPJSKesehatan','NTGWage',1);
end if;

if not exists(select * from WageProperty where KeyWordId = 'ERBPJSPensiun' and WageId = 'NTGWage') then
  insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
  values('ERBPJSPensiun','NTGWage',1);
end if;

commit work;