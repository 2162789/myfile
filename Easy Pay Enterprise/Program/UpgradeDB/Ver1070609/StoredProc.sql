If exists(select * from sys.sysprocedure where proc_name = 'InsertNewBatchRptItemAdd') then 
  drop procedure InsertNewBatchRptItemAdd
end if;
CREATE PROCEDURE "DBA"."InsertNewBatchRptItemAdd"(
in In_BatchRptSysId char(30),
in In_BatchRptItemSysId integer,
in In_BatRptItModule char(30),
in In_BatRptItSubModule char(30),
in In_BatRptItFileName char(255),
in In_BatRptItFileSize integer,
in In_BatRptItFilePageCount integer,
in In_BatRptItProcess smallint,
in In_BatRptItProcessDateTime timestamp,
out Out_BatRptItemAddSysId integer,
out Out_ErrorCode integer
)
BEGIN
	if not exists(select * from BatchRptItemAdd where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = In_BatchRptItemSysId) then
      insert into BatchRptItemAdd(
      BatchRptSysId,
      BatchRptItemSysId,
      BatRptItModule,
      BatRptItSubModule,
      BatRptItFileName,
      BatRptItFileSize,
      BatRptItFilePageCount,
      BatRptItProcess,
      BatRptItProcessDateTime)
      values(
      In_BatchRptSysId,
      In_BatchRptItemSysId,
      In_BatRptItModule,
      In_BatRptItSubModule,
      In_BatRptItFileName,
      In_BatRptItFileSize,
      In_BatRptItFilePageCount,
      In_BatRptItProcess,
      In_BatRptItProcessDateTime);
      
      select BatRptItemAddSysId into Out_BatRptItemAddSysId from BatchRptItemAdd where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = In_BatchRptItemSysId;
      set Out_ErrorCode = 1;
    else
      set Out_BatRptItemAddSysId = 0;      
      set Out_ErrorCode = 0;
    end if;
END;

If exists(select * from sys.sysprocedure where proc_name = 'UpdateBatchRptItemAdd') then 
  drop procedure UpdateBatchRptItemAdd
end if;
CREATE PROCEDURE "DBA"."UpdateBatchRptItemAdd"(
in In_BatchRptSysId char(30),
in In_BatchRptItemSysId integer,
in In_BatRptItModule char(30),
in In_BatRptItSubModule char(30),
in In_BatRptItFileName char(255),
in In_BatRptItFileSize integer,
in In_BatRptItFilePageCount integer,
in In_BatRptItProcess smallint,
in In_BatRptItProcessDateTime timestamp,
out Out_BatRptItemAddSysId integer,
out Out_ErrorCode integer
)
BEGIN
    if exists(select * from BatchRptItemAdd where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = In_BatchRptItemSysId) then
      Update BatchRptItemAdd
      Set BatchRptSysId = In_BatchRptSysId,
      BatchRptItemSysId = In_BatchRptItemSysId,
      BatRptItModule = In_BatRptItModule,
      BatRptItSubModule = In_BatRptItSubModule,
      BatRptItFileName = In_BatRptItFileName,
      BatRptItFileSize = In_BatRptItFileSize,
      BatRptItFilePageCount = In_BatRptItFilePageCount,
      BatRptItProcess = In_BatRptItProcess,
      BatRptItProcessDateTime = In_BatRptItProcessDateTime
      where BatchRptSysId = In_BatchRptSysId
        and BatchRptItemSysId = In_BatchRptItemSysId;
       
      select BatRptItemAddSysId into Out_BatRptItemAddSysId from BatchRptItemAdd where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId = In_BatchRptItemSysId;    
      set Out_ErrorCode = 1;
    else
      set Out_BatRptItemAddSysId =0;
      set Out_ErrorCode = 0;
    end if;
END;

If exists(select * from sys.sysprocedure where proc_name = 'DeleteBatchRptItem') then 
  drop procedure DeleteBatchRptItem
end if;
CREATE PROCEDURE "DBA"."DeleteBatchRptItem"(
in In_BatchRptSysId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId) then
       delete from BatchRptItemAdd where BatchRptSysId = In_BatchRptSysId;
       delete from BatchRptItem where BatchRptSysId = In_BatchRptSysId;
    commit work;
    if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end;

If exists(select * from sys.sysprocedure where proc_name = 'DeleteBatchRpt') then 
  drop procedure DeleteBatchRpt
end if;
CREATE PROCEDURE "DBA"."DeleteBatchRpt"(
in In_BatchRptSysId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from BatchRpt where BatchRptSysId = In_BatchRptSysId) then
    call DeleteBatchRptItem(In_BatchRptSysId,Out_ErrorCode);
    delete from BatchRpt where BatchRptSysId = In_BatchRptSysId;
    commit work;
    if exists(select* from BatchRpt where BatchRptSysId = In_BatchRptSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end;

If exists(select * from sys.sysprocedure where proc_name = 'DeleteBatchRptItemRec') then 
  drop procedure DeleteBatchRptItemRec
end if;
CREATE PROCEDURE "DBA"."DeleteBatchRptItemRec"(
in In_BatchRptSysId char(30), 
in In_BatchRptItemSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId=In_BatchRptItemSysId) then
      delete from BatchRptItemAdd where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId=In_BatchRptItemSysId;
      delete from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId=In_BatchRptItemSysId;
    commit work;
    if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId=In_BatchRptItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end;

commit work;