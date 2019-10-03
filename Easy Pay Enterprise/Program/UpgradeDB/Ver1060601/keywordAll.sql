if not exists(select * from keyword where keywordid = 'CR_GNLveEmpEarn') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNLveEmpEarn','Leave','Employee Earned Leave','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Employee Earned Leave Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNLvePerSum') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )

   values('CR_GNLvePerSum','Leave','Leave Period Summary','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Leave Period Summary Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNLveCustom') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNLveCustom','Leave','Custom','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Custom Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayStat_A3') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayStat_A3','Pay','Statistics A3','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Statistics A3 Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayStat_A4') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayStat_A4','Pay','Statistics A4','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Statistics A4 Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayCustom') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayCustom','Pay','Custom','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Custom Report');
end if;