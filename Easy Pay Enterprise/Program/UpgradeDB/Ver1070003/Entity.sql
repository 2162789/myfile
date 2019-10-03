/*==============================================================*/
/* Table: IndoTaxDetails                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='IndoTaxDetails' and cname='ClaimMarriageRelief') then
    alter table DBA.IndoTaxDetails Add ClaimMarriageRelief smallint;
	Update IndoTaxDetails Set ClaimMarriageRelief = 0; 
	Update IndoTaxDetails Set ClaimMarriageRelief = 1 Where PersonalSysId in (Select PersonalSysId From Personal where MaritalStatusCode = 'Married');
end if;

/*==============================================================*/
/* Table: iIndoTaxDetails                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='iIndoTaxDetails' and cname='ClaimMarriageRelief') then
    alter table DBA.iIndoTaxDetails Add ClaimMarriageRelief smallint;
end if;

commit work;