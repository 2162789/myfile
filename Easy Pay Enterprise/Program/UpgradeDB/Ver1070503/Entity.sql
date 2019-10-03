if not exists (select 1 from sys.syscolumns where tname='PhTaxEmployer' and cname='phEmail') then
   alter table dba.PhTaxEmployer add phEmail char(60);
   Update PhTaxEmployer Set phEmail = '';
end if;

commit work;