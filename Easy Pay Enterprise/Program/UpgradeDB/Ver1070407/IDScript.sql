/*==============================================================*/
/* Include Tax Processing Method in Export Report               */
/*==============================================================*/
/* Add Indo Tax Processing Method as keyword - For Pay Details Report(Export purpose) */
if not exists(select * from keyword where keywordId = 'EX_IndoTaxMethod') then
	Insert into KeyWord (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage) VALUES ('EX_IndoTaxMethod', 'Tax Processing Method', 'Tax Processing Method', 'EXPORT', 0,0,0, 'IndoTaxMethod', 622, 5, 0);
end if;

commit work;