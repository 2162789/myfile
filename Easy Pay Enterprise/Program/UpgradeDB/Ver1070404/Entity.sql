/*==============================================================*/
/* Table: DetailRecord                                    */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'DetailRecord' and cname = 'PayRecBasicRate') then
   alter table DetailRecord add PayRecBasicRate double;
   update DetailRecord set PayRecBasicRate = 0;
end if;

if not exists(select * from sys.syscolumns where tname = 'DetailRecord' and cname = 'PayRecBasicRateF') then
   alter table DetailRecord add PayRecBasicRateF double;
   update DetailRecord set PayRecBasicRateF = 0;
end if;

/*==============================================================*/
/* Table: iRebateClaimRecord                                    */
/*==============================================================*/
if not exists(select * from sys.systable where table_name = 'iRebateClaimRecord') then
	create table DBA.iRebateClaimRecord 
	(
			RebateClaimSysId     integer                        not null default AUTOINCREMENT,
			RebateIdentityNo     char(20),
			RebateDate           date,
			RebateePortalStatus  char(20),
			RebateID             char(20),
			RebateClaimAmt       double,
			RebateReferenceNo    char(20),
			RebateReceiptDate    date,
			RebateRemarks        char(100),
			Processed            smallint,
			ProcessedDateTime    timestamp,
			ErrorMessage         char(100),
			CreatedBy            char(1),
			InterfaceGranted     smallint,
			constraint PK_IREBATECLAIMRECORD primary key (RebateClaimSysId)
	);

	/*==============================================================*/
	/* Index: iRebateClaimRecord_PK                                 */
	/*==============================================================*/
	create unique index iRebateClaimRecord_PK on iRebateClaimRecord (
	RebateClaimSysId ASC
	);

end if;

/*==============================================================*/
/* Table: iYTDMYPolicy                                    */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'iYTDMYPolicy' and cname = 'EISEmployeeContri') then
    alter table iYTDMYPolicy add EISEmployeeContri double;
end if;

if not exists(select * from sys.syscolumns where tname = 'iYTDMYPolicy' and cname = 'EISEmployerContri') then
    alter table iYTDMYPolicy add EISEmployerContri double;
end if;

commit work;