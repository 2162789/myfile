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


if not exists(select 1 from sys.systable where table_name='MalPrevEmployer') then 
/* ============================================================ */
/*   Table: MalPrevEmployer                                     */
/* ============================================================ */
create table dba.MalPrevEmployer
(
    MalPrevEmployerSysId  integer               not null
        default AUTOINCREMENT,
    EmployeeSysId         integer               not null,
    CompanyName           char(100)                     ,
    CessationDate         date                          ,
    YTDTaxWage            double                        ,
    YTDEPFRelief          double                        ,
    YTDZakatRelief        double                        ,
    YTDTaxAmt             double                        ,
    primary key (MalPrevEmployerSysId)
);

alter table dba.MalPrevEmployer
    add foreign key FK_MALPREVE_RELATION__PAYEMPLO (EmployeeSysId)
       references PayEmployeePolicy (EmployeeSysId) on update restrict on delete restrict;

end if;

if not exists (select 1 from sys.systable where table_name='RebateItem') then
/* ============================================================ */
/*   Table: RebateItem                                          */
/* ============================================================ */
create table dba.RebateItem
(
    RebateID                char(20)              not null,
    RebateDesc              char(100)                     ,
    RebateERApproval        smallint                      ,
    RebateProperty          char(20)                      ,
    primary key (RebateID)
);
end if;

if not exists (select 1 from sys.systable where table_name='RebateClaim') then
/* ============================================================ */
/*   Table: RebateClaim                                         */
/* ============================================================ */
create table dba.RebateClaim
(
    RebateSysId             integer               not null
        default AUTOINCREMENT,
    PersonalSysId           integer               not null,
    RebateDate              date                          ,
    ePortalStatus           char(20)                      ,
    CreatedBy               char(1)                       ,
    PayrollProcessDate      date                          ,
    PayrollYear             integer                       ,
    PayrollPeriod           integer                       ,
    primary key (RebateSysId)
);

alter table RebateClaim
    add foreign key FK_REBATECL_RELATION__MALTAXDE (PersonalSysId)
       references MalTaxDetails (PersonalSysId) on update restrict on delete restrict;

end if;

if not exists (select 1 from sys.systable where table_name='RebateGranted') then
/* ============================================================ */
/*   Table: RebateGranted                                       */
/* ============================================================ */
create table dba.RebateGranted
(
    RebateGrantSysId        integer               not null
        default AUTOINCREMENT,
    RebateID                char(20)              not null,
    PersonalSysId           integer               not null,
    RebatePayrollYear       integer                       ,
    RebatePayrollPeriod     integer                       ,
    RebateDeclaredYear      integer                       ,
    RebateAmt               double                        ,
    CreatedBy               char(1)                       ,
    TaxableAmt              double                        ,
    primary key (RebateGrantSysId)
);

alter table RebateGranted
    add foreign key FK_REBATEGR_RELATION__REBATEIT (RebateID)
       references RebateItem (RebateID) on update restrict on delete restrict;

alter table RebateGranted
    add foreign key FK_REBATEGR_RELATION__MALTAXDE (PersonalSysId)
       references MalTaxDetails (PersonalSysId) on update restrict on delete restrict;

end if;

if not exists (select 1 from sys.systable where table_name='RebateSetup') then
/* ============================================================ */
/*   Table: RebateSetup                                         */
/* ============================================================ */
create table dba.RebateSetup
(
    MalTaxPolicyProgSysId   integer               not null,
    RebateID                char(20)              not null,
    RebateCapAmt            double                        ,
    RebateCapDuration       double                        ,
    RebatePaymentOption     smallint                      ,
    primary key (MalTaxPolicyProgSysId, RebateID)
);


alter table RebateSetup
    add foreign key FK_REBATESE_RELATION__REBATEIT (RebateID)
       references RebateItem (RebateID) on update restrict on delete restrict;

alter table RebateSetup
    add foreign key FK_REBATESE_RELATION__MALTAXPO (MalTaxPolicyProgSysId)
       references MalTaxPolicyProg (MalTaxPolicyProgSysId) on update restrict on delete restrict;

end if;

if not exists (select 1 from sys.systable where table_name='RebateClaimRecord') then
/* ============================================================ */
/*   Table: RebateClaimRecord                                   */
/* ============================================================ */
create table dba.RebateClaimRecord
(
    RebateClaimRecordSysId  integer               not null
        default AUTOINCREMENT,
    RebateSysId             integer               not null,
    RebateID                char(20)              not null,
    RebateClaimAmt          double                        ,
    RebateReferenceNo       char(20)                      ,
    RebateReceiptDate       date                          ,
    RebateRemarks           char(100)                     ,
    primary key (RebateClaimRecordSysId)
);

alter table RebateClaimRecord
    add foreign key FK_REBATECL_RELATION__REBATECL (RebateSysId)
       references RebateClaim (RebateSysId) on update restrict on delete restrict;

alter table RebateClaimRecord
    add foreign key FK_REBATECL_RELATION__REBATEIT (RebateID)
       references RebateItem (RebateID) on update restrict on delete restrict;

end if;


//
// Malaysia CP 38 changes
//
if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxCP38ReceiptNo') then
   alter table dba.MalTaxReceipt add MalTaxCP38ReceiptNo char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxCP38ReceiptDate') then
   alter table dba.MalTaxReceipt add MalTaxCP38ReceiptDate date;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxPrevYearIncomeType') then
   alter table dba.MalTaxReceipt add MalTaxPrevYearIncomeType char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxPrevYearReceiptNo') then
   alter table dba.MalTaxReceipt add MalTaxPrevYearReceiptNo char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxPrevYearReceiptDate') then
   alter table dba.MalTaxReceipt add MalTaxPrevYearReceiptDate date;
end if;
