if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolOCappingOption') then
	ALTER TABLE DBA.MalTaxPolicyProg ADD PetrolOCappingOption SmallInt default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolOCappingYearly') then
	ALTER TABLE DBA.MalTaxPolicyProg ADD PetrolOCappingYearly double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolOCappingMonthly') then
	ALTER TABLE DBA.MalTaxPolicyProg ADD PetrolOCappingMonthly double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolNOCappingOption') then
	ALTER TABLE DBA.MalTaxPolicyProg ADD PetrolNOCappingOption SmallInt default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolNOCappingYearly') then
	ALTER TABLE DBA.MalTaxPolicyProg ADD PetrolNOCappingYearly double default 0;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='MalTaxPolicyProg' and cname='PetrolNOCappingMonthly') then
	ALTER TABLE DBA.MalTaxPolicyProg ADD PetrolNOCappingMonthly double default 0;
end if;

UPDATE MalTaxPolicyProg SET PetrolOCappingOption=0;
UPDATE MalTaxPolicyProg SET PetrolNOCappingOption=0;

 if exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21A2' and cname='TotalNSOPExempt') then
	ALTER TABLE DBA.IR21A2 drop TotalNSOPExempt;
end if;

if not exists(select 1 from sys.systable JOIN sys.syscolumns where table_name='IR21A2' and cname='TotalNSOPTaxExempt') then
	ALTER TABLE DBA.IR21A2 ADD TotalNSOPTaxExempt double;
end if;
