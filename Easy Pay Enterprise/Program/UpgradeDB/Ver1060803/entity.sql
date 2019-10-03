/*==============================================================*/
/* Table: LabSurveyCessationMapping                             */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyCessationMapping') then
create table DBA.LabSurveyCessationMapping 
(
    EPECessationCode     char(20)                       not null,
    MOMReason            char(20),
    constraint PK_LABSURVEYCESSATIONMAPPING primary key (EPECessationCode)
);

/*==============================================================*/
/* Index: LabSurveyCessationMapping_PK                          */
/*==============================================================*/
create unique index LabSurveyCessationMapping_PK on LabSurveyCessationMapping (
EPECessationCode ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveyEmpClassificationMapping                     */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyEmpClassificationMapping') then
create table DBA.LabSurveyEmpClassificationMapping 
(
    EPEClassification    char(20)                       not null,
    MOMEmployeeClassification char(20),
    constraint PK_LABSURVEYEMPCLASSIFICATIONM primary key (EPEClassification)
);

/*==============================================================*/
/* Index: LabSurveyEmpClassificationMapping_PK                  */
/*==============================================================*/
create unique index LabSurveyEmpClassificationMapping_PK on LabSurveyEmpClassificationMapping (
EPEClassification ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveyEmployeeRecord                               */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyEmployeeRecord') then
create table DBA.LabSurveyEmployeeRecord 
(
    LabSurveyEmployeeRecordId integer                        not null default AUTOINCREMENT,
    LabSurveyRecordId    integer,
    EmployeeSysId        integer,
    Result               double,
    constraint PK_LABSURVEYEMPLOYEERECORD primary key (LabSurveyEmployeeRecordId)
);

/*==============================================================*/
/* Index: LabSurveyEmployeeRecord_PK                            */
/*==============================================================*/
create unique index LabSurveyEmployeeRecord_PK on LabSurveyEmployeeRecord (
LabSurveyEmployeeRecordId ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveyJobPositionMapping                           */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyJobPositionMapping') then
create table DBA.LabSurveyJobPositionMapping 
(
    EPEJobPosition       char(20)                       not null,
    MOMJobPosition       char(20),
    constraint PK_LABSURVEYJOBPOSITIONMAPPING primary key (EPEJobPosition)
);

/*==============================================================*/
/* Index: LabSurveyJobPositionMapping_PK                        */
/*==============================================================*/
create unique index LabSurveyJobPositionMapping_PK on LabSurveyJobPositionMapping (
EPEJobPosition ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveyKeyword                                      */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyKeyword') then
create table DBA.LabSurveyKeyword 
(
    KeywordId            char(20)                       not null,
    KeywordDesc          char(200),
    KeywordCategory      char(50),
    constraint PK_LABSURVEYKEYWORD primary key (KeywordId)
);

/*==============================================================*/
/* Index: LabSurveyKeyword_PK                                   */
/*==============================================================*/
create unique index LabSurveyKeyword_PK on LabSurveyKeyword (
KeywordId ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveyRecord                                       */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyRecord') then
create table DBA.LabSurveyRecord 
(
    LabSurveyRecordId    integer                        not null default AUTOINCREMENT,
    LabSurveySetupId     integer,
    Description          char(255),
    Rule1                char(255),
    Rule2                char(255),
    Result               double,
    IPAddress            char(100),
    DisplaySequence      integer,
    constraint PK_LABSURVEYRECORD primary key (LabSurveyRecordId)
);

/*==============================================================*/
/* Index: LabSurveyRecord_PK                                    */
/*==============================================================*/
create unique index LabSurveyRecord_PK on LabSurveyRecord (
LabSurveyRecordId ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveyResidenceStatusMapping                       */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveyResidenceStatusMapping') then
create table DBA.LabSurveyResidenceStatusMapping 
(
    LabourSurveyResidenceStatusId integer                        not null default AUTOINCREMENT,
    EPEResidenceStatus   char(20),
    MOMResidenceStatus   char(20),
    constraint PK_LABSURVEYRESIDENCESTATUSMAP primary key (LabourSurveyResidenceStatusId)
);

/*==============================================================*/
/* Index: LabSurveyResidenceStatusMapping_PK                    */
/*==============================================================*/
create unique index LabSurveyResidenceStatusMapping_PK on LabSurveyResidenceStatusMapping (
LabourSurveyResidenceStatusId ASC
);
end if;

/*==============================================================*/
/* Table: LabSurveySetup                                        */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'LabSurveySetup') then
create table DBA.LabSurveySetup 
(
    LabSurveySetupId     integer                        not null default AUTOINCREMENT,
    Description          char(255),
    Rule1                char(255),
    Rule2                char(255),
    Rule3                char(20),
    Query                char(500),
    QueryCondition       char(500),
    DisplaySection       integer,
    DisplayRow           integer,
    DisplayColumn        integer,
    ShowEmpDetail        smallint,
    constraint PK_LABSURVEYSETUP primary key (LabSurveySetupId)
);

/*==============================================================*/
/* Index: LabSurveySetup_PK                                     */
/*==============================================================*/
create unique index LabSurveySetup_PK on LabSurveySetup (
LabSurveySetupId ASC
);
end if;

commit work;