if not exists (select * from "DBA"."Keyword" where KeywordId = 'Last2YrPaymentCode')
then
insert into keyword
(KeywordId, 
KeyWordDefaultName,
KeyWordUserDefinedName,
KeyWordCategory,
KeyWordPropertySelection,
KeyWordFormulaSelection,
KeyWordRangeSelection,
KeyWordDesc,
KeyWordSubCategory,
KeyWordSubProperty,
KeyWordStage,
KeyWordGroup) values
('Last2YrPaymentCode','Last 2 Yrs (2008 if 2010) Payment Code','Last 2 Yrs (2008 if 2010) Payment Code','System',1,0,0,'',0,0,0,'G');
end if;


if not exists (select * from "DBA"."Keyword" where KeywordId = 'Last2YrTaxCode')
then
insert into keyword 
(KeywordId, 
KeyWordDefaultName,
KeyWordUserDefinedName,
KeyWordCategory,
KeyWordPropertySelection,
KeyWordFormulaSelection,
KeyWordRangeSelection,
KeyWordDesc,
KeyWordSubCategory,
KeyWordSubProperty,
KeyWordStage,
KeyWordGroup) values
('Last2YrTaxCode','Last 2 Yrs (2008 if 2010) Tax Code','Last 2 Yrs (2008 if 2010) Tax Code','System',1,0,0,'',0,0,0,'G');
end if;


commit work;