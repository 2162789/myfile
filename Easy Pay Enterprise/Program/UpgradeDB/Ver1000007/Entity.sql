/*==============================================================*/
/* Table: AccpacExportLog                                       */
/*==============================================================*/

if exists(select 1 from sys.systable where table_name='AccpacExportLog') then
   drop table  AccpacExportLog
end if;

create table dba.AccpacExportLog 
(
    APSysId              integer                        not null default AUTOINCREMENT,
    APBatchId            char(6),
    APUserId             char(8),
    APCompany            char(6),
    EPEUserId            char(20),
    IsSuccess            smallint,
    ErrorMessage         char(100),
    LastChangedDateTime  timestamp,
    constraint PK_ACCPACEXPORTLOG primary key (APSysId)
);


/*==============================================================*/
/* Index: AccpacExportLog_PK                                    */
/*==============================================================*/
create unique index AccpacExportLog_PK on AccpacExportLog (
APSysId ASC
);

