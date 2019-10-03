if exists(select 1 from sys.sysviews where viewname = 'View_SYSCOLUMNS') then
    DROP VIEW View_SYSCOLUMNS
end if;

Create VIEW DBA.View_SYSCOLUMNS
    AS
  SELECT 
  SYS.SYSCOLUMNS.ColType AS ColType,  
  SYS.SYSCOLUMNS.TName AS TName,
  SYS.SYSCOLUMNS.CName AS CName,
  SYS.SYSCOLUMNS.Length AS Length,
  SYS.SYSCOLUMNS.SysLength AS SysLength,
  SYS.SYSCOLUMNS.ColNo AS ColNo,
  SYS.SYSCOLUMNS.In_Primary_Key AS In_Primary_Key,
  SYS.SYSCOLUMNS.Default_Value AS Default_Value
  FROM SYS.SYSCOLUMNS
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBatchRptItemRec') then
   drop function DBA.DeleteBatchRptItemRec
end if;

CREATE PROCEDURE DBA.DeleteBatchRptItemRec(
in In_BatchRptSysId char(30), in In_BatchRptItemSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from BatchRptItem where BatchRptSysId = In_BatchRptSysId and BatchRptItemSysId=In_BatchRptItemSysId) then
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
end
;

/*Insert into Registry */
IF NOT EXISTS (SELECT 1 FROM Registry WHERE RegistryId = 'Accpac5.0') THEN
  INSERT INTO Registry VALUES ('Accpac5.0','Accpac Export v5.0a Options')
END IF;

IF NOT EXISTS (SELECT 1 FROM SubRegistry WHERE RegistryId = 'Accpac5.0' AND SubRegistryId = 'TransDesc') THEN
  INSERT INTO SubRegistry VALUES ('Accpac5.0','TransDesc','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;

Update SystemRptComp SET IsRptKey=1, RptKeyIndex=4 WHERE SysRptCompName = 'dxDBGridMaskColumn_RecID';

Commit Work;
