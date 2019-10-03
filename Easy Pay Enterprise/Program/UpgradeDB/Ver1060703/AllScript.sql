/*==============================================================*/
/* Table: BatchRptItem                                              */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'BatchRptItem' and cname = 'RptHasPassword') then
   Alter table DBA.BatchRptItem Add RptHasPassword smallint Default 0;
end if;
/*==============================================================*/

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewBatchRptItem') then
   drop procedure InsertNewBatchRptItem;
end if;

CREATE PROCEDURE "DBA"."InsertNewBatchRptItem"(
in In_BatchRptSysId char(30),
in In_RptPersonEmpeeSysId integer,
in In_RptHasPassword smallint,
out Out_BatchRptItemSysId integer,
out Out_ErrorCode integer)
begin
  if In_RptPersonEmpeeSysId is null then
    // Summary Rpt
    if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId) then
      set Out_BatchRptItemSysId=1;
      insert into BatchRptItem(BatchRptSysId,
        BatchRptItemSysId,
        RptPersonEmpeeSysId,
        RptHasPassword) values(
        In_BatchRptSysId,
        Out_BatchRptItemSysId,
        In_RptPersonEmpeeSysId,
        In_RptHasPassword);
      commit work;
      if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = Out_BatchRptItemSysId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    // Individual Rpt
    if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and RptPersonEmpeeSysId = In_RptPersonEmpeeSysId) then
      select MAX(BatchRptItemSysId) into Out_BatchRptItemSysId from BatchRptItem where BatchRptSysId = In_BatchRptSysId;
      if Out_BatchRptItemSysId is null then
        set Out_BatchRptItemSysId=1
      else
        set Out_BatchRptItemSysId=Out_BatchRptItemSysId+1
      end if;
      insert into BatchRptItem(BatchRptSysId,
        BatchRptItemSysId,
        RptPersonEmpeeSysId,
        RptHasPassword) values(
        In_BatchRptSysId,
        Out_BatchRptItemSysId,
        In_RptPersonEmpeeSysId,
        In_RptHasPassword);
      commit work;
      if not exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = Out_BatchRptItemSysId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

commit work;