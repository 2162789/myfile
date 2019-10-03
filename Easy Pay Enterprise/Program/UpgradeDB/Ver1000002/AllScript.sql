if exists(
   select 1 from sys.systable 
   where table_name='iAnlysDispSection'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iAnlysDispSection
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iAnlysItemSetup'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iAnlysItemSetup
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iAnlysProject'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iAnlysProject
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iAnlysSetup'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iAnlysSetup
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iColourScheme'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iColourScheme
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iEmpColItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iEmpColItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iEmpGrpItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iEmpGrpItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iEmpSortItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iEmpSortItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iEmployeeRpt'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iEmployeeRpt
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iExcelSpreadsheet'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iExcelSpreadsheet
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iExcelWkSheet'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iExcelWkSheet
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iExcelWkSheetItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iExcelWkSheetItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iFinanceColItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iFinanceColItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iFinanceGrpItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iFinanceGrpItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iFinanceRowItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iFinanceRowItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iFinanceSortItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iFinanceSortItem
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iFinancialRpt'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iFinancialRpt
end if;

/*==============================================================*/
/* Table: iAnlysDispSection                                     */
/*==============================================================*/
create table dba.iAnlysDispSection 
(
    AnlysDisplaySysId    char(30)                       not null,
    AnlysItemSysId       char(30),
    AnlysLookUpId        char(50),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    DisplaySubSection    integer,
    constraint PK_IANLYSDISPSECTION primary key (AnlysDisplaySysId)
);

/*==============================================================*/
/* Table: iAnlysItemSetup                                       */
/*==============================================================*/
create table dba.iAnlysItemSetup 
(
    InterfaceAnlysItemSysId char(30)                       not null,
    AnlysSetupId         char(30),
    AnlysItemTypeId      char(20),
    DisplaySection       integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IANLYSITEMSETUP primary key (InterfaceAnlysItemSysId)
);

/*==============================================================*/
/* Table: iAnlysProject                                         */
/*==============================================================*/
create table dba.iAnlysProject 
(
    AnlysProjectId       char(30)                       not null,
    AnlysSetupId         char(30),
    AnlysProjectDesc     char(100),
    AnlysProjectType     char(20),
    Basis1               char(20),
    Basis2               char(20),
    Basis3               char(20),
    CycleMethod          char(20),
    CycleGroupBy         char(20),
    CycleSubGroupBy      char(20),
    SummaryLevel         char(20),
    IsSystemProject      smallint,
    AnlysProjectSubType  char(20),
    BasisPolicyId1       char(20),
    BasisPolicyId2       char(20),
    BasisPolicyId3       char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IANLYSPROJECT primary key (AnlysProjectId)
);

/*==============================================================*/
/* Table: iAnlysSetup                                           */
/*==============================================================*/
create table dba.iAnlysSetup 
(
    InterfaceAnlysSetupId char(30)                       not null,
    AnlysSetupDesc       char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IANLYSSETUP primary key (InterfaceAnlysSetupId)
);

/*==============================================================*/
/* Table: iColourScheme                                         */
/*==============================================================*/
create table dba.iColourScheme 
(
    InterfaceColourSchemeId char(20)                       not null,
    ColourSchemeDesc     char(100),
    ColourSchFont        char(50),
    ColourSchFontStyle   char(20),
    ColourSchSize        integer,
    ColourSchUnderline   char(30),
    ColourSchStrikethrough smallint,
    ColourSchSuperscript smallint,
    ColourSchSubscript   smallint,
    ColourSchCellHeight  integer,
    ColourSchCellWidth   integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ICOLOURSCHEME primary key (InterfaceColourSchemeId)
);

/*==============================================================*/
/* Table: iEmpColItem                                           */
/*==============================================================*/
create table dba.iEmpColItem 
(
    EmpColItemSysId      integer                        not null,
    EmpInfoRptId         char(20),
    ColourSchemeId       char(20),
    EmpColItemOrder      integer,
    EmpColIsRptMainInfo  smallint                       default 0,
    EmpColItemType       char(20),
    EmpColItemTitle      char(50),
    EmpColSysTableId     char(100),
    EmpColSysAttributeId char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEMPCOLITEM primary key (EmpColItemSysId)
);

/*==============================================================*/
/* Table: iEmpGrpItem                                           */
/*==============================================================*/
create table dba.iEmpGrpItem 
(
    EmpGrpItemSysId      integer                        not null,
    EmpInfoRptId         char(20),
    ColourSchemeId       char(20),
    EmpGrpItemOrder      integer,
    EmpGrpItemType       char(20),
    EmpGrpItemTitle      char(50),
    EmpGrpSysTableId     char(100),
    EmpGrpSysAttributeId char(100),
    EmpGrpHasEmpCount    smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEMPGRPITEM primary key (EmpGrpItemSysId)
);

/*==============================================================*/
/* Table: iEmpSortItem                                          */
/*==============================================================*/
create table dba.iEmpSortItem 
(
    EmpSortItemSysId     integer,
    EmpInfoRptId         char(20),
    ColourSchemeId       char(20),
    EmpSortItemOrder     integer,
    EmpSortItemType      char(20),
    EmpSortItemTitle     char(50),
    EmpSortSysTableId    char(100),
    EmpSortSysAttributeId char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint
);

/*==============================================================*/
/* Table: iEmployeeRpt                                          */
/*==============================================================*/
create table dba.iEmployeeRpt 
(
    InterfaceEmpInfoRptId char(20)                       not null,
    EmpInfoRptDesc       char(100),
    EmpInfoRptType       char(20),
    EmployeeRptHasFilter smallint,
    EmployeeRptFilterCond char(255),
    EmployeeRptHasEmpCt  smallint,
    EmployeeRptHasEmpOnly smallint                       default 1,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEMPLOYEERPT primary key (InterfaceEmpInfoRptId)
);

/*==============================================================*/
/* Table: iExcelSpreadsheet                                     */
/*==============================================================*/
create table dba.iExcelSpreadsheet 
(
    InterfaceExcelSpreadsheetId char(20)                       not null,
    ExcelSpreadsheetDesc char(100),
    ExcelRptFileName     char(50),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEXCELSPREADSHEET primary key (InterfaceExcelSpreadsheetId)
);

/*==============================================================*/
/* Table: iExcelWkSheet                                         */
/*==============================================================*/
create table dba.iExcelWkSheet 
(
    InterfaceWkSheetSysId integer                        not null,
    ExcelSpreadsheetId   char(20),
    WkSheetName          char(50),
    WkSheetOrder         integer,
    WkSheetRptSumLvl     char(20),
    WkSheetRptBasis1     char(20),
    WkSheetRptBasis2     char(20),
    WkSheetRptBasis3     char(20),
    WkSheetHasRptHeader  smallint,
    WkSheetHasRptFooter  smallint,
    WkSheetRptHeader     long binary,
    WkSheetRptFooter     long binary,
    WkSheetHeadColourSchemeId char(20),
    WkSheetFootColourSchemeId char(20),
    WkSheetTitleColourSchemeId char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEXCELWKSHEET primary key (InterfaceWkSheetSysId)
);

/*==============================================================*/
/* Table: iExcelWkSheetItem                                     */
/*==============================================================*/
create table dba.iExcelWkSheetItem 
(
    WkSheetItemSysId     integer                        not null,
    WkSheetSysId         integer,
    WkSheetItemOrdering  integer,
    WkSheetItemRptType   char(20),
    WkSheetItemRptId     char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEXCELWKSHEETITEM primary key (WkSheetItemSysId)
);

/*==============================================================*/
/* Table: iFinanceColItem                                       */
/*==============================================================*/
create table dba.iFinanceColItem 
(
    FinColItemSysId      integer                        not null,
    ColourSchemeId       char(20),
    FinancialRptId       char(20),
    FinColItemOrder      integer,
    FinColItemType       char(20),
    FinColItemTitle      char(250),
    FinColIncAccuRange   smallint,
    FinColIsRptMainInfo  smallint                       default 0,
    FinColGrouping       char(100),
    FinColItem           char(100),
    FinColComponent      char(100),
    FinColExcelFormula   char(255),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFINANCECOLITEM primary key (FinColItemSysId)
);

/*==============================================================*/
/* Table: iFinanceGrpItem                                       */
/*==============================================================*/
create table dba.iFinanceGrpItem 
(
    FinGrpItemSysId      integer                        not null,
    ColourSchemeId       char(20),
    FinancialRptId       char(20),
    FinGrpItemOrder      integer,
    FinGrpItemType       char(20),
    FinGrpItemTitle      char(50),
    FinGrpGrouping       char(100),
    FinGrpItem           char(100),
    FinGrpComponent      char(100),
    FinGrpHasSubTotal    smallint,
    FinGrpHasEmpCount    smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFINANCEGRPITEM primary key (FinGrpItemSysId)
);

/*==============================================================*/
/* Table: iFinanceRowItem                                       */
/*==============================================================*/
create table dba.iFinanceRowItem 
(
    FinRowItemSysId      integer                        not null,
    ColourSchemeId       char(20),
    FinancialRptId       char(20),
    FinRowItemOrder      integer,
    FinRowItemType       char(20),
    FinRowItemTitle      char(50),
    FinRowGrouping       char(100),
    FinRowItem           char(100),
    FinRowComponent      char(100),
    FinRowExcelFormula   char(255),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFINANCEROWITEM primary key (FinRowItemSysId)
);

/*==============================================================*/
/* Table: iFinanceSortItem                                      */
/*==============================================================*/
create table dba.iFinanceSortItem 
(
    FinSortItemSysId     integer                        not null,
    ColourSchemeId       char(20),
    FinancialRptId       char(20),
    FinSortItemOrder     integer,
    FinSortItemType      char(20),
    FinSortItemTitle     char(50),
    FinSortGrouping      char(100),
    FinSortItem          char(100),
    FinSortComponent     char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFINANCESORTITEM primary key (FinSortItemSysId)
);

/*==============================================================*/
/* Table: iFinancialRpt                                         */
/*==============================================================*/
create table dba.iFinancialRpt 
(
    InterfaceFinancialRptId char(20)                       not null,
    LayoutSchemeId       char(20),
    FinancialRptDesc     char(100),
    FinancialAnalysProjId char(30),
    FinancialHasGrandTot smallint,
    FinancialHasTotEmpCt smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFINANCIALRPT primary key (InterfaceFinancialRptId)
);



ALTER TABLE dba.InterfaceTableMapping MODIFY InputCols char (400);
ALTER TABLE dba.InterfaceTableMapping MODIFY OutPutCols char (400);
Commit Work;

DELETE FROM InterfaceTableMapping WHERE iTableName='iFinancialRpt';
DELETE FROM InterfaceTableMapping WHERE iTableName='iEmployeeRpt';
DELETE FROM InterfaceTableMapping WHERE iTableName='iAnlysSetup';
DELETE FROM InterfaceTableMapping WHERE iTableName='iAnlysItemSetup';
DELETE FROM InterfaceTableMapping WHERE iTableName='iExcelSpreadsheet';
DELETE FROM InterfaceTableMapping WHERE iTableName='iExcelWkSheet';
DELETE FROM InterfaceTableMapping WHERE iTableName='iColourScheme';
Commit Work;
INSERT INTO InterfaceTableMapping VALUES ('ColourScheme','iColourScheme','ColourCodeMapId,ColourSchCellHeight,ColourSchCellWidth,ColourSchemeDesc,InterfaceColourSchemeId,ColourSchFont,ColourSchFontStyle,ColourSchSize,ColourSchStrikethrough,ColourSchSubscript,ColourSchSuperscript','');
INSERT INTO InterfaceTableMapping VALUES ('ExcelSpreadsheet','iExcelSpreadsheet','ExcelRptFileName,ExcelSpreadsheetDesc,InterfaceExcelSpreadsheetId','');
INSERT INTO InterfaceTableMapping VALUES ('ExcelWkSheet','iExcelWkSheet','ExcelSpreadsheetId,WkSheetFootColourSchemeId,WkSheetHasRptFooter,WkSheetHasRptHeader,WkSheetHeadColourSchemeId,WkSheetName,WkSheetOrder,WkSheetRptBasis1,WkSheetRptBasis2,WkSheetRptBasis3,WkSheetRptFooter,WkSheetRptHeader,WkSheetRptSumLvl,InterfaceWkSheetSysId,WkSheetTitleColourSchemeId','');
INSERT INTO InterfaceTableMapping VALUES ('FinancialRpt','iFinancialRpt','FinancialAnalysProjId,FinancialHasGrandTot,FinancialHasTotEmpCt,FinancialRptDesc,InterfaceFinancialRptId,LayoutSchemeId','');
INSERT INTO InterfaceTableMapping VALUES ('EmployeeRpt','iEmployeeRpt','EmpInfoRptDesc,InterfaceEmpInfoRptId,EmpInfoRptType,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly,EmployeeRptHasFilter','');
INSERT INTO InterfaceTableMapping VALUES ('AnlysSetup','iAnlysSetup','AnlysSetupDesc,InterfaceAnlysSetupId','');
INSERT INTO InterfaceTableMapping VALUES ('AnlysItemSetup','iAnlysItemSetup','InterfaceAnlysItemSysId,AnlysItemTypeId,AnlysSetupId,DisplaySection','');
Commit Work;

UPDATE InterfaceProcess SET IntProcActivate=1 WHERE InterfaceProjectID='EPESetup' AND InterfaceProcessID='Employment Process';

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinancialRpt') then
   drop procedure DeleteFinancialRpt
end if
;

CREATE PROCEDURE "DBA"."DeleteFinancialRpt"(
in In_FinancialRptId char(20),
out Out_ErrorCode integer)
begin
  declare Out_AnlysProjectId char(30);
  declare Out_AnlysSetupId char(30);
  if exists(select* from FinancialRpt where FinancialRptId = In_FinancialRptId) then
    if exists(select* from ExcelWkSheetItem where WkSheetItemRptId = In_FinancialRptId and WkSheetItemRptType = 'FinancialRpt') then
      set Out_ErrorCode=-1;
      return
    end if;
    delete from FinanceSortItem where FinancialRptId = In_FinancialRptId;
    commit work;
    delete from FinanceGrpItem where FinancialRptId = In_FinancialRptId;
    commit work;
    delete from FinanceRowItem where FinancialRptId = In_FinancialRptId;
    commit work;
    /* Delete FinanceColItem*/
    if exists(select* from FinanceColItem  where FinancialRptId = In_FinancialRptId) then
        FinanceColItemLoop: for FinanceColItemFor as Cur_FinColItemSysId dynamic scroll cursor for
        select FinanceColItem.FinColItemSysId as Get_FinColItemSysId from FinanceColItem where FinanceColItem.FinancialRptId = In_FinancialRptId do
        call DeleteFinanceColItem(Get_FinColItemSysId,ErrorCode) end for;
    end if;
    /*Delete Analysis Project & Setup*/
    select FinancialAnalysProjId into Out_AnlysProjectId from FinancialRpt where FinancialRptId = In_FinancialRptId;
    select AnlysSetupId into Out_AnlysSetupId from AnlysProject where AnlysProjectId = Out_AnlysProjectId;
    call DeleteAnlysProject(Out_AnlysProjectId,ErrorCode);
    
    if not exists(select* from AnlysSetup where AnlysSetupId = Out_AnlysSetupId) then
        call DeleteAnlysSetup(Out_AnlysSetupId,ErrorCode);
    end if;

    delete from FinancialRpt where FinancialRptId = In_FinancialRptId;
    commit work;
    if exists(select* from FinancialRpt where FinancialRptId = In_FinancialRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists (select * from sys.systriggers where tname='ExcelWkSheet' and trigname='ExcelWkSheetInsert') then
    DROP TRIGGER ExcelWkSheetInsert;
end if;
