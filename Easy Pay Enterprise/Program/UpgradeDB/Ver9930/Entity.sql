ALTER TABLE DBA.YEEmployee MODIFY Designation char(30);



if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='YEEmployer' and cname='DateIncorporation') then
	ALTER TABLE DBA.YEEmployer ADD DateIncorporation date;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='YEEmployer' and cname='AddressBlock') then
	ALTER TABLE DBA.YEEmployer ADD AddressBlock char(20);
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='YEEmployer' and cname='AddressStorey') then
	ALTER TABLE DBA.YEEmployer ADD AddressStorey char(20);
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='YEEmployer' and cname='AddressUnit') then
	ALTER TABLE DBA.YEEmployer ADD AddressUnit char(20);
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='YEEmployer' and cname='AddressStreetName') then
	ALTER TABLE DBA.YEEmployer ADD AddressStreetName char(100);
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='YEEmployer' and cname='AddressPostalCode') then
	ALTER TABLE DBA.YEEmployer ADD AddressPostalCode char(20);
end if;



if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8B' and cname='TotalNSOPTaxExempt') then
	ALTER TABLE DBA.A8B ADD TotalNSOPTaxExempt double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8B' and cname='TotalNSOPNoTaxExempt') then
	ALTER TABLE DBA.A8B ADD TotalNSOPNoTaxExempt double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8B' and cname='TotalNSOPStockGains') then
	ALTER TABLE DBA.A8B ADD TotalNSOPStockGains double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8B' and cname='TotalNSOPTaxExemptBef') then
	ALTER TABLE DBA.A8B ADD TotalNSOPTaxExemptBef double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8B' and cname='TotalNSOPNoTaxExemptBef') then
	ALTER TABLE DBA.A8B ADD TotalNSOPNoTaxExemptBef double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8B' and cname='TotalNSOPStockGainsBef') then
	ALTER TABLE DBA.A8B ADD TotalNSOPStockGainsBef double default 0;
end if;



if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='A8BRecord' and cname='NSOPTaxExempt') then
	ALTER TABLE DBA.A8BRecord ADD NSOPTaxExempt double default 0;
end if;



if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21A2' and cname='TotalNSOPTaxExempt') then
	ALTER TABLE DBA.IR21A2 ADD TotalNSOPTaxExempt double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21A2' and cname='TotalNSOPNoTaxExempt') then
	ALTER TABLE DBA.IR21A2 ADD TotalNSOPNoTaxExempt double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21A2' and cname='TotalNSOPStockGains') then
	ALTER TABLE DBA.IR21A2 ADD TotalNSOPStockGains double default 0;
end if;



if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21A2Record' and cname='NSOPTaxExempt') then
	ALTER TABLE DBA.IR21A2Record ADD NSOPTaxExempt double default 0;
end if;



if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21Details' and cname='MoniesStatus') then
	ALTER TABLE DBA.IR21Details ADD MoniesStatus SmallInt default 0;
end if;



Update IR21A2 SET TotalNSOPTaxExempt = 0;
Update IR21A2 SET TotalNSOPNoTaxExempt = 0;
Update IR21A2 SET TotalNSOPStockGains = 0;
Update A8B SET TotalNSOPTaxExempt = 0;
Update A8B SET TotalNSOPNoTaxExempt = 0;
Update A8B SET TotalNSOPStockGains = 0;
Update A8B SET TotalNSOPTaxExemptBef = 0;
Update A8B SET TotalNSOPNoTaxExemptBef = 0;
Update A8B SET TotalNSOPStockGainsBef = 0;
