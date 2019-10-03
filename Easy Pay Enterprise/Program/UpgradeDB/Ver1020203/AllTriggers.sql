if exists(SELECT 1 FROM SysTrigger JOIN SysTable WHERE SysTable.Table_Name = 'Appraisers' AND 
	trigger_name = 'AppraisersDelete') then
   drop trigger AppraisersDelete
end if
;

CREATE TRIGGER "AppraisersDelete" after delete on
DBA.Appraisers
referencing old as OLDTable
for each row begin
  declare ApprOrderCnt integer;
  set ApprOrderCnt=1;
  UpdateOrderLoop: for UpdateOrderFor as curs dynamic scroll cursor for
    select ApprOrder as OldApprOrder, AppraisalSysId as OldAppraisalSysId from Appraisers
      where Appraisers.AppraisalSysId = OLDTable.AppraisalSysId order by ApprOrder asc do
    update Appraisers set ApprOrder = ApprOrderCnt 
    where Appraisers.AppraisalSysId = OLDTable.AppraisalSysId and Appraisers.ApprOrder=OldApprOrder;
    set ApprOrderCnt=ApprOrderCnt+1 end for
end
;

commit work;