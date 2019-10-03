if not exists(select * from keyword where keywordId='OffPetrolCode') then 
	INSERT INTO Keyword VALUES ('OffPetrolCode','Official Petrol Code','Official Petrol Code','System',1,0,0,'',0,0,0,'G');
end if;

if not exists(select * from keyword where keywordId='NonOffPetrolCode') then 
	INSERT INTO Keyword VALUES ('NonOffPetrolCode','Non Official Petrol Code','Non Official Petrol Code','System',1,0,0,'',0,0,0,'G');
end if;

UPDATE SubRegistry SET IntegerAttr =6 WHERE SubRegistryId='TaxEPFRelief';
UPDATE SubRegistry SET IntegerAttr =7 WHERE SubRegistryId='TaxZakatRelief';
UPDATE SubRegistry SET IntegerAttr =8 WHERE SubRegistryId='TaxResidenceStatus';
UPDATE SubRegistry SET IntegerAttr =9 WHERE SubRegistryId='TaxStatus';

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxOPetrolRelief') then 
INSERT INTO SubRegistry VALUES ('PayPeriodPolicy','TaxOPetrolRelief','Local','OtherInfo','Tax Official Petrol Relief','TotalYMF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId='PayPeriodPolicy' and SubRegistryId='TaxNOPetrolRelief') then 
INSERT INTO SubRegistry VALUES ('PayPeriodPolicy','TaxNOPetrolRelief','Local','OtherInfo','Tax Non Official Petrol Relief','TotalMOSQ','','','','','','',0,5,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;
