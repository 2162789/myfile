
create procedure dba.DeleteColourScheme(
in In_ColourSchemeId char(20),
out Out_ErrorCode integer)
begin
  if In_ColourSchemeId = 'DefColourScheme' then set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from ColourScheme where ColourSchemeId = In_ColourSchemeId) then
    if exists(select* from EmpColItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-2;
      return
    end if;
    if exists(select* from EmpGrpItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-3;
      return
    end if;
    if exists(select* from EmpSortItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-4;
      return
    end if;
    if exists(select* from FinanceColItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-5;
      return
    end if;
    if exists(select* from FinanceRowItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-6;
      return
    end if;
    if exists(select* from FinanceGrpItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-7;
      return
    end if;
    if exists(select* from FinanceSortItem where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-8;
      return
    end if;
    if exists(select* from ExcelWkSheet where WkSheetHeadColourSchemeId = In_ColourSchemeId or
        WkSheetFootColourSchemeId = In_ColourSchemeId or WkSheetTitleColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=-9;
      return
    end if;
    delete from ColourScheme where ColourSchemeId = In_ColourSchemeId;
    commit work;
    if exists(select* from ColourScheme where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpColItem(
in In_EmpColItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_EmpColItemOrder integer;
  declare Del_EmpInfoRptId char(20);
  if exists(select* from EmpColItem where EmpColItemSysId = In_EmpColItemSysId) then
    select EmpColItemOrder,EmpInfoRptId into Del_EmpColItemOrder,Del_EmpInfoRptId from EmpColItem where EmpColItemSysId = In_EmpColItemSysId;
    delete from EmpColItem where EmpColItemSysId = In_EmpColItemSysId;
    commit work;
    if exists(select* from EmpColItem where EmpColItemSysId = In_EmpColItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      EmpColItemSysIdLoop: for EmpColItemSysIdFor as Cur_EmpColItemSysId dynamic scroll cursor for
        select EmpColItem.EmpColItemOrder as Get_EmpColItemOrder,EmpColItem.EmpColItemSysId as Get_EmpColItemSysId from
          EmpColItem where
          EmpColItem.EmpInfoRptId = Del_EmpInfoRptId and
          EmpColItem.EmpColItemOrder > Del_EmpColItemOrder do
        update EmpColItem set
          EmpColItem.EmpColItemOrder = (Get_EmpColItemOrder-1) where
          EmpColItem.EmpColItemSysId = Get_EmpColItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpColItemRec(
in In_EmpInfoRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from EmpColItem where EmpInfoRptId = In_EmpInfoRptId) then
    delete from EmpColItem where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    if exists(select* from EmpColItem where EmpInfoRptId = In_EmpInfoRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpGrpItem(
in In_EmpGrpItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_EmpGrpItemOrder integer;
  declare Del_EmpInfoRptId char(20);
  if exists(select* from EmpGrpItem where EmpGrpItemSysId = In_EmpGrpItemSysId) then
    select EmpGrpItemOrder,EmpInfoRptId into Del_EmpGrpItemOrder,Del_EmpInfoRptId from EmpGrpItem where EmpGrpItemSysId = In_EmpGrpItemSysId;
    delete from EmpGrpItem where EmpGrpItemSysId = In_EmpGrpItemSysId;
    commit work;
    if exists(select* from EmpGrpItem where EmpGrpItemSysId = In_EmpGrpItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      EmpGrpItemSysIdLoop: for EmpGrpItemSysIdFor as Cur_EmpGrpItemSysId dynamic scroll cursor for
        select EmpGrpItem.EmpGrpItemOrder as Get_EmpGrpItemOrder,EmpGrpItem.EmpGrpItemSysId as Get_EmpGrpItemSysId from
          EmpGrpItem where
          EmpGrpItem.EmpInfoRptId = Del_EmpInfoRptId and
          EmpGrpItem.EmpGrpItemOrder > Del_EmpGrpItemOrder do
        update EmpGrpItem set
          EmpGrpItem.EmpGrpItemOrder = (Get_EmpGrpItemOrder-1) where
          EmpGrpItem.EmpGrpItemSysId = Get_EmpGrpItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpGrpItemRec(
in In_EmpInfoRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId) then
    delete from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    if exists(select* from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmployeeRpt(
in In_EmpInfoRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from EmployeeRpt where EmpInfoRptId = In_EmpInfoRptId) then
    if exists(select* from ExcelWkSheetItem where WkSheetItemRptId = In_EmpInfoRptId and WkSheetItemRptType = 'EmployeeRpt') then
      set Out_ErrorCode=-1;
      return
    end if;
    delete from EmpColItem where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    delete from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    delete from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    delete from EmployeeRpt where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    if exists(select* from EmployeeRpt where EmpInfoRptId = In_EmpInfoRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpSortItem(
in In_EmpSortItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_EmpSortItemOrder integer;
  declare Del_EmpInfoRptId char(20);
  if exists(select* from EmpSortItem where EmpSortItemSysId = In_EmpSortItemSysId) then
    select EmpSortItemOrder,EmpInfoRptId into Del_EmpSortItemOrder,Del_EmpInfoRptId from EmpSortItem where EmpSortItemSysId = In_EmpSortItemSysId;
    delete from EmpSortItem where EmpSortItemSysId = In_EmpSortItemSysId;
    commit work;
    if exists(select* from EmpSortItem where EmpSortItemSysId = In_EmpSortItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      EmpSortItemSysIdLoop: for EmpSortItemSysIdFor as Cur_EmpSortItemSysId dynamic scroll cursor for
        select EmpSortItem.EmpSortItemOrder as Get_EmpSortItemOrder,EmpSortItem.EmpSortItemSysId as Get_EmpSortItemSysId from
          EmpSortItem where
          EmpSortItem.EmpInfoRptId = Del_EmpInfoRptId and
          EmpSortItem.EmpSortItemOrder > Del_EmpSortItemOrder do
        update EmpSortItem set
          EmpSortItem.EmpSortItemOrder = (Get_EmpSortItemOrder-1) where
          EmpSortItem.EmpSortItemSysId = Get_EmpSortItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpSortItemRec(
in In_EmpInfoRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId) then
    delete from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    if exists(select* from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteExcelSpreadsheet(
in In_ExcelSpreadsheetId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ExcelSpreadsheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId) then
    /* Delete ExcelWkSheet*/
    ExcelWkSheetLoop: for ExcelWkSheetFor as Cur_WkSheetSysId dynamic scroll cursor for
      select ExcelWkSheet.WkSheetSysId as Get_WkSheetSysId from ExcelWkSheet where ExcelWkSheet.ExcelSpreadsheetId = In_ExcelSpreadsheetId do
      call DeleteExcelWkSheet(Get_WkSheetSysId,ErrorCode) end for;
    if exists(select* from ExcelSpreadsheetAccess where
        ExcelSpreadsheetAccess.ExcelSpreadsheetId = In_ExcelSPreadsheetId) then
      delete from ExcelSpreadsheetAccess where ExcelSpreadsheetAccess.ExcelSpreadsheetId = In_ExcelSpreadsheetId
    end if;
    delete from ExcelSpreadsheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId;
    commit work;
    if exists(select* from ExcelSpreadsheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteExcelWkSheet(
in In_WkSheetSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_WkSheetOrder integer;
  declare Del_ExcelSpreadsheetId char(20);
  if exists(select* from ExcelWkSheet where WkSheetSysId = In_WkSheetSysId) then
    delete from ExcelWSItemRptLayout where WkSheetItemSysId = any(select WkSheetItemSysId from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId);
    commit work;
    delete from ExcelWSItemRptOpts where WkSheetItemSysId = any(select WkSheetItemSysId from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId);
    commit work;
    delete from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId;
    commit work;
    select WkSheetOrder,ExcelSpreadsheetId into Del_WkSheetOrder,Del_ExcelSpreadsheetId from ExcelWkSheet where WkSheetSysId = In_WkSheetSysId;
    delete from ExcelWkSheet where WkSheetSysId = In_WkSheetSysId;
    commit work;
    if exists(select* from ExcelWkSheet where WkSheetSysId = In_WkSheetSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      WkSheetSysIdLoop: for WkSheetSysIdFor as Cur_WkSheetSysId dynamic scroll cursor for
        select ExcelWkSheet.WkSheetOrder as Get_WkSheetOrder,ExcelWkSheet.WkSheetSysId as Get_WkSheetSysId from
          ExcelWkSheet where
          ExcelWkSheet.ExcelSpreadsheetId = Del_ExcelSpreadsheetId and
          ExcelWkSheet.WkSheetOrder > Del_WkSheetOrder do
        update ExcelWkSheet set
          ExcelWkSheet.WkSheetOrder = (Get_WkSheetOrder-1) where
          ExcelWkSheet.WkSheetSysId = Get_WkSheetSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteExcelWkSheetItem(
in In_WkSheetItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_WkSheetItemOrdering integer;
  declare Del_WkSheetSysId integer;
  if exists(select* from ExcelWkSheetItem where WkSheetItemSysId = In_WkSheetItemSysId) then
    delete from ExcelWSItemRptLayout where WkSheetItemSysId = In_WkSheetItemSysId;
    commit work;
    delete from ExcelWSItemRptOpts where WkSheetItemSysId = In_WkSheetItemSysId;
    commit work;
    select WkSheetItemOrdering,WkSheetSysId into Del_WkSheetItemOrdering,Del_WkSheetSysId from ExcelWkSheetItem where WkSheetItemSysId = In_WkSheetItemSysId;
    delete from ExcelWkSheetItem where WkSheetItemSysId = In_WkSheetItemSysId;
    commit work;
    if exists(select* from ExcelWkSheetItem where WkSheetItemSysId = In_WkSheetItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      WkSheetItemSysIdLoop: for WkSheetItemSysIdFor as Cur_WkSheetItemSysId dynamic scroll cursor for
        select ExcelWkSheetItem.WkSheetItemOrdering as Get_WkSheetItemOrdering,ExcelWkSheetItem.WkSheetItemSysId as Get_WkSheetItemSysId from
          ExcelWkSheetItem where
          ExcelWkSheetItem.WkSheetSysId = Del_WkSheetSysId and
          ExcelWkSheetItem.WkSheetItemOrdering > Del_WkSheetItemOrdering do
        update ExcelWkSheetItem set
          ExcelWkSheetItem.WkSheetItemOrdering = (Get_WkSheetItemOrdering-1) where
          ExcelWkSheetItem.WkSheetItemSysId = Get_WkSheetItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteExcelWkSheetItemRec(
in In_WkSheetSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId) then
    delete from ExcelWSItemRptLayout where WkSheetItemSysId = any(select WkSheetItemSysId from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId);
    commit work;
    delete from ExcelWSItemRptOpts where WkSheetItemSysId = any(select WkSheetItemSysId from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId);
    commit work;
    delete from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId;
    commit work;
    if exists(select* from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceColItem(
in In_FinColItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_FinColItemOrder integer;
  declare Del_FinancialRptId char(20);
  declare Del_FinColComponent char(100);
  declare Del_FinColItemType char(20);
  declare Out_AnlysDisplaySysId char(30);
  if exists(select* from FinanceColItem where FinColItemSysId = In_FinColItemSysId) then
    select FinColItemOrder,FinancialRptId,FinColComponent,FinColItemType into Del_FinColItemOrder,Del_FinancialRptId,Del_FinColComponent,Del_FinColItemType from FinanceColItem where FinColItemSysId = In_FinColItemSysId;
    delete from FinColAccumulated where FinColItemSysId = In_FinColItemSysId;
    commit work;
    delete from FinanceColItem where FinColItemSysId = In_FinColItemSysId;
    commit work;
    if exists(select* from FinanceColItem where FinColItemSysId = In_FinColItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Delete AnlysDispSection*/
      if(Del_FinColItemType = 'AnlysItem') then
        if not exists(select* from FinanceColItem where FinancialRptId = Del_FinancialRptId and FinColComponent = Del_FinColComponent) then
          if not exists(select* from FinanceRowItem where FinancialRptId = Del_FinancialRptId and FinRowComponent = Del_FinColComponent) then
            select AnlysDisplaySysId into Out_AnlysDisplaySysId from AnlysDispSection join AnlysItemSetup where
              AnlysSetupId = any(select AnlysSetupId from FinancialRpt join AnlysProject on AnlysProjectId = FinancialAnalysProjId where FinancialRptId = Del_FinancialRptId) and
              AnlysLookupId = Del_FinColComponent;
            call DeleteAnlysDispSection(Out_AnlysDisplaySysId,ErrorCode)
          end if
        end if
      end if;
      /* Reorder */
      FinColItemSysIdLoop: for FinColItemSysIdFor as Cur_FinColItemSysId dynamic scroll cursor for
        select FinanceColItem.FinColItemOrder as Get_FinColItemOrder,FinanceColItem.FinColItemSysId as Get_FinColItemSysId from
          FinanceColItem where
          FinanceColItem.FinancialRptId = Del_FinancialRptId and
          FinanceColItem.FinColItemOrder > Del_FinColItemOrder do
        update FinanceColItem set
          FinanceColItem.FinColItemOrder = (Get_FinColItemOrder-1) where
          FinanceColItem.FinColItemSysId = Get_FinColItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceColItemRec(
in In_FinancialRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceColItem where FinancialRptId = In_FinancialRptId) then
    /* Delete AnlysDispSection*/
    FinItemLoop: for FinItemSysIdFor as Cur_FinItemSysId dynamic scroll cursor for
      select FinColItemSysId as Get_FinColItemSysId from FinanceColItem where FinancialRptId = In_FinancialRptId do
      call DeleteFinanceColItem(Get_FinColItemSysId,Out_ErrorCode) end for;
    if exists(select* from FinanceColItem where FinancialRptId = In_FinancialRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceGrpItem(
in In_FinGrpItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_FinGrpItemOrder integer;
  declare Del_FinancialRptId char(20);
  declare Del_FinGrpComponent char(100);
  declare Del_FinGrpItemType char(20);
  declare Out_AnlysDisplaySysId char(30);
  if exists(select* from FinanceGrpItem where FinGrpItemSysId = In_FinGrpItemSysId) then
    select FinGrpItemOrder,FinancialRptId,FinGrpComponent,FinGrpItemType into Del_FinGrpItemOrder,Del_FinancialRptId,Del_FinGrpComponent,Del_FinGrpItemType from FinanceGrpItem where FinGrpItemSysId = In_FinGrpItemSysId;
    delete from FinanceGrpItem where FinGrpItemSysId = In_FinGrpItemSysId;
    commit work;
    if exists(select* from FinanceGrpItem where FinGrpItemSysId = In_FinGrpItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      FinGrpItemSysIdLoop: for FinGrpItemSysIdFor as Cur_FinGrpItemSysId dynamic scroll cursor for
        select FinanceGrpItem.FinGrpItemOrder as Get_FinGrpItemOrder,FinanceGrpItem.FinGrpItemSysId as Get_FinGrpItemSysId from
          FinanceGrpItem where
          FinanceGrpItem.FinancialRptId = Del_FinancialRptId and
          FinanceGrpItem.FinGrpItemOrder > Del_FinGrpItemOrder do
        update FinanceGrpItem set
          FinanceGrpItem.FinGrpItemOrder = (Get_FinGrpItemOrder-1) where
          FinanceGrpItem.FinGrpItemSysId = Get_FinGrpItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceGrpItemRec(
in In_FinancialRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceGrpItem where FinancialRptId = In_FinancialRptId) then
    delete from FinanceGrpItem where FinancialRptId = In_FinancialRptId;
    commit work;
    if exists(select* from FinanceGrpItem where FinancialRptId = In_FinancialRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceRowItem(
in In_FinRowItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_FinRowItemOrder integer;
  declare Del_FinancialRptId char(20);
  declare Del_FinRowComponent char(100);
  declare Del_FinRowItemType char(20);
  declare Out_AnlysDisplaySysId char(30);
  if exists(select* from FinanceRowItem where FinRowItemSysId = In_FinRowItemSysId) then
    select FinRowItemOrder,FinancialRptId,FinRowComponent,FinRowItemType into Del_FinRowItemOrder,Del_FinancialRptId,Del_FinRowComponent,Del_FinRowItemType from FinanceRowItem where FinRowItemSysId = In_FinRowItemSysId;
    delete from FinanceRowItem where FinRowItemSysId = In_FinRowItemSysId;
    commit work;
    if exists(select* from FinanceRowItem where FinRowItemSysId = In_FinRowItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Delete AnlysDispSection*/
      if(Del_FinRowItemType = 'AnlysItem') then
        if not exists(select* from FinanceColItem where FinancialRptId = Del_FinancialRptId and FinColComponent = Del_FinRowComponent) then
          if not exists(select* from FinanceRowItem where FinancialRptId = Del_FinancialRptId and FinRowComponent = Del_FinRowComponent) then
            select AnlysDisplaySysId into Out_AnlysDisplaySysId from AnlysDispSection join AnlysItemSetup where
              AnlysSetupId = any(select AnlysSetupId from FinancialRpt join AnlysProject on AnlysProjectId = FinancialAnalysProjId where FinancialRptId = Del_FinancialRptId) and
              AnlysLookupId = Del_FinRowComponent;
            call DeleteAnlysDispSection(Out_AnlysDisplaySysId,ErrorCode)
          end if
        end if
      end if;
      /* Reorder */
      FinRowItemSysIdLoop: for FinRowItemSysIdFor as Cur_FinRowItemSysId dynamic scroll cursor for
        select FinanceRowItem.FinRowItemOrder as Get_FinRowItemOrder,FinanceRowItem.FinRowItemSysId as Get_FinRowItemSysId from
          FinanceRowItem where
          FinanceRowItem.FinancialRptId = Del_FinancialRptId and
          FinanceRowItem.FinRowItemOrder > Del_FinRowItemOrder do
        update FinanceRowItem set
          FinanceRowItem.FinRowItemOrder = (Get_FinRowItemOrder-1) where
          FinanceRowItem.FinRowItemSysId = Get_FinRowItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceRowItemRec(
in In_FinancialRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceRowItem where FinancialRptId = In_FinancialRptId) then
    /* Delete AnlysDispSection*/
    FinItemLoop: for FinItemSysIdFor as Cur_FinItemSysId dynamic scroll cursor for
      select FinRowItemSysId as Get_FinRowItemSysId from FinanceRowItem where FinancialRptId = In_FinancialRptId do
      call DeleteFinanceRowItem(Get_FinRowItemSysId,Out_ErrorCode) end for;
    if exists(select* from FinanceRowItem where FinancialRptId = In_FinancialRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceSortItem(
in In_FinSortItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_FinSortItemOrder integer;
  declare Del_FinancialRptId char(20);
  declare Del_FinSortComponent char(100);
  declare Del_FinSortItemType char(20);
  declare Out_AnlysDisplaySysId char(30);
  if exists(select* from FinanceSortItem where FinSortItemSysId = In_FinSortItemSysId) then
    select FinSortItemOrder,FinancialRptId,FinSortComponent,FinSortItemType into Del_FinSortItemOrder,Del_FinancialRptId,Del_FinSortComponent,Del_FinSortItemType from FinanceSortItem where FinSortItemSysId = In_FinSortItemSysId;
    delete from FinanceSortItem where FinSortItemSysId = In_FinSortItemSysId;
    commit work;
    if exists(select* from FinanceSortItem where FinSortItemSysId = In_FinSortItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      FinSortItemSysIdLoop: for FinSortItemSysIdFor as Cur_FinSortItemSysId dynamic scroll cursor for
        select FinanceSortItem.FinSortItemOrder as Get_FinSortItemOrder,FinanceSortItem.FinSortItemSysId as Get_FinSortItemSysId from
          FinanceSortItem where
          FinanceSortItem.FinancialRptId = Del_FinancialRptId and
          FinanceSortItem.FinSortItemOrder > Del_FinSortItemOrder do
        update FinanceSortItem set
          FinanceSortItem.FinSortItemOrder = (Get_FinSortItemOrder-1) where
          FinanceSortItem.FinSortItemSysId = Get_FinSortItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinanceSortItemRec(
in In_FinancialRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceSortItem where FinancialRptId = In_FinancialRptId) then
    delete from FinanceSortItem where FinancialRptId = In_FinancialRptId;
    commit work;
    if exists(select* from FinanceSortItem where FinancialRptId = In_FinancialRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinancialRpt(
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
    FinanceColItemLoop: for FinanceColItemFor as Cur_FinColItemSysId dynamic scroll cursor for
      select FinanceColItem.FinColItemSysId as Get_FinColItemSysId from FinanceColItem where FinanceColItem.FinancialRptId = In_FinancialRptId do
      call DeleteFinanceColItem(Get_FinColItemSysId,ErrorCode) end for;
    /*Delete Analysis Project & Setup*/
    select FinancialAnalysProjId into Out_AnlysProjectId from FinancialRpt where FinancialRptId = In_FinancialRptId;
    select AnlysSetupId into Out_AnlysSetupId from AnlysProject where AnlysProjectId = Out_AnlysProjectId;
    call DeleteAnlysSetup(Out_AnlysSetupId,ErrorCode);
    call DeleteAnlysProject(Out_AnlysProjectId,ErrorCode);
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

create procedure dba.DeleteFinColAccumulated(
in In_FinColAccuSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_FinColAccuOrder integer;
  declare Del_FinColItemSysId integer;
  if exists(select* from FinColAccumulated where FinColAccuSysId = In_FinColAccuSysId) then
    select FinColAccuOrder,FinColItemSysId into Del_FinColAccuOrder,Del_FinColItemSysId from FinColAccumulated where FinColAccuSysId = In_FinColAccuSysId;
    delete from FinColAccumulated where FinColAccuSysId = In_FinColAccuSysId;
    commit work;
    if exists(select* from FinColAccumulated where FinColAccuSysId = In_FinColAccuSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      FinColAccuSysIdLoop: for FinColAccuSysIdFor as Cur_FinColAccuSysId dynamic scroll cursor for
        select FinColAccumulated.FinColAccuOrder as Get_FinColAccuOrder,FinColAccumulated.FinColAccuSysId as Get_FinColAccuSysId from
          FinColAccumulated where
          FinColAccumulated.FinColItemSysId = Del_FinColItemSysId and
          FinColAccumulated.FinColAccuOrder > Del_FinColAccuOrder do
        update FinColAccumulated set
          FinColAccumulated.FinColAccuOrder = (Get_FinColAccuOrder-1) where
          FinColAccumulated.FinColAccuSysId = Get_FinColAccuSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFinColAccumulatedRec(
in In_FinColItemSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from FinColAccumulated where FinColItemSysId = In_FinColItemSysId) then
    delete from FinColAccumulated where FinColItemSysId = In_FinColItemSysId;
    commit work;
    if exists(select* from FinColAccumulated where FinColItemSysId = In_FinColItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewColourScheme(
in In_ColourSchemeId char(20),
in In_ColourSchemeDesc char(100),
in In_ColourSchFont char(50),
in In_ColourSchFontStyle char(20),
in In_ColourSchSize integer,
in In_ColourCodeMapId integer,
in In_ColourSchUnderline char(30),
in In_ColourSchStrikethrough smallint,
in In_ColourSchSuperscript smallint,
in In_ColourSchSubscript smallint,
in In_ColourSchCellHeight integer,
in In_ColourSchCellWidth integer,
out Out_ErrorCode integer)
begin
  if In_ColourSchemeId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchFont is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_ColourSchFontStyle is null then set Out_ErrorCode=-3;
    return
  end if;
  if In_ColourSchSize is null then set Out_ErrorCode=-4;
    return
  end if;
  if not exists(select* from ColourCodeMapping where ColourCodeMapId = In_ColourCodeMapId) then set Out_ErrorCode=-5;
    return
  end if;
  if In_ColourSchUnderline is null then set Out_ErrorCode=-6;
    return
  end if;
  if not exists(select* from ColourScheme where ColourSchemeId = In_ColourSchemeId) then
    insert into ColourScheme(ColourSchemeId,
      ColourSchemeDesc,
      ColourSchFont,
      ColourSchFontStyle,
      ColourSchSize,
      ColourCodeMapId,
      ColourSchUnderline,
      ColourSchStrikethrough,
      ColourSchSuperscript,
      ColourSchSubscript,
      ColourSchCellHeight,
      ColourSchCellWidth) values(
      In_ColourSchemeId,
      In_ColourSchemeDesc,
      In_ColourSchFont,
      In_ColourSchFontStyle,
      In_ColourSchSize,
      In_ColourCodeMapId,
      In_ColourSchUnderline,
      In_ColourSchStrikethrough,
      In_ColourSchSuperscript,
      In_ColourSchSubscript,
      In_ColourSchCellHeight,
      In_ColourSchCellWidth);
    commit work;
    if not exists(select* from ColourScheme where ColourSchemeId = In_ColourSchemeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewEmpColItem(
in In_ColourSchemeId char(20),
in In_EmpInfoRptId char(20),
in In_EmpColItemType char(20),
in In_EmpColItemTitle char(50),
in In_EmpColSysTableId char(100),
in In_EmpColSysAttributeId char(100),
in In_EmpColIsRptMainInfo integer,
out Out_EmpColItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_EmpColItemOrder integer;
  if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  select max(EmpColItemOrder) into Out_EmpColItemOrder from EmpColItem where
    EmpColItem.EmpInfoRptId = In_EmpInfoRptId;
  if(Out_EmpColItemOrder is null) then
    set Out_EmpColItemOrder=1
  else
    set Out_EmpColItemOrder=Out_EmpColItemOrder+1
  end if;
  if not exists(select* from EmpColItem where EmpInfoRptId = In_EmpInfoRptId and EmpColItemOrder = Out_EmpColItemOrder) then
    insert into EmpColItem(ColourSchemeId,
      EmpInfoRptId,
      EmpColItemOrder,
      EmpColItemType,
      EmpColItemTitle,
      EmpColSysTableId,
      EmpColSysAttributeId,
      EmpColIsRptMainInfo) values(
      In_ColourSchemeId,
      In_EmpInfoRptId,
      Out_EmpColItemOrder,
      In_EmpColItemType,
      In_EmpColItemTitle,
      In_EmpColSysTableId,
      In_EmpColSysAttributeId,
      In_EmpColIsRptMainInfo);
    commit work;
    if not exists(select* from EmpColItem where EmpInfoRptId = In_EmpInfoRptId and EmpColItemOrder = Out_EmpColItemOrder) then
      set Out_ErrorCode=0
    else
      select max(EmpColItemSysId) into Out_EmpColItemSysId from EmpColItem where EmpInfoRptId = In_EmpInfoRptId and
        EmpColItemOrder = Out_EmpColItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewEmpGrpItem(
in In_ColourSchemeId char(20),
in In_EmpInfoRptId char(20),
in In_EmpGrpItemType char(20),
in In_EmpGrpItemTitle char(50),
in In_EmpGrpSysTableId char(100),
in In_EmpGrpSysAttributeId char(100),
in In_EmpGrpHasEmpCount smallint,
out Out_EmpGrpItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_EmpGrpItemOrder integer;
  if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  select max(EmpGrpItemOrder) into Out_EmpGrpItemOrder from EmpGrpItem where
    EmpGrpItem.EmpInfoRptId = In_EmpInfoRptId;
  if(Out_EmpGrpItemOrder is null) then
    set Out_EmpGrpItemOrder=1
  else
    set Out_EmpGrpItemOrder=Out_EmpGrpItemOrder+1
  end if;
  if not exists(select* from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId and EmpGrpItemOrder = Out_EmpGrpItemOrder) then
    insert into EmpGrpItem(ColourSchemeId,
      EmpInfoRptId,
      EmpGrpItemOrder,
      EmpGrpItemType,
      EmpGrpItemTitle,
      EmpGrpSysTableId,
      EmpGrpSysAttributeId,
      EmpGrpHasEmpCount) values(
      In_ColourSchemeId,
      In_EmpInfoRptId,
      Out_EmpGrpItemOrder,
      In_EmpGrpItemType,
      In_EmpGrpItemTitle,
      In_EmpGrpSysTableId,
      In_EmpGrpSysAttributeId,
      In_EmpGrpHasEmpCount);
    commit work;
    if not exists(select* from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId and EmpGrpItemOrder = Out_EmpGrpItemOrder) then
      set Out_ErrorCode=0
    else
      select max(EmpGrpItemSysId) into Out_EmpGrpItemSysId from EmpGrpItem where EmpInfoRptId = In_EmpInfoRptId and
        EmpGrpItemOrder = Out_EmpGrpItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewEmployeeRpt(
in In_EmpInfoRptId char(20),
in In_EmpInfoRptDesc char(100),
in In_EmpInfoRptType char(20),
in In_EmployeeRptHasFilter smallint,
in In_EmployeeRptFilterCond char(255),
in In_EmployeeRptHasEmpCt smallint,
in In_EmployeeRptHasEmpOnly smallint,
out Out_ErrorCode integer)
begin
  if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_EmpInfoRptType is null then set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from EmployeeRpt where EmpInfoRptId = In_EmpInfoRptId) then
    insert into EmployeeRpt(EmpInfoRptId,
      EmpInfoRptDesc,
      EmpInfoRptType,
      EmployeeRptHasFilter,
      EmployeeRptFilterCond,
      EmployeeRptHasEmpCt,
      EmployeeRptHasEmpOnly) values(
      In_EmpInfoRptId,
      In_EmpInfoRptDesc,
      In_EmpInfoRptType,
      In_EmployeeRptHasFilter,
      In_EmployeeRptFilterCond,
      In_EmployeeRptHasEmpCt,
      In_EmployeeRptHasEmpOnly);
    commit work;
    if not exists(select* from EmployeeRpt where EmpInfoRptId = In_EmpInfoRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewEmpSortItem(
in In_ColourSchemeId char(20),
in In_EmpInfoRptId char(20),
in In_EmpSortItemType char(20),
in In_EmpSortItemTitle char(50),
in In_EmpSortSysTableId char(100),
in In_EmpSortSysAttributeId char(100),
out Out_EmpSortItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_EmpSortItemOrder integer;
  if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  select max(EmpSortItemOrder) into Out_EmpSortItemOrder from EmpSortItem where
    EmpSortItem.EmpInfoRptId = In_EmpInfoRptId;
  if(Out_EmpSortItemOrder is null) then
    set Out_EmpSortItemOrder=1
  else
    set Out_EmpSortItemOrder=Out_EmpSortItemOrder+1
  end if;
  if not exists(select* from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId and EmpSortItemOrder = Out_EmpSortItemOrder) then
    insert into EmpSortItem(ColourSchemeId,
      EmpInfoRptId,
      EmpSortItemOrder,
      EmpSortItemType,
      EmpSortItemTitle,
      EmpSortSysTableId,
      EmpSortSysAttributeId) values(
      In_ColourSchemeId,
      In_EmpInfoRptId,
      Out_EmpSortItemOrder,
      In_EmpSortItemType,
      In_EmpSortItemTitle,
      In_EmpSortSysTableId,
      In_EmpSortSysAttributeId);
    commit work;
    if not exists(select* from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId and EmpSortItemOrder = Out_EmpSortItemOrder) then
      set Out_ErrorCode=0
    else
      select max(EmpSortItemSysId) into Out_EmpSortItemSysId from EmpSortItem where EmpInfoRptId = In_EmpInfoRptId and
        EmpSortItemOrder = Out_EmpSortItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewExcelSpreadsheet(
in In_ExcelSpreadsheetId char(20),
in In_ExcelSpreadsheetDesc char(100),
in In_ExcelRptFileName char(50),
out Out_ErrorCode integer)
begin
  if In_ExcelSpreadsheetId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ExcelRptFileName is null then set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from ExcelSpreadsheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId) then
    insert into ExcelSpreadsheet(ExcelSpreadsheetId,
      ExcelSpreadsheetDesc,
      ExcelRptFileName) values(
      In_ExcelSpreadsheetId,
      In_ExcelSpreadsheetDesc,
      In_ExcelRptFileName);
    commit work;
    if not exists(select* from ExcelSpreadsheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewExcelWkSheet(
in In_ExcelSpreadsheetId char(20),
in In_WkSheetName char(50),
in In_WkSheetRptSumLvl char(20),
in In_WkSheetRptBasis1 char(20),
in In_WkSheetRptBasis2 char(20),
in In_WkSheetRptBasis3 char(20),
in In_WkSheetHasRptHeader smallint,
in In_WkSheetHasRptFooter smallint,
in In_WkSheetHeadColourSchemeId char(20),
in In_WkSheetFootColourSchemeId char(20),
in In_WkSheetTitleColourSchemeId char(20),
out Out_WkSheetSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_WkSheetOrder integer;
  if In_ExcelSpreadsheetId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_WkSheetName is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_WkSheetRptSumLvl is null then set Out_ErrorCode=-3;
    return
  end if;
  select max(WkSheetOrder) into Out_WkSheetOrder from ExcelWkSheet where
    ExcelWkSheet.ExcelSpreadsheetId = In_ExcelSpreadsheetId;
  if(Out_WkSheetOrder is null) then
    set Out_WkSheetOrder=1
  else
    set Out_WkSheetOrder=Out_WkSheetOrder+1
  end if;
  if not exists(select* from ExcelWkSheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId and WkSheetName = In_WkSheetName) then
    insert into ExcelWkSheet(ExcelSpreadsheetId,
      WkSheetName,
      WkSheetOrder,
      WkSheetRptSumLvl,
      WkSheetRptBasis1,
      WkSheetRptBasis2,
      WkSheetRptBasis3,
      WkSheetHasRptHeader,
      WkSheetHasRptFooter,
      WkSheetHeadColourSchemeId,
      WkSheetFootColourSchemeId,
      WkSheetTitleColourSchemeId) values(
      In_ExcelSpreadsheetId,
      In_WkSheetName,
      Out_WkSheetOrder,
      In_WkSheetRptSumLvl,
      In_WkSheetRptBasis1,
      In_WkSheetRptBasis2,
      In_WkSheetRptBasis3,
      In_WkSheetHasRptHeader,
      In_WkSheetHasRptFooter,
      In_WkSheetHeadColourSchemeId,
      In_WkSheetFootColourSchemeId,
      In_WkSheetTitleColourSchemeId);
    commit work;
    if not exists(select* from ExcelWkSheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId and WkSheetOrder = Out_WkSheetOrder) then
      set Out_ErrorCode=0
    else
      select max(WkSheetSysId) into Out_WkSheetSysId from ExcelWkSheet where ExcelSpreadsheetId = In_ExcelSpreadsheetId and
        WkSheetOrder = Out_WkSheetOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewExcelWkSheetItem(
in In_WkSheetSysId integer,
in In_WkSheetItemRptType char(20),
in In_WkSheetItemRptId char(20),
out Out_WkSheetItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_WkSheetItemOrdering integer;
  if In_WkSheetSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_WkSheetItemRptType is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_WkSheetItemRptId is null then set Out_ErrorCode=-3;
    return
  end if;
  select max(WkSheetItemOrdering) into Out_WkSheetItemOrdering from ExcelWkSheetItem where
    ExcelWkSheetItem.WkSheetSysId = In_WkSheetSysId;
  if(Out_WkSheetItemOrdering is null) then
    set Out_WkSheetItemOrdering=1
  else
    set Out_WkSheetItemOrdering=Out_WkSheetItemOrdering+1
  end if;
  insert into ExcelWkSheetItem(WkSheetSysId,
    WkSheetItemOrdering,
    WkSheetItemRptType,
    WkSheetItemRptId) values(
    In_WkSheetSysId,
    Out_WkSheetItemOrdering,
    In_WkSheetItemRptType,
    In_WkSheetItemRptId);
  commit work;
  if not exists(select* from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId and
      WkSheetItemRptType = In_WkSheetItemRptType and WkSheetItemRptId = In_WkSheetItemRptId) then
    set Out_ErrorCode=0
  else
    select max(WkSheetItemSysId) into Out_WkSheetItemSysId from ExcelWkSheetItem where WkSheetSysId = In_WkSheetSysId and
      WkSheetItemOrdering = Out_WkSheetItemOrdering;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.InsertNewFinanceColItem(
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinColItemType char(20),
in In_FinColItemTitle char(50),
in In_FinColIncAccuRange integer,
in In_FinColIsRptMainInfo integer,
in In_FinColGrouping char(100),
in In_FinColItem char(100),
in In_FinColComponent char(100),
in In_FinColExcelFormula char(255),
out Out_FinColItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_FinColItemOrder integer;
  if In_FinancialRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_FinColItemType is null then set Out_ErrorCode=-3;
    return
  end if;
  select max(FinColItemOrder) into Out_FinColItemOrder from FinanceColItem where
    FinanceColItem.FinancialRptId = In_FinancialRptId;
  if(Out_FinColItemOrder is null) then
    set Out_FinColItemOrder=1
  else
    set Out_FinColItemOrder=Out_FinColItemOrder+1
  end if;
  if not exists(select* from FinanceColItem where FinancialRptId = In_FinancialRptId and FinColItemOrder = Out_FinColItemOrder) then
    insert into FinanceColItem(ColourSchemeId,
      FinancialRptId,
      FinColItemOrder,
      FinColItemType,
      FinColItemTitle,
      FinColIncAccuRange,
      FinColIsRptMainInfo,
      FinColGrouping,
      FinColItem,
      FinColComponent,
      FinColExcelFormula) values(
      In_ColourSchemeId,
      In_FinancialRptId,
      Out_FinColItemOrder,
      In_FinColItemType,
      In_FinColItemTitle,
      In_FinColIncAccuRange,
      In_FinColIsRptMainInfo,
      In_FinColGrouping,
      In_FinColItem,
      In_FinColComponent,
      In_FinColExcelFormula);
    commit work;
    if not exists(select* from FinanceColItem where FinancialRptId = In_FinancialRptId and
        FinColItemOrder = Out_FinColItemOrder) then
      set Out_ErrorCode=0
    else
      select max(FinColItemSysId) into Out_FinColItemSysId from FinanceColItem where FinancialRptId = In_FinancialRptId and
        FinColItemOrder = Out_FinColItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFinanceGrpItem(
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinGrpItemType char(20),
in In_FinGrpItemTitle char(50),
in In_FinGrpGrouping char(100),
in In_FinGrpItem char(100),
in In_FinGrpComponent char(100),
in In_FinGrpHasSubTotal smallint,
in In_FinGrpHasEmpCount smallint,
out Out_FinGrpItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_FinGrpItemOrder integer;
  if In_FinancialRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_FinGrpItemType is null then set Out_ErrorCode=-3;
    return
  end if;
  select max(FinGrpItemOrder) into Out_FinGrpItemOrder from FinanceGrpItem where
    FinanceGrpItem.FinancialRptId = In_FinancialRptId;
  if(Out_FinGrpItemOrder is null) then
    set Out_FinGrpItemOrder=1
  else
    set Out_FinGrpItemOrder=Out_FinGrpItemOrder+1
  end if;
  if not exists(select* from FinanceGrpItem where FinancialRptId = In_FinancialRptId and FinGrpItemOrder = Out_FinGrpItemOrder) then
    insert into FinanceGrpItem(ColourSchemeId,
      FinancialRptId,
      FinGrpItemOrder,
      FinGrpItemType,
      FinGrpItemTitle,
      FinGrpGrouping,
      FinGrpItem,
      FinGrpComponent,
      FinGrpHasSubTotal,
      FinGrpHasEmpCount) values(
      In_ColourSchemeId,
      In_FinancialRptId,
      Out_FinGrpItemOrder,
      In_FinGrpItemType,
      In_FinGrpItemTitle,
      In_FinGrpGrouping,
      In_FinGrpItem,
      In_FinGrpComponent,
      In_FinGrpHasSubTotal,
      In_FinGrpHasEmpCount);
    commit work;
    if not exists(select* from FinanceGrpItem where FinancialRptId = In_FinancialRptId and
        FinGrpItemOrder = Out_FinGrpItemOrder) then
      set Out_ErrorCode=0
    else
      select max(FinGrpItemSysId) into Out_FinGrpItemSysId from FinanceGrpItem where FinancialRptId = In_FinancialRptId and
        FinGrpItemOrder = Out_FinGrpItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFinanceRowItem(
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinRowItemType char(20),
in In_FinRowItemTitle char(50),
in In_FinRowGrouping char(100),
in In_FinRowItem char(100),
in In_FinRowComponent char(100),
in In_FinRowExcelFormula char(255),
out Out_FinRowItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_FinRowItemOrder integer;
  if In_FinancialRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_FinRowItemType is null then set Out_ErrorCode=-3;
    return
  end if;
  select max(FinRowItemOrder) into Out_FinRowItemOrder from FinanceRowItem where
    FinanceRowItem.FinancialRptId = In_FinancialRptId;
  if(Out_FinRowItemOrder is null) then
    set Out_FinRowItemOrder=1
  else
    set Out_FinRowItemOrder=Out_FinRowItemOrder+1
  end if;
  if not exists(select* from FinanceRowItem where FinancialRptId = In_FinancialRptId and FinRowItemOrder = Out_FinRowItemOrder) then
    insert into FinanceRowItem(ColourSchemeId,
      FinancialRptId,
      FinRowItemOrder,
      FinRowItemType,
      FinRowItemTitle,
      FinRowGrouping,
      FinRowItem,
      FinRowComponent,
      FinRowExcelFormula) values(
      In_ColourSchemeId,
      In_FinancialRptId,
      Out_FinRowItemOrder,
      In_FinRowItemType,
      In_FinRowItemTitle,
      In_FinRowGrouping,
      In_FinRowItem,
      In_FinRowComponent,
      In_FinRowExcelFormula);
    commit work;
    if not exists(select* from FinanceRowItem where FinancialRptId = In_FinancialRptId and
        FinRowItemOrder = Out_FinRowItemOrder) then
      set Out_ErrorCode=0
    else
      select max(FinRowItemSysId) into Out_FinRowItemSysId from FinanceRowItem where FinancialRptId = In_FinancialRptId and
        FinRowItemOrder = Out_FinRowItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFinanceSortItem(
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinSortItemType char(20),
in In_FinSortItemTitle char(50),
in In_FinSortGrouping char(100),
in In_FinSortItem char(100),
in In_FinSortComponent char(100),
out Out_FinSortItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_FinSortItemOrder integer;
  if In_FinancialRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_ColourSchemeId is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_FinSortItemType is null then set Out_ErrorCode=-3;
    return
  end if;
  select max(FinSortItemOrder) into Out_FinSortItemOrder from FinanceSortItem where
    FinanceSortItem.FinancialRptId = In_FinancialRptId;
  if(Out_FinSortItemOrder is null) then
    set Out_FinSortItemOrder=1
  else
    set Out_FinSortItemOrder=Out_FinSortItemOrder+1
  end if;
  if not exists(select* from FinanceSortItem where FinancialRptId = In_FinancialRptId and FinSortItemOrder = Out_FinSortItemOrder) then
    insert into FinanceSortItem(ColourSchemeId,
      FinancialRptId,
      FinSortItemOrder,
      FinSortItemType,
      FinSortItemTitle,
      FinSortGrouping,
      FinSortItem,
      FinSortComponent) values(
      In_ColourSchemeId,
      In_FinancialRptId,
      Out_FinSortItemOrder,
      In_FinSortItemType,
      In_FinSortItemTitle,
      In_FinSortGrouping,
      In_FinSortItem,
      In_FinSortComponent);
    commit work;
    if not exists(select* from FinanceSortItem where FinancialRptId = In_FinancialRptId and
        FinSortItemOrder = Out_FinSortItemOrder) then
      set Out_ErrorCode=0
    else
      select max(FinSortItemSysId) into Out_FinSortItemSysId from FinanceSortItem where FinancialRptId = In_FinancialRptId and
        FinSortItemOrder = Out_FinSortItemOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFinancialRpt(
in In_FinancialRptId char(20),
in In_LayoutSchemeId char(20),
in In_FinancialRptDesc char(100),
in In_FinancialAnalysProjId char(30),
in In_FinancialHasGrandTot smallint,
in In_FinancialHasTotEmpCt smallint,
out Out_ErrorCode integer)
begin
  declare Out_AnlysSetupId char(30);
  if In_FinancialRptId is null then set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from FinancialRpt where FinancialRptId = In_FinancialRptId) then
    insert into FinancialRpt(FinancialRptId,
      LayoutSchemeId,
      FinancialRptDesc,
      FinancialAnalysProjId,
      FinancialHasGrandTot,
      FinancialHasTotEmpCt) values(
      In_FinancialRptId,
      In_LayoutSchemeId,
      In_FinancialRptDesc,
      In_FinancialAnalysProjId,
      In_FinancialHasGrandTot,
      In_FinancialHasTotEmpCt);
    commit work;
    if not exists(select* from FinancialRpt where FinancialRptId = In_FinancialRptId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      set Out_AnlysSetupId='Excel_'+In_FinancialRptId;
      call InsertNewAnlysSetup(Out_AnlysSetupId,In_FinancialRptDesc,Out_ErrorCode);
      call InsertNewAnlysProject(In_FinancialAnalysProjId,Out_AnlysSetupId,In_FinancialRptDesc,null,null,null,null,null,null,null,null,0,null,null,null,null,Out_ErrorCode)
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFinColAccumulated(
in In_FinColItemSysId integer,
in In_FinColAccuYear integer,
in In_FinColAccuMthPeriod integer,
in In_FinColAccuSubPeriod integer,
in In_FinColAccuPayRecIdType char(20),
out Out_FinColAccuSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_FinColAccuOrder integer;
  if In_FinColItemSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  select max(FinColAccuOrder) into Out_FinColAccuOrder from FinColAccumulated where
    FinColAccumulated.FinColItemSysId = In_FinColItemSysId;
  if(Out_FinColAccuOrder is null) then
    set Out_FinColAccuOrder=1
  else
    set Out_FinColAccuOrder=Out_FinColAccuOrder+1
  end if;
  if not exists(select* from FinColAccumulated where FinColAccuYear = In_FinColAccuYear and
      FinColAccuMthPeriod = In_FinColAccuMthPeriod and
      FinColAccuSubPeriod = In_FinColAccuSubPeriod and FinColAccuPayRecIdType = In_FinColAccuPayRecIdType) then
    insert into FinColAccumulated(FinColItemSysId,
      FinColAccuYear,
      FinColAccuMthPeriod,
      FinColAccuSubPeriod,
      FinColAccuPayRecIdType,
      FinColAccuOrder) values(
      In_FinColItemSysId,
      In_FinColAccuYear,
      In_FinColAccuMthPeriod,
      In_FinColAccuSubPeriod,
      In_FinColAccuPayRecIdType,
      Out_FinColAccuOrder);
    commit work;
    if not exists(select* from FinColAccumulated where FinColItemSysId = In_FinColItemSysId and
        FinColAccuOrder = Out_FinColAccuOrder) then
      set Out_ErrorCode=0
    else
      select max(FinColAccuSysId) into Out_FinColAccuSysId from FinColAccumulated where FinColItemSysId = In_FinColItemSysId and
        FinColAccuOrder = Out_FinColAccuOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.UpdateColourScheme(
in In_ColourSchemeId char(20),
in In_ColourSchemeDesc char(100),
in In_ColourSchFont char(50),
in In_ColourSchFontStyle char(20),
in In_ColourSchSize integer,
in In_ColourCodeMapId integer,
in In_ColourSchUnderline char(30),
in In_ColourSchStrikethrough smallint,
in In_ColourSchSuperscript smallint,
in In_ColourSchSubscript smallint,
in In_ColourSchCellHeight integer,
in In_ColourSchCellWidth integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ColourScheme where ColourSchemeId = In_ColourSchemeId) then
    if In_ColourSchemeId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchFont is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_ColourSchFontStyle is null then set Out_ErrorCode=-3;
      return
    end if;
    if In_ColourSchSize is null then set Out_ErrorCode=-4;
      return
    end if;
    if not exists(select* from ColourCodeMapping where ColourCodeMapId = In_ColourCodeMapId) then set Out_ErrorCode=-5;
      return
    end if;
    if In_ColourSchUnderline is null then set Out_ErrorCode=-6;
      return
    end if;
    update ColourScheme set
      ColourScheme.ColourSchemeDesc = In_ColourSchemeDesc,
      ColourScheme.ColourSchFont = In_ColourSchFont,
      ColourScheme.ColourSchFontStyle = In_ColourSchFontStyle,
      ColourScheme.ColourSchSize = In_ColourSchSize,
      ColourScheme.ColourCodeMapId = In_ColourCodeMapId,
      ColourScheme.ColourSchUnderline = In_ColourSchUnderline,
      ColourScheme.ColourSchStrikethrough = In_ColourSchStrikethrough,
      ColourScheme.ColourSchSuperscript = In_ColourSchSuperscript,
      ColourScheme.ColourSchSubscript = In_ColourSchSubscript,
      ColourScheme.ColourSchCellHeight = In_ColourSchCellHeight,
      ColourScheme.ColourSchCellWidth = In_ColourSchCellWidth where
      ColourScheme.ColourSchemeId = In_ColourSchemeId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateEmpColItem(
in In_EmpColItemSysId integer,
in In_ColourSchemeId char(20),
in In_EmpInfoRptId char(20),
in In_EmpColItemOrder integer,
in In_EmpColItemType char(20),
in In_EmpColItemTitle char(50),
in In_EmpColSysTableId char(100),
in In_EmpColSysAttributeId char(100),
in In_EmpColIsRptMainInfo integer,
out Out_ErrorCode integer)
begin
  if exists(select* from EmpColItem where
      EmpColItem.EmpColItemSysId = In_EmpColItemSysId) then
    if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_EmpColItemOrder is null then set Out_ErrorCode=-3;
      return
    end if;
    update EmpColItem set
      EmpColItem.ColourSchemeId = In_ColourSchemeId,
      EmpColItem.EmpInfoRptId = In_EmpInfoRptId,
      EmpColItem.EmpColItemOrder = In_EmpColItemOrder,
      EmpColItem.EmpColItemType = In_EmpColItemType,
      EmpColItem.EmpColItemTitle = In_EmpColItemTitle,
      EmpColItem.EmpColSysTableId = In_EmpColSysTableId,
      EmpColItem.EmpColSysAttributeId = In_EmpColSysAttributeId,
      EmpColItem.EmpColIsRptMainInfo = In_EmpColIsRptMainInfo where
      EmpColItem.EmpColItemSysId = In_EmpColItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateEmpGrpItem(
in In_EmpGrpItemSysId integer,
in In_ColourSchemeId char(20),
in In_EmpInfoRptId char(20),
in In_EmpGrpItemOrder integer,
in In_EmpGrpItemType char(20),
in In_EmpGrpItemTitle char(50),
in In_EmpGrpSysTableId char(100),
in In_EmpGrpSysAttributeId char(100),
in In_EmpGrpHasEmpCount smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from EmpGrpItem where
      EmpGrpItem.EmpGrpItemSysId = In_EmpGrpItemSysId) then
    if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_EmpGrpItemOrder is null then set Out_ErrorCode=-3;
      return
    end if;
    update EmpGrpItem set
      EmpGrpItem.ColourSchemeId = In_ColourSchemeId,
      EmpGrpItem.EmpInfoRptId = In_EmpInfoRptId,
      EmpGrpItem.EmpGrpItemOrder = In_EmpGrpItemOrder,
      EmpGrpItem.EmpGrpItemType = In_EmpGrpItemType,
      EmpGrpItem.EmpGrpItemTitle = In_EmpGrpItemTitle,
      EmpGrpItem.EmpGrpSysTableId = In_EmpGrpSysTableId,
      EmpGrpItem.EmpGrpSysAttributeId = In_EmpGrpSysAttributeId,
      EmpGrpItem.EmpGrpHasEmpCount = In_EmpGrpHasEmpCount where
      EmpGrpItem.EmpGrpItemSysId = In_EmpGrpItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateEmployeeRpt(
in In_EmpInfoRptId char(20),
in In_EmpInfoRptDesc char(100),
in In_EmpInfoRptType char(20),
in In_EmployeeRptHasFilter smallint,
in In_EmployeeRptFilterCond char(255),
in In_EmployeeRptHasEmpCt smallint,
in In_EmployeeRptHasEmpOnly smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from EmployeeRpt where EmployeeRpt.EmpInfoRptId = In_EmpInfoRptId) then
    if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_EmpInfoRptType is null then set Out_ErrorCode=-2;
      return
    end if;
    update EmployeeRpt set
      EmployeeRpt.EmpInfoRptDesc = In_EmpInfoRptDesc,
      EmployeeRpt.EmpInfoRptType = In_EmpInfoRptType,
      EmployeeRpt.EmployeeRptHasFilter = In_EmployeeRptHasFilter,
      EmployeeRpt.EmployeeRptFilterCond = In_EmployeeRptFilterCond,
      EmployeeRpt.EmployeeRptHasEmpCt = In_EmployeeRptHasEmpCt,
      EmployeeRpt.EmployeeRptHasEmpOnly = In_EmployeeRptHasEmpOnly where
      EmployeeRpt.EmpInfoRptId = In_EmpInfoRptId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateEmpSortItem(
in In_EmpSortItemSysId integer,
in In_ColourSchemeId char(20),
in In_EmpInfoRptId char(20),
in In_EmpSortItemOrder integer,
in In_EmpSortItemType char(20),
in In_EmpSortItemTitle char(50),
in In_EmpSortSysTableId char(100),
in In_EmpSortSysAttributeId char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from EmpSortItem where
      EmpSortItem.EmpSortItemSysId = In_EmpSortItemSysId) then
    if In_EmpInfoRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_EmpSortItemOrder is null then set Out_ErrorCode=-3;
      return
    end if;
    update EmpSortItem set
      EmpSortItem.ColourSchemeId = In_ColourSchemeId,
      EmpSortItem.EmpInfoRptId = In_EmpInfoRptId,
      EmpSortItem.EmpSortItemOrder = In_EmpSortItemOrder,
      EmpSortItem.EmpSortItemType = In_EmpSortItemType,
      EmpSortItem.EmpSortItemTitle = In_EmpSortItemTitle,
      EmpSortItem.EmpSortSysTableId = In_EmpSortSysTableId,
      EmpSortItem.EmpSortSysAttributeId = In_EmpSortSysAttributeId where
      EmpSortItem.EmpSortItemSysId = In_EmpSortItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateExcelSpreadsheet(
in In_ExcelSpreadsheetId char(20),
in In_ExcelSpreadsheetDesc char(100),
in In_ExcelRptFileName char(50),
out Out_ErrorCode integer)
begin
  if exists(select* from ExcelSpreadsheet where
      ExcelSpreadsheet.ExcelSpreadsheetId = In_ExcelSpreadsheetId) then
    if In_ExcelSpreadsheetId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ExcelRptFileName is null then set Out_ErrorCode=-2;
      return
    end if;
    update ExcelSpreadsheet set
      ExcelSpreadsheet.ExcelSpreadsheetDesc = In_ExcelSpreadsheetDesc,
      ExcelSpreadsheet.ExcelRptFileName = In_ExcelRptFileName where
      ExcelSpreadsheet.ExcelSpreadsheetId = In_ExcelSpreadsheetId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateExcelWkSheet(
in In_WkSheetSysId integer,
in In_ExcelSpreadsheetId char(20),
in In_WkSheetName char(50),
in In_WkSheetOrder integer,
in In_WkSheetRptSumLvl char(20),
in In_WkSheetRptBasis1 char(20),
in In_WkSheetRptBasis2 char(20),
in In_WkSheetRptBasis3 char(20),
in In_WkSheetHasRptHeader smallint,
in In_WkSheetHasRptFooter smallint,
in In_WkSheetHeadColourSchemeId char(20),
in In_WkSheetFootColourSchemeId char(20),
in In_WkSheetTitleColourSchemeId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ExcelWkSheet where
      ExcelWkSheet.WkSheetSysId = In_WkSheetSysId) then
    if In_ExcelSpreadsheetId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_WkSheetName is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_WkSheetRptSumLvl is null then set Out_ErrorCode=-3;
      return
    end if;
    update ExcelWkSheet set
      ExcelWkSheet.ExcelSpreadsheetId = In_ExcelSpreadsheetId,
      ExcelWkSheet.WkSheetName = In_WkSheetName,
      ExcelWkSheet.WkSheetOrder = In_WkSheetOrder,
      ExcelWkSheet.WkSheetRptSumLvl = In_WkSheetRptSumLvl,
      ExcelWkSheet.WkSheetRptBasis1 = In_WkSheetRptBasis1,
      ExcelWkSheet.WkSheetRptBasis2 = In_WkSheetRptBasis2,
      ExcelWkSheet.WkSheetRptBasis3 = In_WkSheetRptBasis3,
      ExcelWkSheet.WkSheetHasRptHeader = In_WkSheetHasRptHeader,
      ExcelWkSheet.WkSheetHasRptFooter = In_WkSheetHasRptFooter,
      ExcelWkSheet.WkSheetHeadColourSchemeId = In_WkSheetHeadColourSchemeId,
      ExcelWkSheet.WkSheetFootColourSchemeId = In_WkSheetFootColourSchemeId,
      ExcelWkSheet.WkSheetTitleColourSchemeId = In_WkSheetTitleColourSchemeId where
      ExcelWkSheet.WkSheetSysId = In_WkSheetSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateExcelWkSheetItem(
in In_WkSheetItemSysId integer,
in In_WkSheetSysId integer,
in In_WkSheetItemOrdering integer,
in In_WkSheetItemRptType char(20),
in In_WkSheetItemRptId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ExcelWkSheetItem where
      ExcelWkSheetItem.WkSheetItemSysId = In_WkSheetItemSysId) then
    if In_WkSheetSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_WkSheetItemRptType is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_WkSheetItemRptId is null then set Out_ErrorCode=-3;
      return
    end if;
    update ExcelWkSheetItem set
      ExcelWkSheetItem.WkSheetSysId = In_WkSheetSysId,
      ExcelWkSheetItem.WkSheetItemOrdering = In_WkSheetItemOrdering,
      ExcelWkSheetItem.WkSheetItemRptType = In_WkSheetItemRptType,
      ExcelWkSheetItem.WkSheetItemRptId = In_WkSheetItemRptId where
      ExcelWkSheetItem.WkSheetItemSysId = In_WkSheetItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFinanceColItem(
in In_FinColItemSysId integer,
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinColItemOrder integer,
in In_FinColItemType char(20),
in In_FinColItemTitle char(50),
in In_FinColIncAccuRange integer,
in In_FinColIsRptMainInfo integer,
in In_FinColGrouping char(100),
in In_FinColItem char(100),
in In_FinColComponent char(100),
in In_FinColExcelFormula char(255),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceColItem where
      FinanceColItem.FinColItemSysId = In_FinColItemSysId) then
    if In_FinancialRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_FinColItemType is null then set Out_ErrorCode=-3;
      return
    end if;
    if In_FinColItemOrder < 1 then set Out_ErrorCode=-4;
      return
    end if;
    update FinanceColItem set
      FinanceColItem.ColourSchemeId = In_ColourSchemeId,
      FinanceColItem.FinancialRptId = In_FinancialRptId,
      FinanceColItem.FinColItemOrder = In_FinColItemOrder,
      FinanceColItem.FinColItemType = In_FinColItemType,
      FinanceColItem.FinColItemTitle = In_FinColItemTitle,
      FinanceColItem.FinColIncAccuRange = In_FinColIncAccuRange,
      FinanceColItem.FinColIsRptMainInfo = In_FinColIsRptMainInfo,
      FinanceColItem.FinColGrouping = In_FinColGrouping,
      FinanceColItem.FinColItem = In_FinColItem,
      FinanceColItem.FinColComponent = In_FinColComponent,
      FinanceColItem.FinColExcelFormula = In_FinColExcelFormula where
      FinanceColItem.FinColItemSysId = In_FinColItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFinanceGrpItem(
in In_FinGrpItemSysId integer,
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinGrpItemOrder integer,
in In_FinGrpItemType char(20),
in In_FinGrpItemTitle char(50),
in In_FinGrpGrouping char(100),
in In_FinGrpItem char(100),
in In_FinGrpComponent char(100),
in In_FinGrpHasSubTotal smallint,
in In_FinGrpHasEmpCount smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceGrpItem where
      FinanceGrpItem.FinGrpItemSysId = In_FinGrpItemSysId) then
    if In_FinancialRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_FinGrpItemType is null then set Out_ErrorCode=-3;
      return
    end if;
    if In_FinGrpItemOrder < 1 then set Out_ErrorCode=-4;
      return
    end if;
    update FinanceGrpItem set
      FinanceGrpItem.ColourSchemeId = In_ColourSchemeId,
      FinanceGrpItem.FinancialRptId = In_FinancialRptId,
      FinanceGrpItem.FinGrpItemOrder = In_FinGrpItemOrder,
      FinanceGrpItem.FinGrpItemType = In_FinGrpItemType,
      FinanceGrpItem.FinGrpItemTitle = In_FinGrpItemTitle,
      FinanceGrpItem.FinGrpGrouping = In_FinGrpGrouping,
      FinanceGrpItem.FinGrpItem = In_FinGrpItem,
      FinanceGrpItem.FinGrpComponent = In_FinGrpComponent,
      FinanceGrpItem.FinGrpHasSubTotal = In_FinGrpHasSubTotal,
      FinanceGrpItem.FinGrpHasEmpCount = In_FinGrpHasEmpCount where
      FinanceGrpItem.FinGrpItemSysId = In_FinGrpItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFinanceRowItem(
in In_FinRowItemSysId integer,
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinRowItemOrder integer,
in In_FinRowItemType char(20),
in In_FinRowItemTitle char(50),
in In_FinRowGrouping char(100),
in In_FinRowItem char(100),
in In_FinRowComponent char(100),
in In_FinRowExcelFormula char(255),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceRowItem where
      FinanceRowItem.FinRowItemSysId = In_FinRowItemSysId) then
    if In_FinancialRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_FinRowItemType is null then set Out_ErrorCode=-3;
      return
    end if;
    if In_FinRowItemOrder < 1 then set Out_ErrorCode=-4;
      return
    end if;
    update FinanceRowItem set
      FinanceRowItem.ColourSchemeId = In_ColourSchemeId,
      FinanceRowItem.FinancialRptId = In_FinancialRptId,
      FinanceRowItem.FinRowItemOrder = In_FinRowItemOrder,
      FinanceRowItem.FinRowItemType = In_FinRowItemType,
      FinanceRowItem.FinRowItemTitle = In_FinRowItemTitle,
      FinanceRowItem.FinRowGrouping = In_FinRowGrouping,
      FinanceRowItem.FinRowItem = In_FinRowItem,
      FinanceRowItem.FinRowComponent = In_FinRowComponent,
      FinanceRowItem.FinRowExcelFormula = In_FinRowExcelFormula where
      FinanceRowItem.FinRowItemSysId = In_FinRowItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFinanceSortItem(
in In_FinSortItemSysId integer,
in In_ColourSchemeId char(20),
in In_FinancialRptId char(20),
in In_FinSortItemOrder integer,
in In_FinSortItemType char(20),
in In_FinSortItemTitle char(50),
in In_FinSortGrouping char(100),
in In_FinSortItem char(100),
in In_FinSortComponent char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from FinanceSortItem where
      FinanceSortItem.FinSortItemSysId = In_FinSortItemSysId) then
    if In_FinancialRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_ColourSchemeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_FinSortItemType is null then set Out_ErrorCode=-3;
      return
    end if;
    if In_FinSortItemOrder < 1 then set Out_ErrorCode=-4;
      return
    end if;
    update FinanceSortItem set
      FinanceSortItem.ColourSchemeId = In_ColourSchemeId,
      FinanceSortItem.FinancialRptId = In_FinancialRptId,
      FinanceSortItem.FinSortItemOrder = In_FinSortItemOrder,
      FinanceSortItem.FinSortItemType = In_FinSortItemType,
      FinanceSortItem.FinSortItemTitle = In_FinSortItemTitle,
      FinanceSortItem.FinSortGrouping = In_FinSortGrouping,
      FinanceSortItem.FinSortItem = In_FinSortItem,
      FinanceSortItem.FinSortComponent = In_FinSortComponent where
      FinanceSortItem.FinSortItemSysId = In_FinSortItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFinancialRpt(
in In_FinancialRptId char(20),
in In_LayoutSchemeId char(20),
in In_FinancialRptDesc char(100),
in In_FinancialAnalysProjId char(30),
in In_FinancialHasGrandTot smallint,
in In_FinancialHasTotEmpCt smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from FinancialRpt where
      FinancialRpt.FinancialRptId = In_FinancialRptId) then
    if In_FinancialRptId is null then set Out_ErrorCode=-1;
      return
    end if;
    update FinancialRpt set
      FinancialRpt.LayoutSchemeId = In_LayoutSchemeId,
      FinancialRpt.FinancialRptDesc = In_FinancialRptDesc,
      FinancialRpt.FinancialAnalysProjId = In_FinancialAnalysProjId,
      FinancialRpt.FinancialHasGrandTot = In_FinancialHasGrandTot,
      FinancialRpt.FinancialHasTotEmpCt = In_FinancialHasTotEmpCt where
      FinancialRpt.FinancialRptId = In_FinancialRptId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFinColAccumulated(
in In_FinColAccuSysId integer,
in In_FinColItemSysId integer,
in In_FinColAccuYear integer,
in In_FinColAccuMthPeriod integer,
in In_FinColAccuSubPeriod integer,
in In_FinColAccuPayRecIdType char(20),
in In_FinColAccuOrder integer,
out Out_ErrorCode integer)
begin
  if exists(select* from FinColAccumulated where
      FinColAccumulated.In_FinColAccuSysId = In_FinColAccuSysId) then
    if In_FinColItemSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_FinColAccuYear is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_FinColAccuOrder < 1 then set Out_ErrorCode=-3;
      return
    end if;
    update FinColAccumulated set
      FinColAccumulated.FinColItemSysId = In_FinColItemSysId,
      FinColAccumulated.FinColAccuYear = In_FinColAccuYear,
      FinColAccumulated.FinColAccuMthPeriod = In_FinColAccuMthPeriod,
      FinColAccumulated.FinColAccuSubPeriod = In_FinColAccuSubPeriod,
      FinColAccumulated.FinColAccuPayRecIdType = In_FinColAccuPayRecIdType,
      FinColAccumulated.FinColAccuOrder = In_FinColAccuOrder where
      FinColAccumulated.FinColAccuSysId = In_FinColAccuSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create function dba.FGetPeriodPayrollMth(
in In_PayGroupId char(20),
in In_PayGroupPeriod integer)
returns integer
begin
  declare Out_PeriodPayrollMth integer;
  declare Out_PeriodMonth char(20);
  select PeriodMessage.PeriodMonth into Out_PeriodMonth
    from PeriodMessage where
    PeriodMessage.PayGroupId = In_PayGroupId and
    PeriodMessage.PeriodId = In_PayGroupPeriod and
    PeriodMessage.PeriodIdType = 'Period';
  select convert(integer,substring(Out_PeriodMonth,4,2)) into Out_PeriodPayrollMth;
  return(Out_PeriodPayrollMth)
end
;

create function dba.FGetPeriodPayrollMthName(
in In_PayGroupId char(20),
in In_PayGroupPeriod integer)
returns char(20)
begin
  declare Out_PeriodPayrollMth char(20);
  declare Out_PeriodMonth char(20);
  select PeriodMessage.PeriodMonth into Out_PeriodMonth
    from PeriodMessage where
    PeriodMessage.PayGroupId = In_PayGroupId and
    PeriodMessage.PeriodId = In_PayGroupPeriod and
    PeriodMessage.PeriodIdType = 'Period';
  select KeyWordUserDefinedName into Out_PeriodPayrollMth
    from KeyWord where
    KeyWordId = Out_PeriodMonth and KeyWordCategory = 'PayrollMonth';
  return(Out_PeriodPayrollMth)
end
;

create function dba.FGetCodeDescription(
in In_EmployeeSysId integer,
in Out_CodeType char(20))
returns char(100)
begin
  declare Out_CodeDesc char(100);
  if Out_CodeType = 'BranchDesc' then
    (select FGetBranchName(BranchId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'CategoryDesc' then
    (select FGetCategoryDesc(CategoryId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'CessationDesc' then
    (select FGetCessationDesc(CessationCode) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'ClassificationDesc' then
    (select FGetClassificationDesc(ClassificationCode) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'DepartmentDesc' then
    (select FGetDepartmentDesc(DepartmentId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpCode1Desc' then
    (select FGetEmpCode1Desc(EmpCode1Id) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpCode2Desc' then
    (select FGetEmpCode2Desc(EmpCode2Id) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpCode3Desc' then
    (select FGetEmpCode3Desc(EmpCode2Id) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpCode4Desc' then
    (select FGetEmpCode4Desc(EmpCode2Id) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpCode5Desc' then
    (select FGetEmpCode5Desc(EmpCode2Id) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpLocation1Desc' then
    (select FGetEmpLocation1Desc(EmpLocation1Id) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpMaritalStatusDesc' then
    (select FGetMaritalStatusDesc(MaritalStatusCode) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'PositionDesc' then
    (select FGetPositionDesc(PositionId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpRaceDesc' then
    (select FGetRaceDesc(RaceId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpReligionDesc' then
    (select FGetReligionDesc(ReligionId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'SalaryGradeDesc' then
    (select FGetSalaryGradeDesc(SalaryGradeId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'SectionDesc' then
    (select FGetSectionDesc(SectionId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'EmpTitleDesc' then
    (select FGetTitleCodeDesc(TitleId) into Out_CodeDesc from Employee where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'BloodGroupDesc' then
    (select FGetBloodGroupType(BloodGroupId) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'IdentityTypeDesc' then
    (select FGetIdentityTypeDesc(IdentityTypeId) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'PersonalTypeDesc' then
    (select FGetPersonalTypeDesc(PersonalTypeId) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'PerMaritalStatusDesc' then
    (select FGetMaritalStatusDesc(Personal.MaritalStatusCode) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'PerRaceDesc' then
    (select FGetRaceDesc(Personal.RaceId) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'PerReligionDesc' then
    (select FGetReligionDesc(Personal.ReligionId) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  elseif Out_CodeType = 'PerTitleDesc' then
    (select FGetTitleCodeDesc(Personal.TitleId) into Out_CodeDesc from Employee join Personal where EmployeeSysId = In_EmployeeSysId)
  else
    set Out_CodeDesc=''
  end if;
  return(Out_CodeDesc)
end
;

create function dba.FGetCodeDescriptionByPersonal(
in In_PersonalSysId integer,
in In_CodeType char(20))
returns char(100)
begin
  declare Out_CodeDesc char(100);
  if In_CodeType = 'BranchDesc' then
    (select FGetBranchName(BranchId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'CategoryDesc' then
    (select FGetCategoryDesc(CategoryId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'CessationDesc' then
    (select FGetCessationDesc(CessationCode) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'ClassificationDesc' then
    (select FGetClassificationDesc(ClassificationCode) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'DepartmentDesc' then
    (select FGetDepartmentDesc(DepartmentId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpCode1Desc' then
    (select FGetEmpCode1Desc(EmpCode1Id) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpCode2Desc' then
    (select FGetEmpCode2Desc(EmpCode2Id) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpCode3Desc' then
    (select FGetEmpCode3Desc(EmpCode2Id) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpCode4Desc' then
    (select FGetEmpCode4Desc(EmpCode2Id) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpCode5Desc' then
    (select FGetEmpCode5Desc(EmpCode2Id) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpLocation1Desc' then
    (select FGetEmpLocation1Desc(EmpLocation1Id) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpMaritalStatusDesc' then
    (select FGetMaritalStatusDesc(Employee.MaritalStatusCode) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'PositionDesc' then
    (select FGetPositionDesc(PositionId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpRaceDesc' then
    (select FGetRaceDesc(Employee.RaceId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpReligionDesc' then
    (select FGetReligionDesc(Employee.ReligionId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'SalaryGradeDesc' then
    (select FGetSalaryGradeDesc(SalaryGradeId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'SectionDesc' then
    (select FGetSectionDesc(SectionId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'EmpTitleDesc' then
    (select FGetTitleCodeDesc(Employee.TitleId) into Out_CodeDesc from Personal left outer join Employee where
      Personal.PersonalSysId = In_PersonalSysId and Personal.EmployeeId = Employee.EmployeeId)
  elseif In_CodeType = 'BloodGroupDesc' then
    (select FGetBloodGroupType(BloodGroupId) into Out_CodeDesc from Personal where Personal.PersonalSysId = In_PersonalSysId)
  elseif In_CodeType = 'IdentityTypeDesc' then
    (select FGetIdentityTypeDesc(IdentityTypeId) into Out_CodeDesc from Personal where Personal.PersonalSysId = In_PersonalSysId)
  elseif In_CodeType = 'PersonalTypeDesc' then
    (select FGetPersonalTypeDesc(PersonalTypeId) into Out_CodeDesc from Personal where Personal.PersonalSysId = In_PersonalSysId)
  elseif In_CodeType = 'PerMaritalStatusDesc' then
    (select FGetMaritalStatusDesc(Personal.MaritalStatusCode) into Out_CodeDesc from Personal where
      Personal.PersonalSysId = In_PersonalSysId)
  elseif In_CodeType = 'PerRaceDesc' then
    (select FGetRaceDesc(Personal.RaceId) into Out_CodeDesc from Personal where Personal.PersonalSysId = In_PersonalSysId)
  elseif In_CodeType = 'PerReligionDesc' then
    (select FGetReligionDesc(Personal.ReligionId) into Out_CodeDesc from Personal where Personal.PersonalSysId = In_PersonalSysId)
  elseif In_CodeType = 'PerTitleDesc' then
    (select FGetTitleCodeDesc(Personal.TitleId) into Out_CodeDesc from Personal where Personal.PersonalSysId = In_PersonalSysId)
  else
    set Out_CodeDesc=''
  end if;
  return(Out_CodeDesc)
end
;

