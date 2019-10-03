if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostItemDescByIdType') then
   drop procedure FGetCostItemDescByIdType
end if
;

create function
dba.FGetCostItemDescByIdType(
in In_CostItemId char(20),
in In_CostItemType char(20))
returns char(100)
begin
  declare Out_CostItemDesc char(100);
  select CostItemDesc into Out_CostItemDesc
    from CostItem where CostItemId = In_CostItemId and CostItemType = In_CostItemType;
  if(Out_CostItemDesc is null or Out_CostItemDesc = '') then
    return(In_CostItemId)
  else return(Out_CostItemDesc)
  end if
end
;

commit work;
