create procedure dba.ASQLCalendarDayUpdateWkPatternWeek(
in In_UpdateStartDate date,
in In_WeekWorkPatternCode char(20))
begin
  declare N84_NewWorkPattern numeric(8,4);
  declare Char_DateType char(20);
  CalendarDateLoop: for CalendarDateFor as Cur_CalendarDate dynamic scroll cursor for
    select CalendarDay.CalendarDate as Change_WkPatternDate,DateType from
      CalendarDay where
      CalendarDay.WeekWorkPatternCode = In_WeekWorkPatternCode and
      CalendarDay.CalendarDate >= In_UpdateStartDate do
    /*
    select CalendarDay.DateType into Char_DateType
    from CalendarDay where
    CalendarDay.CalendarDate = Change_WkPatternDate and
    CalendarDay.WeekWorkPatternCode = In_WeekWorkPatternCode;
    */
    set N84_NewWorkPattern=FGetNewWorkPattern(DateType,In_WeekWorkPatternCode);
    update CalendarDay set
      CalendarDay.WkCalenDayWkPattern = N84_NewWorkPattern where current of Cur_CalendarDate;
    commit work end for
end
;

create procedure DBA.ASQLDeleteLeaveEmployee(
in In_EmployeeSysId integer)
begin
  delete from LeavePolicyProg where EmployeeSysId = In_EmployeeSysId;
  delete from LvePolicyFolder where EmployeeSysId = In_EmployeeSysId;
  delete from AdjustCredit where EmployeeSysId = In_EmployeeSysId;
  delete from LvePeriodBalRpt where EmployeeSysId = In_EmployeeSysId;
  delete from LeaveCycleRpt where EmployeeSysId = In_EmployeeSysId;
  delete from LvePeriodBalance where EmployeeSysId = In_EmployeeSysId;
  delete from LvePeriodBF where EmployeeSysId = In_EmployeeSysId;
  delete from LvePeriodSummary where EmployeeSysId = In_EmployeeSysId;
  delete from LvePolicySummary where EmployeeSysId = In_EmployeeSysId;
  delete from LeaveApproval where EmployeeSysId = In_EmployeeSysId;
  delete from LeaveRecord where LeaveAppSGSPGenId = any(select LeaveAppSGSPGenId from LeaveApplication where EmployeeSysId = In_EmployeeSysId);
  delete from LeaveApplication where EmployeeSysId = In_EmployeeSysId;
  call DeleteLeaveEmployee(In_EmployeeSysId);
  commit work
end
;

create procedure DBA.ASQLLveClearCrossYear(
in In_employeeSysId integer,
in In_LvePrevYear integer,
in In_LeaveTypeId char(20))
begin
  update LeaveCycleRpt set
    CycCrossCycTaken = 0 where
    EmployeeSysId = In_EmployeeSysId and
    LveYearRpt = In_LvePrevYear and
    LeaveTypeId = In_LeaveTypeId;
  commit work
end
;

create procedure dba.ASQLLveCycleRptBF(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
out Out_CycCrossCycTaken double)
begin
  declare In_LvePolicySummaryId char(20);
  delete from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt;
  commit work;
  /*
  Get the Current Policy  
  */
  select LvePolicySummaryId into In_LvePolicySummaryId from LvePolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYearRpt and
    LveProgressStatus = 'Current' and In_LeaveTypeId = 
    any(select LeaveTypeId from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYearRpt and
      LvePolicySummaryId = LvePolicySummary.LvePolicySummaryId);
  /*
  Create LvePeriodBalRpt
  */
  CreateLveCycleRptLoop: for CreateLveCycleRecFor as curs dynamic scroll cursor for
    select LvePeriodSummary.LvePeriod as In_LvePeriod,
      PeriodStartDate as In_PeriodStartDate,
      PeriodEndDate as In_PeriodEndDate,
      PerEntEarned as In_PerEntEarned,
      PerEntAdjEarned as In_PerEntAdjEarned,
      PerBFEarned as In_PerBFEarned,
      PerBFForfeit as In_PerBFForfeit,
      PerTotalEnt as In_PerTotalEnt,
      PerDayTaken as In_PerDayTaken,
      YTDEntEarned as In_YTDEntEarned,
      YTDEntAdjEarned as In_YTDEntAdjEarned,
      YTDBFEarned as In_YTDBFEarned,
      YTDBFForfeit as In_YTDBFForfeit,
      YTDTotalEnt as In_YTDTotalEnt,
      YTDDayTaken as In_YTDDayTaken,
      YTDBalance as In_YTDBalance from
      LvePeriodSummary join LvePeriodBalance where
      LvePeriodBalance.EmployeeSysId = In_EmployeeSysId and
      LvePeriodBalance.LveYear = In_LveYearRpt and
      LvePeriodBalance.LeaveTypeId = In_LeaveTypeId and
      LvePeriodBalance.LvePolicySummaryId = In_LvePolicySummaryId do
    call InsertNewLvePeriodBalRpt(
    In_EmployeeSysId,
    In_LveYearRpt,
    In_LvePeriod,
    In_LeaveTypeId,
    In_PeriodStartDate,
    In_PeriodEndDate,
    In_PerEntEarned,
    In_PerEntAdjEarned,
    In_PerBFEarned,
    In_PerBFForfeit,
    In_PerTotalEnt,
    In_PerDayTaken,
    In_YTDEntEarned,
    In_YTDEntAdjEarned,
    In_YTDBFEarned,
    In_YTDBFForfeit,
    In_YTDTotalEnt,
    In_YTDDayTaken,
    In_YTDBalance,0,'','','','','','') end for;
  /*In_HisBranchId,In_HisCategoryId,In_HisDepartmentId,In_HisLeaveGroupId,In_HisPositionId,In_HisSectionId*/
  /*
  Update LeaveCycleRpt
  */
  call ASQLLveCycleRptUpdate(In_EmployeeSysId,In_LeaveTypeId,In_LveYearRpt,Out_CycCrossCycTaken)
end
;

create procedure dba.ASQLLveCycleRptNoProgress(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
out Out_CycCrossCycTaken double)
begin
  delete from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt;
  commit work;
  /*
  Create LvePeriodBalRpt
  */
  CreateLveCycleRptLoop: for CreateLveCycleRecFor as curs dynamic scroll cursor for
    select LvePeriodSummary.LvePeriod as In_LvePeriod,
      PeriodStartDate as In_PeriodStartDate,
      PeriodEndDate as In_PeriodEndDate,
      PerEntEarned as In_PerEntEarned,
      PerEntAdjEarned as In_PerEntAdjEarned,
      PerBFEarned as In_PerBFEarned,
      PerBFForfeit as In_PerBFForfeit,
      PerTotalEnt as In_PerTotalEnt,
      PerDayTaken as In_PerDayTaken,
      YTDEntEarned as In_YTDEntEarned,
      YTDEntAdjEarned as In_YTDEntAdjEarned,
      YTDBFEarned as In_YTDBFEarned,
      YTDBFForfeit as In_YTDBFForfeit,
      YTDTotalEnt as In_YTDTotalEnt,
      YTDDayTaken as In_YTDDayTaken,
      YTDBalance as In_YTDBalance,
      CostPerDay as In_CostPerDay from
      LvePeriodSummary join LvePeriodBalance where
      LvePeriodBalance.EmployeeSysId = In_EmployeeSysId and
      LvePeriodBalance.LveYear = In_LveYearRpt and
      LvePeriodBalance.LeaveTypeId = In_LeaveTypeId do
    call InsertNewLvePeriodBalRpt(
    In_EmployeeSysId,
    In_LveYearRpt,
    In_LvePeriod,
    In_LeaveTypeId,
    In_PeriodStartDate,
    In_PeriodEndDate,
    In_PerEntEarned,
    In_PerEntAdjEarned,
    In_PerBFEarned,
    In_PerBFForfeit,
    In_PerTotalEnt,
    In_PerDayTaken,
    In_YTDEntEarned,
    In_YTDEntAdjEarned,
    In_YTDBFEarned,
    In_YTDBFForfeit,
    In_YTDTotalEnt,
    In_YTDDayTaken,
    In_YTDBalance,
    In_CostPerDay,'','','','','','') end for;
  /*In_HisBranchId,In_HisCategoryId,In_HisDepartmentId,In_HisLeaveGroupId,In_HisPositionId,In_HisSectionId*/
  /*
  Update LeaveCycleRpt
  */
  call ASQLLveCycleRptUpdate(In_EmployeeSysId,In_LeaveTypeId,In_LveYearRpt,Out_CycCrossCycTaken)
end
;

create procedure dba.ASQLLveCycleRptProrate(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
out Out_CycCrossCycTaken double)
begin
  declare In_PeriodStartDate date;
  declare In_PeriodEndDate date;
  delete from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt;
  commit work;
  /*
  Create LvePeriodBalRpt
  */
  CreateLveCycleRptLoop: for CreateLveCycleRecFor as curs dynamic scroll cursor for
    select LvePeriodBalance.LvePeriod as In_LvePeriod,
      Sum(PerEntEarned) as In_PerEntEarned,
      Sum(PerEntAdjEarned) as In_PerEntAdjEarned,
      Sum(PerBFEarned) as In_PerBFEarned,
      Sum(PerBFForfeit) as In_PerBFForfeit,
      Sum(PerTotalEnt) as In_PerTotalEnt,
      Sum(PerDayTaken) as In_PerDayTaken,
      Sum(YTDEntEarned) as In_YTDEntEarned,
      Sum(YTDEntAdjEarned) as In_YTDEntAdjEarned,
      Sum(YTDBFEarned) as In_YTDBFEarned,
      Sum(YTDBFForfeit) as In_YTDBFForfeit,
      Sum(YTDTotalEnt) as In_YTDTotalEnt,
      Sum(YTDDayTaken) as In_YTDDayTaken,
      Sum(YTDBalance) as In_YTDBalance from
      LvePeriodSummary join LvePeriodBalance
      group by LvePeriodBalance.EmployeeSysId,
      LvePeriodBalance.LeaveTypeId,
      LvePeriodBalance.LveYear,
      LvePeriodBalance.LvePeriod having
      LvePeriodBalance.EmployeeSysId = In_EmployeeSysId and
      LvePeriodBalance.LveYear = In_LveYearRpt and
      LvePeriodBalance.LeaveTypeId = In_LeaveTypeId order by
      LvePeriodBalance.LvePeriod asc do
    select PeriodStartDate,PeriodEndDate into In_PeriodStartDate,
      In_PeriodEndDate from LvePolicySummary join LvePeriodSummary join LvePeriodBalance where
      LvePolicySummary.EmployeeSysId = In_EmployeeSysId and
      LvePolicySummary.LveYear = In_LveYearRpt and
      LvePeriodSummary.LvePeriod = In_LvePeriod and
      LveProgressStatus = 'Current' and
      LeaveTypeId = In_LeaveTypeId;
    if(In_PeriodStartDate is null) then
      select PeriodStartDate,PeriodEndDate into In_PeriodStartDate,
        In_PeriodEndDate from LvePolicySummary join LvePeriodSummary join LvePeriodBalance where
        LvePolicySummary.EmployeeSysId = In_EmployeeSysId and
        LvePolicySummary.LveYear = In_LveYearRpt and
        LvePeriodSummary.LvePeriod = In_LvePeriod and
        LveProgressStatus = 'Previous' and
        LeaveTypeId = In_LeaveTypeId
    end if;
    call InsertNewLvePeriodBalRpt(
    In_EmployeeSysId,
    In_LveYearRpt,
    In_LvePeriod,
    In_LeaveTypeId,
    In_PeriodStartDate,
    In_PeriodEndDate,
    In_PerEntEarned,
    In_PerEntAdjEarned,
    In_PerBFEarned,
    In_PerBFForfeit,
    In_PerTotalEnt,
    In_PerDayTaken,
    In_YTDEntEarned,
    In_YTDEntAdjEarned,
    In_YTDBFEarned,
    In_YTDBFForfeit,
    In_YTDTotalEnt,
    In_YTDDayTaken,
    In_YTDBalance,0,'','','','','','') end for;
  /*In_HisBranchId,In_HisCategoryId,In_HisDepartmentId,In_HisLeaveGroupId,In_HisPositionId,In_HisSectionId*/
  /*
  Update LeaveCycleRpt
  */
  call ASQLLveCycleRptUpdate(In_EmployeeSysId,In_LeaveTypeId,In_LveYearRpt,Out_CycCrossCycTaken)
end
;

create procedure DBA.ASQLLveCycleRptUpdate(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
out Out_CycCrossCycTaken double)
begin
  declare In_CycEntEarned double;
  declare In_CycEntAdjEarned double;
  declare In_CycBFEarned double;
  declare In_CycBFForfeit double;
  declare In_CycTotalEnt double;
  declare In_CycDayTaken double;
  declare In_CycBalance double;
  select FGetLveCrossTaken(In_EmployeeSysId,In_LveYearRpt,In_LeaveTypeId) into Out_CycCrossCycTaken;
  select YTDEntEarned,
    YTDEntAdjEarned,
    YTDBFEarned,
    YTDBFForfeit,
    YTDTotalEnt,
    YTDDayTaken,
    YTDBalance into In_CycEntEarned,
    In_CycEntAdjEarned,
    In_CycBFEarned,
    In_CycBFForfeit,
    In_CycTotalEnt,
    In_CycDayTaken,
    In_CycBalance from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LveYearRpt = In_LveYearRpt and
    LvePeriodRpt = 12 and
    LeaveTypeId = In_LeaveTypeId;
  update LeaveCycleRpt set
    CycEntEarned = In_CycEntEarned,
    CycEntAdjEarned = In_CycEntAdjEarned,
    CycBFEarned = In_CycBFEarned,
    CycBFForfeit = In_CycBFForfeit,
    CycTotalEnt = In_CycTotalEnt,
    CycDayTaken = In_CycDayTaken,
    CycCrossCycTaken = Out_CycCrossCycTaken,
    CycBalance = In_CycBalance where
    EmployeeSysId = In_EmployeeSysId and
    LveYearRpt = In_LveYearRpt and
    LeaveTypeId = In_LeaveTypeId;
  commit work
end
;

create procedure DBA.ASQLLveDeleteAllSumRpt(
in In_employeeSysId integer,
in In_LveYear integer)
begin
  delete from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LveYearRpt = In_LveYear;
  delete from LeaveCycleRpt where
    EmployeeSysId = In_EmployeeSysId and
    LveYearRpt = In_LveYear;
  delete from LvePeriodBF where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear;
  delete from LvePeriodBalance where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear;
  delete from LvePeriodSummary where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear;
  delete from LvePolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear;
  commit work
end
;

create procedure DBA.ASQLLveDeleteReprocessSumRpt(
in In_employeeSysId integer,
in In_LveYear integer,
in In_LeaveTypeId char(20))
begin
  call DeleteLeaveCycleRpt(In_EmployeeSysId,In_LveYear,In_LeaveTypeId);
  delete from LvePeriodBF where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear and
    LeaveTypeId = In_LeaveTypeId;
  delete from LvePeriodBalance where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear and
    LeaveTypeId = In_LeaveTypeId;
  commit work
end
;

create procedure DBA.ASQLLveDeleteSumRpt(
in In_employeeSysId integer,
in In_LveYear integer,
in In_LeaveTypeId char(20))
begin
  call DeleteLeaveCycleRpt(In_EmployeeSysId,In_LveYear,In_LeaveTypeId);
  delete from LvePeriodBF where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear and
    LeaveTypeId = In_LeaveTypeId;
  delete from LvePeriodBalance where
    EmployeeSysId = In_EmployeeSysId and
    LveYear = In_LveYear and
    LeaveTypeId = In_LeaveTypeId;
  if(not exists(select* from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear)) then
    delete from LvePeriodSummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear;
    delete from LvePolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear
  end if;
  commit work
end
;

create procedure dba.ASQLUpdateEmpLeaveInfo(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare Out_CurrLveEntitlement double;
  declare Out_LveBroughtForward double;
  declare Out_LveAutoOption integer;
  /*
  Annual Leave
  */
  select LveAutoOption into Out_LveAutoOption from PayLeaveSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayLeaveTypeId = 'Annual';
  if(Out_LveAutoOption = 1) then
    select CurrLveEntitlement,LveBroughtForward into Out_CurrLveEntitlement,
      Out_LveBroughtForward from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveTypeFunctCode = 'Annual';
    update PayEmployee set
      ANNLveBroughtForward = Out_LveBroughtForward,
      ANNLveEntitlement = Out_CurrLveEntitlement where
      EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  /*
  Sick Leave
  */
  select LveAutoOption into Out_LveAutoOption from PayLeaveSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayLeaveTypeId = 'Sick';
  if(Out_LveAutoOption = 1) then
    select CurrLveEntitlement into Out_CurrLveEntitlement
      from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveTypeFunctCode = 'Sick';
    update PayEmployee set
      SickLveEntitlement = Out_CurrLveEntitlement where
      EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteAdjustCredit(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_AdjEffectiveDate date,
in In_AdjType smallint)
begin
  if exists(select* from AdjustCredit where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId and
      AdjustCredit.LeaveTypeId = In_LeaveTypeId and
      AdjustCredit.AdjEffectiveDate = In_AdjEffectiveDate and
      AdjustCredit.AdjType = In_AdjType) then
    delete from AdjustCredit where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId and
      AdjustCredit.LeaveTypeId = In_LeaveTypeId and
      AdjustCredit.AdjEffectiveDate = In_AdjEffectiveDate and
      AdjustCredit.AdjType = In_AdjType;
    commit work
  end if
end
;

create procedure dba.DeleteAdjustCreditByEmployeeSysID(
in In_EmployeeSysId integer)
begin
  if exists(select* from AdjustCredit where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId) then
    delete from AdjustCredit where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteCostingMethod(
in In_CostingMethodId char(20))
begin
  if exists(select* from CostingMethod where
      CostMethodId = In_CostingMethodId) then
    call DeleteLveAllocFormRecByCostMethId(In_CostingMethodId);
    delete from CostingMethod where
      CostMethodId = In_CostingMethodId;
    commit work
  end if
end
;

create procedure dba.DeleteEmpLeaveRecord(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_StartYrMonth integer,
in In_LeaveGroupId char(20))
begin
  if exists(select* from EmpLeaveRecord where
      EmpLeaveRecord.EmployeeSysId = In_EmployeeSysId and
      EmpLeaveRecord.LeaveTypeId = In_LeaveTypeId and
      EmpLeaveRecord.LeaveGroupId = In_LeaveGroupId and
      EmpLeaveRecord.StartYrMonth = In_StartYrMonth) then
    delete from EmpLeaveRecord where
      EmpLeaveRecord.EmployeeSysId = In_EmployeeSysId and
      EmpLeaveRecord.LeaveTypeId = In_LeaveTypeId and
      EmpLeaveRecord.LeaveGroupId = In_LeaveGroupId and
      EmpLeaveRecord.StartYrMonth = In_StartYrMonth;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveAllocatGroupLveType(
in In_LeaveTypeId char(20))
begin
  if exists(select* from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId) then
    delete from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveAllocation(
in In_LveAllocationId integer)
begin
  if exists(select* from LeaveAllocation where
      LeaveAllocation.LveAllocationId = In_LveAllocationId) then
    delete from LeaveAllocation where
      LeaveAllocation.LveAllocationId = In_LveAllocationId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveAllocationGroup(
in In_LeaveAllocatGroupId char(20))
begin
  if exists(select* from LeaveAllocationGroup where
      LeaveAllocationGroup.LeaveAllocatGroupId = In_LeaveAllocatGroupId) then
    delete from LeaveAllocationGroup where
      LeaveAllocationGroup.LeaveAllocatGroupId = In_LeaveAllocatGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveAllocationGroupGrpType(
in In_LeaveGroupId char(20))
begin
  if exists(select* from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId) then
    delete from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveAllocationGroupType(
in In_LeaveGroupId char(20),
in In_LeaveTypeId char(20))
begin
  if exists(select* from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId and
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId) then
    delete from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId and
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveApplication(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveAppFromDate date,
in In_LveAppToDate date,
in In_LveAppStartTime time)
begin
  declare In_LeaveAppSGSPGenId char(30);
  if exists(select* from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId and
      LeaveApplication.LeaveTypeId = In_LeaveTypeId and
      LeaveApplication.LveAppFromDate = In_LveAppFromDate and
      LeaveApplication.LveAppToDate = In_LveAppToDate and
      LeaveApplication.LveAppStartTime = In_LveAppStartTime) then
    select LeaveAppSGSPGenId into In_LeaveAppSGSPGenId from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId and
      LeaveApplication.LeaveTypeId = In_LeaveTypeId and
      LeaveApplication.LveAppFromDate = In_LveAppFromDate and
      LeaveApplication.LveAppToDate = In_LveAppToDate and
      LeaveApplication.LveAppStartTime = In_LveAppStartTime;
    delete from LeaveRecord where LeaveAppSGSPGenId = In_LeaveAppSGSPGenId;
    delete from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId and
      LeaveApplication.LeaveTypeId = In_LeaveTypeId and
      LeaveApplication.LveAppFromDate = In_LveAppFromDate and
      LeaveApplication.LveAppToDate = In_LveAppToDate and
      LeaveApplication.LveAppStartTime = In_LveAppStartTime;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveApplicationEmp(
in In_EmployeeSysId integer)
begin
  if exists(select* from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId) then
    delete from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveApply(
in In_AppSysId integer)
begin
  if exists(select* from LeaveApplyDay where
      LeaveApplyDay.LApplicationSysId = In_AppSysId) then
    delete from LeaveApplyDay where
      LeaveApplyDay.LApplicationSysId = In_AppSysId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveApplyDayDate(
in In_EmpSysId integer,
in In_AppSysId integer,
in In_DateApplied date)
begin
  if exists(select* from LeaveApplyDay where
      LeaveApplyDay.LEmployeeSysId = In_EmpSysId and
      LeaveApplyDay.LApplicationSysId = In_AppSysId and
      LeaveApplyDay.DateApplied = In_DateApplied) then
    delete from LeaveApplyDay where
      LeaveApplyDay.LEmployeeSysId = In_EmpSysId and
      LeaveApplyDay.LApplicationSysId = In_AppSysId and
      LeaveApplyDay.DateApplied = In_DateApplied;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveApplyDayNo(
in In_EmpSysId integer,
in In_AppSysId integer)
begin
  if exists(select* from LeaveApplyDay where
      LeaveApplyDay.LEmployeeSysId = In_EmpSysId and
      LeaveApplyDay.LApplicationSysId = In_AppSysId) then
    delete from LeaveApplyDay where
      LeaveApplyDay.LEmployeeSysId = In_EmpSysId and
      LeaveApplyDay.LApplicationSysId = In_AppSysId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveComputation(
in in_LeaveTypeId char(20))
begin
  if exists(select* from LeaveComputation where
      LeaveComputation.LeaveTypeId = In_LeaveTypeId) then
    delete from LeaveComputation where
      LeaveComputation.LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveCutOffDate(
in In_PayGroupId char(20),
in In_SubPeriod integer,
in In_CutOffPayLveTypeId char(20))
begin
  if exists(select* from LeaveCutOffDate where LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod and LeaveCutOffDate.CutOffPayLveTypeId = In_CutOffPayLveTypeId) then
    delete from LeaveCutOffDate where
      LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod and LeaveCutOffDate.CutOffPayLveTypeId = In_CutOffPayLveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveCutOffDateGrp(
in In_PayGroupId char(20))
begin
  if exists(select* from LeaveCutOffDate where
      LeaveCutOffDate.PayGroupId = In_PayGroupId) then
    delete from LeaveCutOffDate where
      LeaveCutOffDate.PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveCutOffDateSubPeriod(
in In_PayGroupId char(20),
in In_SubPeriod integer)
begin
  if exists(select* from LeaveCutOffDate where LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod) then
    delete from LeaveCutOffDate where
      LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveCycleRpt(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LeaveTypeId char(20))
begin
  if exists(select* from LeaveCycleRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LeaveTypeId = In_LeaveTypeId) then
    delete from LvePeriodBalRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LeaveTypeId = In_LeaveTypeId;
    delete from LeaveCycleRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveDeductionRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveTypeFunctCode char(20))
begin
  if exists(select* from LeaveDeductionRecord where
      LeaveDeductionRecord.EmployeeSysId = In_EmployeeSysId and
      LeaveDeductionRecord.PayRecYear = In_PayRecYear and
      LeaveDeductionRecord.PayRecPeriod = In_PayRecPeriod and
      LeaveDeductionRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveDeductionRecord.LeaveTypeFunctCode = In_LeaveTypeFunctCode) then
    delete from SubPeriodSetting where
      LeaveDeductionRecord.EmployeeSysId = In_EmployeeSysId and
      LeaveDeductionRecord.PayRecYear = In_PayRecYear and
      LeaveDeductionRecord.PayRecPeriod = In_PayRecPeriod and
      LeaveDeductionRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveDeductionRecord.LeaveTypeFunctCode = In_LeaveTypeFunctCode;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveEmployee(
in In_EmployeeSysId integer)
begin
  if exists(select* from LeaveEmployee where
      LeaveEmployee.EmployeeSysId = In_EmployeeSysId) then
    delete from LeaveEmployee where LeaveEmployee.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveFormula(
in In_LveFormulaId char(30))
begin
  if exists(select* from LeaveRange where
      LeaveRange.LveFormulaRangeId = 1 and
      LeaveRange.LveFormulaId = In_LveFormulaId) then
    delete from LeaveRange where
      LeaveRange.LveFormulaRangeId = 1 and
      LeaveRange.LveFormulaId = In_LveFormulaId
  end if;
  if exists(select* from LeaveFormula where
      LeaveFormula.LveFormulaId = In_LveFormulaId) then
    delete from LeaveFormula where
      LeaveFormula.LveFormulaId = In_LveFormulaId
  end if;
  commit work
end
;

create procedure dba.DeleteLeaveGroup(
in In_LeaveGroupId char(20))
begin
  if exists(select* from LeaveGroup where
      LeaveGroup.LeaveGroupId = In_LeaveGroupId) then
    delete from LeaveGroup where LeaveGroup.LeaveGroupId = In_LeaveGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveGroupCalendar(
in In_LeaveGroupId char(20))
begin
  if exists(select* from LeaveGroupCalendar where
      LeaveGroupCalendar.LeaveGroupId = In_LeaveGroupId) then
    delete from LeaveGroupCalendar where
      LeaveGroupCalendar.LeaveGroupId = In_LeaveGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveInfoRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveTypeFunctCode char(20))
begin
  if exists(select* from LeaveInfoRecord where
      LeaveInfoRecord.EmployeeSysId = In_EmployeeSysId and
      LeaveInfoRecord.PayRecYear = In_PayRecYear and
      LeaveInfoRecord.PayRecPeriod = In_PayRecPeriod and
      LeaveInfoRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveInfoRecord.LeaveTypeFunctCode = In_LeaveTypeFunctCode) then
    delete from SubPeriodSetting where
      LeaveInfoRecord.EmployeeSysId = In_EmployeeSysId and
      LeaveInfoRecord.PayRecYear = In_PayRecYear and
      LeaveInfoRecord.PayRecPeriod = In_PayRecPeriod and
      LeaveInfoRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveInfoRecord.LeaveTypeFunctCode = In_LeaveTypeFunctCode;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveInitialisedGroup(
in In_LeaveGroupId char(20),
in In_GroupStartYrMonth integer)
begin
  if exists(select* from LeaveInitialisedGroup where
      LeaveInitialisedGroup.LeaveGroupId = In_LeaveGroupId and
      LeaveInitialisedGroup.GroupStartYrMth = In_GroupStartYrMonth) then
    delete from LeaveInitialisedGroup where
      LeaveInitialisedGroup.LeaveGroupId = In_LeaveGroupId and
      LeaveInitialisedGroup.GroupStartYrMth = In_GroupStartYrMonth;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveKeyword(
in In_LveKeywordId char(20))
begin
  if exists(select* from LeaveKeyword where
      LeaveKeyword.LveKeywordId = In_LveKeywordId) then
    delete from LeaveRange where
      LeaveKeyword.LveKeywordId = In_LveKeywordId;
    commit work
  end if
end
;

create procedure dba.DeleteLeavePolicy(
in In_LeavePolicyId char(20))
begin
  if exists(select* from LeavePolicyRecord where
      LeavePolicyRecord.LeavePolicyId = In_LeavePolicyId) then
    delete from LeavePolicyRecord where
      LeavePolicyRecord.LeavePolicyId = In_LeavePolicyId
  end if;
  if exists(select* from LeavePolicy where
      LeavePolicy.LeavePolicyId = In_LeavePolicyId) then
    delete from LeavePolicy where
      LeavePolicy.LeavePolicyId = In_LeavePolicyId
  end if;
  commit work
end
;

create procedure dba.DeleteLeavePolicyRecByLeavePolicy(
in In_LeavePolicyId char(20))
begin
  if exists(select* from LeavePolicyRecord where
      LeavePolicyRecord.LeavePolicyId = In_LeavePolicyId) then
    delete from LeavePolicyRecord where
      LeavePolicyRecord.LeavePolicyId = In_LeavePolicyId;
    commit work
  end if
end
;

create procedure dba.DeleteLeavePolicyRecord(
in In_PolicySysId integer)
begin
  if exists(select* from LeavePolicyRecord where
      LeavePolicyRecord.PolicySysId = In_PolicySysId) then
    delete from LeavePolicyRecord where
      LeavePolicyRecord.PolicySysId = In_PolicySysId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveRange(
in In_LveFormulaRangeId integer,
in In_LveFormulaId char(30))
begin
  if exists(select* from LeaveRange where
      LeaveRange.LveFormulaRangeId = In_LveFormulaRangeId and
      LeaveRange.LveFormulaId = In_LveFormulaId) then
    delete from LeaveRange where
      LeaveRange.LveFormulaRangeId = In_LveFormulaRangeId and
      LeaveRange.LveFormulaId = In_LveFormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveReason(
in In_LeaveReasonId char(20))
begin
  if exists(select* from LeaveReason where
      LeaveReason.LeaveReasonId = In_LeaveReasonId) then
    if exists(select* from LeaveApplication where
        LeaveReasonId = In_LeaveReasonId) then
      return
    end if;
    if exists(select* from AdjustCredit where
        LeaveReasonId = In_LeaveReasonId) then
      return
    end if;
    delete from LeaveReason where
      LeaveReason.LeaveReasonId = In_LeaveReasonId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveRecord(
in In_LeaveAppSGSPGenId char(30),
in In_LveRecDate date,
in In_LveRecStartTime time)
begin
  if exists(select* from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime) then
    delete from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveRecordByGenId(
in In_LeaveAppSGSPGenId char(30))
begin
  if exists(select* from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId) then
    delete from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId;
    commit work
  end if
end
;

create procedure dba.DeleteLeaveType(
in In_LeaveTypeId char(20))
begin
  if exists(select* from LeaveType where
      LeaveType.LeaveTypeId = In_LeaveTypeId) then
    if((not exists(select* from LeaveApplication where LeaveApplication.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from LeavePolicyRecord where LeavePolicyRecord.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from LeaveCycleRpt where LeaveCycleRpt.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from LvePeriodBalRpt where LvePeriodBalRpt.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from LvePeriodBalance where LvePeriodBalance.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from LvePeriodBF where LvePeriodBF.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from AdjustCredit where AdjustCredit.LeaveTypeId = In_LeaveTypeId)) and
      (not exists(select* from DeductSequence where DeductSequence.LeaveTypeId = In_LeaveTypeId))) then
      call DeleteLeaveComputation(in_LeaveTypeId);
      delete from LeaveEligibleItem where LeaveTypeId = In_LeaveTypeId;
      delete from LeaveEligibleGroup where LeaveTypeId = In_LeaveTypeId;
      delete from LeaveType where
        LeaveType.LeaveTypeId = In_LeaveTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteLveAllocation(
in In_LveAllocationId char(20))
begin
  if exists(select* from LveAllocationRec where LveAllocationRec.LveAllocationId = In_LveAllocationId) then
    delete from LveAllocationRec where
      LveAllocationRec.LveAllocationId = In_LveAllocationId
  end if;
  if exists(select* from LveAllocation where LveAllocation.LveAllocationId = In_LveAllocationId) then
    delete from LveAllocation where
      LveAllocation.LveAllocationId = In_LveAllocationId
  end if;
  commit work
end
;

create procedure dba.DeleteLveAllocationRec(
in In_LveAllocationId char(20),
in In_LveAllocationSysId integer)
begin
  if exists(select* from LveAllocationRec where LveAllocationRec.LveAllocationId = In_LveAllocationId and
      LveAllocationRec.LveAllocationSysId = In_LveAllocationSysId) then
    delete from LveAllocationRec where
      LveAllocationRec.LveAllocationId = In_LveAllocationId and
      LveAllocationRec.LveAllocationSysId = In_LveAllocationSysId;
    commit work
  end if
end
;

create procedure dba.DeleteLveAllocFormRecByCostMethId(
in In_CostMethodId char(20))
begin
  if exists(select* from LveAllocFormulaRec where
      LveAllocFormulaRec.CostMethodId = In_CostMethodId) then
    delete from LveAllocFormulaRec where
      LveAllocFormulaRec.CostMethodId = In_CostMethodId;
    commit work
  end if
end
;

create procedure dba.DeleteLveAllocFormulaRec(
in In_CostMethodId char(20),
in In_LveAllocFormulaSysId integer)
begin
  if exists(select* from LveAllocFormulaRec where
      LveAllocFormulaRec.CostMethodId = In_CostMethodId and
      LveAllocFormulaRec.LveAllocFormulaSysId = In_LveAllocFormulaSysId) then
    delete from LveAllocFormulaRec where
      LveAllocFormulaRec.CostMethodId = In_CostMethodId and
      LveAllocFormulaRec.LveAllocFormulaSysId = In_LveAllocFormulaSysId;
    commit work
  end if
end
;

create procedure dba.DeleteLveAllocRecbyAllocId(
in In_LveAllocationId char(20))
begin
  if exists(select* from LveAllocationRec where LveAllocationRec.LveAllocationId = In_LveAllocationId) then
    delete from LveAllocationRec where
      LveAllocationRec.LveAllocationId = In_LveAllocationId;
    commit work
  end if
end
;

create procedure dba.DeleteLvePeriodBalance(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_LeaveTypeId char(20))
begin
  if exists(select* from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId) then
    delete from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLvePeriodBalRpt(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LvePeriodRpt integer,
in In_LeaveTypeId char(20))
begin
  if exists(select* from LvePeriodBalRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LvePeriodRpt = In_LvePeriodRpt and
      LeaveTypeId = In_LeaveTypeId) then
    delete from LvePeriodBalRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LvePeriodRpt = In_LvePeriodRpt and
      LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLvePeriodBF(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_LeaveTypeId char(20),
in In_LveBFLeaveTypeId char(20))
begin
  if exists(select* from LvePeriodBF where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId and
      LveBFLeaveTypeId = In_LveBFLeaveTypeId) then
    delete from LvePeriodBF where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId and
      LveBFLeaveTypeId = In_LveBFLeaveTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLvePeriodSummary(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer)
begin
  if exists(select* from LvePeriodSummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod) then
    delete from LvePeriodBF where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod;
    delete from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod;
    delete from LvePeriodSummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod;
    commit work
  end if
end
;

create procedure dba.DeleteLvePolicyProg(
in In_EmployeeSysId integer,
in In_LveProgDate date)
begin
  if exists(select* from LeavePolicyProg where
      LeavePolicyProg.EmployeeSysId = In_EmployeeSysId and
      LeavePolicyProg.LveProgDate = In_LveProgDate) then
    delete from LeavePolicyProg where
      LeavePolicyProg.EmployeeSysId = In_EmployeeSysId and
      LeavePolicyProg.LveProgDate = In_LveProgDate;
    commit work
  end if
end
;

create procedure dba.DeleteLvePolicySummary(
in In_EmployeeSysId integer,
In_LveYear integer,
In_LvePolicySummaryId char(20))
begin
  if exists(select* from LvePolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId) then
    delete from LvePeriodBF where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId;
    delete from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId;
    delete from LvePeriodSummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId;
    delete from LvePolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId;
    commit work
  end if
end
;

create procedure dba.DeleteWorkTime(
in In_WTProfileId char(20),
in In_StartTime time)
begin
  if exists(select* from WorkTime where
      WorkTime.WTProfileId = In_WTProfileId and
      WorkTime.StartTime = In_StartTime) then
    delete from WorkTime where
      WorkTime.WTProfileId = In_WTProfileId and
      WorkTime.StartTime = In_StartTime;
    commit work
  end if
end
;

create procedure dba.DeleteWorkTimeByWTProfileId(
in In_WTProfileId char(20))
begin
  if exists(select* from WorkTime where
      WorkTime.WTProfileId = In_WTProfileId) then
    delete from WorkTime where
      WorkTime.WTProfileId = In_WTProfileId;
    commit work
  end if
end
;

create procedure dba.DeleteWTCalendar(
in In_WTCalendarId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from WTCalendar where WTCalendarId = In_WTCalendarId) and
    DeleteDefault('WorkTimeCalendarID',In_WTCalendarId) = 1 then
    if exists(select* from ShiftCalendar where WTCalendarId = In_WTCalendarId) then
      set Out_ErrorCode=-1;
      return
    end if;
    delete from WTCalendarPattern where WTCalendarId = In_WTCalendarId;
    delete from WTDay where WTCalendarId = In_WTCalendarId;
    delete from WTCalendar where WTCalendarId = In_WTCalendarId;
    commit work;
    if exists(select* from WTCalendar where WTCalendarId = In_WTCalendarId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteWTDay(
in In_WTCalendarId char(20),
in In_WTDate date)
begin
  if exists(select* from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId and
      WTDay.WTDate = In_WTDate) then
    delete from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId and
      WTDay.WTDate = In_WTDate;
    commit work
  end if
end
;

create procedure dba.DeleteWTDayByCalendarId(
in In_WTCalendarId char(20))
begin
  if exists(select* from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId) then
    delete from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId;
    commit work
  end if
end
;

create procedure dba.DeleteWTProfile(
in In_WTProfileId char(20))
begin
  if exists(select* from WTProfile where
      WTProfile.WTProfileId = In_WTProfileId) then
    call DeleteWorkTimeByWTProfileId(In_WTProfileId);
    delete from WTProfile where
      WTProfile.WTProfileId = In_WTProfileId;
    commit work
  end if
end
;

create function DBA.FDecodeLeaveFormula(
in In_LveFormulaId char(20))
returns char(255)
begin
  declare cont integer;
  declare In_String char(255);
  select Formula into In_String from LeaveRange where LveFormulaId = In_LveFormulaId;
  select Upper(In_String) into In_String;
  set cont=1;
  // K10
  while cont = 1 loop
    if(select PATINDEX('%K10%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K10%',In_String)),3,(select FGetKeyWordUserDefinedName(keywords10) from Leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K1
  while cont = 1 loop
    if(select PATINDEX('%K1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K1%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords1) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K2
  while cont = 1 loop
    if(select PATINDEX('%K2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K2%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords2) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K3
  while cont = 1 loop
    if(select PATINDEX('%K3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K3%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords3) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K4
  while cont = 1 loop
    if(select PATINDEX('%K4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K4%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords4) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K5
  while cont = 1 loop
    if(select PATINDEX('%K5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K5%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords5) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K6
  while cont = 1 loop
    if(select PATINDEX('%K6%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K6%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords6) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K7
  while cont = 1 loop
    if(select PATINDEX('%K7%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K7%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords7) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K8
  while cont = 1 loop
    if(select PATINDEX('%K8%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K8%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords8) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K9
  while cont = 1 loop
    if(select PATINDEX('%K9%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K9%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords9) from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U1
  while cont = 1 loop
    if(select PATINDEX('%U1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U1%',In_String)),2,(select UserDef1 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U2
  while cont = 1 loop
    if(select PATINDEX('%U2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U2%',In_String)),2,(select UserDef2 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U3
  while cont = 1 loop
    if(select PATINDEX('%U3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U3%',In_String)),2,(select UserDef3 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U4
  while cont = 1 loop
    if(select PATINDEX('%U4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U4%',In_String)),2,(select UserDef4 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U5
  while cont = 1 loop
    if(select PATINDEX('%U5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U5%',In_String)),2,(select UserDef5 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C1
  while cont = 1 loop
    if(select PATINDEX('%C1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C1%',In_String)),2,(select Constant1 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C2
  while cont = 1 loop
    if(select PATINDEX('%C2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C2%',In_String)),2,(select Constant2 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C3
  while cont = 1 loop
    if(select PATINDEX('%C3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C3%',In_String)),2,(select Constant3 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C4
  while cont = 1 loop
    if(select PATINDEX('%C4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C4%',In_String)),2,(select Constant4 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C5
  while cont = 1 loop
    if(select PATINDEX('%C5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C5%',In_String)),2,(select Constant5 from leaverange where Lveformulaid = In_LveFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  return(In_String)
end
;

create function DBA.FGetCrossCycTaken(
in In_EmployeeSysID integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer)
returns double
begin
  declare out_CycCrossCycTaken double;
  select CycCrossCycTaken into out_CycCrossCycTaken from LeaveCycleRpt where
    LeaveCycleRpt.EmployeeSysId = In_EmployeeSysId and
    LeaveCycleRpt.LeaveTypeId = In_LeaveTypeId and
    LeaveCycleRpt.LveYearRpt = In_LveYearRpt;
  if out_CycCrossCycTaken is null then set out_CycCrossCycTaken=0
  end if;
  return out_CycCrossCycTaken
end
;

create function DBA.FGetEmployeeLeaveGroup(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_LeaveGroupId char(20);
  select LeaveEmployee.LeaveGroupId into Out_LeaveGroupId
    from LeaveEmployee where
    LeaveEmployee.EmployeeSysId = In_EmployeeSysId;
  return(Out_LeaveGroupId)
end
;

create function dba.FGetHolidayDesc(
in In_CalendarIDCode char(20),
in In_CalendarDate date)
returns char(80)
begin
  declare out_HolidayDesc char(80);
  select HolidayDesc into out_HolidayDesc from Holidays where
    HolidayStartDate = In_CalendarDate and
    CountryID = (select CountryCode from Calendar where CalendarId = In_CalendarIDCode);
  return(out_HolidayDesc)
end
;

create function dba.FGetLeaveTypeRoundingMethod(
in In_LeaveTypeID char(20))
returns char(20)
begin
  declare Out_RoundingMethod char(20);
  select LeaveRoundMethod into Out_RoundingMethod from LeaveComputation where
    LeaveTypeID = In_LeaveTypeID;
  return(Out_RoundingMethod)
end
;

create function DBA.FGetLveAutoOption(
in In_EmployeeSysId integer,
in In_PayLeaveTypeId char(20))
returns smallint
begin
  declare Out_LveAutoOption smallint;
  select PayLeaveSetting.LveAutoOption into Out_LveAutoOption
    from PayLeaveSetting where
    PayLeaveSetting.EmployeeSysId = In_EmployeeSysId and
    PayLeaveSetting.PayLeaveTypeId = In_PayLeaveTypeId;
  return(Out_LveAutoOption)
end
;

create function dba.FGetLveCosting(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
in In_Days double)
returns double
begin
  declare Out_CycCostPerDay double;
  select CycCostPerDay into Out_CycCostPerDay from LeaveCycleRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt;
  return Round(In_Days*Out_CycCostPerDay,2)
end
;

create function dba.FGetLveCreditEarned(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_EffectiveDate date)
returns double
begin
  declare Out_TotalEarned double;
  select Sum(AdjDays) into Out_TotalEarned from AdjustCredit where EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and AdjEffectiveDate <= In_EffectiveDate;
  if(Out_TotalEarned is null) then set Out_TotalEarned=0
  end if;
  return Out_TotalEarned
end
;

create function dba.FGetLveCreditExpired(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_ExpiredDate date)
returns double
begin
  declare Out_TotalExpired double;
  declare Out_TotalTaken double;
  declare In_ExpiredTakenDays double;
  declare In_ExpiredDays double;
  declare In_RemainTakenDays double;
  /*
  Create Temporary Table to store the Credit Leave Application so as to strike off one expired if taken
  */
  if not exists(select* from Systable where Table_name = 'ExpiredLeaveRecord') then
    create global temporary table dba.ExpiredLeaveRecord(
      ExpiredLeaveRecordId integer not null default autoincrement,
      LeaveAppSGSPGenId char(30) not null,
      LveRecDate date not null,
      LveRecStartTime time not null,
      LveRecConvertDays double not null,
      primary key(ExpiredLeaveRecordId),
      ) on commit delete rows;
    message 'Expired Leave Record Table Created' type info to client
  else
    delete from ExpiredLeaveRecord
  end if;
  /*
  Get Credit Leave that has expire date
  */
  set Out_TotalExpired=0;
  CreditLeaveLoop: for CreditLeaveFor as CreditLeaveCurs dynamic scroll cursor for
    select CreditExpireDate as In_CreditExpireDate,
      AdjEffectiveDate as In_AdjEffectiveDate,
      AdjDays as In_AdjDays from AdjustCredit where EmployeeSysId = In_EmployeeSysId and
      LeaveTypeId = In_LeaveTypeId and
      CreditExpireDate <= In_ExpiredDate and
      CreditExpireDate <> '1899-12-30' order by AdjEffectiveDate asc,CreditExpireDate asc do
    message cast(In_AdjEffectiveDate as char(10))+' '+cast(In_CreditExpireDate as char(10))+' '+cast(In_AdjDays as char(3)) type info to client;
    set In_ExpiredDays=In_AdjDays;
    /*
    Get Credit Leave that has expire date
    */
    LeaveRecordLoop: for LeaveRecordFor as LeaveRecordCurs dynamic scroll cursor for
      select LeaveApplication.LeaveAppSGSPGenId as In_LeaveAppSGSPGenId,
        LeaveRecord.LveRecDate as In_LveRecDate,
        LeaveRecord.LveRecStartTime as In_LveRecStartTime,
        LeaveRecord.LveRecConvertDays as In_TakenDays from
        LeaveRecord join LeaveApplication where EmployeeSysId = In_EmployeeSysId and
        LeaveApplication.LeaveTypeId = In_LeaveTypeId and
        LeaveRecord.LveRecDate <= In_CreditExpireDate and
        LeaveRecord.LveRecDate >= In_AdjEffectiveDate order by LeaveRecord.LveRecDate asc do
      if(In_ExpiredDays > 0) then
        /*
        Sum the total taken from ExpiredLeaveRecord
        */
        select sum(LveRecConvertDays) into In_ExpiredTakenDays from ExpiredLeaveRecord where
          LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
          LveRecDate = In_LveRecDate and
          LveRecStartTime = In_LveRecStartTime;
        if In_ExpiredTakenDays is null then set In_ExpiredTakenDays=0
        end if;
        set In_RemainTakenDays=In_TakenDays-In_ExpiredTakenDays;
        /*
        Leave Record is already consumed
        */
        if(In_RemainTakenDays > 0) then
          message Space(5)+In_LeaveAppSGSPGenId+' '+
            cast(In_LveRecDate as char(10))+' '+
            cast(In_LveRecStartTime as char(8))+' '+
            cast(In_TakenDays as char(8))+' '+
            cast(In_RemainTakenDays as char(8)) type info to client;
          /*
          Leave application is more than Expired Day
          */
          if(In_RemainTakenDays >= In_ExpiredDays) then
            set In_RemainTakenDays=In_ExpiredDays
          end if;
          /*
          Leave application is marked
          */
          insert into ExpiredLeaveRecord(LeaveAppSGSPGenId,
            LveRecDate,
            LveRecStartTime,
            LveRecConvertDays) values(
            In_LeaveAppSGSPGenId,In_LveRecDate,In_LveRecStartTime,In_RemainTakenDays);
          set In_ExpiredDays=In_ExpiredDays-In_RemainTakenDays;
          message Space(10)+'Taken : '+cast(In_RemainTakenDays as char(8)) type info to client
        end if
      end if end for;
    /*
    End of Leave Application Loop
    */
    if In_ExpiredDays > 0 then
      set Out_TotalExpired=Out_TotalExpired+In_ExpiredDays
    end if;
    message Space(5)+'Expired :  '+cast(In_ExpiredDays as char(8)) type info to client end for;
  /*
  End of Credit Leave Loop
  */
  message 'Total Expired :  '+cast(Out_TotalExpired as char(8)) type info to client;
  delete from ExpiredLeaveRecord;
  return Out_TotalExpired
end
;

create function dba.FGetLveCreditNotEarned(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_EffectiveDate date)
returns double
begin
  declare Out_TotalNotEarned double;
  select Sum(AdjDays) into Out_TotalNotEarned from AdjustCredit where EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and AdjEffectiveDate > In_EffectiveDate;
  if(Out_TotalNotEarned is null) then set Out_TotalNotEarned=0
  end if;
  return Out_TotalNotEarned
end
;

create function dba.FGetLveCreditTaken(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_EffectiveDate date)
returns double
begin
  declare Out_TotalTaken double;
  /*
  Get Leave Records Taken before Expire Date
  */
  select Sum(LveRecConvertDays) into Out_TotalTaken from LeaveRecord where
    LeaveAppSGSPGenId = any(select LeaveAppSGSPGenId from LeaveApplication where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeId = In_LeaveTypeId and
      LveRecApproved = 1) and LveRecDate <= In_EffectiveDate;
  if(Out_TotalTaken is null) then set Out_TotalTaken=0
  end if;
  return Out_TotalTaken
end
;

create function dba.FGetLveCrossTaken(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LeaveTypeId char(20))
returns double
begin
  declare Out_CycEndDate date;
  declare Out_CrossTaken double;
  /*
  Check Following Years not initialised
  */
  if(exists(select* from LeaveCycleRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt >= In_LveYear+1 and
      LeaveTypeId = In_LeaveTypeId)) then
    return 0
  end if;
  select CycEndDate into Out_CycEndDate from LeaveCycleRpt where
    EmployeeSysId = In_EmployeeSysId and
    LveYearRpt = In_LveYear and
    LeaveTypeId = In_LeaveTypeId;
  select Sum(LveRecConvertDays) into Out_CrossTaken from LeaveRecord join LeaveApplication where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveRecDate > Out_CycEndDate and
    LveRecApproved = 1;
  if(Out_CrossTaken is null) then return 0
  end if;
  return Out_CrossTaken
end
;

create function dba.FGetLveDayRateID(
in In_EmployeeSysId integer,
in In_PayLeaveTypeId char(20))
returns char(20)
begin
  declare Out_LveDayRateId char(20);
  select PayLeaveSetting.LveDayRateId into Out_LveDayRateId
    from PayLeaveSetting where
    PayLeaveSetting.EmployeeSysId = In_EmployeeSysId and
    PayLeaveSetting.PayLeaveTypeId = In_PayLeaveTypeId;
  return(Out_LveDayRateId)
end
;

create function dba.FGetLveEntReportPeriod(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
in In_UntilDate date)
returns integer
begin
  declare Out_LvePeriodRpt integer;
  select LvePeriodRpt into Out_LvePeriodRpt
    from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt and
    PeriodStartDate <= In_UntilDate and
    PeriodEndDate >= In_UntilDate;
  if(Out_LvePeriodRpt is null) then set Out_LvePeriodRpt=0
  end if;
  return Out_LvePeriodRpt
end
;

create function dba.FGetLveEntReportYTDBFForfeit(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
in In_LvePeriodRpt integer)
returns double
begin
  declare Out_YTDBFForfeit double;
  select YTDBFForfeit into Out_YTDBFForfeit
    from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt and
    LvePeriodRpt = In_LvePeriodRpt;
  if(Out_YTDBFForfeit is null) then set Out_YTDBFForfeit=0
  end if;
  return Out_YTDBFForfeit
end
;

create function dba.FGetLveEntReportYTDDayTaken(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
in In_LvePeriodRpt integer)
returns double
begin
  declare Out_YTDDayTaken double;
  select YTDDayTaken into Out_YTDDayTaken
    from LvePeriodBalRpt where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeId = In_LeaveTypeId and
    LveYearRpt = In_LveYearRpt and
    LvePeriodRpt = In_LvePeriodRpt;
  if(Out_YTDDayTaken is null) then set Out_YTDDayTaken=0
  end if;
  return Out_YTDDayTaken
end
;

create function dba.FGetLveHourRateID(
in In_EmployeeSysId integer,
in In_PayLeaveTypeId char(20))
returns char(20)
begin
  declare Out_LveHourRateId char(20);
  select PayLeaveSetting.LveHourRateId into Out_LveHourRateId
    from PayLeaveSetting where
    PayLeaveSetting.EmployeeSysId = In_EmployeeSysId and
    PayLeaveSetting.PayLeaveTypeId = In_PayLeaveTypeId;
  return(Out_LveHourRateId)
end
;

create function dba.FGetLvKeyWordUserDefinedName(
in In_LveKeyWordId char(20))
returns char(100)
begin
  declare Out_LveKeyWordUserDefinedName char(100);
  select LveKeyWordUserDefinedName into Out_LveKeyWordUserDefinedName from Leavekeyword where
    LveKeyWordId = In_LveKeyWordId;
  if(Out_LveKeyWordUserDefinedName is null or Out_LveKeyWordUserDefinedName = '') then
    return(In_LveKeyWordId)
  else return(Out_LveKeyWordUserDefinedName)
  end if
end
;

create function dba.FGetRangeBasisDesc(
in In_SubRegistryId char(20))
returns char(100)
begin
  declare Out_RangeBasisDesc char(100);
  select RegProperty2 into Out_RangeBasisDesc from SubRegistry where
    RegistryId = 'LeaveRangeBasis' and SubRegistryId = In_SubRegistryId;
  if(Out_RangeBasisDesc is null or Out_RangeBasisDesc = '') then
    return(In_SubRegistryId)
  else return(Out_RangeBasisDesc)
  end if
end
;

create function dba.FRoundHalf(
in in_value double)
returns double
begin
  declare flag double;
  declare deci double;
  set flag=1.0;
  if(in_value < 0) then
    set in_value=in_value*-1;
    set flag=-1.0
  end if;
  set deci=in_value-cast(in_value as integer);
  if(deci < .00001) then
    return(in_value*flag)
  elseif(deci+.00001 <= .5) then
    set in_value=cast(in_value as integer)+.5
  elseif(deci >= .4999 and deci <= .50001) then return(in_value*flag)
  else
    set in_value=cast(in_value as integer)+1.0
  end if;
  return(in_value*flag)
end
;

create function dba.FRoundQuarter(
in in_value double)
returns double
begin
  declare flag double;
  declare deci double;
  set flag=1.0;
  if(in_value < 0) then
    set in_value=in_value*-1;
    set flag=-1.0
  end if;
  set deci=in_value-cast(in_value as integer);
  if(deci+.00001 < .25) then
    set in_value=cast(in_value as integer)
  elseif(deci+.00001 >= .25 and deci+.00001 < .75) then
    set in_value=cast(in_value as integer)+.5
  else
    set in_value=cast(in_value as integer)+1.0
  end if;
  return(in_value*flag)
end
;

create procedure dba.InsertNewAdjustCredit(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_AdjEffectiveDate date,
in In_AdjType smallint,
in In_LeaveReasonId char(20),
in In_AdjDays double,
in In_CreditExpireDate date,
in In_Remarks char(100))
begin
  if
    not exists(select* from AdjustCredit where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId and
      AdjustCredit.LeaveTypeId = In_LeaveTypeId and
      AdjustCredit.AdjEffectiveDate = In_AdjEffectiveDate and
      AdjustCredit.AdjType = In_AdjType) then
    insert into AdjustCredit(EmployeeSysId,
      LeaveTypeId,
      AdjEffectiveDate,
      AdjType,
      LeaveReasonId,
      AdjDays,
      CreditExpireDate,
      Remarks) values(
      In_EmployeeSysId,
      In_LeaveTypeId,
      In_AdjEffectiveDate,
      In_AdjType,
      In_LeaveReasonId,
      In_AdjDays,
      In_CreditExpireDate,
      In_Remarks);
    commit work
  end if
end
;

create procedure dba.InsertNewCostingMethod(
in In_CostingMethodId char(20),
in In_CostingMethod char(20),
in In_CostingAllocationBasis char(20),
in In_CostingDesc char(100))
begin
  if not exists(select* from CostingMethod where CostingMethod.CostMethodId = In_CostingMethodId) then
    insert into CostingMethod(CostMethodId,CostingMethod,CostingAllocationBasis,CostingDesc) values(
      In_CostingMethodId,In_CostingMethod,In_CostingAllocationBasis,In_CostingDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveAllocation(
in In_LveAllocationEntitle double,
in In_MinServiceYear double,
in In_MaxServiceYear double,
in In_MaxBrForward double,
in In_LeaveAllocatGroupId char(20))
begin
  insert into LeaveAllocation(LveAllocationEntitle,
    LeaveAllocatGroupId,
    MinServiceYear,MaxServiceYear,
    MaxBrForward) values(
    In_LveAllocationEntitle,In_LeaveAllocatGroupId,
    In_MinServiceYear,In_MaxServiceYear,In_MaxBrForward);
  commit work
end
;

create procedure dba.InsertNewLeaveAllocationGroup(
in In_LeaveAllocatGroupId char(20),
in In_LveAllocatGroupDesc char(100))
begin
  if not exists(select* from LeaveAllocationGroup where
      LeaveAllocationGroup.LeaveAllocatGroupId = In_LeaveAllocatGroupId) then
    insert into LeaveAllocationGroup(LeaveAllocatGroupId,
      LveAllocatGroupDesc) values(
      In_LeaveAllocatGroupId,In_LveAllocatGroupDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveAllocationGroupType(
in In_LeaveGroupId char(20),
in In_LeaveTypeId char(20),
in In_LeaveAllocatGroupId char(20)
,in In_ProrationId char(20),
in In_LeaveTransferId char(20),
in In_EntitlementRoundId char(20),
in In_LeaveCutOffDate integer,
in In_LeaveMethodId char(10),
in In_LeaveEndMth integer,
in In_LeaveStartMth integer,
in In_MaxAdvLveAllowed double,
in In_MaxHalfDayLveAllowed double,
in In_BroughtForward char(30))
begin
  if not exists(select* from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId and
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId and
      LeaveAllocationGroupType.LeaveAllocatGroupId = In_LeaveAllocatGroupId) then
    insert into LeaveAllocationGroupType(LeaveGroupId,
      LeaveTypeId,
      LeaveAllocatGroupId,ProrationId,
      LeaveTransferId,EntitlementRoundId,
      LeaveCutOffDate,LeaveMethodId,
      LeaveEndMth,LeaveStartMth,MaxAdvLveAllowed,MaxHalfDayLveAllowed,BroughtForward) values(
      In_LeaveGroupId,In_LeaveTypeId,In_LeaveAllocatGroupId,
      In_ProrationId,In_LeaveTransferId,In_EntitlementRoundId,
      In_LeaveCutOffDate,In_LeaveMethodId,In_LeaveEndMth,
      In_LeaveStartMth,In_MaxAdvLveAllowed,In_MaxHalfDayLveAllowed,In_BroughtForward);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveApplication(
in In_EmployeeSysId integer,
in In_LeaveReasonId char(20),
in In_LeaveTypeId char(20),
in In_LveRecCategory char(20),
in In_LveAppFromDate date,
in In_LveAppStartTime time,
in In_LveAppToDate date,
in In_LveAppEndTime time,
in In_LveAppIsHour smallint,
in In_LveRecApproved smallint,
in In_Remarks char(200),
in In_Status char(20),
in In_LastModified timestamp,
in In_CreatedBy char(1),
out Out_LeaveAppSGSPGenId char(30))
begin
  select FGetNewSGSPGeneratedIndex('LeaveApplication') into Out_LeaveAppSGSPGenId;
  if not exists(select* from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId and
      LeaveApplication.LeaveTypeId = In_LeaveTypeId and
      LeaveApplication.LveAppFromDate = In_LveAppFromDate and
      LeaveApplication.LveAppToDate = In_LveAppToDate and
      LeaveApplication.LveAppStartTime = In_LveAppStartTime) then
    insert into LeaveApplication(LeaveAppSGSPGenId,
      EmployeeSysId,
      LeaveReasonId,
      LeaveTypeId,
      LveRecCategory,
      LveAppFromDate,
      LveAppStartTime,
      LveAppToDate,
      LveAppEndTime,
      LveAppIsHour,
      LveRecApproved,
      Remarks,
      Status,
      LastModified,
      CreatedBy) values(
      Out_LeaveAppSGSPGenId,
      In_EmployeeSysId,
      In_LeaveReasonId,
      In_LeaveTypeId,
      In_LveRecCategory,
      In_LveAppFromDate,
      In_LveAppStartTime,
      In_LveAppToDate,
      In_LveAppEndTime,
      In_LveAppIsHour,
      In_LveRecApproved,
      In_Remarks,
      In_Status,
      In_LastModified,
      In_CreatedBy);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveComputation(
in In_LeaveTypeId char(20),
in In_HasEntitleApp smallint,
in In_HasBFApp smallint,
in In_HasForfeitApp smallint,
in In_HasAdvApp smallint,
in In_HasHourApp smallint,
in In_HasHalfDayApp smallint,
in In_LeaveRoundMethod char(20),
in In_EntProrateMethod char(20),
in In_EntProrateCutOffDay integer,
in In_EntProrateBeforeCutoff double,
in In_NoProrateCareerChange smallint,
in In_NoProrateHire smallint,
in In_NoProrateCess smallint,
in In_EntDistributeMethod char(20),
in In_BFLeaveTypeId char(20),
in In_BFForfeitTime integer,
in In_CanHalfDayApplyHour smallint,
in In_LeaveFunctionId char(20),
in In_HireSuspendMethod char(20),
in In_HireSuspendUntil integer,
in In_CessSuspendMethod char(20),
in In_CessSuspendStart integer,
in In_HasDeductSeq integer,
in In_IncludeHolidayOff smallint,
in In_EntTakenNoEnt smallint,
in In_HasSIWageDeduct smallint,
in In_HasSIReimbursement smallint,
in In_C04ContriRate double,
in In_HasLeaveSuspension smallint,
in In_LeaveSuspensionMethod char(20),
in In_LeaveSuspensionValue integer,
in In_LeaveSuspensionField char(20),
in In_TotalEntRoundMethod smallint)
begin
  if not exists(select* from LeaveComputation where
      LeaveComputation.LeaveTypeId = In_LeaveTypeId) then
    insert into LeaveComputation(LeaveTypeId,
      HasEntitleApp,
      HasBFApp,
      HasForfeitApp,
      HasAdvApp,
      HasHourApp,
      HasHalfDayApp,
      LeaveRoundMethod,
      EntProrateMethod,
      EntProrateCutOffDay,
      EntProrateBeforeCutoff,
      NoProrateCareerChange,
      NoProrateHire,
      NoProrateCess,
      EntDistributeMethod,
      BFLeaveTypeId,
      BFForfeitTime,
      CanHalfDayApplyHour,
      LeaveFunctionId,
      HireSuspendMethod,
      HireSuspendUntil,
      CessSuspendMethod,
      CessSuspendStart,
      HasDeductSeq,
      IncludeHolidayOff,
      EntTakenNoEnt,HasSIWageDeduct,
      HasSIReimbursement,
      C04ContriRate,
      HasLeaveSuspension,
      LeaveSuspensionMethod,
      LeaveSuspensionValue,
      LeaveSuspensionField,
      TotalEntRoundMethod) values(
      In_LeaveTypeId,
      In_HasEntitleApp,
      In_HasBFApp,
      In_HasForfeitApp,
      In_HasAdvApp,
      In_HasHourApp,
      In_HasHalfDayApp,
      In_LeaveRoundMethod,
      In_EntProrateMethod,
      In_EntProrateCutOffDay,
      In_EntProrateBeforeCutoff,
      In_NoProrateCareerChange,
      In_NoProrateHire,
      In_NoProrateCess,
      In_EntDistributeMethod,
      In_BFLeaveTypeId,
      In_BFForfeitTime,
      In_CanHalfDayApplyHour,
      In_LeaveFunctionId,
      In_HireSuspendMethod,
      In_HireSuspendUntil,
      In_CessSuspendMethod,
      In_CessSuspendStart,
      In_HasDeductSeq,
      In_IncludeHolidayOff,
      In_EntTakenNoEnt,
      In_HasSIWageDeduct,
      In_HasSIReimbursement,
      In_C04ContriRate,
      In_HasLeaveSuspension,
      In_LeaveSuspensionMethod,
      In_LeaveSuspensionValue,
      In_LeaveSuspensionField,
      In_TotalEntRoundMethod);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveCutOffDate(
in In_PayGroupId char(20),
in In_SubPeriod integer,
in In_CutOffPayLveTypeId char(20),
in In_CutOffFromDay char(20),
in In_CutOffFromMonth char(20),
in In_CutOffEndDay char(20),
in In_CutOffEndMonth char(20))
begin
  if not exists(select* from LeaveCutOffDate where LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod and LeaveCutOffDate.CutOffPayLveTypeId = In_CutOffPayLveTypeId) then
    insert into LeaveCutOffDate(PayGroupId,SubPeriod,
      CutOffPayLveTypeId,CutOffFromDay,
      CutOffFromMonth,CutOffEndDay,
      CutOffEndMonth) values(
      In_PayGroupId,In_SubPeriod,
      In_CutOffPayLveTypeId,In_CutOffFromDay,
      In_CutOffFromMonth,In_CutOffEndDay,
      In_CutOffEndMonth);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveCycleRpt(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LeaveTypeId char(20),
in In_CycStartDate date,
in In_CycEndDate date,
in In_CycEntEarned double,
in In_CycEntAdjEarned double,
in In_CycBFEarned double,
in In_CycBFForfeit double,
in In_CycTotalEnt double,
in In_CycDayTaken double,
in In_CycCrossCycTaken double,
in In_CycBalance double,
in In_CycLastUpdate timestamp,
in In_CycStatus char(20),
in In_CycCostPerDay double)
begin
  if not exists(select* from LeaveCycleRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LeaveTypeId = In_LeaveTypeId) then
    insert into LeaveCycleRpt(EmployeeSysId,
      LveYearRpt,
      LeaveTypeId,
      CycStartDate,
      CycEndDate,
      CycEntEarned,
      CycEntAdjEarned,
      CycBFEarned,
      CycBFForfeit,
      CycTotalEnt,
      CycDayTaken,
      CycCrossCycTaken,
      CycBalance,
      CycLastUpdate,
      CycStatus,
      CycCostPerDay) values(
      In_EmployeeSysId,
      In_LveYearRpt,
      In_LeaveTypeId,
      In_CycStartDate,
      In_CycEndDate,
      In_CycEntEarned,
      In_CycEntAdjEarned,
      In_CycBFEarned,
      In_CycBFForfeit,
      In_CycTotalEnt,
      In_CycDayTaken,
      In_CycCrossCycTaken,
      In_CycBalance,
      In_CycLastUpdate,
      In_CycStatus,
      In_CycCostPerDay);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveDeductionRecord(
in In_EmployeeSysId integer,
in In_LeaveTypeFunctCode char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_CurrentLveDays double,
in In_CurrentLveHours double,
in In_PerviousLveIncDays double,
in In_PerviousLveIncHours double,
in In_LveAutoOption smallint,
in In_LveAmount double,
in In_LveDayRateId char(20),
in In_LveHourRateId char(20),
in In_CurrentDayRateAmt double,
in In_CurrentHourRateAmt double,
in In_PreviousDayRateAmt double,
in In_PreviousHourRateAmt double,
in In_LveDedCreatedBy char(20))
begin
  declare In_PaySubPeriodSGSPGenId char(30);
  if not exists(select* from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveTypeFunctCode = In_LeaveTypeFunctCode) then
    select PaySubPeriodSGSPGenId into In_PaySubPeriodSGSPGenId from SubPeriodREcord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if(In_PaySubPeriodSGSPGenId is not null) then
      insert into LeaveDeductionRecord(LveDeductSGSPGenId,
        EmployeeSysId,
        PaySubPeriodSGSPGenId,
        LeaveTypeFunctCode,
        PayRecYear,
        PayRecPeriod,
        PayRecSubPeriod,
        CurrentLveDays,
        CurrentLveHours,
        PreviousLveIncDays,
        PreviousLveIncHours,
        LveAutoOption,
        LveAmount,
        LveDayRateId,
        LveHourRateId,
        CurrentDayRateAmt,
        CurrentHourRateAmt,
        PreviousDayRateAmt,
        PreviousHourRateAmt,
        LveDedCreatedBy) values(
        FGetNewSGSPGeneratedIndex('LeaveDeductionRecord'),
        In_EmployeeSysId,
        In_PaySubPeriodSGSPGenId,
        In_LeaveTypeFunctCode,
        In_PayRecYear,
        In_PayRecPeriod,
        In_PayRecSubPeriod,
        In_CurrentLveDays,
        In_CurrentLveHours,
        In_PerviousLveIncDays,
        In_PerviousLveIncHours,
        In_LveAutoOption,
        In_LveAmount,
        In_LveDayRateId,
        In_LveHourRateId,
        In_CurrentDayRateAmt,
        In_CurrentHourRateAmt,
        In_PreviousDayRateAmt,
        In_PreviousHourRateAmt,'');
      commit work
    end if
  end if
end
;

create procedure dba.InsertNewLeaveEmployee(
in In_EmployeeSysId integer,
in In_LeaveGroupId char(20),
in In_WTCalendarId char(20),
in In_HasShiftRotation smallint,
in In_FullDayWorkTimeProfile char(20),
in In_HalfDayWorkTimeProfile char(20),
in In_SuspendLeave smallint,
in In_QuarterDayWorkTimeProfile char(20))
begin
  if not exists(select* from LeaveEmployee where
      LeaveEmployee.EmployeeSysId = In_EmployeeSysId) then
    insert into LeaveEmployee(EmployeeSysId,
      LeaveGroupId,
      WTCalendarId,
      HasShiftRotation,
      FullDayWorkTimeProfile,
      HalfDayWorkTimeProfile,
      SuspendLeave,
      QuarterDayWorkTimeProfile) values(
      In_EmployeeSysId,
      In_LeaveGroupId,
      In_WTCalendarId,
      In_HasShiftRotation,
      In_FullDayWorkTimeProfile,
      In_HalfDayWorkTimeProfile,
      In_SuspendLeave,
      In_QuarterDayWorkTimeProfile);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveFormula(
in In_LveFormulaId char(30),
in In_LveFormulaActive integer,
in In_LveFormulaCategory char(20),
in In_LveFormulaDesc char(100),
in In_LveFormulaRangeBasis char(20),
in In_LveFormulaSubCategory char(20),
in In_LveFormulaType char(20))
begin
  insert into LeaveFormula(LveFormulaId,LveFormulaActive,LveFormulaCategory,LveFormulaDesc,LveFormulaRangeBasis,LveFormulaSubCategory,LveFormulaType) values(
    In_LveFormulaId,In_LveFormulaActive,In_LveFormulaCategory,In_LveFormulaDesc,In_LveFormulaRangeBasis,In_LveFormulaSubCategory,In_LveFormulaType);
  commit work
end
;

create procedure dba.InsertNewLeaveGroup(
in In_LeaveGroupId char(20),
in In_LeaveGroupDesc char(100))
begin
  if not exists(select* from LeaveGroup where
      LeaveGroup.LeaveGroupId = In_LeaveGroupId) then
    insert into LeaveGroup(LeaveGroupId,
      LeaveGroupDesc) values(
      In_LeaveGroupId,
      In_LeaveGroupDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveGroupCalendar(
in In_LeaveGroupId char(20),
in In_LveCalGroupDate date,
in In_LeavePattern double)
begin
  if not exists(select* from LeaveGroupCalendar where
      LeaveGroupCalendar.LveCalGroupDate = In_LveCalGroupDate and
      LeaveGroupCalendar.LeaveGroupId = In_LeaveGroupId) then
    insert into LeaveGroupCalendar(LeaveGroupId,
      LveCalGroupDate,LeavePattern) values(
      In_LeaveGroupId,In_LveCalGroupDate,In_LeavePattern);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveInfoRecord(
in In_EmployeeSysId integer,
in In_LeaveTypeFunctCode char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LveBroughtForward double,
in In_CurrLveEntitlement double,
in In_CurrLvePeriodTaken double,
in In_LeaveInfoCreatedBy char(20))
begin
  declare In_PaySubPeriodSGSPGenId char(30);
  if not exists(select* from LeaveInfoRecord where
      LeaveInfoRecord.EmployeeSysId = In_EmployeeSysId and
      LeaveInfoRecord.PayRecYear = In_PayRecYear and
      LeaveInfoRecord.PayRecPeriod = In_PayRecPeriod and
      LeaveInfoRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      LeaveInfoRecord.LeaveTypeFunctCode = In_LeaveTypeFunctCode) then
    select PaySubPeriodSGSPGenId into In_PaySubPeriodSGSPGenId from SubPeriodREcord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if(In_PaySubPeriodSGSPGenId is not null) then
      insert into LeaveInfoRecord(LeaveInfoSGSPGenId,
        EmployeeSysId,
        PaySubPeriodSGSPGenId,
        LeaveTypeFunctCode,
        PayRecYear,
        PayRecPeriod,
        PayRecSubPeriod,
        LveBroughtForward,
        CurrLveEntitlement,
        CurrLvePeriodTaken,
        LeaveInfoCreatedBy) values(
        FGetNewSGSPGeneratedIndex('LeaveInfoRecord'),
        In_EmployeeSysId,
        In_PaySubPeriodSGSPGenId,
        In_LeaveTypeFunctCode,
        In_PayRecYear,
        In_PayRecPeriod,
        In_PayRecSubPeriod,
        In_LveBroughtForward,
        In_CurrLveEntitlement,
        In_CurrLvePeriodTaken,'');
      commit work
    end if
  end if
end
;

create procedure dba.InsertNewLeaveInitialisedGroup(
in In_LeaveGroupId char(20),
in In_GroupStartYrMonth integer,
in In_GroupEndYrMonth integer,
in In_Status integer)
begin
  if not exists(select* from LeaveInitialisedGroup where
      LeaveInitialisedGroup.LeaveGroupId = In_LeaveGroupId and
      LeaveInitialisedGroup.GroupStartYrMth = In_GroupStartYrMonth) then
    insert into LeaveInitialisedGroup(LeaveGroupId,
      GroupStartYrMth,GroupEndYrMth,LveGroupStatus) values(
      In_LeaveGroupId,In_GroupStartYrMonth,In_GroupEndYrMonth,In_Status);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveKeyword(
in In_LveKeywordId char(20),
in In_LveKeywordUserDefinedName char(100),
in In_LveKeywordDesc char(100),
in In_LveKeywordCategory char(20))
begin
  if not exists(select* from LeaveKeyword where LeaveKeyword.LveKeywordId = In_LveKeywordId) then
    insert into LeaveKeyword(LveKeywordId,LveKeywordUserDefinedName,LveKeywordDesc,LveKeywordCategory) values(
      In_LveKeywordId,In_LveKeywordUserDefinedName,In_LveKeywordDesc,In_LveKeywordCategory);
    commit work
  end if
end
;

create procedure dba.InsertNewLeavePolicy(
in In_LeavePolicyId char(20),
in In_LeavePolicyDesc char(40),
in In_LeavePolicyBasis char(20),
in In_LeaveCalendarType char(20),
in In_LeaveStartMonth integer)
begin
  if not exists(select* from LeavePolicy where LeavePolicy.LeavePolicyId = In_LeavePolicyId) then
    insert into LeavePolicy(LeavePolicyId,LeavePolicyDesc,LeavePolicyBasis,LeaveCalendarType,LeaveStartMonth) values(
      In_LeavePolicyId,In_LeavePolicyDesc,In_LeavePolicyBasis,In_LeaveCalendarType,In_LeaveStartMonth);
    commit work
  end if
end
;

create procedure dba.InsertNewLeavePolicyRecord(
in In_PolicySysId integer,
in In_LeavePolicyId char(20),
in In_LveAllocationId char(20),
in In_LeaveTypeId char(20),
in In_CostMethodId char(20),
in In_PolicyStringMatch char(20),
in In_PolicyRangeFrom double,
in In_PolicyRangeTo double)
begin
  if not exists(select* from LeavePolicyRecord where LeavePolicyRecord.PolicySysId = In_PolicySysId) then
    insert into LeavePolicyRecord(PolicySysId,LeavePolicyId,LveAllocationId,LeaveTypeId,CostMethodId,PolicyStringMatch,PolicyRangeFrom,PolicyRangeTo) values(
      In_PolicySysId,In_LeavePolicyId,In_LveAllocationId,In_LeaveTypeId,In_CostMethodId,In_PolicyStringMatch,In_PolicyRangeFrom,In_PolicyRangeTo);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveRange(
in In_LveFormulaRangeId integer,
in In_LveFormulaId char(30),
in In_Formula char(255),
in In_SearchString char(100),
in In_Maximum double,
in In_Minimum double,
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20))
begin
  insert into LeaveRange(LveFormulaRangeId,LveFormulaId,Formula,SearchString,Maximum,Minimum,
    Constant1,Constant2,Constant3,Constant4,Constant5,
    Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,
    UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values(
    In_LveFormulaRangeId,In_LveFormulaId,In_Formula,In_SearchString,In_Maximum,In_Minimum,
    In_Constant1,In_Constant2,In_Constant3,In_Constant4,In_Constant5,
    In_Keywords1,In_Keywords2,In_Keywords3,In_Keywords4,In_Keywords5,In_Keywords6,In_Keywords7,In_Keywords8,In_Keywords9,In_Keywords10,
    In_UserDef1,In_UserDef2,In_UserDef3,In_UserDef4,In_UserDef5);
  commit work
end
;

create procedure dba.InsertNewLeaveReason(
in In_LeaveReasonId char(20),
in In_LeaveReason char(100))
begin
  if not exists(select* from LeaveReason where
      LeaveReason.LeaveReasonId = In_LeaveReasonId) then
    insert into LeaveReason(LeaveReasonId,
      LeaveReason) values(
      In_LeaveReasonId,In_LeaveReason);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveRecord(
in In_LeaveAppSGSPGenId char(30),
in In_LveRecDate date,
in In_LveRecStartTime time,
in In_LveRecEndTime time,
in In_LveRecDays double,
in In_LveRecHours double,
in In_LveRecConvertDays double,
in In_LveRecCalendarDay double,
in In_LveCertificationDate date)
begin
  if not exists(select* from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime) then
    insert into LeaveRecord(LeaveAppSGSPGenId,
      LveRecDate,
      LveRecStartTime,
      LveRecEndTime,
      LveRecDays,
      LveRecHours,
      LveRecConvertDays,
      LveRecCalendarDay,LveCertificationDate) values(
      In_LeaveAppSGSPGenId,
      In_LveRecDate,
      In_LveRecStartTime,
      In_LveRecEndTime,
      In_LveRecDays,
      In_LveRecHours,
      In_LveRecConvertDays,
      In_LveRecCalendarDay,In_LveCertificationDate);
    commit work
  end if
end
;

create procedure dba.InsertNewLeaveType(
in In_LeaveTypeId char(20),
in In_LeaveCredit smallint,
in In_LeaveAbbrev char(2),
in In_LeaveColorCode integer,
in In_LeaveTypeActive smallint,
in In_LeaveTypeDesc char(100),
in In_LeaveUnit smallint,
in In_HasSpecialEligible smallint,
in In_SpecialEligibleCode char(20),
in In_SpecialEligibleMethod char(20),
in In_SpecialEligibleValue integer)
begin
  if not exists(select* from LeaveType where
      LeaveType.LeaveTypeId = In_LeaveTypeId) then
    insert into LeaveType(LeaveTypeId,
      LeaveCredit,
      LeaveAbbrev,
      LeaveColorCode,
      LeaveTypeActive,
      LeaveTypeDesc,
      LeaveUnit,
      HasSpecialEligible,
      SpecialEligibleCode,
      SpecialEligibleMethod,
      SpecialEligibleValue) values(
      In_LeaveTypeId,
      In_LeaveCredit,
      In_LeaveAbbrev,
      In_LeaveColorCode,
      In_LeaveTypeActive,
      In_LeaveTypeDesc,
      In_LeaveUnit,
      In_HasSpecialEligible,
      In_SpecialEligibleCode,
      In_SpecialEligibleMethod,
      In_SpecialEligibleValue);
    commit work
  end if
end
;

create procedure dba.InsertNewLveAllocation(
in In_LveAllocationId char(20),
in In_LveAllocationDesc char(100),
in In_LveAllocationBasis char(20))
begin
  if not exists(select* from LveAllocation where LveAllocation.LveAllocationId = In_LveAllocationId) then
    insert into LveAllocation(LveAllocationId,LveAllocationDesc,LveAllocationBasis) values(
      In_LveAllocationId,In_LveAllocationDesc,In_LveAllocationBasis);
    commit work
  end if
end
;

create procedure dba.InsertNewLveAllocationRec(
in In_LveAllocationId char(20),
in In_LveAllocationSysId integer,
in In_LveAllocStringMatch char(20),
in In_LveAllocRangeFrom double,
in In_LveAllocRangeTo double,
in In_MaxEntPerCycle double,
in In_MaxBFPerCycle double,
in In_MaxForfeitPerCycle double,
in In_MaxAdvPerCycle double,
in In_MaxHalfPerCycle double,
in In_MaxHalfOnHalf double,
in In_MaxHourPerDay double,
in In_MaxHourPerCycle double)
begin
  if not exists(select* from LveAllocationRec where LveAllocationRec.LveAllocationId = In_LveAllocationId and
      LveAllocationRec.LveAllocationSysId = In_LveAllocationSysId) then
    insert into LveAllocationRec(LveAllocationId,
      LveAllocationSysId,
      LveAllocStringMatch,
      LveAllocRangeFrom,
      LveAllocRangeTo,
      MaxEntPerCycle,
      MaxBFPerCycle,
      MaxForfeitPerCycle,
      MaxAdvPerCycle,
      MaxHalfPerCycle,
      MaxHalfOnHalf,
      MaxHourPerDay,
      MaxHourPerCycle) values(
      In_LveAllocationId,
      In_LveAllocationSysId,
      In_LveAllocStringMatch,
      In_LveAllocRangeFrom,
      In_LveAllocRangeTo,
      In_MaxEntPerCycle,
      In_MaxBFPerCycle,
      In_MaxForfeitPerCycle,
      In_MaxAdvPerCycle,
      In_MaxHalfPerCycle,
      In_MaxHalfOnHalf,
      In_MaxHourPerDay,
      In_MaxHourPerCycle);
    commit work
  end if
end
;

create procedure dba.InsertNewLveAllocFormulaRec(
in In_CostMethodId char(20),
in In_LveAllocFormulaSysId integer,
in In_LveAllocRangeFrom double,
in In_LveAllocRangeTo double,
in In_LveAllocStringMatch char(20),
in In_LveFormulaId char(30),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double)
begin
  if not exists(select* from LveAllocFormulaRec where LveAllocFormulaRec.CostMethodId = In_CostMethodId and
      LveAllocFormulaRec.LveAllocFormulaSysId = In_LveAllocFormulaSysId) then
    insert into LveAllocFormulaRec(CostMethodId,LveAllocFormulaSysId,LveAllocRangeFrom,LveAllocRangeTo,LveAllocStringMatch,LveFormulaId,UserDef1Value,UserDef2Value,UserDef3Value,UserDef4Value,UserDef5Value) values(
      In_CostMethodId,In_LveAllocFormulaSysId,In_LveAllocRangeFrom,In_LveAllocRangeTo,In_LveAllocStringMatch,In_LveFormulaId,In_UserDef1Value,In_UserDef2Value,In_UserDef3Value,In_UserDef4Value,In_UserDef5Value);
    commit work
  end if
end
;

create procedure dba.InsertNewLvePeriodBalance(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_LeaveTypeId char(20),
in In_PolicyCareerValue char(20),
in In_AllocCareerValue char(20),
in In_PerEntEarned double,
in In_PerEntAdjEarned double,
in In_PerBFEarned double,
in In_PerBFForfeit double,
in In_PerTotalEnt double,
in In_PerDayTaken double,
in In_YTDEntEarned double,
in In_YTDEntAdjEarned double,
in In_YTDBFEarned double,
in In_YTDBFForfeit double,
in In_YTDTotalEnt double,
in In_YTDDayTaken double,
in In_YTDBalance double,
in In_CostPerDay double,
in In_AllocRangeBasis char(20),
in In_PerBalLveAllocationId char(20),
in In_PerBalCostMethodId char(20),
in In_PolicyCareerChangeDate date,
in In_AllocCareerChangeDate date)
begin
  if not exists(select* from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId) then
    insert into LvePeriodBalance(EmployeeSysId,
      LveYear,
      LvePolicySummaryId,
      LvePeriod,
      LeaveTypeId,
      PolicyCareerValue,
      AllocCareerValue,
      PerEntEarned,
      PerEntAdjEarned,
      PerBFEarned,
      PerBFForfeit,
      PerTotalEnt,
      PerDayTaken,
      YTDEntEarned,
      YTDEntAdjEarned,
      YTDBFEarned,
      YTDBFForfeit,
      YTDTotalEnt,
      YTDDayTaken,
      YTDBalance,
      CostPerDay,
      AllocRangeBasis,
      PerBalLveAllocationId,
      PerBalCostMethodId,
      PolicyCareerChangeDate,
      AllocCareerChangeDate) values(
      In_EmployeeSysId,
      In_LveYear,
      In_LvePolicySummaryId,
      In_LvePeriod,
      In_LeaveTypeId,
      In_PolicyCareerValue,
      In_AllocCareerValue,
      In_PerEntEarned,
      In_PerEntAdjEarned,
      In_PerBFEarned,
      In_PerBFForfeit,
      In_PerTotalEnt,
      In_PerDayTaken,
      In_YTDEntEarned,
      In_YTDEntAdjEarned,
      In_YTDBFEarned,
      In_YTDBFForfeit,
      In_YTDTotalEnt,
      In_YTDDayTaken,
      In_YTDBalance,
      In_CostPerDay,
      In_AllocRangeBasis,
      In_PerBalLveAllocationId,
      In_PerBalCostMethodId,
      In_PolicyCareerChangeDate,
      In_AllocCareerChangeDate);
    commit work
  end if
end
;

create procedure dba.InsertNewLvePeriodBalRpt(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LvePeriodRpt integer,
in In_LeaveTypeId char(20),
in In_PeriodStartDate date,
in In_PeriodEndDate date,
in In_PerEntEarned double,
in In_PerEntAdjEarned double,
in In_PerBFEarned double,
in In_PerBFForfeit double,
in In_PerTotalEnt double,
in In_PerDayTaken double,
in In_YTDEntEarned double,
in In_YTDEntAdjEarned double,
in In_YTDBFEarned double,
in In_YTDBFForfeit double,
in In_YTDTotalEnt double,
in In_YTDDayTaken double,
in In_YTDBalance double,
in In_CostPerDay double,
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisLeaveGroupId char(20),
in In_HisPositionId char(20),
in In_HisSectionId char(20))
begin
  if not exists(select* from LvePeriodBalRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LvePeriodRpt = In_LvePeriodRpt and
      LeaveTypeId = In_LeaveTypeId) then
    insert into LvePeriodBalRpt(EmployeeSysId,
      LveYearRpt,
      LvePeriodRpt,
      LeaveTypeId,
      PeriodStartDate,
      PeriodEndDate,
      PerEntEarned,
      PerEntAdjEarned,
      PerBFEarned,
      PerBFForfeit,
      PerTotalEnt,
      PerDayTaken,
      YTDEntEarned,
      YTDEntAdjEarned,
      YTDBFEarned,
      YTDBFForfeit,
      YTDTotalEnt,
      YTDDayTaken,
      YTDBalance,
      CostPerDay,
      HisBranchId,
      HisCategoryId,
      HisDepartmentId,
      HisLeaveGroupId,
      HisPositionId,
      HisSectionId) values(
      In_EmployeeSysId,
      In_LveYearRpt,
      In_LvePeriodRpt,
      In_LeaveTypeId,
      In_PeriodStartDate,
      In_PeriodEndDate,
      In_PerEntEarned,
      In_PerEntAdjEarned,
      In_PerBFEarned,
      In_PerBFForfeit,
      In_PerTotalEnt,
      In_PerDayTaken,
      In_YTDEntEarned,
      In_YTDEntAdjEarned,
      In_YTDBFEarned,
      In_YTDBFForfeit,
      In_YTDTotalEnt,
      In_YTDDayTaken,
      In_YTDBalance,
      In_CostPerDay,
      In_HisBranchId,
      In_HisCategoryId,
      In_HisDepartmentId,
      In_HisLeaveGroupId,
      In_HisPositionId,
      In_HisSectionId);
    commit work
  end if
end
;

create procedure dba.InsertNewLvePeriodBF(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_LeaveTypeId char(20),
in In_LveBFLeaveTypeId char(20),
in In_BFDays double,
in In_MaxBFPerCycle double)
begin
  if not exists(select* from LvePeriodBF where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId and
      LveBFLeaveTypeId = In_LveBFLeaveTypeId) then
    insert into LvePeriodBF(EmployeeSysId,
      LveYear,
      LvePolicySummaryId,
      LvePeriod,
      LeaveTypeId,
      LveBFLeaveTypeId,
      BFDays,
      MaxBFPerCycle) values(
      In_EmployeeSysId,
      In_LveYear,
      In_LvePolicySummaryId,
      In_LvePeriod,
      In_LeaveTypeId,
      In_LveBFLeaveTypeId,
      In_BFDays,
      In_MaxBFPerCycle);
    commit work
  end if
end
;

create procedure dba.InsertNewLvePeriodSummary(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_PeriodStartDate date,
in In_PeriodEndDate date)
begin
  if not exists(select* from LvePeriodSummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod) then
    insert into LvePeriodSummary(EmployeeSysId,
      LveYear,
      LvePolicySummaryId,
      LvePeriod,
      PeriodStartDate,
      PeriodEndDate) values(
      In_EmployeeSysId,
      In_LveYear,
      In_LvePolicySummaryId,
      In_LvePeriod,
      In_PeriodStartDate,
      In_PeriodEndDate);
    commit work
  end if
end
;

create procedure dba.InsertNewLvePolicyProg(
in In_EmployeeSysId integer,
in In_LveProgDate date,
in In_LveProgDesc char(100),
in In_LveProgCareerId char(20),
in In_LveOldPolicyId char(20),
in In_LveNewPolicyId char(20),
in In_LveConvertMethod char(20))
begin
  if not exists(select* from LeavePolicyProg where LeavePolicyProg.EmployeeSysId = In_EmployeeSysId and
      LeavePolicyProg.LveProgDate = In_LveProgDate) then
    insert into LeavePolicyProg(EmployeeSysId,LveProgDate,LveProgDesc,LveProgCareerId,LveOldPolicyId,LveNewPolicyId,LveConvertMethod) values(
      In_EmployeeSysId,In_LveProgDate,In_LveProgDesc,In_LveProgCareerId,In_LveOldPolicyId,In_LveNewPolicyId,In_LveConvertMethod);
    commit work
  end if
end
;

create procedure dba.InsertNewLvePolicySummary(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_CycStartDate date,In_CycEndDate date,
in In_LveProgressStatus char(20),
in In_LveProgressPolicy char(20),
in In_LveProgressMethod char(20),
in In_LveProgressDate date)
begin
  if not exists(select* from LvePolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId) then
    insert into LvePolicySummary(EmployeeSysId,
      LveYear,
      LvePolicySummaryId,
      CycStartDate,
      CycEndDate,
      LveProgressStatus,
      LveProgressPolicy,
      LveProgressMethod,
      LveProgressDate) values(
      In_EmployeeSysId,
      In_LveYear,
      In_LvePolicySummaryId,
      In_CycStartDate,
      In_CycEndDate,
      In_LveProgressStatus,
      In_LveProgressPolicy,
      In_LveProgressMethod,
      In_LveProgressDate);
    commit work
  end if
end
;

create procedure dba.InsertNewWorkTime(
in In_WTProfileId char(20),
in In_StartTime time,
in In_EndTime time,
in In_DayAppControlId char(20))
begin
  if not exists(select* from WorkTime where
      WorkTime.WTProfileId = In_WTProfileId and
      WorkTime.StartTime = In_StartTime) then
    insert into WorkTime(WTProfileId,
      StartTime,
      EndTime,
      DayAppControlId) values(In_WTProfileId,
      In_StartTime,
      In_EndTime,
      In_DayAppControlId);
    commit work
  end if
end
;

create procedure dba.InsertNewWTCalendar(
in In_WTCalendarId char(20),
in In_WTCalendarDesc char(100),
in In_LveCalendarId char(20),
in In_WTCalendarShortForm char(2),
in In_WTCalendarColor integer,
in In_WTPatternType integer,
out Out_ErrorCode integer)
begin
  /* Get the default WTProfileID */
  declare Out_WTProfileId char(20);
  if not exists(select* from WTCalendar where WTCalendarId = In_WTCalendarId) then
    insert into WTCalendar(WTCalendarId,
      WTCalendarDesc,
      LveCalendarId,
      WTCalendarShortForm,
      WTCalendarColor,
      WTPatternType) values(In_WTCalendarId,
      In_WTCalendarDesc,
      In_LveCalendarId,
      In_WTCalendarShortForm,
      In_WTCalendarColor,
      In_WTPatternType);
    commit work;
    if not exists(select* from WTCalendar where WTCalendarId = In_WTCalendarId) then
      set Out_ErrorCode=0
    else
      /* Create 7 Default WTCalendarPattern with the first WTProfileId if the In_WTPatternType is - 0 (Day of Week) */
      select first WTProfileID into Out_WTProfileId from WTProfile order by WTProfileId;
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,1,Out_WTProfileId);
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,2,Out_WTProfileId);
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,3,Out_WTProfileId);
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,4,Out_WTProfileId);
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,5,Out_WTProfileId);
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,6,Out_WTProfileId);
      insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(In_WTCalendarId,7,Out_WTProfileId);
      commit work;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewWTDay(
in In_WTProfileId char(20),
in In_WTCalendarId char(20),
in In_WTDate date)
begin
  if not exists(select* from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId and WTDay.WTDate = In_WTDate) then
    insert into WTDay(WTProfileId,WTCalendarId,WTDate) values(
      In_WTProfileId,In_WTCalendarId,In_WTDate);
    commit work
  end if
end
;

create procedure dba.InsertNewWTProfile(
in In_WTProfileId char(20),
in In_WTProfileDesc char(100))
begin
  if not exists(select* from WTProfile where
      WTProfile.WTProfileId = In_WTProfileId) then
    insert into WTProfile(WTProfileId,
      WTProfileDesc) values(In_WTProfileId,
      In_WTProfileDesc);
    commit work
  end if
end
;

create function dba.IsCalendarDatePublicHoliday(
in In_CalendarIDCode char(20),
in In_CalendarDate date)
returns integer
begin
  declare out_IsPublicHoliday integer;
  select PublicHoliday into out_IsPublicHoliday from CalendarDay where
    CalendarIDCode = In_CalendarIDCode and
    CalendarDate = In_CalendarDate;
  return(out_IsPublicHoliday)
end
;

create procedure dba.UpdateAdjustCredit(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_AdjEffectiveDate date,
in In_AdjType smallint,
in In_LeaveReasonId char(20),
in In_AdjDays double,
in In_CreditExpireDate date,
in In_Remarks char(100))
begin
  if exists(select* from AdjustCredit where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId and
      AdjustCredit.LeaveTypeId = In_LeaveTypeId and
      AdjustCredit.AdjEffectiveDate = In_AdjEffectiveDate and
      AdjustCredit.AdjType = In_AdjType) then
    update AdjustCredit set
      LeaveReasonId = In_LeaveReasonId,
      AdjDays = In_AdjDays,
      CreditExpireDate = In_CreditExpireDate,
      Remarks = In_Remarks where
      AdjustCredit.EmployeeSysId = In_EmployeeSysId and
      AdjustCredit.LeaveTypeId = In_LeaveTypeId and
      AdjustCredit.AdjEffectiveDate = In_AdjEffectiveDate and
      AdjustCredit.AdjType = In_AdjType;
    commit work
  end if
end
;

create procedure dba.UpdateCostingMethod(
in In_CostingMethodId char(20),
in In_CostingMethod char(20),
in In_CostingAllocationBasis char(20),
in In_CostingDesc char(100))
begin
  if exists(select* from CostingMethod where CostingMethod.CostMethodId = In_CostingMethodId) then
    update CostingMethod set
      CostingMethod.CostingMethod = In_CostingMethod,
      CostingMethod.CostingAllocationBasis = In_CostingAllocationBasis,
      CostingMethod.CostingDesc = In_CostingDesc where
      CostingMethod.CostMethodId = In_CostingMethodId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveAllocation(
in In_LveAllocationId char(20),
in In_LveAllocationEntitle double,
in In_MinServiceYear double,
in In_MaxServiceYear double,
in In_MaxBrForward double,
in In_LeaveAllocatGroupId char(20))
begin
  if exists(select* from LeaveAllocation where
      LeaveAllocation.LveAllocationId = In_LveAllocationId) then
    update LeaveAllocation set
      LeaveAllocation.LveAllocationId = In_LveAllocationId,
      LeaveAllocation.LveAllocationEntitle = In_LveAllocationEntitle,
      LeaveAllocation.MinServiceYear = In_MinServiceYear,
      LeaveAllocation.MaxServiceYear = In_MaxServiceYear,
      LeaveAllocation.MaxBrForward = In_MaxBrForward,
      LeaveAllocation.LeaveAllocatGroupId = In_LeaveAllocatGroupId where
      LeaveAllocation.LveAllocationId = In_LveAllocationId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveAllocationGroupDesc(
in In_LeaveAllocatGroupId char(20),
in In_LveAllocatGroupDesc char(100))
begin
  if exists(select* from LeaveAllocationGroup where
      LeaveAllocationGroup.LeaveAllocatGroupId = In_LeaveAllocatGroupId) then
    update LeaveAllocationGroup set
      LeaveAllocationGroup.LveAllocatGroupDesc = In_LveAllocatGroupDesc where
      LeaveAllocationGroup.LeaveAllocatGroupId = In_LeaveAllocatGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveAllocationGroupType(
in In_LeaveGroupId char(20),
in In_LeaveTypeId char(20),
in In_LeaveAllocatGroupId char(20),
in In_ProrationId char(20),
in In_LeaveTransferId char(20),
in In_EntitlementRoundId char(20),
in In_LeaveCutOffDate integer,
in In_LeaveMethodId char(10),
in In_LeaveEndMth integer,
in In_LeaveStartMth integer,
in In_MaxAdvLveAllowed double,
in In_MaxHalfDayLveAllowed double,
in In_BroughtForward char(30))
begin
  if exists(select* from LeaveAllocationGroupType where
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId and
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId) then
    update LeaveAllocationGroupType set
      LeaveAllocationGroupType.LeaveAllocatGroupId = In_LeaveAllocatGroupId,
      LeaveAllocationGroupType.EntitlementRoundId = In_EntitlementRoundId,
      LeaveAllocationGroupType.LeaveCutOffDate = In_LeaveCutOffDate,
      LeaveAllocationGroupType.LeaveEndMth = In_LeaveEndMth,
      LeaveAllocationGroupType.LeaveStartMth = In_LeaveStartMth,
      LeaveAllocationGroupType.LeaveMethodId = In_LeaveMethodId,
      LeaveAllocationGroupType.LeaveTransferId = In_LeaveTransferId,
      LeaveAllocationGroupType.MaxAdvLveAllowed = In_MaxAdvLveAllowed,
      LeaveAllocationGroupType.MaxHalfDayLveAllowed = In_MaxHalfDayLveAllowed,
      LeaveAllocationGroupType.BroughtForward = In_BroughtForward,
      LeaveAllocationGroupType.ProrationId = In_ProrationId where
      LeaveAllocationGroupType.LeaveTypeId = In_LeaveTypeId and
      LeaveAllocationGroupType.LeaveGroupId = In_LeaveGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveApplication(
in In_LeaveAppSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_LeaveReasonId char(20),
in In_LeaveTypeId char(20),
in In_LveRecCategory char(20),
in In_LveAppFromDate date,
in In_LveAppStartTime time,
in In_LveAppToDate date,
in In_LveAppEndTime time,
in In_LveAppIsHour smallint,
in In_LveRecApproved smallint,
in In_Remarks char(200),
in In_Status char(20),
in In_LastModified timestamp,
in In_CreatedBy char(1))
begin
  if exists(select* from LeaveApplication where
      LeaveApplication.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId) then
    update LeaveApplication set
      EmployeeSysId = In_EmployeeSysId,
      LeaveReasonId = In_LeaveReasonId,
      LeaveTypeId = In_LeaveTypeId,
      LveRecCategory = In_LveRecCategory,
      LveAppFromDate = In_LveAppFromDate,
      LveAppStartTime = In_LveAppStartTime,
      LveAppToDate = In_LveAppToDate,
      LveAppEndTime = In_LveAppEndTime,
      LveAppIsHour = In_LveAppIsHour,
      LveRecApproved = In_LveRecApproved,
      Remarks = In_Remarks,
      Status = In_Status,
      LastModified = In_LastModified,
      CreatedBy = In_CreatedBy where
      LeaveApplication.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveApplyDay(
in In_EmpSysId integer,
in In_AppSysId integer,
in In_DateApplied date,
in In_DayApplied double,
in In_HourApplied double,
in In_LeaveTypeId char(20),
in In_LeaveStatus char(2))
begin
  if exists(select* from LeaveApplyDay where
      LeaveApplyDay.LEmployeeSysId = In_EmpSysId and
      LeaveApplyDay.LApplicationSysId = In_AppSysId and
      LeaveApplyDay.DateApplied = In_DateApplied) then
    update LeaveApplyDay set
      LEmployeeSysId = In_EmpSysId,
      LApplicationSysId = In_AppSysId,
      DateApplied = In_DateApplied,
      DayApplied = In_DayApplied,
      HourApplied = In_HourApplied,
      LLeaveTypeId = In_LeaveTypeId,
      LeaveStatus = In_LeaveStatus where
      LeaveApplyDay.LEmployeeSysId = In_EmpSysId and
      LeaveApplyDay.LApplicationSysId = In_AppSysId and
      LeaveApplyDay.DateApplied = In_DateApplied;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveComputation(
in In_LeaveTypeId char(20),
in In_HasEntitleApp smallint,
in In_HasBFApp smallint,
in In_HasForfeitApp smallint,
in In_HasAdvApp smallint,
in In_HasHourApp smallint,
in In_HasHalfDayApp smallint,
in In_LeaveRoundMethod char(20),
in In_EntProrateMethod char(20),
in In_EntProrateCutOffDay integer,
in In_EntProrateBeforeCutoff double,
in In_NoProrateCareerChange smallint,
in In_NoProrateHire smallint,
in In_NoProrateCess smallint,
in In_EntDistributeMethod char(20),
in In_BFLeaveTypeId char(20),
in In_BFForfeitTime integer,
in In_CanHalfDayApplyHour smallint,
in In_LeaveFunctionId char(20),
in In_HireSuspendMethod char(20),
in In_HireSuspendUntil integer,
in In_CessSuspendMethod char(20),
in In_CessSuspendStart integer,
in In_HasDeductSeq integer,
in In_IncludeHolidayOff smallint,
in In_EntTakenNoEnt smallint,
in In_HasSIWageDeduct smallint,
in In_HasSIReimbursement smallint,
in In_C04ContriRate double,
in In_HasLeaveSuspension smallint,
in In_LeaveSuspensionMethod char(20),
in In_LeaveSuspensionValue integer,
in In_LeaveSuspensionField char(20),
in In_TotalEntRoundMethod smallint)
begin
  if exists(select* from LeaveComputation where
      LeaveComputation.LeaveTypeId = In_LeaveTypeId) then
    update LeaveComputation set
      HasEntitleApp = In_HasEntitleApp,
      HasBFApp = In_HasBFApp,
      HasForfeitApp = In_HasForfeitApp,
      HasAdvApp = In_HasAdvApp,
      HasHourApp = In_HasHourApp,
      HasHalfDayApp = In_HasHalfDayApp,
      LeaveRoundMethod = In_LeaveRoundMethod,
      EntProrateMethod = In_EntProrateMethod,
      EntProrateCutOffDay = In_EntProrateCutOffDay,
      EntProrateBeforeCutoff = In_EntProrateBeforeCutoff,
      NoProrateCareerChange = In_NoProrateCareerChange,
      NoProrateHire = In_NoProrateHire,
      NoProrateCess = In_NoProrateCess,
      EntDistributeMethod = In_EntDistributeMethod,
      BFLeaveTypeId = In_BFLeaveTypeId,
      BFForfeitTime = In_BFForfeitTime,
      CanHalfDayApplyHour = In_CanHalfDayApplyHour,
      LeaveFunctionId = In_LeaveFunctionId,
      HireSuspendMethod = In_HireSuspendMethod,
      HireSuspendUntil = In_HireSuspendUntil,
      CessSuspendMethod = In_CessSuspendMethod,
      CessSuspendStart = In_CessSuspendStart,
      HasDeductSeq = in_HasDeductSeq,
      IncludeHolidayOff = In_IncludeHolidayOff,
      EntTakenNoEnt = In_EntTakenNoEnt,
      HasSIWageDeduct = In_HasSIWageDeduct,
      HasSIReimbursement = In_HasSIReimbursement,
      C04ContriRate = In_C04ContriRate,
      HasLeaveSuspension = In_HasLeaveSuspension,
      LeaveSuspensionMethod = In_LeaveSuspensionMethod,
      LeaveSuspensionValue = In_LeaveSuspensionValue,
      LeaveSuspensionField = In_LeaveSuspensionField,
      TotalEntRoundMethod = In_TotalEntRoundMethod where
      LeaveComputation.LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveCutOffDate(
in In_PayGroupId char(20),
in In_SubPeriod integer,
in In_CutOffPayLveTypeId char(20),
in In_CutOffFromDay char(20),
in In_CutOffFromMonth char(20),
in In_CutOffEndDay char(20),
in In_CutOffEndMonth char(20))
begin
  if exists(select* from LeaveCutOffDate where LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod and LeaveCutOffDate.CutOffPayLveTypeId = In_CutOffPayLveTypeId) then
    update LeaveCutOffDate set
      LeaveCutOffDate.PayGroupId = In_PayGroupId,
      LeaveCutOffDate.SubPeriod = In_SubPeriod,
      LeaveCutOffDate.CutOffPayLveTypeId = In_CutOffPayLveTypeId,
      LeaveCutOffDate.CutOffFromDay = In_CutOffFromDay,
      LeaveCutOffDate.CutOffFromMonth = In_CutOffFromMonth,
      LeaveCutOffDate.CutOffEndDay = In_CutOffEndDay,
      LeaveCutOffDate.CutOffEndMonth = In_CutOffEndMonth where
      LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod and LeaveCutOffDate.CutOffPayLveTypeId = In_CutOffPayLveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveCycleRpt(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LeaveTypeId char(20),
in In_CycStartDate date,
in In_CycEndDate date,
in In_CycEntEarned double,
in In_CycEntAdjEarned double,
in In_CycBFEarned double,
in In_CycBFForfeit double,
in In_CycTotalEnt double,
in In_CycDayTaken double,
in In_CycCrossCycTaken double,
in In_CycBalance double,
in In_CycLastUpdate timestamp,
in In_CycStatus char(20),
in In_CycCostPerDay double)
begin
  if
    exists(select* from LeaveCycleRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LeaveTypeId = In_LeaveTypeId) then
    update LeaveCycleRpt set
      CycStartDate = In_CycStartDate,
      CycEndDate = In_CycEndDate,
      CycEntEarned = In_CycEntEarned,
      CycEntAdjEarned = In_CycEntAdjEarned,
      CycBFEarned = In_CycBFEarned,
      CycBFForfeit = In_CycBFForfeit,
      CycTotalEnt = In_CycTotalEnt,
      CycDayTaken = In_CycDayTaken,
      CycCrossCycTaken = In_CycCrossCycTaken,
      CycBalance = In_CycBalance,
      CycLastUpdate = In_CycLastUpdate,
      CycStatus = In_CycStatus,
      CycCostPerDay = In_CycCostPerDay where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveDeductionRecord(
in In_LveDeductSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PaySubPeriodSGSPGenId char(30),
in In_LeaveTypeFunctCode char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_CurrentLveDays double,
in In_CurrentLveHours double,
in In_PreviousLveIncDays double,
in In_PreviousLveIncHours double,
in In_LveAutoOption smallint,
in In_LveAmount double,
in In_LveDayRateId char(20),
in In_LveHourRateId char(20),
in In_CurrentDayRateAmt double,
in In_CurrentHourRateAmt double,
in In_PreviousDayRateAmt double,
in In_PreviousHourRateAmt double,
in In_LveDedCreatedBy char(20))
begin
  if exists(select* from LeaveDeductionRecord where
      LeaveDeductionRecord.LveDeductSGSPGenId = In_LveDeductSGSPGenId) then
    update LeaveDeductionRecord set
      LveDeductSGSPGenId = In_LveDeductSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PaySubPeriodSGSPGenId = In_PaySubPeriodSGSPGenId,
      LeaveTypeFunctCode = In_LeaveTypeFunctCode,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      CurrentLveDays = In_CurrentLveDays,
      CurrentLveHours = In_CurrentLveHours,
      PreviousLveIncDays = In_PreviousLveIncDays,
      PreviousLveIncHours = In_PreviousLveIncHours,
      LveAutoOption = In_LveAutoOption,
      LveAmount = In_LveAmount,
      LveDayRateId = In_LveDayRateId,
      LveHourRateId = In_LveHourRateId,
      CurrentDayRateAmt = In_CurrentDayRateAmt,
      CurrentHourRateAmt = In_CurrentHourRateAmt,
      PreviousDayRateAmt = In_PreviousDayRateAmt,
      PreviousHourRateAmt = In_PreviousHourRateAmt,
      LveDedCreatedBy = In_LveDedCreatedBy where
      LeaveDeductionRecord.LveDeductSGSPGenId = In_LveDeductSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveEmployee(
in In_EmployeeSysId integer,
in In_LeaveGroupId char(20),
in In_WTCalendarId char(20),
in In_HasShiftRotation smallint,
in In_FullDayWorkTimeProfile char(20),
in In_HalfDayWorkTimeProfile char(20),
in In_SuspendLeave smallint,
in In_QuarterDayWorkTimeProfile char(20))
begin
  if exists(select* from LeaveEmployee where
      LeaveEmployee.EmployeeSysId = In_EmployeeSysId) then
    update LeaveEmployee set
      LeaveGroupId = In_LeaveGroupId,
      WTCalendarId = In_WTCalendarId,
      HasShiftRotation = In_HasShiftRotation,
      FullDayWorkTimeProfile = In_FullDayWorkTimeProfile,
      HalfDayWorkTimeProfile = In_HalfDayWorkTimeProfile,
      SuspendLeave = In_SuspendLeave,
      QuarterDayWorkTimeProfile = In_QuarterDayWorkTimeProfile where
      LeaveEmployee.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveFormula(
in In_LveFormulaId char(30),
in In_LveFormulaActive integer,
in In_LveFormulaCategory char(20),
in In_LveFormulaDesc char(100),
in In_LveFormulaRangeBasis char(20),
in In_LveFormulaSubCategory char(20),
in In_LveFormulaType char(20))
begin
  if exists(select* from LeaveFormula where LeaveFormula.LveFormulaId = In_LveFormulaId) then
    update LeaveFormula set
      LeaveFormula.LveFormulaActive = In_LveFormulaActive,
      LeaveFormula.LveFormulaCategory = In_LveFormulaCategory,
      LeaveFormula.LveFormulaDesc = In_LveFormulaDesc,
      LeaveFormula.LveFormulaRangeBasis = In_LveFormulaRangeBasis,
      LeaveFormula.LveFormulaSubCategory = In_LveFormulaSubCategory,
      LeaveFormula.LveFormulaType = In_LveFormulaType where
      LeaveFormula.LveFormulaId = In_LveFormulaId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveGroup(
in In_LeaveGroupId char(20),
in In_LeaveGroupDesc char(100))
begin
  if exists(select* from LeaveGroup where
      LeaveGroup.LeaveGroupId = In_LeaveGroupId) then
    update LeaveGroup set
      LeaveGroupDesc = In_LeaveGroupDesc where
      LeaveGroup.LeaveGroupId = In_LeaveGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveInfoRecord(
in In_LeaveInfoSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PaySubPeriodSGSPGenId char(30),
in In_LeaveTypeFunctCode char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LveBroughtForward double,
in In_CurrLveEntitlement double,
in In_CurrLvePeriodTaken double,
in In_LeaveInfoCreatedBy char(20))
begin
  if exists(select* from LeaveInfoRecord where
      LeaveInfoRecord.LeaveInfoSGSPGenId = In_LeaveInfoSGSPGenId) then
    update LeaveInfoRecord set
      LeaveInfoSGSPGenId = In_LeaveInfoSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PaySubPeriodSGSPGenId = In_PaySubPeriodSGSPGenId,
      LeaveTypeFunctCode = In_LeaveTypeFunctCode,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      LveBroughtForward = In_LveBroughtForward,
      CurrLveEntitlement = In_CurrLveEntitlement,
      CurrLvePeriodTaken = In_CurrLvePeriodTaken,
      LeaveInfoCreatedBy = In_LeaveInfoCreatedBy where
      LeaveInfoSGSPGenId = In_LeaveInfoSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveInitialisedGroup(
in In_LeaveGroupId char(20),
in In_GroupStartYrMonth integer,
in In_GroupEndYrMonth integer,
in In_Status integer)
begin
  if exists(select* from LeaveInitialisedGroup where
      LeaveInitialisedGroup.LeaveGroupId = In_LeaveGroupId and
      LeaveInitialisedGroup.GroupStartYrMth = In_GroupStartYrMonth) then
    update LeaveInitialisedGroup set
      LeaveInitialisedGroup.LeaveGroupId = In_LeaveGroupId,
      LeaveInitialisedGroup.GroupStartYrMth = In_GroupStartYrMonth,
      LeaveInitialisedGroup.GroupEndYrMth = In_GroupEndYrMonth,
      LeaveInitialisedGroup.LveGroupStatus = In_Status where
      LeaveInitialisedGroup.LeaveGroupId = In_LeaveGroupId and
      LeaveInitialisedGroup.GroupStartYrMth = In_GroupStartYrMonth;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveKeyword(
in In_LveKeywordId char(20),
in In_LveKeywordUserDefinedName char(100),
in In_LveKeywordDesc char(100),
in In_LveKeywordCategory char(20))
begin
  if exists(select* from LeaveKeyword where LeaveKeyword.LveKeywordId = In_LveKeywordId) then
    update LeaveKeyword set
      LeaveKeyword.LveKeywordUserDefinedName = In_LveKeywordUserDefinedName,
      LeaveKeyword.LveKeywordDesc = In_LveKeywordDesc,
      LeaveKeyword.LveKeywordCategory = In_LveKeywordCategory where
      LeaveKeyword.LveKeywordId = In_LveKeywordId;
    commit work
  end if
end
;

create procedure dba.UpdateLeavePolicy(
in In_LeavePolicyId char(20),
in In_LeavePolicyDesc char(40),
in In_LeavePolicyBasis char(20),
in In_LeaveCalendarType char(20),
in In_LeaveStartMonth integer)
begin
  if exists(select* from LeavePolicy where LeavePolicy.LeavePolicyId = In_LeavePolicyId) then
    update LeavePolicy set
      LeavePolicy.LeavePolicyDesc = In_LeavePolicyDesc,
      LeavePolicy.LeavePolicyBasis = In_LeavePolicyBasis,
      LeavePolicy.LeaveCalendarType = In_LeaveCalendarType,
      LeavePolicy.LeaveStartMonth = In_LeaveStartMonth where
      LeavePolicy.LeavePolicyId = In_LeavePolicyId;
    commit work
  end if
end
;

create procedure dba.UpdateLeavePolicyRecord(
in In_PolicySysId integer,
in In_LeavePolicyId char(20),
in In_LveAllocationId char(20),
in In_LeaveTypeId char(20),
in In_CostMethodId char(20),
in In_PolicyStringMatch char(20),
in In_PolicyRangeFrom double,
in In_PolicyRangeTo double)
begin
  if exists(select* from LeavePolicyRecord where LeavePolicyRecord.PolicySysId = In_PolicySysId) then
    update LeavePolicyRecord set
      LeavePolicyRecord.LeavePolicyId = In_LeavePolicyId,
      LeavePolicyRecord.LveAllocationId = In_LveAllocationId,
      LeavePolicyRecord.LeaveTypeId = In_LeaveTypeId,
      LeavePolicyRecord.CostMethodId = In_CostMethodId,
      LeavePolicyRecord.PolicyStringMatch = In_PolicyStringMatch,
      LeavePolicyRecord.PolicyRangeFrom = In_PolicyRangeFrom,
      LeavePolicyRecord.PolicyRangeTo = In_PolicyRangeTo where
      LeavePolicyRecord.PolicySysId = In_PolicySysId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveRange(
in In_LveFormulaRangeId integer,
in In_LveFormulaId char(30),
in In_Formula char(255),
in In_SearchString char(100),
in In_Maximum double,
in In_Minimum double,
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20))
begin
  if exists(select* from LeaveRange where LeaveRange.LveFormulaRangeId = In_LveFormulaRangeId and LeaveRange.LveFormulaId = In_LveFormulaId) then
    update LeaveRange set
      LeaveRange.LveFormulaId = In_LveFormulaId,
      LeaveRange.Formula = In_Formula,
      LeaveRange.SearchString = In_SearchString,
      LeaveRange.Maximum = In_Maximum,
      LeaveRange.Minimum = In_Minimum,
      LeaveRange.Constant1 = In_Constant1,
      LeaveRange.Constant2 = In_Constant2,
      LeaveRange.Constant3 = In_Constant3,
      LeaveRange.Constant4 = In_Constant4,
      LeaveRange.Constant5 = In_Constant5,
      LeaveRange.Keywords1 = In_Keywords1,
      LeaveRange.Keywords2 = In_Keywords2,
      LeaveRange.Keywords3 = In_Keywords3,
      LeaveRange.Keywords4 = In_Keywords4,
      LeaveRange.Keywords5 = In_Keywords5,
      LeaveRange.Keywords6 = In_Keywords6,
      LeaveRange.Keywords7 = In_Keywords7,
      LeaveRange.Keywords8 = In_Keywords8,
      LeaveRange.Keywords9 = In_Keywords9,
      LeaveRange.Keywords10 = In_Keywords10,
      LeaveRange.UserDef1 = In_UserDef1,
      LeaveRange.UserDef2 = In_UserDef2,
      LeaveRange.UserDef3 = In_UserDef3,
      LeaveRange.UserDef4 = In_UserDef4,
      LeaveRange.UserDef5 = In_UserDef5 where
      LeaveRange.LveFormulaRangeId = In_LveFormulaRangeId and LeaveRange.LveFormulaId = In_LveFormulaId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveReason(
in In_LeaveReasonId char(20),
in In_LeaveReason char(100))
begin
  if exists(select* from LeaveReason where
      LeaveReason.LeaveReasonId = In_LeaveReasonId) then
    update LeaveReason set
      LeaveReason.LeaveReason = In_LeaveReason where
      LeaveReason.LeaveReasonId = In_LeaveReasonId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveReasonDesc(
in In_LeaveReasonId char(20),
in In_LeaveReasonDesc char(100),
in In_LvStatus char(2))
begin
  if exists(select* from LeaveReason where
      LeaveReason.LeaveReasonId = In_LeaveReasonId) then
    update LeaveReason set
      LeaveReason.LeaveReasonDesc = In_LeaveReasonDesc,
      LeaveReason.LvStatus = In_LvStatus where
      LeaveReason.LeaveReasonId = In_LeaveReasonId;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveRecord(
in In_LeaveAppSGSPGenId char(30),
in In_LveRecDate date,
in In_LveRecStartTime time,
in In_LveRecEndTime time,
in In_LveRecDays double,
in In_LveRecHours double,
in In_LveRecConvertDays double,
in In_LveRecCalendarDay double,
in In_LveCertificationDate date)
begin
  if exists(select* from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime) then
    update LeaveRecord set
      LveRecEndTime = In_LveRecEndTime,
      LveRecDays = In_LveRecDays,
      LveRecHours = In_LveRecHours,
      LveRecConvertDays = In_LveRecConvertDays,
      LveRecCalendarDay = In_LveRecCalendarDay,
      LveCertificationDate = In_LveCertificationDate where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime;
    commit work
  end if
end
;

create procedure dba.UpdateLeaveType(
in In_LeaveTypeId char(20),
in In_LeaveCredit smallint,
in In_LeaveAbbrev char(2),
in In_LeaveColorCode integer,
in In_LeaveTypeActive smallint,
in In_LeaveTypeDesc char(100),
in In_LeaveUnit smallint,
in In_HasSpecialEligible smallint,
in In_SpecialEligibleCode char(20),
in In_SpecialEligibleMethod char(20),
in In_SpecialEligibleValue integer)
begin
  if exists(select* from LeaveType where
      LeaveType.LeaveTypeId = In_LeaveTypeId) then
    update LeaveType set
      LeaveCredit = In_LeaveCredit,
      LeaveAbbrev = In_LeaveAbbrev,
      LeaveColorCode = In_LeaveColorCode,
      LeaveTypeActive = In_LeaveTypeActive,
      LeaveTypeDesc = In_LeaveTypeDesc,
      LeaveUnit = In_LeaveUnit,
      HasSpecialEligible = In_HasSpecialEligible,
      SpecialEligibleCode = In_SpecialEligibleCode,
      SpecialEligibleMethod = In_SpecialEligibleMethod,
      SpecialEligibleValue = In_SpecialEligibleValue where
      LeaveType.LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLveAllocation(
in In_LveAllocationId char(20),
in In_LveAllocationDesc char(100),
in In_LveAllocationBasis char(20))
begin
  if exists(select* from LveAllocation where LveAllocation.LveAllocationId = In_LveAllocationId) then
    update LveAllocation set
      LveAllocation.LveAllocationDesc = In_LveAllocationDesc,
      LveAllocation.LveAllocationBasis = In_LveAllocationBasis where
      LveAllocation.LveAllocationId = In_LveAllocationId;
    commit work
  end if
end
;

create procedure dba.UpdateLveAllocationRec(
in In_LveAllocationId char(20),
in In_LveAllocationSysId integer,
in In_LveAllocStringMatch char(20),
in In_LveAllocRangeFrom double,
in In_LveAllocRangeTo double,
in In_MaxEntPerCycle double,
in In_MaxBFPerCycle double,
in In_MaxForfeitPerCycle double,
in In_MaxAdvPerCycle double,
in In_MaxHalfPerCycle double,
in In_MaxHalfOnHalf double,
in In_MaxHourPerDay double,
in In_MaxHourPerCycle double)
begin
  if exists(select* from LveAllocationRec where LveAllocationRec.LveAllocationId = In_LveAllocationId and
      LveAllocationRec.LveAllocationSysId = In_LveAllocationSysId) then
    update LveAllocationRec set
      LveAllocationRec.LveAllocStringMatch = In_LveAllocStringMatch,
      LveAllocationRec.LveAllocRangeFrom = In_LveAllocRangeFrom,
      LveAllocationRec.LveAllocRangeTo = In_LveAllocRangeTo,
      LveAllocationRec.MaxEntPerCycle = In_MaxEntPerCycle,
      LveAllocationRec.MaxBFPerCycle = In_MaxBFPerCycle,
      LveAllocationRec.MaxForfeitPerCycle = In_MaxForfeitPerCycle,
      LveAllocationRec.MaxAdvPerCycle = In_MaxAdvPerCycle,
      LveAllocationRec.MaxHalfPerCycle = In_MaxHalfPerCycle,
      LveAllocationRec.MaxHalfOnHalf = In_MaxHalfOnHalf,
      LveAllocationRec.MaxHourPerDay = In_MaxHourPerDay,
      LveAllocationRec.MaxHourPerCycle = In_MaxHourPerCycle where
      LveAllocationRec.LveAllocationId = In_LveAllocationId and LveAllocationRec.LveAllocationSysId = In_LveAllocationSysId;
    commit work
  end if
end
;

create procedure dba.UpdateLveAllocFormulaRec(
in In_CostMethodId char(20),
in In_LveAllocFormulaSysId integer,
in In_LveAllocRangeFrom double,
in In_LveAllocRangeTo double,
in In_LveAllocStringMatch char(20),
in In_LveFormulaId char(30),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double)
begin
  if exists(select* from LveAllocFormulaRec where LveAllocFormulaRec.CostMethodId = In_CostMethodId and
      LveAllocFormulaRec.LveAllocFormulaSysId = In_LveAllocFormulaSysId) then
    update LveAllocFormulaRec set
      LveAllocFormulaRec.LveAllocRangeFrom = In_LveAllocRangeFrom,
      LveAllocFormulaRec.LveAllocRangeTo = In_LveAllocRangeTo,
      LveAllocFormulaRec.LveAllocStringMatch = In_LveAllocStringMatch,
      LveAllocFormulaRec.LveFormulaId = In_LveFormulaId,
      LveAllocFormulaRec.UserDef1Value = In_UserDef1Value,
      LveAllocFormulaRec.UserDef2Value = In_UserDef2Value,
      LveAllocFormulaRec.UserDef3Value = In_UserDef3Value,
      LveAllocFormulaRec.UserDef4Value = In_UserDef4Value,
      LveAllocFormulaRec.UserDef5Value = In_UserDef5Value where
      LveAllocFormulaRec.CostMethodId = In_CostMethodId and
      LveAllocFormulaRec.LveAllocFormulaSysId = In_LveAllocFormulaSysId;
    commit work
  end if
end
;

create procedure dba.UpdateLvePeriodBalance(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_LeaveTypeId char(20),
in In_PolicyCareerValue char(20),
in In_AllocCareerValue char(20),
in In_PerEntEarned double,
in In_PerEntAdjEarned double,
in In_PerBFEarned double,
in In_PerBFForfeit double,
in In_PerTotalEnt double,
in In_PerDayTaken double,
in In_YTDEntEarned double,
in In_YTDEntAdjEarned double,
in In_YTDBFEarned double,
in In_YTDBFForfeit double,
in In_YTDTotalEnt double,
in In_YTDDayTaken double,
in In_YTDBalance double,
in In_CostPerDay double,
in In_AllocRangeBasis char(20),
in In_PerBalLveAllocationId char(20),
in In_PerBalCostMethodId char(20),
in In_PolicyCareerChangeDate date,
in In_AllocCareerChangeDate date)
begin
  if
    exists(select* from LvePeriodBalance where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId) then
    update LvePeriodBalance set
      PerEntEarned = In_PerEntEarned,
      PerEntAdjEarned = In_PerEntAdjEarned,
      PerBFEarned = In_PerBFEarned,
      PerBFForfeit = In_PerBFForfeit,
      PerTotalEnt = In_PerTotalEnt,
      PerDayTaken = In_PerDayTaken,
      YTDEntEarned = In_YTDEntEarned,
      YTDEntAdjEarned = In_YTDEntAdjEarned,
      YTDBFEarned = In_YTDBFEarned,
      YTDBFForfeit = In_YTDBFForfeit,
      YTDTotalEnt = In_YTDTotalEnt,
      YTDDayTaken = In_YTDDayTaken,
      YTDBalance = In_YTDBalance,
      CostPerDay = In_CostPerDay,
      PolicyCareerValue = In_PolicyCareerValue,
      AllocCareerValue = In_AllocCareerValue,
      AllocRangeBasis = In_AllocRangeBasis,
      PerBalLveAllocationId = In_PerBalLveAllocationId,
      PerBalCostMethodId = In_PerBalCostMethodId,
      PolicyCareerChangeDate = In_PolicyCareerChangeDate,
      AllocCareerChangeDate = In_AllocCareerChangeDate where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLvePeriodBalRpt(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LvePeriodRpt integer,
in In_LeaveTypeId char(20),
in In_PeriodStartDate date,
in In_PeriodEndDate date,
in In_PerEntEarned double,
in In_PerEntAdjEarned double,
in In_PerBFEarned double,
in In_PerBFForfeit double,
in In_PerTotalEnt double,
in In_PerDayTaken double,
in In_YTDEntEarned double,
in In_YTDEntAdjEarned double,
in In_YTDBFEarned double,
in In_YTDBFForfeit double,
in In_YTDTotalEnt double,
in In_YTDDayTaken double,
in In_YTDBalance double,
in In_CostPerDay double,
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisLeaveGroupId char(20),
in In_HisPositionId char(20),
in In_HisSectionId char(20))
begin
  if
    exists(select* from LvePeriodBalRpt where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LvePeriodRpt = In_LvePeriodRpt and
      LeaveTypeId = In_LeaveTypeId) then
    update LvePeriodBalRpt set
      PeriodStartDate = In_PeriodStartDate,
      PeriodEndDate = In_PeriodEndDate,
      PerEntEarned = In_PerEntEarned,
      PerEntAdjEarned = In_PerEntAdjEarned,
      PerBFEarned = In_PerBFEarned,
      PerBFForfeit = In_PerBFForfeit,
      PerTotalEnt = In_PerTotalEnt,
      PerDayTaken = In_PerDayTaken,
      YTDEntEarned = In_YTDEntEarned,
      YTDEntAdjEarned = In_YTDEntAdjEarned,
      YTDBFEarned = In_YTDBFEarned,
      YTDBFForfeit = In_YTDBFForfeit,
      YTDTotalEnt = In_YTDTotalEnt,
      YTDDayTaken = In_YTDDayTaken,
      YTDBalance = In_YTDBalance,
      CostPerDay = In_CostPerDay,
      HisBranchId = In_HisBranchId,
      HisCategoryId = In_HisCategoryId,
      HisDepartmentId = In_HisDepartmentId,
      HisLeaveGroupId = In_HisLeaveGroupId,
      HisPositionId = In_HisPositionId,
      HisSectionId = In_HisSectionId where
      EmployeeSysId = In_EmployeeSysId and
      LveYearRpt = In_LveYearRpt and
      LvePeriodRpt = In_LvePeriodRpt and
      LeaveTypeId = In_LeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLvePeriodBF(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_LeaveTypeId char(20),
in In_LveBFLeaveTypeId char(20),
in In_BFDays double,
in In_MaxBFPerCycle double)
begin
  if
    exists(select* from LvePeriodBF where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId and
      LveBFLeaveTypeId = In_LveBFLeaveTypeId) then
    update LvePeriodBF set
      BFDays = In_BFDays,
      MaxBFPerCycle = In_MaxBFPerCycle where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod and
      LeaveTypeId = In_LeaveTypeId and
      LveBFLeaveTypeId = In_LveBFLeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLvePeriodSummary(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_LvePeriod integer,
in In_PeriodStartDate date,
in In_PeriodEndDate date)
begin
  if
    exists(select* from LvePeriodSummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod) then
    update LvePeriodSummary set
      PeriodStartDate = In_PeriodStartDate,
      PeriodEndDate = In_PeriodEndDate where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId and
      LvePeriod = In_LvePeriod;
    commit work
  end if
end
;

create procedure dba.UpdateLvePolicyProg(
in In_EmployeeSysId integer,
in In_LveProgDate date,
in In_LveProgDesc char(100),
in In_LveProgCareerId char(20),
in In_LveOldPolicyId char(20),
in In_LveNewPolicyId char(20),
in In_LveConvertMethod char(20))
begin
  if exists(select* from LeavePolicyProg where LeavePolicyProg.EmployeeSysId = In_EmployeeSysId and
      LeavePolicyProg.LveProgDate = In_LveProgDate) then
    update LeavePolicyProg set
      LeavePolicyProg.LveProgDesc = In_LveProgDesc,
      LeavePolicyProg.LveProgCareerId = In_LveProgCareerId,
      LeavePolicyProg.LveOldPolicyId = In_LveOldPolicyId,
      LeavePolicyProg.LveNewPolicyId = In_LveNewPolicyId,
      LeavePolicyProg.LveConvertMethod = In_LveConvertMethod where
      LeavePolicyProg.EmployeeSysId = In_EmployeeSysId and
      LeavePolicyProg.LveProgDate = In_LveProgDate;
    commit work
  end if
end
;

create procedure dba.UpdateLvePolicySummary(
in In_EmployeeSysId integer,
in In_LveYear integer,
in In_LvePolicySummaryId char(20),
in In_CycStartDate date,
in In_CycEndDate date,
in In_LveProgressStatus char(20),
in In_LveProgressPolicy char(20),
in In_LveProgressMethod char(20),
in In_LveProgressDate date)
begin
  if
    exists(select* from LvePolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId) then
    update LvePolicySummary set
      CycStartDate = In_CycStartDate,
      CycEndDate = In_CycEndDate,
      LveProgressStatus = In_LveProgressStatus,
      LveProgressPolicy = In_LveProgressPolicy,
      LveProgressMethod = In_LveProgressMethod,
      LveProgressDate = In_LveProgressDate where
      EmployeeSysId = In_EmployeeSysId and
      LveYear = In_LveYear and
      LvePolicySummaryId = In_LvePolicySummaryId;
    commit work
  end if
end
;

create procedure
dba.UpdateWorkTime(in In_WTProfileId char(20),in In_StartTime time,in In_EndTime time,in In_DayAppControlId char(20))
begin
  if exists(select* from WorkTime where
      WorkTime.WTProfileId = In_WTProfileId and
      WorkTime.StartTime = In_StartTime) then
    update WorkTime set
      EndTime = In_EndTime,
      DayAppControlId = In_DayAppControlId where
      WorkTime.WTProfileId = In_WTProfileId and
      WorkTime.StartTime = In_StartTime;
    commit work
  end if
end
;

create procedure dba.UpdateWTCalendar(
in In_WTCalendarId char(20),
in In_WTCalendarDesc char(100),
in In_LveCalendarId char(20),
in In_WTCalendarShortForm char(2),
in In_WTCalendarColor integer,
in In_WTPatternType integer,
out Out_ErrorCode integer)
begin
  if exists(select* from WTCalendar where WTCalendarId = In_WTCalendarId) then
    update WTCalendar set
      WTCalendarDesc = In_WTCalendarDesc,
      LveCalendarId = In_LveCalendarId,
      WTCalendarShortForm = In_WTCalendarShortForm,
      WTCalendarColor = In_WTCalendarColor,
      WTPatternType = In_WTPatternType where
      WTCalendarId = In_WTCalendarId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateWTProfile(
in In_WTProfileId char(20),
in In_WTProfileDesc char(100))
begin
  if exists(select* from WTProfile where
      WTProfile.WTProfileId = In_WTProfileId) then
    update WTProfile set
      WTProfileDesc = In_WTProfileDesc where
      WTProfile.WTProfileId = In_WTProfileId;
    commit work
  end if
end
;

create procedure dba.ASQLUpdateLeaveBasisSubregistry()
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
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id,RegProperty2 = EmpCode1_Id where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id,RegProperty2 = EmpCode2_Id where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id,RegProperty2 = EmpCode3_Id where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id,RegProperty2 = EmpCode4_Id where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id,RegProperty2 = EmpCode5_Id where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id,RegProperty2 = EmpLocation1_Id where
      RegistryId = 'LeaveRangeBasis' and SubRegistryId = 'LeaveEmpLoc1Id'
  end if;
  commit work
end
;

Create procedure dba.DeleteLeaveApplicationByGenId(
in In_LeaveAppSGSPGenId char(30))
begin
  if exists(select* from LeaveApplication where
      LeaveApplication.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId) then
    delete from LeaveRecord where LeaveAppSGSPGenId = In_LeaveAppSGSPGenId;
    delete from LeaveApplication where
      LeaveAppSGSPGenId = In_LeaveAppSGSPGenId;
    commit work
  end if
end
;

create function dba.FGetNearestPeriodForeignLocalRate(
in In_Year integer,
in In_Month integer)
returns double
begin
  declare Out_ForeignLocalRate double;
  declare Out_CufOffDate date;
  /* finds the lastest Exch Rate progression nearest to In_Year,In_Period
  eg. Eff Date : '2005-08-09', will compare against last date of the specified period, eg 2005/ 7 = '2005-07-30'
  Difference = '2005-08-09' - '2005-06-30' = 40 days
  */
  select first YMD(In_Year,In_Month+1,1-1) as CutOffDate,
    ForeignLocalRate into Out_CufOffDate,Out_ForeignLocalRate from
    ExchangeRateProg where
    ExChgRateEffectiveDate <= CutOffDate and
    ExchangeRateID = (select first CompanyStatutoryContri from Company order by CompanyId) order by
    ExChgRateEffectiveDate desc;
  if Out_ForeignLocalRate is null then set Out_ForeignLocalRate=1
  end if;
  return(Out_ForeignLocalRate)
end
;

create function dba.FGetLveCreditFutureTaken(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_EffectiveDate date)
returns double
begin
  declare Out_TotalTaken double;
  /*
  Get Leave Records Taken before Expire Date
  */
  select Sum(LveRecConvertDays) into Out_TotalTaken from LeaveRecord where
    LeaveAppSGSPGenId = any(select LeaveAppSGSPGenId from LeaveApplication where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeId = In_LeaveTypeId and
      LveRecApproved = 1) and LveRecDate > In_EffectiveDate;
  if(Out_TotalTaken is null) then set Out_TotalTaken=0
  end if;
  return Out_TotalTaken
end
;

create procedure dba.ASQLUpdateLeaveKeyword()
begin
  declare CustDate1 char(100);
  declare CustDate2 char(100);
  declare CustDate3 char(100);
  declare CustDate4 char(100);
  declare CustDate5 char(100);
  select NewLName into CustDate1 from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2 from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3 from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
  select NewLName into CustDate4 from LabelName where TableName = 'Employee' and AttributeName = 'CustDate4';
  select NewLName into CustDate5 from LabelName where TableName = 'Employee' and AttributeName = 'CustDate5';
  update LeaveKeyword set
    LveKeywordUserdefinedName = CustDate1,
    LveKeywordDesc = CustDate1 where
    LveKeywordId = 'ByCustDate1';
  update LeaveKeyword set
    LveKeywordUserdefinedName = CustDate2,
    LveKeywordDesc = CustDate2 where
    LveKeywordId = 'ByCustDate2';
  update LeaveKeyword set
    LveKeywordUserdefinedName = CustDate3,
    LveKeywordDesc = CustDate3 where
    LveKeywordId = 'ByCustDate3';
  update LeaveKeyword set
    LveKeywordUserdefinedName = CustDate4,
    LveKeywordDesc = CustDate4 where
    LveKeywordId = 'ByCustDate4';
  update LeaveKeyword set
    LveKeywordUserdefinedName = CustDate5,
    LveKeywordDesc = CustDate5 where
    LveKeywordId = 'ByCustDate5';
  commit work
end
;