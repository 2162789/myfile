if not exists (select 1 from sys.syscolumns where tname='LoanEmployee' and cname='LoanInterestAmt') then
   alter table dba.LoanEmployee add LoanInterestAmt double default 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxEmployer' and cname='PublicSector') then
   alter table dba.MalTaxEmployer add PublicSector smallint;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxRecord_EC') then
create table dba.MalTaxRecord_EC 
(
    PersonalSysId        integer                        not null,
    MalTaxYear           integer                        not null,
    MalTaxGratuity       double,
    MalTaxBenefitsDetails char(100),
    MalTaxRebate1        char(50),
    MalTaxRebate1Amt     double,
    MalTaxRebate2        char(50),
    MalTaxRebate2Amt     double,
    MalTaxRebate3        char(50),
    MalTaxRebate3Amt     double,
    MalTaxRebate4        char(50),
    MalTaxRebate4Amt     double,
    constraint PK_MALTAXRECORD_EC primary key clustered (PersonalSysId, MalTaxYear)
);

/*==============================================================*/
/* Index: MalTaxRecord_EC_PK                                    */
/*==============================================================*/
create unique index MalTaxRecord_EC_PK on MalTaxRecord_EC (
PersonalSysId ASC,
MalTaxYear ASC
);


alter table MalTaxRecord_EC
   add constraint FK_MALTAXRE_RELATIONS_MALTAXRE foreign key (PersonalSysId, MalTaxYear)
      references MalTaxRecord (PersonalSysId, MalTaxYear)
      on update restrict
      on delete restrict;

end if;

commit work;