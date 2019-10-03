if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemBAssgn') then
   drop procedure InsertNewItemBAssgn
end if
;

CREATE PROCEDURE "DBA"."InsertNewItemBAssgn"(
in In_ItemId char(20),
in In_ItemBatchId char(20),
in In_AssignQty integer,
in In_AssignUnitAmt double,
in In_Remarks char(100),
in In_ExpiryDate date,
in In_IsOnLoan smallint,
in In_WaivedDate date,
in In_NextIssueDate date,
in In_EffectiveDate date,
in In_IssueDate date,
in In_IssueByEmpeeSysId integer,
out Out_ItemBAssignSysId integer,
out Out_ErrorCode integer)
begin
  declare Get_ItemAttrStrValue char(20);
  declare Get_ItemAttrNumValue integer;
  declare Get_ItemAttrDateValue date;
  select max(ItemBAssignSysId) into Out_ItemBAssignSysId from ItemBAssgn;
  if(Out_ItemBAssignSysId is null) then
    set Out_ItemBAssignSysId=0
  end if;
  if not exists(select* from ItemBAssgn where
      ItemBAssignSysId = Out_ItemBAssignSysId+1) then
    insert into ItemBAssgn(ItemBAssignSysId,
      ItemId,
      ItemBatchId,
      AssignQty,
      AssignUnitAmt,
      Remarks,
      ExpiryDate,
      IsOnLoan,
      WaivedDate,
      NextIssueDate,
      EffectiveDate,
      IssueDate,
      IssueByEmpeeSysId) values(Out_ItemBAssignSysId+1,
      In_ItemId,
      In_ItemBatchId,
      In_AssignQty,
      In_AssignUnitAmt,
      In_Remarks,
      In_ExpiryDate,
      In_IsOnLoan,
      In_WaivedDate,
      In_NextIssueDate,
      In_EffectiveDate,
      In_IssueDate,
      In_IssueByEmpeeSysId);
    commit work;
    if not exists(select* from ItemBAssgn where
        ItemBAssignSysId = Out_ItemBAssignSysId+1) then
      set Out_ItemBAssignSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ItemBAssignSysId=Out_ItemBAssignSysId+1;
      set Out_ErrorCode=1;
      ItemAttrNameIdLoop: for ItemAttrNameIdFor as Cur_ItemAttrNameId dynamic scroll cursor for
        select distinct ItemAttrValue.ItemAttrNameId as Get_ItemAttrNameId,ItemAttrValue.ItemAttrType as Get_ItemAttrType from
          ItemAttrValue where
          ItemAttrValue.ItemId = In_ItemId do
        set Get_ItemAttrStrValue='';
        set Get_ItemAttrNumValue=0;
        set Get_ItemAttrDateValue=null;
        if(Get_ItemAttrType = 'ItemAttrTypeStr') then
          select first ItemAttrStrValue into Get_ItemAttrStrValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId order by ItemAttrStrValue asc
        elseif(Get_ItemAttrType = 'ItemAttrTypeNum') then
          select ItemAttrNumValue into Get_ItemAttrNumValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId
        elseif(Get_ItemAttrType = 'ItemAttrTypeDate') then
          select ItemAttrDateValue into Get_ItemAttrDateValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId
        end if;
        insert into ItemBAssignAttr(ItemBAssignAttrSysId,
          ItemBAssignSysId,
          ItemAttrNameId,
          ItemAttrType,ItemAttrStrValue,ItemAttrNumValue,ItemAttrDateValue) values((select max(ItemBAssignAttrSysId) from ItemBAssignAttr)+1,Out_ItemBAssignSysId,Get_ItemAttrNameId,Get_ItemAttrType,Get_ItemAttrStrValue,Get_ItemAttrNumValue,Get_ItemAttrDateValue);
        commit work end for
    end if
  else
    set Out_ItemBAssignSysId=null;
    set Out_ErrorCode=0
  end if
end
;

commit work;