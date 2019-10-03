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