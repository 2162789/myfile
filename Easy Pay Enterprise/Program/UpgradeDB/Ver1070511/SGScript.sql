if not exists(select * from keyword where keywordid = 'EX_CurOrdWage') then
    insert into keyword(KeyWordId, KeyWordDefaultName, KeywordUserDefinedName, KeyWordCategory, KeywordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup) 
	values('EX_CurOrdWage', 'CPF Ordinary Wage', 'CPF Ordinary Wage', 'EXPORT', 0, 0, 0, 'CurOrdinaryWage', 87, 2, 0, '')
end if;

if not exists(select * from keyword where keywordid = 'EX_CurAddWage') then
    insert into keyword(KeyWordId, KeyWordDefaultName, KeywordUserDefinedName, KeyWordCategory, KeywordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)  
	values('EX_CurAddWage', 'CPF Additional Wage', 'CPF Additional Wage', 'EXPORT', 0, 0, 0, 'CurAdditionalWage', 88, 2, 0, '')
end if;

if not exists(select * from keyword where keywordid = 'EX_OrdWage_Prev') then
    insert into keyword(KeyWordId, KeyWordDefaultName, KeywordUserDefinedName, KeyWordCategory, KeywordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)  
	values('EX_OrdWage_Prev', 'CPF Ordinary Wage (Prev)', 'CPF Ordinary Wage (Prev)', 'EXPORT', 0, 0, 0, 'CurOrdinaryWage', 89, 8, 0, '')
end if;

if not exists(select * from keyword where keywordid = 'EX_AddWage_Prev') then
    insert into keyword(KeyWordId, KeyWordDefaultName, KeywordUserDefinedName, KeyWordCategory, KeywordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)  
	values('EX_AddWage_Prev', 'CPF Additional Wage (Prev)', 'CPF Additional Wage (Prev)', 'EXPORT', 0, 0, 0, 'CurAdditionalWage', 90, 8, 0, '')
end if;
commit work;