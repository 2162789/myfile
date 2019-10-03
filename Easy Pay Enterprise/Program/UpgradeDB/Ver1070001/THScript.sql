/* New Tax Method Annualized with suppelmentary difference */

if not exists(select * from keyword where keywordid='TaxAnnualizeSup') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
   KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup) 
  values('TaxAnnualizeSup','Annualize Supplementary Difference','Annualize Supplementary Difference','TaxProcess',0,0,0,'',0,0,0,'');
end if;

commit work;