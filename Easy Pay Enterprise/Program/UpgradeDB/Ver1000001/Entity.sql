/*========================================================================================*/
/* Interface Table											                               */
/*========================================================================================*/

/*==============================================================*/
/* Table: iAnlysDispSection                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iAnlysDispSection') then
   drop table iAnlysDispSection
end if;

create table dba.iAnlysDispSection 
(
    AnlysDisplaySysId    char(30)                       not null,
    AnlysItemSysId1      char(30),
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
if exists(select 1 from sys.systable where table_name='iAnlysItemSetup') then
   drop table iAnlysItemSetup
end if;

create table dba.iAnlysItemSetup 
(
    AnlysItemSysId       char(30)                       not null,
    AnlysSetupId3        char(30),
    AnlysItemTypeId      char(20),
    DisplaySection       integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IANLYSITEMSETUP primary key (AnlysItemSysId)
);


/*==============================================================*/
/* Table: iAnlysProject                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iAnlysProject') then
   drop table iAnlysProject
end if;

create table dba.iAnlysProject 
(
    AnlysProjectId       char(30)                       not null,
    AnlysSetupId2        char(30),
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
if exists(select 1 from sys.systable where table_name='iAnlysSetup') then
   drop table iAnlysSetup
end if;

create table dba.iAnlysSetup 
(
    AnlysSetupId         char(30)                       not null,
    AnlysSetupDesc       char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IANLYSSETUP primary key (AnlysSetupId)
);


/*==============================================================*/
/* Table: iBankAccType                                          */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iBankAccType') then
   drop table iBankAccType
end if;

create table dba.iBankAccType 
(
    iBankAccTypeId       char(20)                       not null,
    BankAccTypeDesc      char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IBANKACCTYPE primary key (iBankAccTypeId)
);


/*==============================================================*/
/* Table: iConnection                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iConnection') then
   drop table iConnection
end if;

create table dba.iConnection 
(
    InterfaceConnectionId char(20)                       not null,
    InterfaceRemarks     char(100),
    InterfaceDSN         char(20),
    InterfacePassword    char(50),
    InterfaceUserId      char(50),
    IsEPEdb              smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ICONNECTION primary key (InterfaceConnectionId)
);


/*==============================================================*/
/* Table: iContactLocation                                      */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iContactLocation') then
   drop table iContactLocation
end if;

create table dba.iContactLocation 
(
    iContactLocationId   char(20)                       not null,
    ContactLocationDesc  char(80),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ICONTACTLOCATION primary key (iContactLocationId)
);


/*==============================================================*/
/* Table: iCostingMethod                                        */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iCostingMethod') then
   drop table iCostingMethod
end if;

create table dba.iCostingMethod 
(
    CostMethodId         char(20)                       not null,
    CostingMethod        char(20),
    CostingDesc          char(100),
    CostingAllocationBasis char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ICOSTINGMETHOD primary key (CostMethodId)
);


/*==============================================================*/
/* Table: iEmpColItem                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iEmpColItem') then
   drop table iEmpColItem
end if;

create table dba.iEmpColItem 
(
    EmpColItemSysId      integer                        not null,
    EmpInfoRptId1        char(20),
    ColourSchemeId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iEmpGrpItem') then
   drop table iEmpGrpItem
end if;

create table dba.iEmpGrpItem 
(
    EmpGrpItemSysId      integer                        not null,
    EmpInfoRptId1        char(20),
    ColourSchemeId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iEmpSortItem') then
   drop table iEmpSortItem
end if;

create table dba.iEmpSortItem 
(
    EmpSortItemSysId     integer                        not null,
    EmpInfoRptId1        char(20),
    ColourSchemeId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iEmployeeRpt') then
   drop table iEmployeeRpt
end if;

create table dba.iEmployeeRpt 
(
    EmpInfoRptId         char(20)                       not null,
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
    constraint PK_IEMPLOYEERPT primary key (EmpInfoRptId)
);



/*==============================================================*/
/* Table: iExcelSpreadsheet                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iExcelSpreadsheet') then
   drop table iExcelSpreadsheet
end if;

create table dba.iExcelSpreadsheet 
(
    ExcelSpreadsheetId   char(20)                       not null,
    ExcelSpreadsheetDesc char(100),
    ExcelRptFileName     char(50),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IEXCELSPREADSHEET primary key (ExcelSpreadsheetId)
);


/*==============================================================*/
/* Table: iExcelWkSheet                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iExcelWkSheet') then
   drop table iExcelWkSheet
end if;

create table dba.iExcelWkSheet 
(
    WkSheetSysId         integer                        not null,
    ExcelSpreadsheetId1  char(20),
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
    constraint PK_IEXCELWKSHEET primary key (WkSheetSysId)
);


/*==============================================================*/
/* Table: iExcelWkSheetItem                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iExcelWkSheetItem') then
   drop table iExcelWkSheetItem
end if;

create table dba.iExcelWkSheetItem 
(
    WkSheetItemSysId     integer                        not null,
    WhSheetSysId1        integer,
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
/* Table: iFieldMajor                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iFieldMajor') then
   drop table iFieldMajor
end if;

create table dba.iFieldMajor 
(
    iFieldMajorId        char(20)                       not null,
    FieldMajorDesc       char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFIELDMAJOR primary key (iFieldMajorId)
);


/*==============================================================*/
/* Table: iFinanceColItem                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iFinanceColItem') then
   drop table iFinanceColItem
end if;

create table dba.iFinanceColItem 
(
    FinColItemSysId      integer                        not null,
    ColourSchemeId1      char(20),
    FinancialRptId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iFinanceGrpItem') then
   drop table iFinanceGrpItem
end if;

create table dba.iFinanceGrpItem 
(
    FinGrpItemSysId      integer                        not null,
    ColourSchemeId1      char(20),
    FinancialRptId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iFinanceRowItem') then
   drop table iFinanceRowItem
end if;

create table dba.iFinanceRowItem 
(
    FinRowItemSysId      integer                        not null,
    ColourSchemeId1      char(20),
    FinancialRptId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iFinanceSortItem') then
   drop table iFinanceSortItem
end if;

create table dba.iFinanceSortItem 
(
    FinSortItemSysId     integer                        not null,
    ColourSchemeId1      char(20),
    FinancialRptId1      char(20),
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
if exists(select 1 from sys.systable where table_name='iFinancialRpt') then
   drop table iFinancialRpt
end if;

create table dba.iFinancialRpt 
(
    FinancialRptId       char(20)                       not null,
    LayoutSchemeIdFin    char(20),
    FinancialRptDesc     char(100),
    FinancialAnalysProjId char(30),
    FinancialHasGrandTot smallint,
    FinancialHasTotEmpCt smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IFINANCIALRPT primary key (FinancialRptId)
);


/*==============================================================*/
/* Table: iImportField                                          */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iImportField') then
   drop table iImportField
end if;

create table dba.iImportField 
(
    WorkSheetID          char(20)                       not null,
    ImportFieldPhysical  char(50)                       not null,
    Column               char(2),
    Row                  integer,
    DateValue            date,
    StringValue          char(100),
    IntegerValue         integer,
    NumericValue         double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IIMPORTFIELD primary key (WorkSheetID, ImportFieldPhysical)
);


/*==============================================================*/
/* Table: iImportProject                                        */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iImportProject') then
   drop table iImportProject
end if;

create table dba.iImportProject 
(
    ImportProjectId      char(20)                       not null,
    InterfaceConnectionId char(20),
    ImportExtConnection  smallint,
    ImportProjectRemarks char(100),
    ImportAppearIn       char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IIMPORTPROJECT primary key (ImportProjectId)
);


/*==============================================================*/
/* Table: iImportProjectMember                                  */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iImportProjectMember') then
   drop table iImportProjectMember
end if;

create table dba.iImportProjectMember 
(
    ImportSpSheetId      char(20)                       not null,
    ImportProjectId      char(20)                       not null,
    ProcessSequence      integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IIMPORTPROJECTMEMBER primary key (ImportSpSheetId, ImportProjectId)
);


/*==============================================================*/
/* Table: iImportSSMember                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iImportSSMember') then
   drop table iImportSSMember
end if;

create table dba.iImportSSMember 
(
    WorkSheetID          char(20)                       not null,
    ImportSpSheetId      char(20)                       not null,
    ProcessSequence      integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IIMPORTSSMEMBER primary key (WorkSheetID, ImportSpSheetId)
);


/*==============================================================*/
/* Table: iImportSpreadSheet                                    */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iImportSpreadSheet') then
   drop table iImportSpreadSheet
end if;

create table dba.iImportSpreadSheet 
(
    ImportSpSheetId      char(20)                       not null,
    ImportSpSheetRemarks char(100),
    ImportSpSheetPath    char(200),
    ImportSpSheetType    char(20),
    ImportSpSheetPassword char(50),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IIMPORTSPREADSHEET primary key (ImportSpSheetId)
);


/*==============================================================*/
/* Table: iImportWorkSheet                                      */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iImportWorkSheet') then
   drop table iImportWorkSheet
end if;

create table dba.iImportWorkSheet 
(
    WorkSheetID          char(20)                       not null,
    WorkSheetName        char(50),
    WorkSheetType        char(20),
    PhysicalTableName    char(50),
    EndingColumn         char(2),
    EndingRow            integer,
    StartingColumn       char(2),
    StartingRow          integer,
    LogFileName          char(50),
    LogFilePath          char(200),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IIMPORTWORKSHEET primary key (WorkSheetID)
);


/*==============================================================*/
/* Table: iInterfaceAttribute                                   */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iInterfaceAttribute') then
   drop table iInterfaceAttribute
end if;

create table dba.iInterfaceAttribute 
(
    InterfaceProjectID   char(20)                       not null,
    InterfaceAttributeID char(20)                       not null,
    InterfaceAttrTableID char(20)                       not null,
    InterfaceAttrUse     smallint,
    InterfacePhysicalAttr char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IINTERFACEATTRIBUTE primary key (InterfaceProjectID, InterfaceAttributeID, InterfaceAttrTableID)
);


/*==============================================================*/
/* Table: iInterfaceCodeMapping                                 */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iInterfaceCodeMapping') then
   drop table iInterfaceCodeMapping
end if;

create table dba.iInterfaceCodeMapping 
(
    InterfaceProjectID   char(20)                       not null,
    InterfaceProcessID   char(20)                       not null,
    CodeTableID          char(20)                       not null,
    CodeMappingExtID     char(50)                       not null,
    CodeMappingEPEID     char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IINTERFACECODEMAPPING primary key (InterfaceProjectID, InterfaceProcessID, CodeTableID, CodeMappingExtID)
);


/*==============================================================*/
/* Table: iInterfaceCodeTable                                   */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iInterfaceCodeTable') then
   drop table  iInterfaceCodeTable
end if;

create table dba.iInterfaceCodeTable 
(
    InterfaceProjectID   char(20)                       not null,
    InterfaceProcessID   char(20)                       not null,
    CodeTableID          char(20)                       not null,
    CodeSQLStatement     char(200),
    CodeSkipMapping      smallint,
    CodeUseExternal      smallint,
    CodeExternalSQL      char(200),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IINTERFACECODETABLE primary key (InterfaceProjectID, InterfaceProcessID, CodeTableID)
);


/*==============================================================*/
/* Table: iInterfaceProcess                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iInterfaceProcess') then
   drop table  iInterfaceProcess
end if;

create table dba.iInterfaceProcess 
(
    InterfaceProjectID   char(20)                       not null,
    InterfaceProcessID   char(20)                       not null,
    InterfaceConnectionId char(20),
    IntProcExtConnection smallint,
    IntProcActivate      smallint,
    IntProcRemarks       char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IINTERFACEPROCESS primary key (InterfaceProjectID, InterfaceProcessID)
);


/*==============================================================*/
/* Table: iInterfaceProject                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iInterfaceProject') then
   drop table  iInterfaceProject
end if;

create table dba.iInterfaceProject 
(
    InterfaceProjectID   char(20)                       not null,
    InterfaceProjRemarks char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IINTERFACEPROJECT primary key (InterfaceProjectID)
);


/*==============================================================*/
/* Table: iLeaveComputation                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveComputation') then
   drop table  iLeaveComputation
end if;

create table dba.iLeaveComputation 
(
    LeaveTypeId          char(20)                       not null,
    HasEntitleApp        smallint,
    HasBFApp             smallint,
    HasForfeitApp        smallint,
    HasAdvApp            smallint,
    HasHourApp           smallint,
    HasHalfDayApp        smallint,
    HasDeductSeq         smallint,
    LeaveRoundMethod     char(20),
    EntProrateMethod     char(20),
    EntProrateCutOffDay  integer,
    EntProrateBeforeCutoff double,
    NoProrateCareerChange smallint,
    NoProrateHire        smallint,
    NoProrateCess        smallint,
    EntDistributeMethod  char(20),
    BFLeaveTypeId        char(20),
    BFForfeitTime        integer,
    CanHalfDayApplyHour  smallint,
    LeaveFunctionId      char(20),
    HireSuspendMethod    char(20),
    HireSuspendUntil     integer,
    CessSuspendMethod    char(20),
    CessSuspendStart     integer,
    IncludeHolidayOff    smallint,
    EntTakenNoEnt        smallint,
    HasSIWageDeduct      smallint,
    HasSIReimbursement   smallint,
    C04ContriRate        double,
    HasLeaveSuspension   smallint,
    LeaveSuspensionMethod char(20),
    LeaveSuspensionValue integer,
    LeaveSuspensionField char(20),
    TotalEntRoundMethod  smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVECOMPUTATION primary key (LeaveTypeId)
);


/*==============================================================*/
/* Table: iLeaveEligibleGroup                                   */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveEligibleGroup') then
   drop table  iLeaveEligibleGroup
end if;

create table dba.iLeaveEligibleGroup 
(
    LeaveTypeId          char(20)                       not null,
    LeaveEligibleGroup   char(20)                       not null,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVEELIGIBLEGROUP primary key (LeaveTypeId, LeaveEligibleGroup)
);


/*==============================================================*/
/* Table: iLeaveEligibleItem                                    */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveEligibleItem') then
   drop table  iLeaveEligibleItem
end if;

create table dba.iLeaveEligibleItem 
(
    LeaveTypeId          char(20)                       not null,
    LeaveEligibleGroup   char(20)                       not null,
    LeaveEligibleItem    char(100)                      not null,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVEELIGIBLEITEM primary key (LeaveTypeId, LeaveEligibleGroup, LeaveEligibleItem)
);


/*==============================================================*/
/* Table: iLeaveFormula                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveFormula') then
   drop table  iLeaveFormula
end if;

create table dba.iLeaveFormula 
(
    LveFormulaId         char(30)                       not null,
    LveFormulaActive     smallint,
    LveFormulaCategory   char(20),
    LveFormulaSubCategory char(20),
    LveFormulaType       char(20),
    LveFormulaRangeBasis char(20),
    LveFormulaDesc       char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVEFORMULA primary key (LveFormulaId)
);


/*==============================================================*/
/* Table: iLeaveGroup                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveGroup') then
   drop table  iLeaveGroup
end if;

create table dba.iLeaveGroup 
(
    iLeaveGroupId        char(20)                       not null,
    LeaveGroupDesc       char(100),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVEGROUP primary key (iLeaveGroupId)
);


/*==============================================================*/
/* Table: iLeavePolicy                                          */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeavePolicy') then
   drop table  iLeavePolicy
end if;

create table dba.iLeavePolicy 
(
    LeavePolicyId        char(20)                       not null,
    LeavePolicyDesc      char(40),
    LeavePolicyBasis     char(20),
    LeaveCalendarType    char(20),
    LeaveStartMonth      integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVEPOLICY primary key (LeavePolicyId)
);


/*==============================================================*/
/* Table: iLeavePolicyRecord                                    */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeavePolicyRecord') then
   drop table  iLeavePolicyRecord
end if;

create table dba.iLeavePolicyRecord 
(
    PolicySysId          integer                        not null,
    CostMethodId         char(20),
    LeaveTypeId          char(20),
    LveAllocationId      char(20),
    LeavePolicyId        char(20),
    PolicyStringMatch    char(20),
    PolicyRangeFrom      double,
    PolicyRangeTo        double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVEPOLICYRECORD primary key (PolicySysId)
);


/*==============================================================*/
/* Table: iLeaveRange                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveRange') then
   drop table  iLeaveRange
end if;

create table dba.iLeaveRange 
(
    LveFormulaId         char(30)                       not null,
    LveFormulaRangeId    integer                        not null,
    SearchString         char(100),
    Maximum              double,
    Minimum              double,
    Formula              char(255),
    Constant1            double,
    Constant2            double,
    Constant3            double,
    Constant4            double,
    Constant5            double,
    Keywords1            char(20),
    Keywords10           char(20),
    Keywords2            char(20),
    Keywords3            char(20),
    Keywords4            char(20),
    Keywords5            char(20),
    Keywords6            char(20),
    Keywords7            char(20),
    Keywords8            char(20),
    Keywords9            char(20),
    UserDef1             char(20),
    UserDef2             char(20),
    UserDef3             char(20),
    UserDef4             char(20),
    UserDef5             char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVERANGE primary key (LveFormulaId, LveFormulaRangeId)
);


/*==============================================================*/
/* Table: iLeaveType                                            */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLeaveType') then
   drop table  iLeaveType
end if;

create table dba.iLeaveType 
(
    LeaveTypeId          char(20)                       not null,
    LeaveCredit          smallint,
    LeaveAbbrev          char(2),
    LeaveColorCode       integer,
    LeaveTypeActive      smallint,
    LeaveTypeDesc        char(100),
    LeaveUnit            smallint,
    HasSpecialEligible   smallint,
    SpecialEligibleCode  char(20),
    SpecialEligibleMethod char(20),
    SpecialEligibleValue integer,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILEAVETYPE primary key (LeaveTypeId)
);


/*==============================================================*/
/* Table: iLveAllocFormulaRec                                   */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLveAllocFormulaRec') then
   drop table  iLveAllocFormulaRec
end if;

create table dba.iLveAllocFormulaRec 
(
    CostMethodId         char(20)                       not null,
    LveAllocFormulaSysId integer                        not null,
    LveFormulaId         char(30),
    LveAllocStringMatch  char(20),
    LveAllocRangeFrom    double,
    LveAllocRangeTo      double,
    UserDef1Value        double,
    UserDef2Value        double,
    UserDef3Value        double,
    UserDef4Value        double,
    UserDef5Value        double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILVEALLOCFORMULAREC primary key (CostMethodId, LveAllocFormulaSysId)
);


/*==============================================================*/
/* Table: iLveAllocation                                        */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLveAllocation') then
   drop table  iLveAllocation
end if;

create table dba.iLveAllocation 
(
    LveAllocationId      char(20)                       not null,
    LveAllocationDesc    char(100),
    LveAllocationBasis   char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILVEALLOCATION primary key (LveAllocationId)
);


/*==============================================================*/
/* Table: iLveAllocationRec                                     */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='iLveAllocationRec') then
   drop table  iLveAllocationRec
end if;

create table dba.iLveAllocationRec 
(
    LveAllocationId      char(20)                       not null,
    LveAllocationSysId   integer                        not null,
    LveAllocStringMatch  char(20),
    LveAllocRangeFrom    double,
    LveAllocRangeTo      double,
    MaxEntPerCycle       double,
    MaxBFPerCycle        double,
    MaxForfeitPerCycle   double,
    MaxAdvPerCycle       double,
    MaxHalfPerCycle      double,
    MaxHalfOnHalf        double,
    MaxHourPerDay        double,
    MaxHourPerCycle      double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_ILVEALLOCATIONREC primary key (LveAllocationId, LveAllocationSysId)
);

/*========================================================================================*/
/* End of Interface Table                                                                                                                                        */
/*========================================================================================*/



/*========================================================================================*/
/* EPE Table														         */
/*========================================================================================*/

/*==============================================================*/
/* Table: CustView                                              */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='CustView') then
   drop table  CustView
end if;


create table dba.CustView 
(
    CustViewId           char(20)                       not null,
    CustViewDesc         char(100),
    CustViewName         char(50),
    DriveTbl             char(50),
    DriveItem            char(255),
    constraint PK_CUSTVIEW primary key (CustViewId)
);

/*==============================================================*/
/* Index: CustView_PK                                           */
/*==============================================================*/
create unique index CustView_PK on CustView (
CustViewId ASC
);


/*==============================================================*/
/* Table: CustViewItem                                          */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='CustViewItem') then
   drop table  CustViewItem
end if;

create table dba.CustViewItem 
(
    CustViewId           char(20)                       not null,
    CustViewObjId        char(20)                       not null,
    CustViewTblId        char(50)                       not null,
    CustViewItemID       char(50)                       not null,
    ViewItemFunct        char(255),
    ViewItemAs           char(50),
    constraint PK_CUSTVIEWITEM primary key (CustViewId, CustViewObjId, CustViewTblId, CustViewItemID)
);

/*==============================================================*/
/* Index: CustViewItem_PK                                       */
/*==============================================================*/
create unique index CustViewItem_PK on CustViewItem (
CustViewId ASC,
CustViewObjId ASC,
CustViewTblId ASC,
CustViewItemID ASC
);

/*==============================================================*/
/* Index: Relationship_739_FK                                   */
/*==============================================================*/
create  index Relationship_739_FK on CustViewItem (
CustViewId ASC,
CustViewObjId ASC,
CustViewTblId ASC
);

/*==============================================================*/
/* Table: CustViewObj                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='CustViewObj') then
   drop table  CustViewObj
end if;

create table dba.CustViewObj 
(
    CustViewId           char(20)                       not null,
    CustViewObjId        char(20)                       not null,
    CustViewObjDesc      char(100),
    IsObjSel             smallint,
    constraint PK_CUSTVIEWOBJ primary key (CustViewId, CustViewObjId)
);

/*==============================================================*/
/* Index: CustViewObj_PK                                        */
/*==============================================================*/
create unique index CustViewObj_PK on CustViewObj (
CustViewId ASC,
CustViewObjId ASC
);

/*==============================================================*/
/* Index: Relationship_734_FK                                   */
/*==============================================================*/
create  index Relationship_734_FK on CustViewObj (
CustViewId ASC
);

/*==============================================================*/
/* Table: CustViewObjTbl                                        */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='CustViewObjTbl') then
   drop table  CustViewObjTbl
end if;

create table dba.CustViewObjTbl 
(
    CustViewId           char(20)                       not null,
    CustViewObjId        char(20)                       not null,
    CustViewTblId        char(50)                       not null,
    CustViewCond1        char(255),
    CustViewCond2        char(255),
    CustViewCond3        char(255),
    CustViewCond4        char(255),
    CustViewCond5        char(255),
    constraint PK_CUSTVIEWOBJTBL primary key (CustViewId, CustViewObjId, CustViewTblId)
);

/*==============================================================*/
/* Index: CustViewObjTbl_PK                                     */
/*==============================================================*/
create unique index CustViewObjTbl_PK on CustViewObjTbl (
CustViewId ASC,
CustViewObjId ASC,
CustViewTblId ASC
);

/*==============================================================*/
/* Index: Relationship_736_FK                                   */
/*==============================================================*/
create  index Relationship_736_FK on CustViewObjTbl (
CustViewId ASC,
CustViewObjId ASC
);

alter table CustViewItem
   add constraint FK_CUSTVIEW_RELATIONS_CUSTVIEW foreign key (CustViewId, CustViewObjId, CustViewTblId)
      references CustViewObjTbl (CustViewId, CustViewObjId, CustViewTblId)
      on update restrict
      on delete restrict;

alter table CustViewObj
   add constraint FK_CUSTVIEW_RELATIONS_CUSTVIEW foreign key (CustViewId)
      references CustView (CustViewId)
      on update restrict
      on delete restrict;

alter table CustViewObjTbl
   add constraint FK_CUSTVIEW_RELATIONS_CUSTVIEW foreign key (CustViewId, CustViewObjId)
      references CustViewObj (CustViewId, CustViewObjId)
      on update restrict
      on delete restrict;

/*==============================================================*/
/* Table: InterfaceTableMapping                                 */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='InterfaceTableMapping') then
   drop table  InterfaceTableMapping
end if;

create table dba.InterfaceTableMapping 
(
    PhysicalTableName    char(50)                       not null,
    iTableName           char(50),
    InputCols            char(255),
    OutputCols           char(255),
    constraint PK_INTERFACETABLEMAPPING primary key (PhysicalTableName)
);

/*==============================================================*/
/* Table: OutboxMessage                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='OutboxMessage') then
   drop table  OutboxMessage
end if;

create table dba.OutboxMessage 
(
    OutboxMsgSysId       integer                        not null default AUTOINCREMENT,
    OutboxModule         char(30),
    OutboxSubModule      char(30),
    Description          char(150),
    MessageText          long binary,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(200),
    CreatedById          char(40),
    constraint PK_OUTBOXMESSAGE primary key (OutboxMsgSysId)
);

/*==============================================================*/
/* Index: OutboxMessage_PK                                      */
/*==============================================================*/
create unique index OutboxMessage_PK on OutboxMessage (
OutboxMsgSysId ASC
);

/*==============================================================*/
/* Table: OutboxMessageAttachment                               */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='OutboxMessageAttachment') then
   drop table  OutboxMessageAttachment
end if;

create table dba.OutboxMessageAttachment 
(
    OutboxMsgAttachSysId integer                        not null default AUTOINCREMENT,
    OutboxMsgSysId       integer,
    OutboxMsgAttachPath  char(255),
    OutboxMsgObject      long binary,
    constraint PK_OUTBOXMESSAGEATTACHMENT primary key (OutboxMsgAttachSysId)
);

/*==============================================================*/
/* Index: OutboxMessageAttachment_PK                            */
/*==============================================================*/
create unique index OutboxMessageAttachment_PK on OutboxMessageAttachment (
OutboxMsgAttachSysId ASC
);

/*==============================================================*/
/* Index: Relationship_733_FK                                   */
/*==============================================================*/
create  index Relationship_733_FK on OutboxMessageAttachment (
OutboxMsgSysId ASC
);

/*==============================================================*/
/* Table: OutboxRecipientList                                   */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='OutboxRecipientList') then
   drop table  OutboxRecipientList
end if;

create table dba.OutboxRecipientList 
(
    OutEmailSendSysId    integer                        not null,
    OutboxMsgSysId       integer,
    RecipientDispName    char(200),
    RecipientEmailAddr   char(200),
    RecipientType        smallint,
    constraint PK_OUTBOXRECIPIENTLIST primary key (OutEmailSendSysId)
);

/*==============================================================*/
/* Index: OutboxRecipientList_PK                                */
/*==============================================================*/
create unique index OutboxRecipientList_PK on OutboxRecipientList (
OutEmailSendSysId ASC
);

/*==============================================================*/
/* Index: Relationship_732_FK                                   */
/*==============================================================*/
create  index Relationship_732_FK on OutboxRecipientList (
OutboxMsgSysId ASC
);


/*==============================================================*/
/* Table: RptConfigEmail                                        */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='RptConfigEmail') then
   drop table  RptConfigEmail
end if;

create table dba.RptConfigEmail 
(
    PersonalSysId        integer                        not null,
    CcEmail              char(200),
    BccEmail             char(200),
    CompressFilePassword char(50),
    constraint PK_RPTCONFIGEMAIL primary key clustered (PersonalSysId)
);

/*==============================================================*/
/* Index: RptConfigEmail_PK                                     */
/*==============================================================*/
create unique index RptConfigEmail_PK on RptConfigEmail (
PersonalSysId ASC
);


if not exists (select 1 from sys.syscolumns where tname='CustomisedPatchLog' and cname='PatchIPAddress') then
   alter table dba.CustomisedPatchLog add PatchIPAddress char(20);
end if;

if not exists (select 1 from sys.syscolumns where tname='EPFProgression' and cname='EPFEEVolAmt') then
   alter table dba.EPFProgression add EPFEEVolAmt double;
end if;

if not exists (select 1 from sys.syscolumns where tname='EPFProgression' and cname='EPFERVolAmt') then
   alter table dba.EPFProgression add EPFERVolAmt double;
end if;

if not exists (select 1 from sys.syscolumns where tname='RptConfig' and cname='CompressFileExt') then
   alter table dba.RptConfig add CompressFileExt char(20);
end if;

/*==============================================================*/
/* Table: AccpacExportLog                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='AccpacExportLog') then
   drop table  AccpacExportLog
end if;

create table dba.AccpacExportLog 
(
    APBatchId            char(6)                        not null,
    APUserId             char(8),
    APCompany            char(6),
    IsSuccess            smallint,
    LastChangedDateTime  timestamp,
    constraint PK_ACCPACEXPORTLOG primary key (APBatchId)
);

/*==============================================================*/
/* Index: AccpacExportLog_PK                                    */
/*==============================================================*/
create unique index AccpacExportLog_PK on AccpacExportLog (
APBatchId ASC
);

/*========================================================================================*/
/*End of EPE Table 													         */
/*========================================================================================*/

Commit Work;