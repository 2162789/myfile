/* Table Keyword */
if exists(select * from keyword where keywordid ='CR_GNBnkCsh') then
    delete from keyword where keywordid ='CR_GNBnkCsh';
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayBnkCsh') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayBnkCsh','Pay','Bank/Cash Listing','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Bank/Cash Listing Report');
end if;

if exists(select * from keyword where keywordid ='CR_GNBnkCshWOBasis') then
    delete from keyword where keywordid ='CR_GNBnkCshWOBasis';
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayBnkCshWOBas') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayBnkCshWOBas','Pay','Bank/Cash Listing Without Basis and Beneficiary','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Bank/Cash Listing Report Without Basis and Beneficiary')
end if;

if exists(select * from keyword where keywordid ='CR_GNDeptAllowance') then
    delete from keyword where keywordid ='CR_GNDeptAllowance';
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayAllowDept') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayAllowDept','Pay','Pay Element Record Report By Department','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Pay Element Record Report By Department');
end if;

if exists(select * from keyword where keywordid ='CR_GNDetailAllowance') then
    delete from keyword where keywordid ='CR_GNDetailAllowance';
end if;

if not exists(select * from keyword where keywordid = 'CR_GNPayAllowDet') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNPayAllowDet','Pay','Pay Element Record Report By Detail','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Pay Element Record Report By Detail');
end if;

Update CRCustom set CRID='CR_GNPayBnkCsh' where CRID='CR_GNBnkCsh';
Update CRCustom set CRID='CR_GNPayBnkCshWOBas' where CRID='CR_GNBnkCshWOBasis';
update CRCustom set CRId = 'CR_GNPayAllowDept' where CRId = 'CR_GNDeptAllowance';
update CRCustom set CRId = 'CR_GNPayAllowDet' where CRId = 'CR_GNDetailAllowance';

UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_GNLveEmpEarn';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_GNLvePerSum';
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_GNLveCustom';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_GNPayStat_A3';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_GNPayStat_A4';
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_GNPayCustom';
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_GNPayAllowDept';
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_GNPayAllowDet';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_GNPayBnkCsh';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_GNPayBnkCshWOBas';


if not exists(select * from registry where registryid = 'OldReport') then
   insert into Registry(RegistryId, RegistryDesc)
   values('OldReport','OldReport');
end if;

if not exists(select * from subregistry where registryid = 'OldReport' and subregistryid = 'ReportOn') then
   insert into SubRegistry(RegistryId,SubRegistryId,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr)
   values('OldReport','ReportOn',0,1,0,0)
end if;


commit work;