READ UpgradeDB\Ver1060103\StoredPro.sql;
READ UpgradeDB\Ver1060103\iFamilyEduRecViewer_All.sql;

/*==============================================================*/
/* Table: iFamilyEduRec                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iFamilyEduRec') then
    drop table iFamilyEduRec
end if;
create table DBA.iFamilyEduRec 
(
    FamilyEduRecSysId    integer                        not null default AUTOINCREMENT,
    FamilyIdentityNo     char(30),
    PersonName           char(150),
    EducationId          char(20),
    EduInstitution       char(100),
    EduStartDate         date,
    EduEndDate           date,
    EduHighest           smallint,
    EduResult            double,
    EduLocal             smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFAMILYEDUREC primary key (FamilyEduRecSysId)
);

/*==============================================================*/
/* Index: iFamilyEduRec_PK                                      */
/*==============================================================*/
create unique index iFamilyEduRec_PK on iFamilyEduRec (
FamilyEduRecSysId ASC
);

if not exists (select 1 from ePortalVersion where EPE=1060100 and ePortal=1030000) then
  insert into ePortalVersion (EPE, ePortal) values (1060100,1030000)
end if;

if not exists (select 1 from ePortalVersion where EPE=1060200 and ePortal=1030000) then
  insert into ePortalVersion (EPE, ePortal) values (1060200,1030000)
end if;

Commit Work;