if not exists (select 1 from sys.syscolumns where tname='Ph1601C' and cname='PhRORNo') then
   alter table dba.Ph1601C add PhRORNo char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='Ph1601C' and cname='PhDateRemittance') then
   alter table dba.Ph1601C add PhDateRemittance date;
end if;

if not exists (select 1 from sys.syscolumns where tname='RebateGranted' and cname='LPAmt') then
   alter table dba.RebateGranted add LPAmt double;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxClubMembership') then
   alter table dba.MalTaxRecord add MalTaxClubMembership double;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxGardener') then
   alter table dba.MalTaxRecord add MalTaxGardener double;
end if;

if not exists(
   select 1 from sys.systable
   where table_name='MalBIKItem'
     and table_type in ('BASE', 'GBL TEMP')
) then

   /*==============================================================*/
   /* Table: MalBIKItem                                            */
   /*==============================================================*/
   create table dba.MalBIKItem
   (
       MalBIKItemId         char(20)                       not null,
       MalBIKPropertyId     char(20),
       MalBIKItemDesc       char(100),
       constraint PK_MALBIKITEM primary key (MalBIKItemId)
   );

   /*==============================================================*/
   /* Index: MalBIKItem_PK                                         */
   /*==============================================================*/
   create unique index MalBIKItem_PK on MalBIKItem (
   MalBIKItemId ASC
   );

end if;

if not exists(
   select 1 from sys.systable
   where table_name='MalBIKRecord'
     and table_type in ('BASE', 'GBL TEMP')
) then

   /*==============================================================*/
   /* Table: MalBIKRecord                                          */
   /*==============================================================*/

   create table dba.MalBIKRecord
   (
       MalBIKRecSGSPGenId   char(30)                       not null,
       BIKRecRecurSysId     integer,
       MalBIKItemId         char(20)                       not null,
       EmployeeSysId        integer,
       PayRecYear           integer,
       PayRecPeriod         integer,
       PayRecSubPeriod      integer,
       PayRecID             char(20),
       BIKAmount            double,
       constraint PK_MALBIKRECORD primary key (MalBIKRecSGSPGenId)
   );

   /*==============================================================*/
   /* Index: MalBIKRecord_PK                                       */
   /*==============================================================*/
   create unique index MalBIKRecord_PK on MalBIKRecord (
   MalBIKRecSGSPGenId ASC
   );

   /*==============================================================*/
   /* Index: Relationship_737_FK                                   */
   /*==============================================================*/
   create  index Relationship_737_FK on MalBIKRecord (
   MalBIKItemId ASC
   );

   /*==============================================================*/
   /* Index: Relationship_740_FK                                   */
   /*==============================================================*/
   create  index Relationship_740_FK on MalBIKRecord (
   BIKRecRecurSysId ASC
   );

   /*==============================================================*/
   /* Index: Relationship_741_FK                                   */
   /*==============================================================*/
   create  index Relationship_741_FK on MalBIKRecord (
   EmployeeSysId ASC
   );

   alter table MalBIKRecord
      add constraint FK_MALBIKRE_RELATIONS_MALBIKIT foreign key (MalBIKItemId)
         references MalBIKItem (MalBIKItemId)
         on update restrict
         on delete restrict;

   alter table MalBIKRecord
      add constraint FK_MALBIKRE_RELATIONS_PAYEMPLO foreign key (EmployeeSysId)
         references PayEmployee (EmployeeSysId)
         on update restrict
         on delete restrict;

end if;

if not exists(
   select 1 from sys.systable
   where table_name='MalBIKRecurring'
     and table_type in ('BASE', 'GBL TEMP')
) then

   /*==============================================================*/
   /* Table: MalBIKRecurring                                       */
   /*==============================================================*/
   create table dba.MalBIKRecurring
   (
       BIKRecurSysId        integer                        not null default AUTOINCREMENT,
       MalBIKItemId         char(20)                       not null,
       EmployeeSysId        integer,
       BIKStartYear         integer,
       BIKStartPeriod       integer,
       BIKEndPeriod         integer,
       BIKAnnualAmount      double,
       BIKNoOfPayment       double,
       BIKPaymentPerSubPeriod double,
       BIKPreviousPayment   double,
       Remarks              char(100),
       constraint PK_MALBIKRECURRING primary key (BIKRecurSysId)
   );

   /*==============================================================*/
   /* Index: MalBIKRecurring_PK                                    */
   /*==============================================================*/
   create unique index MalBIKRecurring_PK on MalBIKRecurring (
   BIKRecurSysId ASC
   );

   /*==============================================================*/
   /* Index: Relationship_738_FK                                   */
   /*==============================================================*/
   create  index Relationship_738_FK on MalBIKRecurring (
   MalBIKItemId ASC
   );

   /*==============================================================*/
   /* Index: Relationship_742_FK                                   */
   /*==============================================================*/
   create  index Relationship_742_FK on MalBIKRecurring (
   EmployeeSysId ASC
   );

   alter table MalBIKRecord
      add constraint FK_MALBIKRE_RELATIONS_MALBIKRE foreign key (BIKRecRecurSysId)
         references MalBIKRecurring (BIKRecurSysId)
         on update restrict
         on delete restrict;

   alter table MalBIKRecurring
      add constraint FK_MALBIKRE_RELATIONS_MALBIKIT foreign key (MalBIKItemId)
         references MalBIKItem (MalBIKItemId)
         on update restrict
         on delete restrict;

   alter table MalBIKRecurring
      add constraint FK_MALBIKRE_RELATIONS_PAYEMPLO foreign key (EmployeeSysId)
         references PayEmployee (EmployeeSysId)
         on update restrict
         on delete restrict;

end if;


commit work;
