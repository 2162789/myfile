if not exists (select 1 from sys.syscolumns where tname='Training' and cname='PlanDate') then
   alter table dba.Training add PlanDate date;
end if;

if not exists (select 1 from sys.syscolumns where tname='Training' and cname='CertificateExpiryDate') then
   alter table dba.Training add CertificateExpiryDate date;
end if;

if not exists (select 1 from sys.syscolumns where tname='TrainingBatch' and cname='PlanDate') then
   alter table dba.TrainingBatch add PlanDate date;
end if;

commit work;