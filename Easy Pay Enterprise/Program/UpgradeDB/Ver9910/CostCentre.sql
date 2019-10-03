create procedure dba.ASQLCostCurrentCostPeriod(
in In_CostGroupId char(20),
out Out_CurrentYear integer,
out Out_CurrentPeriod integer,
out Out_CurrentSubPeriod integer)
begin
  declare Out_NoSubPeriod integer;
  declare Out_PeriodStartYear integer;
  select NoSubPeriod into Out_NoSubPeriod from CostGroup where CostGroupId = In_CostGroupId;
  select max(CostGroupYear) into Out_CurrentYear from CostGroupPeriod where CostGroupId = In_CostGroupId;
  if(Out_CurrentYear is null) then
    set Out_CurrentYear=0;
    set Out_CurrentPeriod=0;
    set Out_CurrentSubPeriod=0
  else
    select max(CostGroupPeriod) into Out_CurrentPeriod from CostGroupPeriod where
      CostGroupId = In_CostGroupId and
      CostGroupYear = Out_CurrentYear;
    select max(CostGroupSubPeriod) into Out_CurrentSubPeriod from CostGroupPeriod where
      CostGroupId = In_CostGroupId and
      CostGroupYear = Out_CurrentYear and
      CostGroupPeriod = Out_CurrentPeriod
  end if
end
;


create procedure dba.ASQLCostNextCostPeriod(
in In_CostGroupId char(20),
out Out_NextYear integer,
out Out_NextPeriod integer,
out Out_NextSubPeriod integer)
begin
  declare Out_NoSubPeriod integer;
  declare Out_PeriodStartYear integer;
  select NoSubPeriod into Out_NoSubPeriod from CostGroup where CostGroupId = In_CostGroupId;
  select max(CostGroupYear) into Out_NextYear from CostGroupPeriod where CostGroupId = In_CostGroupId;
  select max(CostGroupPeriod) into Out_NextPeriod from CostGroupPeriod where
    CostGroupId = In_CostGroupId and
    CostGroupYear = Out_NextYear;
  select max(CostGroupSubPeriod) into Out_NextSubPeriod from CostGroupPeriod where
    CostGroupId = In_CostGroupId and
    CostGroupYear = Out_NextYear and
    CostGroupPeriod = Out_NextPeriod;
  if(Out_NextYear is null or Out_NextPeriod is null or Out_NextSubPeriod is null) then
    set Out_NextYear=0;
    set Out_NextPeriod=1;
    set Out_NextSubPeriod=1
  else
    set Out_NextSubPeriod=Out_NextSubPeriod+1;
    if(Out_NextSubPeriod > Out_NoSubPeriod) then
      set Out_NextSubPeriod=1;
      set Out_NextPeriod=Out_NextPeriod+1
    end if;
    if(Out_NextPeriod > 12) then
      set Out_NextPeriod=1;
      set Out_NextYear=Out_NextYear+1
    end if
  end if
end
;


create procedure DBA.ASQLCreateCostPeriodCostCentre(
in In_EmployeeSysId integer,
in In_CostPeriodSysId integer,
in In_CostProgSysId integer)
begin
  delete from CostPeriodCostCentre where
    CostPeriodSysId = In_CostPeriodSysId;
  EmpeeCostCentreLoop: for EmpeeCostCentreForLoop as Cur_EmpeeCostCentre dynamic scroll cursor for
    select CostCentreId as Out_CostCentreId,
      CostAllocType as Out_CostAllocType,
      CostAllocValue as Out_CostAllocValue from
      EmployeeCostCentre where CostProgSysId = In_CostProgSysId do
    call InsertNewCostPeriodCostCentre(
    In_CostPeriodSysId,
    Out_CostCentreId,
    Out_CostAllocType,
    Out_CostAllocValue) end for
end
;


create procedure dba.ASQLDeleteCostItemComponent(
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostComponentId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostItemComponent where CostItemId = In_CostItemId and
      CostItemType = In_CostItemType and CostComponentId = In_CostComponentId) then
    if not exists(select* from CostRecord where CostItemId = In_CostItemId and
        CostItemType = In_CostItemType and CostComponentId = In_CostComponentId) then
      if exists(select* from CostCreditDebit where CostItemId = In_CostItemId and
          CostItemType = In_CostItemType and CostComponentId = In_CostComponentId) then
        DeleteCostComponent: for DeleteCostComponentFor as DeleteCostComponentCurs dynamic scroll cursor for
          select CostCrDrSysId as Out_CostCrDrSysId from
            CostCreditDebit where
            CostItemId = In_CostItemId and
            CostItemType = In_CostItemType and
            CostComponentId = In_CostComponentId do
          call DeleteCostCreditDebit(Out_CostCrDrSysId) end for;
        if exists(select* from CostCreditDebit where CostItemId = In_CostItemId and
            CostItemType = In_CostItemType and CostComponentId = In_CostComponentId) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=1
      end if;
      if Out_ErrorCode = 1 then
        delete from CostItemComponent where CostItemId = In_CostItemId and
          CostItemType = In_CostItemType and CostComponentId = In_CostComponentId;
        commit work;
        if exists(select* from CostItemComponent where CostItemId = In_CostItemId and
            CostItemType = In_CostItemType and CostComponentId = In_CostComponentId) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure DBA.ASQLDeleteCostSubPeriod(
in In_CostPeriodSysId integer,
in In_CostSubPeriod integer)
begin
  delete from AccrualRecord where CostPeriodSysId = In_CostPeriodSysId and
    CostSubPeriod = In_CostSubPeriod;
  delete from CostTimeSheetRecord where CostRecordSysId = any(select CostRecordSysId from CostRecord where CostPeriodSysId = In_CostPeriodSysId and
      CostSubPeriod = In_CostSubPeriod);
  delete from CostRecord where CostPeriodSysId = In_CostPeriodSysId and
    CostSubPeriod = In_CostSubPeriod;
  delete from CostSubPeriod where CostPeriodSysId = In_CostPeriodSysId and
    CostSubPeriod = In_CostSubPeriod;
  if not exists(select* from CostSubPeriod where CostPeriodSysId = In_CostPeriodSysId) then
    delete from CostPeriodHistory where CostPeriodSysId = In_CostPeriodSysId;
    delete from CostPeriodCostCentre where CostPeriodSysId = In_CostPeriodSysId;
    delete from CostPeriod where CostPeriodSysId = In_CostPeriodSysId
  end if;
  commit work
end
;


create procedure DBA.ASQLUpdateCostRecord(
in In_CostPeriodSysId integer,
in In_CostSubPeriod integer,
in In_CostCentreId char(20),
in In_GLCode char(20),
in In_CostComponentId char(20),
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostDebitAmt double,
in In_CostCreditAmt double,
in In_CostDebitForeignAmt double,
in In_CostCreditForeignAmt double,
in In_CostAllocType char(20),
in In_CostAllocValue double,
out Out_Error integer)
begin
  declare Out_CostRecordSysId integer;
  declare Out_CostDebitAmt double;
  declare Out_CostCreditAmt double;
  set Out_Error=0;
  /*
  Check Record exists
  */
  select CostRecordSysId,
    CostDebitAmt,
    CostCreditAmt into Out_CostRecordSysId,
    Out_CostDebitAmt,
    Out_CostCreditAmt from CostRecord where
    CostPeriodSysId = In_CostPeriodSysId and
    CostSubPeriod = In_CostSubPeriod and
    CostCentreId = In_CostCentreId and
    GLCode = In_GLCode and
    CostComponentId = In_CostComponentId and
    CostItemId = In_CostItemId and
    CostItemType = In_CostItemType;
  if Out_CostRecordSysId is null and
    (In_CostDebitAmt > 0 or In_CostCreditAmt > 0) then
    insert into CostRecord(CostPeriodSysId,
      CostSubPeriod,
      CostCentreId,
      GLCode,
      CostComponentId,
      CostItemId,
      CostItemType,
      CostDebitAmt,
      CostCreditAmt,
      CostDebitForeignAmt,
      CostCreditForeignAmt,
      CostCreditAdj,
      CostDebitAdj,
      CostAllocType,
      CostAllocValue,
      CostDebitBfAvg,
      CostCreditBfAvg,
      CostDebitForeignBfAvg,
      CostCreditForeignBfAvg,
      CreatedBy) values(
      In_CostPeriodSysId,
      In_CostSubPeriod,
      In_CostCentreId,
      In_GLCode,
      In_CostComponentId,
      In_CostItemId,
      In_CostItemType,
      In_CostDebitAmt,
      In_CostCreditAmt,
      In_CostDebitForeignAmt,
      In_CostCreditForeignAmt,
      0,
      0,
      In_CostAllocType,
      In_CostAllocValue,
      In_CostDebitAmt,
      In_CostCreditAmt,
      In_CostDebitForeignAmt,
      In_CostCreditForeignAmt,'S')
  else
    /*
    Check Record already contains amount
    */
    if Out_CostDebitAmt <> 0 or Out_CostCreditAmt <> 0 then set Out_Error=-1
    end if;
    if In_CostDebitAmt > 0 or In_CostCreditAmt > 0 then
      update CostRecord set
        CostDebitAmt = In_CostDebitAmt,
        CostCreditAmt = In_CostCreditAmt,
        CostDebitForeignAmt = In_CostDebitForeignAmt,
        CostCreditForeignAmt = In_CostCreditForeignAmt,
        CostAllocType = In_CostAllocType,
        CostAllocValue = In_CostAllocValue,
        CostCreditBfAvg = In_CostCreditAmt,
        CostDebitBfAvg = In_CostDebitAmt,
        CostCreditForeignBfAvg = In_CostCreditForeignAmt,
        CostDebitForeignBfAvg = In_CostDebitForeignAmt where
        CostRecordSysId = Out_CostRecordSysId
    end if
  end if;
  commit work
end
;


create procedure dba.DeleteCostCreditDebit(
in In_CostCrDrSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from CostCreditDebit where CostCreditDebit.CostCrDrSysId = In_CostCrDrSysId) then
    if exists(select* from CostItemRule where CostItemRule.CostCrDrSysId = In_CostCrDrSysId) then
      delete from CostItemRule where CostItemRule.CostCrDrSysId = In_CostCrDrSysId
    end if;
    if exists(select* from CostCond_mm where CostCond_mm.CostCrDrSysId = In_CostCrDrSysId) then
      delete from CostCond_mm where CostCond_mm.CostCrDrSysId = In_CostCrDrSysId
    end if;
    delete from CostCreditDebit where CostCreditDebit.CostCrDrSysId = In_CostCrDrSysId;
    commit work;
    if exists(select* from CostCreditDebit where CostCreditDebit.CostCrDrSysId = In_CostCrDrSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteCostItem(
in In_CostItemId char(20),
in In_CostItemType char(20),
out Out_ErrorCode integer)
begin
  if In_CostItemId <> 'System Balance' and In_CostItemType <> 'BalanceType' then
    if not exists(select* from CostRecord where
        CostRecord.CostItemId = In_CostItemId and
        CostRecord.CostItemType = In_CostItemType) then
      if exists(select* from CostItem where
          CostItem.CostItemId = In_CostItemId and
          CostItem.CostItemType = In_CostItemType) then
        if exists(select* from CostItemComponent where
            CostItemComponent.CostItemId = In_CostItemId and
            CostItemComponent.CostItemType = In_CostItemType) then
          DeleteCostComponent: for DeleteCostComponentFor as DeleteCostComponentCurs dynamic scroll cursor for
            select CostComponentId as Out_CostComponentId from
              CostItemComponent where
              CostItemId = In_CostItemId and
              CostItemType = In_CostItemType do
            call ASQLDeleteCostItemComponent(In_CostItemId,In_CostItemType,Out_CostComponentId) end for;
          if exists(select* from CostItemComponent where
              CostItemComponent.CostItemId = In_CostItemId and
              CostItemComponent.CostItemType = In_CostItemType) then
            set Out_ErrorCode=0
          else
            set Out_ErrorCode=1
          end if
        else
          set Out_ErrorCode=1
        end if;
        if Out_ErrorCode = 1 then
          if exists(select* from GroupCostItem where
              GroupCostItem.CostItemId = In_CostItemId and
              GroupCostItem.CostItemType = In_CostItemType) then
            delete from GroupCostItem where
              GroupCostItem.CostItemId = In_CostItemId and
              GroupCostItem.CostItemType = In_CostItemType
          end if;
          delete from CostItem where
            CostItem.CostItemId = In_CostItemId and
            CostItem.CostItemType = In_CostItemType;
          commit work;
          if exists(select* from CostItem where
              CostItem.CostItemId = In_CostItemId and
              CostItem.CostItemType = In_CostItemType) then
            set Out_ErrorCode=0
          else
            set Out_ErrorCode=1
          end if
        else
          set Out_ErrorCode=0
        end if
      else
        set Out_ErrorCode=0
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;


create procedure dba.DeleteCostPeriodHistory(
in In_CostPeriodSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from CostPeriodHistory where CostPeriodHistory.CostPeriodSysId = In_CostPeriodSysId) then
    delete from CostPeriodHistory where CostPeriodHistory.CostPeriodSysId = In_CostPeriodSysId;
    commit work;
    if exists(select* from CostPeriodHistory where CostPeriodHistory.CostPeriodSysId = In_CostPeriodSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewCostCreditDebit(
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostComponentId char(20),
in In_CostPostingOption integer,
in In_CostCentreOption integer,
in In_GLCode char(20),
in In_CostPayRecId char(20),
in In_CostPayRecType char(20),
in In_CostCentreId char(20),
out Out_CostCrDrSysId integer,
out Out_ErrorCode integer)
begin
  declare CostCrDrId integer;
  select MAX(CostCrDrSysId) into CostCrDrId from CostCreditDebit;
  if CostCrDrId is null then set CostCrDrId=0
  end if;
  insert into CostCreditDebit(CostItemId,
    CostItemType,
    CostComponentId,
    CostPostingOption,
    CostCentreOption,
    GLCode,
    CostPayRecId,
    CostPayRecType,
    CostCentreId) values(
    In_CostItemId,
    In_CostItemType,
    In_CostComponentId,
    In_CostPostingOption,
    In_CostCentreOption,
    In_GLCode,
    In_CostPayRecId,
    In_CostPayRecType,
    In_CostCentreId);
  commit work;
  select MAX(CostCrDrSysId) into Out_CostCrDrSysId from CostCreditDebit;
  if Out_CostCrDrSysId is null then set Out_CostCrDrSysId=0
  end if;
  if CostCrDrId = Out_CostCrDrSysId then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;



create procedure dba.InsertNewCostGroupPeriod(
in In_CostGroupId char(20),
in In_CostGroupYear integer,
in In_CostGroupPeriod integer,
in In_CostGroupSubPeriod integer,
in In_CostDateFrom date,
in In_CostDateTo date)
begin
  if not exists(select* from CostGroupPeriod where
      CostGroupId = In_CostGroupId and
      CostGroupYear = In_CostGroupYear and
      CostGroupPeriod = In_CostGroupPeriod and
      CostGroupSubPeriod = In_CostGroupSubPeriod) then
    insert into CostGroupPeriod(CostGroupId,
      CostGroupYear,
      CostGroupPeriod,
      CostGroupSubPeriod,
      CostDateFrom,
      CostDateTo) values(
      In_CostGroupId,
      In_CostGroupYear,
      In_CostGroupPeriod,
      In_CostGroupSubPeriod,
      In_CostDateFrom,
      In_CostDateTo);
    commit work
  end if
end
;



create procedure dba.InsertNewCostItem(
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostItemDesc char(100),
in In_CostItemHistory integer,
in In_CostItemTaxInclusive integer,
in In_IsCreditItem integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostItem where CostItemId = In_CostItemId and CostItemType = In_CostItemType) then
    insert into CostItem(CostItemId,
      CostItemType,
      CostItemDesc,
      CostItemHistory,
      CostItemTaxInclusive,
      IsCreditItem) values(
      In_CostItemId,
      In_CostItemType,
      In_CostItemDesc,
      In_CostItemHistory,
      In_CostItemTaxInclusive,
      In_IsCreditItem);
    commit work;
    if exists(select* from CostItem where CostItemId = In_CostItemId and CostItemType = In_CostItemType) then
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewCostPeriod(
in In_EmployeeSysId integer,
in In_CostYear integer,
in In_CostPeriod integer,
out Out_CostPeriodSysId integer)
begin
  /*
  Create Cost Period Record if not exist
  */
  if not exists(select* from CostPeriod where EmployeeSysId = In_EmployeeSysId and
      CostYear = In_CostYear and
      CostPeriod = In_CostPeriod) then
    insert into CostPeriod(EmployeeSysId,
      CostYear,
      CostPeriod) values(
      In_EmployeeSysId,In_CostYear,In_CostPeriod);
    commit work
  end if;
  /*
  Get the Cost Period Record
  */
  select CostPeriodSysId into Out_CostPeriodSysId from CostPeriod where EmployeeSysId = In_EmployeeSysId and
    CostYear = In_CostYear and
    CostPeriod = In_CostPeriod
end
;


create procedure dba.InsertNewCostPeriodCostCentre(
in In_CostPeriodSysId integer,
in In_CostCentreId char(20),
in In_CostAllocType char(20),
in In_CostAllocValue double)
begin
  if not exists(select* from CostPeriodCostCentre where
      CostPeriodSysId = In_CostPeriodSysId and
      CostCentreId = In_CostCentreId) then
    insert into CostPeriodCostCentre(CostPeriodSysId,
      CostCentreId,
      CostAllocType,
      CostAllocValue) values(
      In_CostPeriodSysId,
      In_CostCentreId,
      In_CostAllocType,
      In_CostAllocValue);
    commit work
  end if
end
;


create procedure
dba.InsertNewCostPeriodHistory(
in In_CostPeriodSysId integer,
in In_HisCostGroupId char(20),
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisPositionId char(20),
in In_HisSectionId char(20),
in In_HisSalaryGradeId char(20),
in In_HisClassificationCode char(20),
in In_HisEmpCode1 char(20),
in In_HisEmpCode2 char(20),
in In_HisEmpCode3 char(20),
in In_HisEmpCode4 char(20),
in In_HisEmpCode5 char(20),
in In_HisEmpLocation1 char(20),
in In_HisCostCentreId char(20),
in In_HisPayGroupId char(20),
in In_HisWTCalendarId char(20),
in In_HisLeaveGroupId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from CostPeriodHistory where CostPeriodSysId = In_CostPeriodSysId) then
    insert into CostPeriodHistory(CostPeriodSysId,
      HisCostGroupId,
      HisBranchId,
      HisCategoryId,
      HisDepartmentId,
      HisPositionId,
      HisSectionId,
      HisSalaryGradeId,
      HisClassificationCode,
      HisEmpCode1,
      HisEmpCode2,
      HisEmpCode3,
      HisEmpCode4,
      HisEmpCode5,
      HisEmpLocation1,
      HisCostCentreId,
      HisPayGroupId,
      HisWTCalendarId,
      HisLeaveGroupId) values(
      In_CostPeriodSysId,
      In_HisCostGroupId,
      In_HisBranchId,
      In_HisCategoryId,
      In_HisDepartmentId,
      In_HisPositionId,
      In_HisSectionId,
      In_HisSalaryGradeId,
      In_HisClassificationCode,
      In_HisEmpCode1,
      In_HisEmpCode2,
      In_HisEmpCode3,
      In_HisEmpCode4,
      In_HisEmpCode5,
      In_HisEmpLocation1,
      In_HisCostCentreId,
      In_HisPayGroupId,
      In_HisWTCalendarId,
      In_HisLeaveGroupId);
    commit work;
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=-1
  end if
end
;


create procedure dba.InsertNewCostSubPeriod(
in In_CostPeriodSysId integer,
in In_CostSubPeriod integer,
in In_CostError smallint,
in In_CostLocalForeignRate double,
in In_Status char(20),
in In_CreatedBy char(1),
in In_LastProcessed timestamp)
begin
  /*
  Create Cost Sub Period Record if not exist
  */
  if not exists(select* from CostSubPeriod where CostPeriodSysId = In_CostPeriodSysId and
      CostSubPeriod = In_CostSubPeriod) then
    insert into CostsubPeriod(CostPeriodSysId,
      CostSubPeriod,
      CostError,
      CostLocalForeignRate,
      Status,
      CreatedBy,
      LastProcessed) values(
      In_CostPeriodSysId,
      In_CostSubPeriod,
      In_CostError,
      In_CostLocalForeignRate,
      In_Status,
      In_CreatedBy,
      In_LastProcessed);
    commit work
  end if
end
;



create procedure dba.PatchCostDetails()
begin
  CreateCostEmpDetailsLoop: for CreateCostEmpDetailsFor as curs dynamic scroll cursor for
    select EmployeeSysId as Out_EmployeeSysId from Employee do
    if not exists(select* from CostingDetails where EmployeeSysId = Out_EmployeeSysId) then
      insert into CostingDetails(EmployeeSysId) values(Out_EmployeeSysId)
    end if end for;
  commit work
end
;


create procedure dba.UpdateCostCreditDebit(
in In_CostCrDrSysId integer,
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostComponentId char(20),
in In_CostPostingOption integer,
in In_CostCentreOption integer,
in In_GLCode char(20),
in In_CostPayRecId char(20),
in In_CostPayRecType char(20),
in In_CostCentreId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostCreditDebit where CostCreditDebit.CostCrDrSysId = In_CostCrDrSysId) then
    update CostCreditDebit set
      CostCreditDebit.CostItemId = In_CostItemId,
      CostCreditDebit.CostItemType = In_CostItemType,
      CostCreditDebit.CostComponentId = In_CostComponentId,
      CostCreditDebit.CostPostingOption = In_CostPostingOption,
      CostCreditDebit.CostCentreOption = In_CostCentreOption,
      CostCreditDebit.GLCode = In_GLCode,
      CostCreditDebit.CostPayRecId = In_CostPayRecId,
      CostCreditDebit.CostPayRecType = In_CostPayRecType,
      CostCreditDebit.CostCentreId = In_CostCentreId where
      CostCreditDebit.CostCrDrSysId = In_CostCrDrSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateCostItem(
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostItemDesc char(100),
in In_CostItemHistory integer,
in In_CostItemTaxInclusive integer,
in In_IsCreditItem integer,
out Out_ErrorCode integer)
begin
  if exists(select* from CostItem where CostItemId = In_CostItemId and CostItemType = In_CostItemType) then
    update CostItem set
      CostItemDesc = In_CostItemDesc,
      CostItemHistory = In_CostItemHistory,
      CostItemTaxInclusive = In_CostItemTaxInclusive,
      IsCreditItem = In_IsCreditItem where
      CostItemId = In_CostItemId and
      CostItemType = In_CostItemType;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateCostPeriodHistory(
in In_CostPeriodSysId integer,
in In_HisCostGroupId char(20),
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisPositionId char(20),
in In_HisSectionId char(20),
in In_HisSalaryGradeId char(20),
in In_HisClassificationCode char(20),
in In_HisEmpCode1 char(20),
in In_HisEmpCode2 char(20),
in In_HisEmpCode3 char(20),
in In_HisEmpCode4 char(20),
in In_HisEmpCode5 char(20),
in In_HisEmpLocation1 char(20),
in In_HisCostCentreId char(20),
in In_HisPayGroupId char(20),
in In_HisWTCalendarId char(20),
in In_HisLeaveGroupId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostPeriodHistory where CostPeriodHistory.CostPeriodSysId = In_CostPeriodSysId) then
    update CostPeriodHistory set
      CostPeriodSysId = In_CostPeriodSysId,
      HisCostGroupId = In_HisCostGroupId,
      HisBranchId = In_HisBranchId,
      HisCategoryId = In_HisCategoryId,
      HisDepartmentId = In_HisDepartmentId,
      HisPositionId = In_HisPositionId,
      HisSectionId = In_HisSectionId,
      HisSalaryGradeId = In_HisSalaryGradeId,
      HisClassificationCode = In_HisClassificationCode,
      HisEmpCode1 = In_HisEmpCode1,
      HisEmpCode2 = In_HisEmpCode2,
      HisEmpCode3 = In_HisEmpCode3,
      HisEmpCode4 = In_HisEmpCode4,
      HisEmpCode5 = In_HisEmpCode5,
      HisEmpLocation1 = In_HisEmpLocation1,
      HisCostCentreId = In_HisCostCentreId,
      HisPayGroupId = In_HisPayGroupId,
      HisWTCalendarId = In_HisWTCalendarId,
      HisLeaveGroupId = In_HisLeaveGroupId where
      CostPeriodHistory.CostPeriodSysId = In_CostPeriodSysId;
    commit work;
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;


create procedure dba.ASQLUpdateCostBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpLocation1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'CostBasis' and SubRegistryId = 'CostEmpLocation1Id'
  end if;
  commit work
end
;



create procedure dba.DeleteCostAccount(
in In_CostAccountId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostAccount where CostAccount.CostAccountId = In_CostAccountId) then
    if not exists(select* from GLCode where GLCode.CostAccountId = In_CostAccountId) then
      delete from CostAccount where CostAccount.CostAccountId = In_CostAccountId;
      commit work
    end if;
    if exists(select* from CostAccount where CostAccount.CostAccountId = In_CostAccountId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.DeleteCostCentre(
in In_CostCentreId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostCentre where CostCentre.CostCentreId = In_CostCentreId) then
    if not exists(select* from CostPeriodCostCentre where
        CostPeriodCostCentre.CostCentreId = In_CostCentreId) then
      if not exists(select* from MapCostCentre_mm where
          MapCostCentre_mm.CostCentreId = In_CostCentreId) then
        if not exists(select* from EmployeeCostCentre where
            EmployeeCostCentre.CostCentreId = In_CostCentreId) then
          if not exists(select* from CostItemRule where
              CostItemRule.CostCentreId = In_CostCentreId) then
            if not exists(select* from CostRecord where
                CostRecord.CostCentreId = In_CostCentreId) then
              delete from CostCentre where CostCentre.CostCentreId = In_CostCentreId;
              commit work
            end if
          end if
        end if
      end if
    end if;
    if exists(select* from CostCentre where CostCentre.CostCentreId = In_CostCentreId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.DeleteCostComponent(
in In_CostComponentId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostComponent where CostComponent.CostComponentId = In_CostComponentId) then
    if not exists(select* from CostItemComponent where CostItemComponent.CostComponentID = In_CostComponentId) then
      delete from CostComponent where
        CostComponent.CostComponentId = In_CostComponentId;
      commit work
    end if;
    if exists(select* from CostComponent where CostComponent.CostComponentId = In_CostComponentId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteCostCond(
in In_CostCondId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostCond where CostCond.CostCondId = In_CostCondId) then
    if not exists(select* from CostCond_mm where CostCond_mm.CostCondId = In_CostCondId) then
      if exists(select* from CostCondValue where CostCondValue.CostCondId = In_CostCondId) then
        delete from CostCondValue where CostCondValue.CostCondId = In_CostCondId;
        commit work
      end if;
      delete from CostCond where CostCond.CostCondId = In_CostCondId;
      commit work
    end if;
    if exists(select* from CostCond where CostCond.CostCondId = In_CostCondId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.DeleteCostGroup(
in In_CostGroupId char(20),
out ErrorCode integer)
begin
  if exists(select* from CostGroup where
      CostGroupId = In_CostGroupId) then
    if exists(select* from CostingDetails where CostGroupId = In_CostGroupId) then set ErrorCode=-1;
      return
    end if;
    delete from CostGroupPeriod where
      CostGroupId = In_CostGroupId;
    commit work;
    delete from CostGroup where
      CostGroupId = In_CostGroupId;
    commit work;
    set ErrorCode=1
  end if
end
;


create procedure dba.DeleteCostingDetails(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  else
    // deleting CostProgression
    for CostProgressionFor as Cur_CostProgSysId dynamic scroll cursor for
      select CostProgSysId from
        CostProgression where
        CostProgression.EmployeeSysId = In_EmployeeSysId do
      call DeleteCostProgression(CostProgSysId) end for;
    // deleting CostPeriod
    for CostPeriodFor as Cur_CostPeriodSysId dynamic scroll cursor for
      select CostPeriod.CostPeriodSysId,CostSubPeriod from
        CostPeriod join CostSubPeriod where
        EmployeeSysId = In_EmployeeSysId order by
        CostPeriod.CostPeriodSysId asc,CostSubPeriod asc do
      call ASQLDeleteCostSubPeriod(CostPeriodSysId,CostSubPeriod) end for;
    delete from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  if exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteCostPeriod(
in In_CostPeriodSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostPeriod where CostPeriod.CostPeriodSysId = In_CostPeriodSysId) then
    set Out_ErrorCode=-1; // CostPeriodSysId not exist
    return
  else
    for CostSubPeriodFor as Cur_CostSubPeriod dynamic scroll cursor for
      select CostSubPeriod from
        CostSubPeriod where
        CostSubPeriod.CostPeriodSysId = In_CostPeriodSysId do
      call ASQLDeleteCostSubPeriod(In_CostPeriodSysId,CostSubPeriod) end for
  end if;
  if exists(select* from CostPeriod where CostPeriod.CostPeriodSysId = In_CostPeriodSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteCostProgression(
in In_CostProgSysId char(20),
out ErrorCode integer)
begin
  if exists(select* from CostProgression where
      CostProgSysId = In_CostProgSysId) then
    delete from EmployeeCostCentre where
      CostProgSysId = In_CostProgSysId;
    commit work;
    delete from CostProgression where
      CostProgSysId = In_CostProgSysId;
    commit work;
    set ErrorCode=1
  end if
end
;


create procedure dba.DeleteExchangeRate(
in In_ExchangeRateId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId) then
    set Out_ErrorCode=-1; // ExchangeRateId not exist
    return
  else if DeleteDefault('ExchangeRateId',In_ExchangeRateId) = 0 then
      set Out_ErrorCode=0; // System error
      return
    else
      delete from ExchangeRateProg where ExchangeRateProg.ExchangeRateId = In_ExchangeRateId;
      delete from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId;
      commit work
    end if
  end if;
  if exists(select* from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.DeleteGLCode(
in In_GLCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from GLCode where GLCode.GLCode = In_GLCode) then
    if not exists(select* from CostRecord where
        CostRecord.GLCode = In_GLCode) then
      if not exists(select* from CostItemRule where
          CostItemRule.GLCode = In_GLCode) then
        if not exists(select* from CostCreditDebit where
            CostCreditDebit.GLCode = In_GLCode) then
          delete from GLCode where GLCode.GLCode = In_GLCode;
          commit work
        end if
      end if
    end if;
    if exists(select* from GLCode where GLCode.GLCode = In_GLCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteMapCostCentre(
in In_MapCostCentreSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapCostCentre where MapCostCentre.MapCostCentreSysId = In_MapCostCentreSysId) then
    if exists(select* from MapCostCentre_mm where MapCostCentre_mm.MapCostCentreSysId = In_MapCostCentreSysId) then
      delete from MapCostCentre_mm where MapCostCentre_mm.MapCostCentreSysId = In_MapCostCentreSysId;
      commit work
    end if;
    delete from MapCostCentre where MapCostCentre.MapCostCentreSysId = In_MapCostCentreSysId;
    commit work;
    if exists(select* from MapCostCentre where MapCostCentre.MapCostCentreSysId = In_MapCostCentreSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create function dba.FGetCostKeyWordUserDefinedName(
in In_CostKeywordId char(20))
returns char(100)
begin
  declare Out_CostKeywordUserDefinedName char(100);
  select CostKeywordUserDefinedName into Out_CostKeywordUserDefinedName from CostKeyword where
    CostKeyWordId = In_CostKeywordId;
  if(Out_CostKeywordUserDefinedName is null or Out_CostKeywordUserDefinedName = '') then
    return(In_CostKeywordId)
  else return(Out_CostKeywordUserDefinedName)
  end if
end
;



create procedure dba.InsertNewCostAccount(
in In_CostAccountId char(20),
in In_CostAccountDesc char(100),
in In_CostConsolidateRpt integer,
in In_CostAccountHistory integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostAccount where CostAccount.CostAccountId = In_CostAccountId) then
    insert into CostAccount(CostAccountId,CostAccountDesc,CostConsolidateRpt,CostAccountHistory) values(
      In_CostAccountId,In_CostAccountDesc,In_CostConsolidateRpt,In_CostAccountHistory);
    commit work;
    if not exists(select* from CostAccount where CostAccount.CostAccountId = In_CostAccountId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewCostCentre(
in In_CostCentreId char(20),
in In_CostCentreDesc char(100),
in In_CostCentreCode1Id char(20),
in In_CostCentreCode2Id char(20),
in In_CostCentreCode3Id char(20),
in In_CostCentreCode4Id char(20),
in In_CostCentreCode5Id char(20),
in In_CostCentreRemarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from CostCentre where CostCentre.CostCentreId = In_CostCentreId) then
    insert into CostCentre(CostCentreId,
      CostCentreDesc,
      CostCentreCode1Id,
      CostCentreCode2Id,
      CostCentreCode3Id,
      CostCentreCode4Id,
      CostCentreCode5Id,
      CostCentreRemarks) values(
      In_CostCentreId,
      In_CostCentreDesc,
      In_CostCentreCode1Id,
      In_CostCentreCode2Id,
      In_CostCentreCode3Id,
      In_CostCentreCode4Id,
      In_CostCentreCode5Id,
      In_CostCentreRemarks);
    commit work;
    if not exists(select* from CostCentre where CostCentre.CostCentreId = In_CostCentreId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewCostComponent(
in In_CostComponentId char(20),
in In_CostComponentDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from CostComponent where CostComponent.CostComponentId = In_CostComponentId) then
    insert into CostComponent(CostComponentId,CostComponentDesc) values(In_CostComponentId,In_CostComponentDesc);
    commit work;
    if not exists(select* from CostComponent where CostComponent.CostComponentId = In_CostComponentId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewCostCond(
in In_CostCondId char(20),
in In_CostCondDesc char(100),
in In_CostCondBasis char(20),
in In_CostCondNotCond integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostCond where CostCondId = In_CostCondId) then
    insert into CostCond(CostCondId,
      CostCondDesc,
      CostCondBasis,
      CostCondNotCond) values(
      In_CostCondId,
      In_CostCondDesc,
      In_CostCondBasis,
      In_CostCondNotCond);
    commit work;
    if not exists(select* from CostCond where CostCondId = In_CostCondId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.InsertNewCostGroup(
in In_CostGroupId char(20),
in In_CostGroupDesc char(100),
in In_MapPayGroupPeriod integer,
in In_MapPayGroupYear char(20),
in In_NoSubPeriod integer,
in In_Period1StartMonth integer,
in In_CostExchangeRateId char(20),
in In_SubPeriod1EndDate char(20),
in In_SubPeriod2EndDate char(20),
in In_SubPeriod3EndDate char(20),
out Out_Code integer)
begin
  if In_CostGroupId is null then set Out_Code=-1;
    return
  end if;
  if In_MapPayGroupPeriod is null then set Out_Code=-2;
    return
  end if;
  if In_MapPayGroupPeriod = 0 then set Out_Code=-3;
    return
  end if;
  if In_MapPayGroupYear = '' then set Out_Code=-4;
    return
  end if;
  if In_NoSubPeriod is null then set Out_Code=-5;
    return
  end if;
  if In_NoSubPeriod = 0 then set Out_Code=-6;
    return
  end if;
  if In_Period1StartMonth is null then set Out_Code=-7;
    return
  end if;
  if In_Period1StartMonth = 0 then set Out_Code=-8;
    return
  end if;
  if not exists(select* from CostGroup where CostGroupId = In_CostGroupId) then
    insert into CostGroup(CostGroupId,
      CostGroupDesc,
      MapPayGroupPeriod,
      MapPayGroupYear,
      NoSubPeriod,
      Period1StartMonth,
      CostExchangeRateId,
      SubPeriod1EndDate,
      SubPeriod2EndDate,
      SubPeriod3EndDate) values(
      In_CostGroupId,
      In_CostGroupDesc,
      In_MapPayGroupPeriod,
      In_MapPayGroupYear,
      In_NoSubPeriod,
      In_Period1StartMonth,
      In_CostExchangeRateId,
      In_SubPeriod1EndDate,
      In_SubPeriod2EndDate,
      In_SubPeriod3EndDate);
    commit work;
    set Out_Code=1
  else
    set Out_Code=-9;
    return
  end if
end
;


create procedure dba.InsertNewCostingDetails(
in In_EmployeeSysId integer,
in In_CostGroupId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // EmployeeSysId exists
    return
  else
    insert into CostingDetails(EmployeeSysId,CostGroupId) values(
      In_EmployeeSysId,In_CostGroupId);
    commit work
  end if;
  if not exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.InsertNewCostProgression(
in In_EmployeeSysId integer,
in In_CostProgEffectiveDate date,
in In_CostCareerId char(20),
in In_CostCentreCurrent integer,
in In_CostCentreProgDesc char(100),
out Out_Code integer)
begin
  declare MaxSysId integer;
  if exists(select* from CostProgression) then
    select max(CostProgSysId) into MaxSysId from CostProgression;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  if In_EmployeeSysId is null then set Out_Code=-1;
    return
  end if;
  if not exists(select* from CostProgression where EmployeeSysId = In_EmployeeSysId and
      CostProgEffectiveDate = In_CostProgEffectiveDate) then
    if not exists(select* from CostProgression where CostCentreCurrent = 1 and EmployeeSysId = In_EmployeeSysId) then
      set In_CostCentreCurrent=1
    end if;
    if In_CostCentreCurrent = 1 then
      update CostProgression set CostCentreCurrent = 0 where CostCentreCurrent = 1 and EmployeeSysId = In_EmployeeSysId;
      commit work
    end if;
    insert into CostProgression(CostProgSysId,
      EmployeeSysId,
      CostProgEffectiveDate,
      CostCareerId,
      CostCentreCurrent,
      CostCentreProgDesc) values(
      Out_Code,
      In_EmployeeSysId,
      In_CostProgEffectiveDate,
      In_CostCareerId,
      In_CostCentreCurrent,
      In_CostCentreProgDesc);
    commit work
  else
    set Out_Code=-3;
    return
  end if
end
;



create procedure dba.InsertNewExchangeRate(
in In_ExchangeRateId char(20),
in In_LocalCountryId char(20),
in In_ForeignCountryId char(20),
in In_ExchangeRateDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId) then
    set Out_ErrorCode=-1; // ExchangeRateId exists 
    return
  else
    insert into ExchangeRate(ExchangeRateId,LocalCountryId,ForeignCountryId,ExchangeRateDesc) values(
      In_ExchangeRateId,In_LocalCountryId,In_ForeignCountryId,In_ExchangeRateDesc);
    commit work
  end if;
  if not exists(select* from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.InsertNewGLCode(
in In_GLCode char(20),
in In_CostAccountId char(20),
in In_GLCodeDesc char(100),
in In_GLCodeHistory integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from GLCode where GLCode = In_GLCode) then
    insert into GLCode(GLCode,
      CostAccountId,
      GLCodeDesc,
      GLCodeHistory) values(
      In_GLCode,
      In_CostAccountId,
      In_GLCodeDesc,
      In_GLCodeHistory);
    commit work;
    if not exists(select* from GLCode where GLCode = In_GLCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.InsertNewMapCostCentre(
in In_CostCentreBasis1 char(20),
in In_CostCentreBasis2 char(20),
in In_CostCentreBasis3 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MapCostCentre where CostCentreBasis1 = In_CostCentreBasis1 and
      CostCentreBasis2 = In_CostCentreBasis2 and
      CostCentreBasis3 = In_CostCentreBasis3) then
    insert into MapCostCentre(CostCentreBasis1,
      CostCentreBasis2,
      CostCentreBasis3) values(
      In_CostCentreBasis1,
      In_CostCentreBasis2,
      In_CostCentreBasis3);
    commit work;
    if not exists(select* from MapCostCentre where CostCentreBasis1 = In_CostCentreBasis1 and
        CostCentreBasis2 = In_CostCentreBasis2 and
        CostCentreBasis3 = In_CostCentreBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateCostAccount(
in In_CostAccountId char(20),
in In_CostAccountDesc char(100),
in In_CostConsolidateRpt integer,
in In_CostAccountHistory integer,
out Out_ErrorCode integer)
begin
  if exists(select* from CostAccount where CostAccountId = In_CostAccountId) then
    update CostAccount set
      CostAccountDesc = In_CostAccountDesc,
      CostConsolidateRpt = In_CostConsolidateRpt,
      CostAccountHistory = In_CostAccountHistory where
      CostAccountId = In_CostAccountId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateCostCentre(
in In_CostCentreId char(20),
in In_CostCentreDesc char(100),
in In_CostCentreCode1Id char(20),
in In_CostCentreCode2Id char(20),
in In_CostCentreCode3Id char(20),
in In_CostCentreCode4Id char(20),
in In_CostCentreCode5Id char(20),
in In_CostCentreRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from CostCentre where CostCentreId = In_CostCentreId) then
    update CostCentre set
      CostCentreDesc = In_CostCentreDesc,
      CostCentreCode1Id = In_CostCentreCode1Id,
      CostCentreCode2Id = In_CostCentreCode2Id,
      CostCentreCode3Id = In_CostCentreCode3Id,
      CostCentreCode4Id = In_CostCentreCode4Id,
      CostCentreCode5Id = In_CostCentreCode5Id,
      CostCentreRemarks = In_CostCentreRemarks where
      CostCentreId = In_CostCentreId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateCostComponent(
in In_CostComponentId char(20),
in In_CostComponentDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from CostComponent where CostComponentId = In_CostComponentId) then
    update CostComponent set
      CostComponentDesc = In_CostComponentDesc where
      CostComponentId = In_CostComponentId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateCostCond(
in In_CostCondId char(20),
in In_CostCondDesc char(100),
in In_CostCondBasis char(20),
in In_CostCondNotCond integer,
out Out_ErrorCode integer)
begin
  if exists(select* from CostCond where CostCondId = In_CostCondId) then
    update CostCond set
      CostCondDesc = In_CostCondDesc,
      CostCondBasis = In_CostCondBasis,
      CostCondNotCond = In_CostCondNotCond where
      CostCondId = In_CostCondId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateCostGroup(
in In_CostGroupId char(20),
in In_CostGroupDesc char(100),
in In_MapPayGroupPeriod integer,
in In_MapPayGroupYear char(20),
in In_NoSubPeriod integer,
in In_Period1StartMonth integer,
in In_CostExchangeRateId char(20),
in In_SubPeriod1EndDate char(20),
in In_SubPeriod2EndDate char(20),
in In_SubPeriod3EndDate char(20),
out Out_Code integer)
begin
  if In_CostGroupId is null then set Out_Code=-1;
    return
  end if;
  if In_MapPayGroupPeriod is null then set Out_Code=-2;
    return
  end if;
  if In_MapPayGroupPeriod = 0 then set Out_Code=-3;
    return
  end if;
  if In_MapPayGroupYear = '' then set Out_Code=-4;
    return
  end if;
  if In_NoSubPeriod is null then set Out_Code=-5;
    return
  end if;
  if In_NoSubPeriod = 0 then set Out_Code=-6;
    return
  end if;
  if In_Period1StartMonth is null then set Out_Code=-7;
    return
  end if;
  if In_Period1StartMonth = 0 then set Out_Code=-8;
    return
  end if;
  if exists(select* from CostGroup where CostGroupId = In_CostGroupId) then
    update CostGroup set
      CostGroupDesc = In_CostGroupDesc,
      MapPayGroupPeriod = In_MapPayGroupPeriod,
      MapPayGroupYear = In_MapPayGroupYear,
      NoSubPeriod = In_NoSubPeriod,
      Period1StartMonth = In_Period1StartMonth,
      CostExchangeRateId = In_CostExchangeRateId,
      SubPeriod1EndDate = In_SubPeriod1EndDate,
      SubPeriod2EndDate = In_SubPeriod2EndDate,
      SubPeriod3EndDate = In_SubPeriod3EndDate where CostGroupId = In_CostGroupId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-9;
    return
  end if
end
;



create procedure dba.UpdateCostingDetails(
in In_EmployeeSysId integer,
in In_CostGroupId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  else
    update CostingDetails set
      CostingDetails.CostGroupId = In_CostGroupId where
      CostingDetails.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;



create procedure dba.UpdateCostProgression(
in In_CostProgSysId integer,
in In_EmployeeSysId integer,
in In_CostProgEffectiveDate date,
in In_CostCareerId char(20),
in In_CostCentreCurrent integer,
in In_CostCentreProgDesc char(100),
out Out_Code integer)
begin
  if In_CostProgSysId is null then set Out_Code=-1;
    return
  end if;
  if In_EmployeeSysId is null then set Out_Code=-2;
    return
  end if;
  if exists(select* from CostProgression where CostProgSysId <> In_CostProgSysId and EmployeeSysId = In_EmployeeSysId and CostProgEffectiveDate = In_CostProgEffectiveDate) then
    set Out_Code=-3;
    return
  end if;
  if exists(select* from CostProgression where CostProgSysId = In_CostProgSysId) then
    if In_CostCentreCurrent = 1 then
      update CostProgression set CostCentreCurrent = 0 where CostCentreCurrent = 1 and EmployeeSysId = In_EmployeeSysId;
      commit work
    end if;
    update CostProgression set
      EmployeeSysId = In_EmployeeSysId,
      CostProgEffectiveDate = In_CostProgEffectiveDate,
      CostCareerId = In_CostCareerId,
      CostCentreCurrent = In_CostCentreCurrent,
      CostCentreProgDesc = In_CostCentreProgDesc where CostProgSysId = In_CostProgSysId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-4;
    return
  end if
end
;



create procedure dba.UpdateExchangeRate(
in In_ExchangeRateId char(20),
in In_LocalCountryId char(20),
in In_ForeignCountryId char(20),
in In_ExchangeRateDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId) then
    set Out_ErrorCode=1; // ExchangeRateId not exist 
    return
  else
    update ExchangeRate set
      ExchangeRate.LocalCountryId = In_LocalCountryId,
      ExchangeRate.ForeignCountryId = In_ForeignCountryId,
      ExchangeRate.ExchangeRateDesc = In_ExchangeRateDesc where
      ExchangeRate.ExchangeRateId = In_ExchangeRateId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;



create procedure dba.UpdateGLCode(
in In_GLCode char(20),
in In_CostAccountId char(20),
in In_GLCodeDesc char(100),
in In_GLCodeHistory integer,
out Out_ErrorCode integer)
begin
  if In_CostAccountId is null then set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from GLCode where GLCode = In_GLCode) then
    update GLCode set
      CostAccountId = In_CostAccountId,
      GLCodeDesc = In_GLCodeDesc,
      GLCodeHistory = In_GLCodeHistory where
      GLCode = In_GLCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdateMapCostCentre(
in In_MapCostCentreSysId integer,
in In_CostCentreBasis1 char(20),
in In_CostCentreBasis2 char(20),
in In_CostCentreBasis3 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MapCostCentre where MapCostCentreSysId = In_MapCostCentreSysId) then
    update MapCostCentre set
      CostCentreBasis1 = In_CostCentreBasis1,
      CostCentreBasis2 = In_CostCentreBasis2,
      CostCentreBasis3 = In_CostCentreBasis3 where
      MapCostCentreSysId = In_MapCostCentreSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.ASQLGetEmpCurrentCostRecord(
in In_EmployeeSysId integer,
out Out_CurrentNoSubPeriod integer,
out Out_CurrentYear integer,
out Out_CurrentPeriod integer,
out Out_CurrentSubPeriod integer,
out Out_Flag integer,
out Out_CurrentGroupId char(20))
begin
  select CostGroupId into Out_CurrentGroupId from CostingDetails where EmployeeSysId = In_EmployeeSysId;
  if Out_CurrentGroupId is null then
	 set Out_Flag=-1;
	 return
  else
    if not exists(select* from CostGroupPeriod where CostGroupId = Out_CurrentGroupId) then
      set Out_Flag=-2;
      return
    else
      set Out_Flag=1;
      select NoSubPeriod into Out_CurrentNoSubPeriod from CostGroup where CostGroupId = Out_CurrentGroupId;
      select max(CostGroupYear) into Out_CurrentYear from CostGroupPeriod where CostGroupId = Out_CurrentGroupId;
      select max(CostGroupPeriod) into Out_CurrentPeriod from CostGroupPeriod where CostGroupId = Out_CurrentGroupId and CostGroupYear = Out_CurrentYear;
      select max(CostGroupSubPeriod) into Out_CurrentSubPeriod from CostGroupPeriod where CostGroupId = Out_CurrentGroupId and CostGroupYear = Out_CurrentYear and CostGroupPeriod = Out_CurrentPeriod
    end if
  end if
end
;



create procedure dba.ASQLGetEmpTargetCostRecord(
in In_TargetCostGroupId char(20),
out Out_TargetNoSubPeriod integer,
out Out_TargetYear integer,
out Out_TargetPeriod integer,
out Out_TargetSubPeriod integer,
out Out_Flag integer)
begin
  if not exists(select* from CostGroupPeriod where CostGroupId = In_TargetCostGroupId) then
	 set Out_Flag=-1;
    return
  else
    set Out_Flag=1;
    select NoSubPeriod into Out_TargetNoSubPeriod from CostGroup where CostGroupId = In_TargetCostGroupId;
    select max(CostGroupYear) into Out_TargetYear from CostGroupPeriod where CostGroupId = In_TargetCostGroupId;
    select max(CostGroupPeriod) into Out_TargetPeriod from CostGroupPeriod where CostGroupId = In_TargetCostGroupId and CostGroupYear = Out_TargetYear;
    select max(CostGroupSubPeriod) into Out_TargetSubPeriod from CostGroupPeriod where CostGroupId = In_TargetCostGroupId and CostGroupYear = Out_TargetYear and CostGroupPeriod = Out_TargetPeriod
  end if
end
;



create procedure DBA.ASQLProcessEmployeeCostCentre(
in In_CostProgSysId integer,
in In_MapCostCentreSysId integer)
begin
  /* Clears the EmployeeCostCentre Table first */
  delete from EmployeeCostCentre where EmployeeCostCentre.CostProgSysId = In_CostProgSysId;
  /* Inserts the EmployeeCostCentre one by one */
  CostCentreIdLoop: for CostCentreIdForLoop as Cur_CostCentreId dynamic scroll cursor for
	 select MapCostCentre_mm.CostCentreId as New_CostCentreId,
      MapCostCentre_mm.CostAllocType as New_CostAllocType,
      MapCostCentre_mm.CostAllocValue as New_CostAllocValue,MapCostCentre_mm.KeyCostCentre as New_KeyCostCentre from MapCostCentre_mm where
      MapCostCentre_mm.MapCostCentreSysId = In_MapCostCentreSysId do
    insert into EmployeeCostCentre(CostProgSysId,CostCentreId,CostAllocType,CostAllocValue,KeyCostCentre) values(
      In_CostProgSysId,New_CostCentreId,New_CostAllocType,New_CostAllocValue,New_KeyCostCentre);
    commit work end for
end
;



create function DBA.FGetCostRecordSum(
in In_EmployeeSysId integer,
in In_CostCentreId char(20),
in In_GLCode char(20),
in In_CostItemId char(20),
in In_CostYear integer,
in In_CostPeriod integer,
in In_Currency char(20),
in In_CostGroup char(20))
returns double
begin
  declare TotalSum double;
  set TotalSum=0;
  if In_Currency = 'Local' then
    if In_CostGroup = 'All' then
      SumLoop1: for DefSumLoop as Cur_DefaultSumLoop dynamic scroll cursor for
        select CostCreditAmt as CCAm,
          CostDebitAmt as CDAm,
          CostCreditAdj as CCAj,
          CostDebitAdj as CDAj from CostRecord join CostPeriod on(CostPeriod.CostPeriodSysId = CostRecord.CostPeriodSysId) where
          CostCentreId = In_CostCentreId and GLCode = In_GLCode and CostItemId = In_CostItemId and
          CostYear = In_CostYear and CostPeriod = In_CostPeriod and CostPeriod.EmployeeSysId = In_EmployeeSysId do
        set TotalSum=TotalSum+CDAm-CCAm;
        set TotalSum=TotalSum+CDAj-CCAj;
        commit work end for
    else
      SumLoop2: for DefSumLoop2 as Cur_DefaultSumLoop2 dynamic scroll cursor for
        select CostCreditAmt as CCAm,
          CostDebitAmt as CDAm,
          CostCreditAdj as CCAj,
          CostDebitAdj as CDAj from CostRecord join CostPeriod on(CostPeriod.CostPeriodSysId = CostRecord.CostPeriodSysId) where
          CostCentreId = In_CostCentreId and GLCode = In_GLCode and CostItemId = In_CostItemId and
          CostYear = In_CostYear and CostPeriod = In_CostPeriod and
          CostPeriod.EmployeeSysId = any(select EmployeeSysId from CostingDetails where CostGroupId = In_CostGroup) and
          CostPeriod.EmployeeSysId = In_EmployeeSysId do
        set TotalSum=TotalSum+CDAm-CCAm;
        set TotalSum=TotalSum+CDAj-CCAj;
        commit work end for
    end if
  else
    if In_CostGroup = 'All' then
      SumLoop2: for DefSumLoop3 as Cur_DefaultSumLoop3 dynamic scroll cursor for
        select CostCreditForeignAmt as CF,
          CostDebitForeignAmt as DF from
          CostRecord join CostPeriod on(CostPeriod.CostPeriodSysId = CostRecord.CostPeriodSysId) where
          CostCentreId = In_CostCentreId and GLCode = In_GLCode and CostItemId = In_CostItemId and
          CostYear = In_CostYear and CostPeriod = In_CostPeriod and CostPeriod.EmployeeSysId = In_EmployeeSysId do
        set TotalSum=TotalSum+DF-CF;
        commit work end for
    else
      SumLoop4: for DefSumLoop4 as Cur_DefaultSumLoop4 dynamic scroll cursor for
        select CostCreditForeignAmt as CF,
          CostDebitForeignAmt as DF from
          CostRecord join CostPeriod on(CostPeriod.CostPeriodSysId = CostRecord.CostPeriodSysId) where
          CostCentreId = In_CostCentreId and GLCode = In_GLCode and CostItemId = In_CostItemId and
          CostYear = In_CostYear and CostPeriod = In_CostPeriod and
          CostPeriod.EmployeeSysId = any(select EmployeeSysId from CostingDetails where CostGroupId = In_CostGroup) and
          CostPeriod.EmployeeSysId = In_EmployeeSysId do
        set TotalSum=TotalSum+DF-CF;
        commit work end for
    end if
  end if;
  return TotalSum
end
;



create function DBA.FGetNetAmt(
in In_GrossDrAmt double,
in In_GrossCrAmt double,
in In_DrFlag smallint)
returns double
begin
  declare Out_NetAmt double;
  set Out_NetAmt=In_GrossDrAmt-In_GrossCrAmt;
  if((Out_NetAmt > 0) and(In_DrFlag = 0)) or
    ((Out_NetAmt < 0) and(In_DrFlag = 1)) then
    set Out_NetAmt=0
  end if;
  return abs(Out_NetAmt)
end
;


create function DBA.IsCostHasPayRecord(
in In_EmployeeSysId integer,
in In_CostYear integer,
in In_CostPeriod integer,
in In_CostSubPeriod integer)
returns smallint
begin
  declare Out_MapPayGroupYear char(20);
  declare Out_MapPayGroupPeriod integer;
  declare Out_PayRecYear integer;
  declare Out_PayRecPeriod integer;
  declare Out_CostGroupId char(20);
  /*
  Get Cost Group Information
  */
  select CostGroupId into Out_CostGroupId from CostingDetails where EmployeeSysId = In_EmployeeSysId;
  select MapPayGroupYear,MapPayGroupPeriod into Out_MapPayGroupYear,
    Out_MapPayGroupPeriod from CostGroup where CostGroupId = Out_CostGroupId;
  /*
  Set Year
  */
  case Out_MapPayGroupYear when 'CurrentYr' then
    set Out_PayRecYear=In_CostYear when 'PreviousYr' then
    set Out_PayRecYear=In_CostYear-1 when 'FollowingYr' then
    set Out_PayRecYear=In_CostYear+1
  end case
  ;
  /*
  Check exceed Period 12
  */
  set Out_PayRecPeriod=Out_MapPayGroupPeriod+In_CostPeriod-1;
  if(Out_PayRecPeriod > 12) then
    set Out_PayRecYear=Out_PayRecYear+1;
    set Out_PayRecPeriod=Out_PayRecPeriod-12
  end if;
  /*
  Check record exists
  */
  if exists(select* from PayRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = Out_PayRecYear and PayRecPeriod = Out_PayRecPeriod and
      PayRecSubPeriod = In_CostSubPeriod) then return 1
  end if;
  return 0
end
;

create function dba.FGetCostCentreValueInPeriod(
in In_EmployeeSysId integer,
in In_CostCentreId char(20),
in In_Year integer,
in In_Period integer)
returns double
begin
  declare RValue double;
  if exists(select* from CostPeriodCostCentre join CostPeriod where EmployeeSysId = In_EmployeeSysId and
      CostCentreId = In_CostCentreId and CostYear = In_Year and CostPeriod = In_Period) then
    select CostAllocValue into RValue from CostPeriodCostCentre join CostPeriod where EmployeeSysId = In_EmployeeSysId and
      CostCentreId = In_CostCentreId and CostYear = In_Year and CostPeriod = In_Period
  else
    set RValue=0
  end if;
  return RValue
end
;

create function DBA.FGetEmployeeKeyCostCentre(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_CostCentreId char(20);
  select EmployeeCostCentre.CostCentreId into Out_CostCentreId
    from EmployeeCostCentre join CostProgression on
    EmployeeCostCentre.CostProgSysId = CostProgression.CostProgSysId where
    CostProgression.EmployeeSysId = In_EmployeeSysId and KeyCostCentre = 1 and
    CostProgression.CostProgEffectiveDate = (select max(CostProgEffectiveDate) from
      CostProgression where CostProgression.EmployeeSysId = In_EmployeeSysId);
  return(Out_CostCentreId)
end
;

create function DBA.FGetEmployeeCostGroup(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_CostGroupId char(20);
  select CostingDetails.CostGroupId into Out_CostGroupId
    from CostingDetails where
    CostingDetails.EmployeeSysId = In_EmployeeSysId;
  return(Out_CostGroupId)
end
;

create procedure dba.InsertNewCostRecord(
in In_CostPeriodSysId integer,
in In_CostSubPeriod integer,
in In_CostCentreId char(20),
in In_GLCode char(20),
in In_CostComponentId char(20),
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostCreditAmt double,
in In_CostDebitAmt double,
in In_CostCreditAdj double,
in In_CostDebitAdj double,
in In_CostCreditForeignAmt double,
in In_CostDebitForeignAmt double,
in In_CostAllocType char(20),
in In_CostAllocValue double,
in In_CostCreditBfAvg double,
in In_CostDebitBfAvg double,
in In_CostCreditForeignBfAvg double,
in In_CostDebitForeignBfAvg double,
in In_CreatedBy char(1),
out Out_ErrorCode integer)
begin
  /*
  Check for posting to same GL and Cost Centre for the same Item
  */
  if exists(select* from CostRecord where
      CostPeriodSysId = In_CostPeriodSysId and
      CostSubPeriod = In_CostSubPeriod and
      CostCentreId = In_CostCentreId and
      GLCode = In_GLCode and
      CostItemId = In_CostItemId and
      CostItemType = In_CostItemType) then
    set Out_ErrorCode=-1;
    return
  end if;
  /*
  Check for duplicated record
  */
  if not exists(select* from CostRecord where
      CostPeriodSysId = In_CostPeriodSysId and
      CostSubPeriod = In_CostSubPeriod and
      CostCentreId = In_CostCentreId and
      GLCode = In_GLCode and
      CostItemId = In_CostItemId and
      CostItemType = In_CostItemType and
      CostComponentId = In_CostComponentId) then
    insert into CostRecord(CostPeriodSysId,
      CostSubPeriod,
      CostCentreId,
      GLCode,
      CostComponentId,
      CostItemId,
      CostItemType,
      CostCreditAmt,
      CostDebitAmt,
      CostCreditAdj,
      CostDebitAdj,
      CostCreditForeignAmt,
      CostDebitForeignAmt,
      CostAllocType,
      CostAllocValue,
      CostCreditBfAvg,
      CostDebitBfAvg,
      CostCreditForeignBfAvg,
      CostDebitForeignBfAvg,
      CreatedBy) values(
      In_CostPeriodSysId,
      In_CostSubPeriod,
      In_CostCentreId,
      In_GLCode,
      In_CostComponentId,
      In_CostItemId,
      In_CostItemType,
      In_CostCreditAmt,
      In_CostDebitAmt,
      In_CostCreditAdj,
      In_CostDebitAdj,
      In_CostCreditForeignAmt,
      In_CostDebitForeignAmt,
      In_CostAllocType,
      In_CostAllocValue,
      In_CostCreditBfAvg,
      In_CostDebitBfAvg,
      In_CostCreditForeignBfAvg,
      In_CostDebitForeignBfAvg,
      In_CreatedBy);
    commit work;
    if exists(select* from CostRecord where
        CostPeriodSysId = In_CostPeriodSysId and
        CostSubPeriod = In_CostSubPeriod and
        CostCentreId = In_CostCentreId and
        GLCode = In_GLCode and
        CostItemId = In_CostItemId and
        CostItemType = In_CostItemType and
        CostComponentId = In_CostComponentId) then
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateCostRecord(
in In_CostRecordSysId integer,
in In_CostPeriodSysId integer,
in In_CostSubPeriod integer,
in In_CostCentreId char(20),
in In_GLCode char(20),
in In_CostComponentId char(20),
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostCreditAmt double,
in In_CostDebitAmt double,
in In_CostCreditAdj double,
in In_CostDebitAdj double,
in In_CostCreditForeignAmt double,
in In_CostDebitForeignAmt double,
in In_CostAllocType char(20),
in In_CostAllocValue double,
in In_CostCreditBfAvg double,
in In_CostDebitBfAvg double,
in In_CostCreditForeignBfAvg double,
in In_CostDebitForeignBfAvg double,
in In_CreatedBy char(1),
out Out_Error integer)
begin
  if exists(select* from CostRecord where
      CostRecordSysId = In_CostRecordSysId) then
    update CostRecord set
      CostPeriodSysId = In_CostPeriodSysId,
      CostSubPeriod = In_CostSubPeriod,
      CostCentreId = In_CostCentreId,
      GLCode = In_GLCode,
      CostComponentId = In_CostComponentId,
      CostItemId = In_CostItemId,
      CostItemType = In_CostItemType,
      CostCreditAmt = In_CostCreditAmt,
      CostDebitAmt = In_CostDebitAmt,
      CostCreditAdj = In_CostCreditAdj,
      CostDebitAdj = In_CostDebitAdj,
      CostCreditForeignAmt = In_CostCreditForeignAmt,
      CostDebitForeignAmt = In_CostDebitForeignAmt,
      CostAllocType = In_CostAllocType,
      CostAllocValue = In_CostAllocValue,
      CostCreditBfAvg = In_CostCreditBfAvg,
      CostDebitBfAvg = In_CostDebitBfAvg,
      CostCreditForeignBfAvg = In_CostCreditForeignBfAvg,
      CostDebitForeignBfAvg = In_CostDebitForeignBfAvg,
      CreatedBy = In_CreatedBy where
      CostRecordSysId = In_CostRecordSysId;
    commit work;
    set Out_Error=1
  else
    set Out_Error=0
  end if
end
;

create function dba.FGetCostAccountId(
in In_GLCode char(20))
returns char(20)
begin
  declare Out_CostAccountId char(20);
  select CostAccountId into Out_CostAccountId from GLCode where
    GLCode = In_GLCode;
  return(Out_CostAccountId)
end
;

create function DBA.FGetCostStartDate(
in In_CostGroupId char(20),
in In_Year integer,
in In_Period integer)
returns date
begin
  declare Out_StartDate date;
  select first CostDateFrom into Out_StartDate from
    CostGroupPeriod where
    CostGroupId = In_CostGroupId and
    CostGroupYear = In_Year and
    CostGroupPeriod = In_Period order by
    CostGroupSubPeriod asc;
  return Out_StartDate
end
;

create function dba.FGetGLCodeDesc(
in In_GLCode char(20))
returns char(100)
begin
  declare Out_GLCodeDesc char(100);
  select GLCodeDesc into Out_GLCodeDesc from GLCode where GLCode = In_GLCode;
  return(Out_GLCodeDesc)
end
;

create procedure dba.ASQLMapCostCentreIdDesc(
in In_CostCentreCode1Id char(20),
in In_CostCentreCode2Id char(20),
in In_CostCentreCode3Id char(20),
in In_CostCentreCode4Id char(20),
in In_CostCentreCode5Id char(20),
out Out_CostCentreId char(20),
out Out_CostCentreDesc char(100))
begin
  set Out_CostCentreId='';
  set Out_CostCentreDesc=''
end
;

create procedure dba.ASQLCostRecordCopy(
in In_CostRecordSysId integer,
in In_NewCostCentreId char(20),
in In_NewGLCode char(20),
out Out_ErrorCode integer)
begin
  declare In_CostPeriodSysId integer;
  declare In_CostSubPeriod integer;
  declare In_CostCentreId char(20);
  declare In_GLCode char(20);
  declare In_CostComponentId char(20);
  declare In_CostItemId char(20);
  declare In_CostItemType char(20);
  declare In_CostCreditAmt double;
  declare In_CostDebitAmt double;
  declare In_CostCreditAdj double;
  declare In_CostDebitAdj double;
  declare In_CostCreditForeignAmt double;
  declare In_CostDebitForeignAmt double;
  declare In_CostAllocType char(20);
  declare In_CostAllocValue double;
  declare In_CostCreditBfAvg double;
  declare In_CostDebitBfAvg double;
  declare In_CostCreditForeignBfAvg double;
  declare In_CostDebitForeignBfAvg double;
  declare In_CreatedBy char(1);
  set Out_ErrorCode=1;
  if exists(select* from CostRecord where CostRecordSysId = In_CostRecordSysId) then
    select CostPeriodSysId,CostSubPeriod,CostCentreId,GLCode,CostComponentId,CostItemId,
      CostItemType,CostCreditAmt,CostDebitAmt,CostCreditAdj,CostDebitAdj,CostCreditForeignAmt,
      CostDebitForeignAmt,CostAllocType,CostAllocValue,CostCreditBfAvg,CostDebitBfAvg,
      CostCreditForeignBfAvg,CostDebitForeignBfAvg,CreatedBy into In_CostPeriodSysId,
      In_CostSubPeriod,In_CostCentreId,In_GLCode,In_CostComponentId,In_CostItemId,In_CostItemType,In_CostCreditAmt,
      In_CostDebitAmt,In_CostCreditAdj,In_CostDebitAdj,In_CostCreditForeignAmt,
      In_CostDebitForeignAmt,In_CostAllocType,In_CostAllocValue,In_CostCreditBfAvg,
      In_CostDebitBfAvg,In_CostCreditForeignBfAvg,In_CostDebitForeignBfAvg,
      In_CreatedBy from CostRecord where CostRecordSysId = In_CostRecordSysId;
    if not(In_NewCostCentreId = '') then
      set In_CostCentreId=In_NewCostCentreId
    end if;
    if not(In_NewGLCode = '') then
      set In_GLCode=In_NewGLCode
    end if;
    call InsertNewCostRecord(In_CostPeriodSysId,In_CostSubPeriod,In_CostCentreId,In_GLCode,In_CostComponentId,
    In_CostItemId,In_CostItemType,In_CostCreditAmt,In_CostDebitAmt,In_CostCreditAdj,
    In_CostDebitAdj,In_CostCreditForeignAmt,In_CostDebitForeignAmt,In_CostAllocType,In_CostAllocValue,In_CostCreditBfAvg,
    In_CostDebitBfAvg,In_CostCreditForeignBfAvg,In_CostDebitForeignBfAvg,'U',Out_ErrorCode)
  end if
end
;

create procedure DBA.DeleteCCCode1(
in In_CCCode1Id char(20))
begin
  if exists(select* from CCCode1 where CCCode1.CostCentreCode1Id = In_CCCode1Id) then
    delete from CCCode1 where
      CCCode1.CostCentreCode1Id = In_CCCode1Id;
    commit work
  end if
end
;

create procedure DBA.DeleteCCCode2(
in In_CCCode2Id char(20))
begin
  if exists(select* from CCCode2 where CCCode2.CostCentreCode2Id = In_CCCode2Id) then
    delete from CCCode2 where
      CCCode2.CostCentreCode2Id = In_CCCode2Id;
    commit work
  end if
end
;

create procedure DBA.DeleteCCCode3(
in In_CCCode3Id char(20))
begin
  if exists(select* from CCCode3 where CCCode3.CostCentreCode3Id = In_CCCode3Id) then
    delete from CCCode3 where
      CCCode3.CostCentreCode3Id = In_CCCode3Id;
    commit work
  end if
end
;

create procedure DBA.DeleteCCCode4(
in In_CCCode4Id char(20))
begin
  if exists(select* from CCCode4 where CCCode4.CostCentreCode4Id = In_CCCode4Id) then
    delete from CCCode4 where
      CCCode4.CostCentreCode4Id = In_CCCode4Id;
    commit work
  end if
end
;

create procedure DBA.DeleteCCCode5(
in In_CCCode5Id char(20))
begin
  if exists(select* from CCCode5 where CCCode5.CostCentreCode5Id = In_CCCode5Id) then
    delete from CCCode5 where
      CCCode5.CostCentreCode5Id = In_CCCode5Id;
    commit work
  end if
end
;

create procedure DBA.InsertNewCCCode1(
in In_CCCode1Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from CCCode1 where CCCode1.CostCentreCode1Id = In_CCCode1Id) then
    insert into CCCode1(CostCentreCode1Id,CustCodeDesc) values(
      In_CCCode1Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure DBA.InsertNewCCCode2(
in In_CCCode2Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from CCCode2 where CCCode2.CostCentreCode2Id = In_CCCode2Id) then
    insert into CCCode2(CostCentreCode2Id,CustCodeDesc) values(
      In_CCCode2Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure DBA.InsertNewCCCode3(
in In_CCCode3Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from CCCode3 where CCCode3.CostCentreCode3Id = In_CCCode3Id) then
    insert into CCCode3(CostCentreCode3Id,CustCodeDesc) values(
      In_CCCode3Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure DBA.InsertNewCCCode4(
in In_CCCode4Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from CCCode4 where CCCode4.CostCentreCode4Id = In_CCCode4Id) then
    insert into CCCode4(CostCentreCode4Id,CustCodeDesc) values(
      In_CCCode4Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure DBA.InsertNewCCCode5(
in In_CCCode5Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from CCCode5 where CCCode5.CostCentreCode5Id = In_CCCode5Id) then
    insert into CCCode5(CostCentreCode5Id,CustCodeDesc) values(
      In_CCCode5Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure DBA.UpdateCCCode1(
in In_CCCode1Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from CCCode1 where CCCode1.CostCentreCode1Id = In_CCCode1Id) then
    update CCCode1 set
      CCCode1.CustCodeDesc = In_CustCodeDesc where
      CCCode1.CostCentreCode1Id = In_CCCode1Id;
    commit work
  end if
end
;

create procedure DBA.UpdateCCCode2(
in In_CCCode2Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from CCCode2 where CCCode2.CostCentreCode2Id = In_CCCode2Id) then
    update CCCode2 set
      CCCode2.CustCodeDesc = In_CustCodeDesc where
      CCCode2.CostCentreCode2Id = In_CCCode2Id;
    commit work
  end if
end
;

create procedure DBA.UpdateCCCode3(
in In_CCCode3Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from CCCode3 where CCCode3.CostCentreCode3Id = In_CCCode3Id) then
    update CCCode3 set
      CCCode3.CustCodeDesc = In_CustCodeDesc where
      CCCode3.CostCentreCode3Id = In_CCCode3Id;
    commit work
  end if
end
;

create procedure DBA.UpdateCCCode4(
in In_CCCode4Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from CCCode4 where CCCode4.CostCentreCode4Id = In_CCCode4Id) then
    update CCCode4 set
      CCCode4.CustCodeDesc = In_CustCodeDesc where
      CCCode4.CostCentreCode4Id = In_CCCode4Id;
    commit work
  end if
end
;

create procedure DBA.UpdateCCCode5(
in In_CCCode5Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from CCCode5 where CCCode5.CostCentreCode5Id = In_CCCode5Id) then
    update CCCode5 set
      CCCode5.CustCodeDesc = In_CustCodeDesc where
      CCCode5.CostCentreCode5Id = In_CCCode5Id;
    commit work
  end if
end
;

create procedure dba.InsertNewCostTimeSheetRecord(
in In_CostRecordSysId integer,
in In_CostTMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if not exists(select* from CostTimeSheetRecord where CostRecordSysId = In_CostRecordSysId and CostTMSSGSPGenId = In_CostTMSSGSPGenId) then
    insert into CostTimeSheetRecord(CostRecordSysId,CostTMSSGSPGenId) values(
      In_CostRecordSysId,In_CostTMSSGSPGenId);
    commit work;
    if not exists(select* from CostTimeSheetRecord where CostRecordSysId = In_CostRecordSysId and CostTMSSGSPGenId = In_CostTMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function DBA.FGetCurrentCostProgEffectiveDate(
in in_EmployeeSysID integer)
returns char(40)
begin
  declare output_CurrentDate date;
  select distinct CostProgEffectiveDate into output_CurrentDate from CostProgression where EmployeeSysID = in_EmployeeSysID and
    CostCentreCurrent = 1;
  return(output_CurrentDate)
end
;

create function dba.FGetCostItemDesc(
in In_CostItemId char(20))
returns char(100)
begin
  declare Out_CostItemDesc char(100);
  select CostItemDesc into Out_CostItemDesc
    from CostItem where CostItemId = In_CostItemId;
  if(Out_CostItemDesc is null or Out_CostItemDesc = '') then
    return(In_CostItemId)
  else return(Out_CostItemDesc)
  end if
end
;