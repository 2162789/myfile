if not exists(select * from subregistry where registryId='PayOption' and SubRegistryId = 'ProrateBackPay') then 
	Insert into SubRegistry Values('PayOption','ProrateBackPay','','','','','','','','','','',0,0,'',0,'TWWorkDay','','1899-12-30','1899-12-30 00:00:00');
end if;


if exists(select 1 from sys.sysviews where viewname = 'View_SYSTABLE') then
    DROP VIEW View_SYSTABLE;
end if;
  
if NOT exists(select 1 from sys.sysviews where viewname = 'View_SYSTABLE') then

  /* ============================================================ */
  /*   View: View_SYSTABLE                                        */
  /* ============================================================ */
  CREATE VIEW "DBA"."View_SYSTABLE"
    AS 
  SELECT 
  SYS.SYSTAB.Table_Id AS Table_Id,  
  SYS.SYSTAB.Table_Name AS Table_Name,  
  SYS.SYSTAB.Table_Type_Str AS Table_type,
  SYS.SYSTAB.Creator AS Creator
  FROM SYS.SYSTAB;

end if;

if exists(select 1 from sys.sysviews where viewname = 'View_SYSTABCOL') then
    DROP VIEW View_SYSTABCOL;
end if;

  /* ============================================================ */
  /*   View: View_SYSTABCOL*/
  /* ============================================================ */
  CREATE VIEW "DBA"."View_SYSTABCOL"
    AS
  SELECT 
  SYS.SYSTABCOL.Column_Name AS Column_Name,  
  SYS.SYSTABCOL.Column_Id AS Column_Id,
  SYS.SYSTABCOL.Table_Id AS Table_Id  
  FROM SYS.SYSTABCOL;


if exists(select 1 from sys.sysviews where viewname = 'View_ACCPACCostInfo') then
    DROP VIEW View_ACCPACCostInfo;
end if;
  /* ============================================================ */
  /*   View: View_ACCPACCostInfo */
  /* ============================================================ */
  CREATE VIEW "DBA"."View_ACCPACCostInfo" 
    AS
  SELECT CostRecord.*
  ,CostPeriod.EmployeeSysId
  ,CostPeriod.CostYear
  ,CostPeriod.CostPeriod
  FROM DBA.CostRecord
  JOIN DBA.CostSubPeriod
 JOIN DBA.CostPeriod;


if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'ColourScheme') THEN
	insert into InterfaceTableMapping values ('ColourScheme', 'iColourScheme', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'ExcelSpreadsheet') THEN
	insert into InterfaceTableMapping values ('ExcelSpreadsheet', 'iExcelSpreadsheet', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'ExcelWkSheet') THEN
	insert into InterfaceTableMapping values ('ExcelWkSheet', 'iExcelWkSheet', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'ExcelWkSheetItem') THEN
	insert into InterfaceTableMapping values ('ExcelWkSheetItem', 'iExcelWkSheetItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'FinancialRpt') THEN
	insert into InterfaceTableMapping values ('FinancialRpt', 'iFinancialRpt', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'FinanceColItem') THEN
	insert into InterfaceTableMapping values ('FinanceColItem', 'iFinanceColItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'FinanceRowItem') THEN
	insert into InterfaceTableMapping values ('FinanceRowItem', 'iFinanceRowItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'FinanceGrpItem') THEN
	insert into InterfaceTableMapping values ('FinanceGrpItem', 'iFinanceGrpItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'FinanceSortItem') THEN
	insert into InterfaceTableMapping values ('FinanceSortItem', 'iFinanceSortItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'EmployeeRpt') THEN
	insert into InterfaceTableMapping values ('EmployeeRpt', 'iEmployeeRpt', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'EmpColItem') THEN
	insert into InterfaceTableMapping values ('EmpColItem', 'iEmpColItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'EmpGrpItem') THEN
	insert into InterfaceTableMapping values ('EmpGrpItem', 'iEmpGrpItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'EmpSortItem') THEN
	insert into InterfaceTableMapping values ('EmpSortItem', 'iEmpSortItem', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'AnlysProject') THEN
	insert into InterfaceTableMapping values ('AnlysProject', 'iAnlysProject', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'AnlysSetup') THEN
	insert into InterfaceTableMapping values ('AnlysSetup', 'iAnlysSetup', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'AnlysItemSetup') THEN
	insert into InterfaceTableMapping values ('AnlysItemSetup', 'iAnlysItemSetup', '', '');
END IF;

if not exists(select * from  InterfaceTableMapping WHERE PhysicalTableName = 'AnlysDispSection') THEN
	insert into InterfaceTableMapping values ('AnlysDispSection', 'iAnlysDispSection', '', '');
END IF;

Commit Work;



