if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteCostGroupPeriod') then
   drop PROCEDURE ASQLDeleteCostGroupPeriod
end if
;
create PROCEDURE DBA.ASQLDeleteCostGroupPeriod(
in In_CostGroupYear integer,
in In_CostGroupPeriod integer,
in In_CostGroupSubPeriod integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostGroupPeriod where CostGroupYear = In_CostGroupYear and CostGroupPeriod=In_CostGroupPeriod and CostGroupSubPeriod=In_CostGroupSubPeriod) then
    set Out_ErrorCode=-1; // CostGroupPeriod not exist
    return
  else
    delete from AccrualRecord where CostPeriodSysId in (select CostPeriod.CostPeriodSysId from CostPeriod join CostSubPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod and CostSubPeriod=In_CostGroupSubPeriod);
    delete from CostTimeSheetRecord where CostRecordSysId in (select CostRecordSysId from CostRecord  where CostPeriodSysId in (select CostPeriod.CostPeriodSysId from CostPeriod join CostSubPeriod where CostYear = In_CostGroupYear and CostPeriod=In_CostGroupPeriod and CostSubPeriod=In_CostGroupSubPeriod));
    delete from CostRecord where CostPeriodSysId in (select CostPeriod.CostPeriodSysId from CostPeriod  join CostSubPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod and CostSubPeriod=In_CostGroupSubPeriod);
    delete from CostSubPeriod where CostPeriodSysId in (select CostPeriod.CostPeriodSysId from CostPeriod  where CostYear = In_CostGroupYear and CostPeriod =In_CostGroupPeriod ) and CostSubPeriod=In_CostGroupSubPeriod;
      
    if not exists(select* from CostSubPeriod where CostPeriodSysId = In_CostGroupPeriod) then
         delete from CostPeriodHistory where CostPeriodSysId in (select CostPeriod.CostPeriodSysId from CostPeriod  join CostSubPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod and CostSubPeriod=In_CostGroupSubPeriod);
         delete from CostPeriodCostCentre where CostPeriodSysId in (select CostPeriod.CostPeriodSysId from CostPeriod  join CostSubPeriod where CostYear = In_CostGroupYear and CostPeriod =In_CostGroupPeriod and CostSubPeriod=In_CostGroupSubPeriod); 
         delete from CostPeriod where CostYear = In_CostGroupYear and CostPeriod= In_CostGroupPeriod and CostPeriodSysID  in (Select CostPeriodSysId from CostSubPeriod Where CostPeriodSysId=In_CostGroupPeriod or CostSubPeriod=In_CostGroupSubPeriod);
    end if;
   
    delete from CostGroupPeriod where CostGroupYear = In_CostGroupYear and CostGroupPeriod= In_CostGroupPeriod and CostGroupSubPeriod=In_CostGroupSubPeriod ;
  end if;
end
;

COMMIT WORK;

