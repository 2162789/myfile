/*Show/Hide Menu */

if  exists (select 1 from KeyWord where KeyWordId = 'IncomeTaxReports') then
Update KeyWord set KeywordSubProperty=1 where KeyWordId = 'IncomeTaxReports'
end if;

if  exists (select 1 from KeyWord where KeyWordId = 'SPTMasaRpt') then
Update KeyWord set KeywordSubProperty=1 where KeyWordId = 'SPTMasaRpt'
end if;

commit work;
