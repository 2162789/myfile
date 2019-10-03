READ UpgradeDB\Ver1070404\Entity.sql;
READ UpgradeDB\Ver1070404\StoredProc.sql;

if not exists(select * from Keyword where KeywordId = 'BasicRateFull') then
   insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
	                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
	 values('BasicRateFull','Basic Rate (Full)','Basic Rate (Full)','System',0,0,0,'',0,0,0,'');
end if;

commit work;