create procedure
DBA.InsertNewEPFProgression(
in In_EmployeeSysId integer,
in In_EPFEffectiveDate date,
in In_EPFCareerId char(20),
in In_EPFProgPolicyId char(20),
in In_EPFProgSchemeId char(20),
in In_EPFEEVolPercent double,
in In_EPFERVolPercent double,
in In_EPFProgRemarks char(255),
in In_EPFProgCurrent smallint)
begin
  if not exists(select* from EPFProgression where
      EPFProgression.EmployeeSysId = In_EmployeeSysId and
      EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate) then
    insert into EPFProgression(EmployeeSysId,
      EPFEffectiveDate,
      EPFCareerId,
      EPFProgPolicyId,
      EPFProgSchemeId,
      EPFEEVolPercent,
      EPFERVolPercent,
      EPFProgRemarks,
      EPFProgCurrent) values(
      In_EmployeeSysId,
      In_EPFEffectiveDate,
      In_EPFCareerId,
      In_EPFProgPolicyId,
      In_EPFProgSchemeId,
      In_EPFEEVolPercent,
      In_EPFERVolPercent,
      In_EPFProgRemarks,
      In_EPFProgCurrent);
    commit work
  end if
end
;

create procedure DBA.UpdateEPFProgression(
in In_EmployeeSysId integer,
in In_EPFEffectiveDate date,
in In_EPFCareerId char(20),
in In_EPFProgPolicyId char(20),
in In_EPFProgSchemeId char(20),
in In_EPFEEVolPercent double,
in In_EPFERVolPercent double,
in In_EPFProgRemarks char(255),
in In_EPFProgCurrent smallint)
begin
  if exists(select* from EPFProgression where EPFProgression.EmployeeSysId = In_EmployeeSysId and EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate) then
    if(In_EPFProgCurrent = 1) then
      update EPFProgression set
        EPFProgression.EPFProgCurrent = 0 where
        EPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update EPFProgression set
      EPFProgression.EmployeeSysId = In_EmployeeSysId,
      EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate,
      EPFProgression.EPFCareerId = In_EPFCareerId,
      EPFProgression.EPFProgPolicyId = In_EPFProgPolicyId,
      EPFProgression.EPFProgSchemeId = In_EPFProgSchemeId,
      EPFProgression.EPFEEVolPercent = In_EPFEEVolPercent,
      EPFProgression.EPFERVolPercent = In_EPFERVolPercent,
      EPFProgression.EPFProgRemarks = In_EPFProgRemarks,
      EPFProgression.EPFProgCurrent = In_EPFProgCurrent where
      EPFProgression.EmployeeSysId = In_EmployeeSysId and EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate;
    commit work
  end if
end
;

create procedure DBA.DeleteEPFProgression(
in In_EmployeeSysId integer)
begin
  if exists(select* from EPFProgression where EPFProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from EPFProgression where
      EPFProgression.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.DeleteEPFProgressionRec(
in In_EmployeeSysId integer,
in In_EPFEffectiveDate date)
begin
  if exists(select* from EPFProgression where EPFProgression.EmployeeSysId = In_EmployeeSysId and
      EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate) then
    delete from EPFProgression where
      EPFProgression.EmployeeSysId = In_EmployeeSysId and
      EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate;
    commit work
  end if
end
;

create procedure DBA.InsertNewSOCSOProgression(
in In_EmployeeSysId integer,
in In_SOCSOEffectiveDate date,
in In_SOCSOCareerId char(20),
in In_SOCSOProgPolicyId char(20),
in In_SOCSOProgSchemeId char(20),
in In_SOCSOP1Payment smallint,
in In_SOCSORemarks char(255),
in In_SOCSOCurrent smallint)
begin
  if not exists(select* from SOCSOProgression where
      SOCSOProgression.EmployeeSysId = In_EmployeeSysId and
      SOCSOProgression.SOCSOEffectiveDate = In_SOCSOEffectiveDate) then
    insert into SOCSOProgression(EmployeeSysId,
      SOCSOEffectiveDate,
      SOCSOCareerId,
      SOCSOProgPolicyId,
      SOCSOProgSchemeId,
      SOCSOP1Payment,
      SOCSORemarks,
      SOCSOCurrent) values(
      In_EmployeeSysId,
      In_SOCSOEffectiveDate,
      In_SOCSOCareerId,
      In_SOCSOProgPolicyId,
      In_SOCSOProgSchemeId,
      In_SOCSOP1Payment,
      In_SOCSORemarks,
      In_SOCSOCurrent);
    commit work
  end if
end
;

create procedure DBA.DeleteSOCSOProgression(
in In_EmployeeSysId integer)
begin
  if exists(select* from SOCSOProgression where SOCSOProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from SOCSOProgression where
      SOCSOProgression.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.UpdateSOCSOProgression(
in In_EmployeeSysId integer,
in In_SOCSOEffectiveDate date,
in In_SOCSOCareerId char(20),
in In_SOCSOProgPolicyId char(20),
in In_SOCSOProgSchemeId char(20),
in In_SOCSOP1Payment smallint,
in In_SOCSORemarks char(255),
in In_SOCSOCurrent smallint)
begin
  if exists(select* from SOCSOProgression where SOCSOProgression.EmployeeSysId = In_EmployeeSysId and SOCSOProgression.SOCSOEffectiveDate = In_SOCSOEffectiveDate) then
    if(In_SOCSOCurrent = 1) then
      update SOCSOProgression set
        SOCSOProgression.SOCSOCurrent = 0 where
        SOCSOProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update SOCSOProgression set
      SOCSOProgression.EmployeeSysId = In_EmployeeSysId,
      SOCSOProgression.SOCSOEffectiveDate = In_SOCSOEffectiveDate,
      SOCSOProgression.SOCSOCareerId = In_SOCSOCareerId,
      SOCSOProgression.SOCSOProgPolicyId = In_SOCSOProgPolicyId,
      SOCSOProgression.SOCSOProgSchemeId = In_SOCSOProgSchemeId,
      SOCSOProgression.SOCSOP1Payment = In_SOCSOP1Payment,
      SOCSOProgression.SOCSORemarks = In_SOCSORemarks,
      SOCSOProgression.SOCSOCurrent = In_SOCSOCurrent where
      SOCSOProgression.EmployeeSysId = In_EmployeeSysId and SOCSOProgression.SOCSOEffectiveDate = In_SOCSOEffectiveDate;
    commit work
  end if
end
;

create procedure DBA.DeleteSOCSOProgressionRec(
in In_EmployeeSysId integer,
in In_SOCSOEffectiveDate date)
begin
  if exists(select* from SOCSOProgression where SOCSOProgression.EmployeeSysId = In_EmployeeSysId and
      SOCSOProgression.SOCSOEffectiveDate = In_SOCSOEffectiveDate) then
    delete from SOCSOProgression where
      SOCSOProgression.EmployeeSysId = In_EmployeeSysId and
      SOCSOProgression.SOCSOEffectiveDate = In_SOCSOEffectiveDate;
    commit work
  end if
end
;

create function DBA.FGetEPFProgPreviousProgDate(
in In_EmployeeSysId integer,
in In_EPFEffectiveDate date)
returns date
begin
  declare Out_PrevEPFEffectiveDate date;
  select max(EPFEffectiveDate) into Out_PrevEPFEffectiveDate from EPFProgression where EmployeeSysId = in_EmployeeSysId and
    EPFEffectiveDate < In_EPFEffectiveDate;
  if exists(select* from EPFProgression where EPFProgression.EmployeeSysId = In_EmployeeSysId and
      EPFEffectiveDate = Out_PrevEPFEffectiveDate) then
    update EPFProgression set
      EPFProgression.EPFProgCurrent = 1 where
      EPFProgression.EmployeeSysId = In_EmployeeSysId and EPFEffectiveDate = Out_PrevEPFEffectiveDate;
    commit work
  end if;
  return(Out_PrevEPFEffectiveDate)
end
;

create function DBA.FGetSOCSOProgPreviousProgDate(
in In_EmployeeSysId integer,
in In_SOCSOEffectiveDate date)
returns date
begin
  declare Out_PrevSOCSOEffectiveDate date;
  select max(SOCSOEffectiveDate) into Out_PrevSOCSOEffectiveDate from SOCSOProgression where EmployeeSysId = in_EmployeeSysId and
    SOCSOEffectiveDate < In_SOCSOEffectiveDate;
  if exists(select* from SOCSOProgression where SOCSOProgression.EmployeeSysId = In_EmployeeSysId and
      SOCSOEffectiveDate = Out_PrevSOCSOEffectiveDate) then
    update SOCSOProgression set
      SOCSOProgression.SOCSOCurrent = 1 where
      SOCSOProgression.EmployeeSysId = In_EmployeeSysId and SOCSOEffectiveDate = Out_PrevSOCSOEffectiveDate;
    commit work
  end if;
  return(Out_PrevSOCSOEffectiveDate)
end
;

create procedure dba.InsertNewMalTaxRecord(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxEmployerId char(20),
in In_MalTaxPolicyId char(20),
in In_MalTaxSerialNo char(20),
in In_MalTaxSubmissionStatus char(20),
in In_MalTaxResidenceStatus char(20),
in In_MalTaxPositionId char(20),
in In_MalTaxChildRelief integer,
in In_MalTaxNoChildRelief integer,
in In_MalTaxNoChildBelow18 integer,
in In_MalTaxMaritalStatus char(20),
in In_MalTaxHireDate date,
in In_MalTaxCessationDate date,
in In_MalTaxPrevERName char(100),
in In_MalTaxPrevERAddr char(100),
in In_MalTaxNewERName char(100),
in In_MalTaxNewERAddr char(100),
in In_MalTaxGrossSalary double,
in In_MalTaxLeavePayCode double,
in In_MalTaxDirCommBonus double,
in In_MalTaxBonusFrom date,
in In_MalTaxBonusTo date,
in In_MalTaxOtherAllowance double,
in In_MalTaxOtherAllowDesc char(100),
in In_MalTaxIncentiveCode double,
in In_MalTaxERTaxPayment double,
in In_MalTaxCarDate date,
in In_MalTaxMotorCarFuel double,
in In_MalTaxCarType char(30),
in In_MalTaxCarYear integer,
in In_MalTaxCarModel char(20),
in In_MalTaxDriver double,
in In_MalTaxUtility double,
in In_MalTaxFurniture double,
in In_MalTaxFullKitchenEquip double,
in In_MalTaxFittings double,
in In_MalTaxKitchenEquip double,
in In_MalTaxEntertainment double,
in In_MalTaxHandphone double,
in In_MalTaxServant double,
in In_MalTaxHolidays double,
in In_MalTaxOtherFoodCloth double,
in In_MalTaxAccomdation double,
in In_MalTaxAccomAddr char(100),
in In_MalTaxRefundPension double,
in In_MalTaxCompensation double,
in In_MalTaxERPension double,
in In_MalTaxAnnuity double,
in In_MalTaxAmount double,
in In_MalTaxCP38Amount double,
in In_MalTaxWP39Amount double,
in In_MalTaxZAKAT double,
in In_MalTaxProvidentDesc char(100),
in In_MalTaxEECurrManEPF double,
in In_MalTaxEESocso double,
in In_MalTaxPrevYear integer,
in In_MalTaxPrevIncomeType char(50),
in In_MalTaxPrevTaxAmount double,
in In_MalTaxEEPrevManEPF double,
in In_MalTaxSubmittedDate date,
in In_MalTaxLastSalary double,
in In_MalTaxNJAllowance char(100),
in In_MalTaxNJEmoluments char(100),
in In_MalTaxPrevTaxWage double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
    return
  elseif not In_MalTaxEmployerId = any(select MalTaxEmployerId from MalTaxEmployer) then
    set Out_ErrorCode=-3; // MalTaxEmployerId not exist
    return
  elseif not In_MalTaxPolicyId = any(select MalTaxPolicyId from MalTaxPolicy) then
    set Out_ErrorCode=-4; // MalTaxPolicyId not exist
    return
  else
    insert into MalTaxRecord(PersonalSysId,
      MalTaxYear,
      MalTaxEmployerId,
      MalTaxPolicyId,
      MalTaxSerialNo,
      MalTaxSubmissionStatus,
      MalTaxResidenceStatus,
      MalTaxPositionId,
      MalTaxChildRelief,
      MalTaxNoChildRelief,
      MalTaxNoChildBelow18,
      MalTaxMaritalStatus,
      MalTaxHireDate,
      MalTaxCessationDate,
      MalTaxPrevERName,
      MalTaxPrevERAddr,
      MalTaxNewERName,
      MalTaxNewERAddr,
      MalTaxGrossSalary,
      MalTaxLeavePayCode,
      MalTaxDirCommBonus,
      MalTaxBonusFrom,
      MalTaxBonusTo,
      MalTaxOtherAllowance,
      MalTaxOtherAllowDesc,
      MalTaxIncentiveCode,
      MalTaxERTaxPayment,
      MalTaxCarDate,
      MalTaxMotorCarFuel,
      MalTaxCarType,
      MalTaxCarYear,
      MalTaxCarModel,
      MalTaxDriver,
      MalTaxUtility,
      MalTaxFurniture,
      MalTaxFullKitchenEquip,
      MalTaxFittings,
      MalTaxKitchenEquip,
      MalTaxEntertainment,
      MalTaxHandphone,
      MalTaxServant,
      MalTaxHolidays,
      MalTaxOtherFoodCloth,
      MalTaxAccomdation,
      MalTaxAccomAddr,
      MalTaxRefundPension,
      MalTaxCompensation,
      MalTaxERPension,
      MalTaxAnnuity,
      MalTaxAmount,
      MalTaxCP38Amount,
      MalTaxWP39Amount,
      MalTaxZAKAT,
      MalTaxProvidentDesc,
      MalTaxEECurrManEPF,
      MalTaxEESocso,
      MalTaxPrevYear,
      MalTaxPrevIncomeType,
      MalTaxPrevTaxAmount,
      MalTaxEEPrevManEPF,
      MalTaxSubmittedDate,
      MalTaxLastSalary,
      MalTaxNJAllowance,
      MalTaxNJEmoluments,
      MalTaxPrevTaxWage) values(
      In_PersonalSysId,
      In_MalTaxYear,
      In_MalTaxEmployerId,
      In_MalTaxPolicyId,
      In_MalTaxSerialNo,
      In_MalTaxSubmissionStatus,
      In_MalTaxResidenceStatus,
      In_MalTaxPositionId,
      In_MalTaxChildRelief,
      In_MalTaxNoChildRelief,
      In_MalTaxNoChildBelow18,
      In_MalTaxMaritalStatus,
      In_MalTaxHireDate,
      In_MalTaxCessationDate,
      In_MalTaxPrevERName,
      In_MalTaxPrevERAddr,
      In_MalTaxNewERName,
      In_MalTaxNewERAddr,
      In_MalTaxGrossSalary,
      In_MalTaxLeavePayCode,
      In_MalTaxDirCommBonus,
      In_MalTaxBonusFrom,
      In_MalTaxBonusTo,
      In_MalTaxOtherAllowance,
      In_MalTaxOtherAllowDesc,
      In_MalTaxIncentiveCode,
      In_MalTaxERTaxPayment,
      In_MalTaxCarDate,
      In_MalTaxMotorCarFuel,
      In_MalTaxCarType,
      In_MalTaxCarYear,
      In_MalTaxCarModel,
      In_MalTaxDriver,
      In_MalTaxUtility,
      In_MalTaxFurniture,
      In_MalTaxFullKitchenEquip,
      In_MalTaxFittings,
      In_MalTaxKitchenEquip,
      In_MalTaxEntertainment,
      In_MalTaxHandphone,
      In_MalTaxServant,
      In_MalTaxHolidays,
      In_MalTaxOtherFoodCloth,
      In_MalTaxAccomdation,
      In_MalTaxAccomAddr,
      In_MalTaxRefundPension,
      In_MalTaxCompensation,
      In_MalTaxERPension,
      In_MalTaxAnnuity,
      In_MalTaxAmount,
      In_MalTaxCP38Amount,
      In_MalTaxWP39Amount,
      In_MalTaxZAKAT,
      In_MalTaxProvidentDesc,
      In_MalTaxEECurrManEPF,
      In_MalTaxEESocso,
      In_MalTaxPrevYear,
      In_MalTaxPrevIncomeType,
      In_MalTaxPrevTaxAmount,
      In_MalTaxEEPrevManEPF,
      In_MalTaxSubmittedDate,
      In_MalTaxLastSalary,
      In_MalTaxNJAllowance,
      In_MalTaxNJEmoluments,
      In_MalTaxPrevTaxWage);
    commit work
  end if;
  if not exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.UpdateMalTaxRecord(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxEmployerId char(20),
in In_MalTaxPolicyId char(20),
in In_MalTaxSerialNo char(20),
in In_MalTaxSubmissionStatus char(20),
in In_MalTaxResidenceStatus char(20),
in In_MalTaxPositionId char(20),
in In_MalTaxChildRelief integer,
in In_MalTaxNoChildRelief integer,
in In_MalTaxNoChildBelow18 integer,
in In_MalTaxMaritalStatus char(20),
in In_MalTaxHireDate date,
in In_MalTaxCessationDate date,
in In_MalTaxPrevERName char(100),
in In_MalTaxPrevERAddr char(100),
in In_MalTaxNewERName char(100),
in In_MalTaxNewERAddr char(100),
in In_MalTaxGrossSalary double,
in In_MalTaxLeavePayCode double,
in In_MalTaxDirCommBonus double,
in In_MalTaxBonusFrom date,
in In_MalTaxBonusTo date,
in In_MalTaxOtherAllowance double,
in In_MalTaxOtherAllowDesc char(100),
in In_MalTaxIncentiveCode double,
in In_MalTaxERTaxPayment double,
in In_MalTaxCarDate date,
in In_MalTaxMotorCarFuel double,
in In_MalTaxCarType char(30),
in In_MalTaxCarYear integer,
in In_MalTaxCarModel char(20),
in In_MalTaxDriver double,
in In_MalTaxUtility double,
in In_MalTaxFurniture double,
in In_MalTaxFullKitchenEquip double,
in In_MalTaxFittings double,
in In_MalTaxKitchenEquip double,
in In_MalTaxEntertainment double,
in In_MalTaxHandphone double,
in In_MalTaxServant double,
in In_MalTaxHolidays double,
in In_MalTaxOtherFoodCloth double,
in In_MalTaxAccomdation double,
in In_MalTaxAccomAddr char(100),
in In_MalTaxRefundPension double,
in In_MalTaxCompensation double,
in In_MalTaxERPension double,
in In_MalTaxAnnuity double,
in In_MalTaxAmount double,
in In_MalTaxCP38Amount double,
in In_MalTaxWP39Amount double,
in In_MalTaxZAKAT double,
in In_MalTaxProvidentDesc char(100),
in In_MalTaxEECurrManEPF double,
in In_MalTaxEESocso double,
in In_MalTaxPrevYear integer,
in In_MalTaxPrevIncomeType char(50),
in In_MalTaxPrevTaxAmount double,
in In_MalTaxEEPrevManEPF double,
in In_MalTaxSubmittedDate date,
in In_MalTaxLastSalary double,
in In_MalTaxNJAllowance char(100),
in In_MalTaxNJEmoluments char(100),
in In_MalTaxPrevTaxWage double,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  elseif not In_MalTaxEmployerId = any(select MalTaxEmployerId from MalTaxEmployer) then
    set Out_ErrorCode=-2; // MalTaxEmployerId not exist
    return
  elseif not In_MalTaxPolicyId = any(select MalTaxPolicyId from MalTaxPolicy) then
    set Out_ErrorCode=-3; // MalTaxPolicyId not exist
    return
  else
    update MalTaxRecord set
      MalTaxYear = In_MalTaxYear,
      MalTaxEmployerId = In_MalTaxEmployerId,
      MalTaxPolicyId = In_MalTaxPolicyId,
      MalTaxSerialNo = In_MalTaxSerialNo,
      MalTaxSubmissionStatus = In_MalTaxSubmissionStatus,
      MalTaxResidenceStatus = In_MalTaxResidenceStatus,
      MalTaxPositionId = In_MalTaxPositionId,
      MalTaxChildRelief = In_MalTaxChildRelief,
      MalTaxNoChildRelief = In_MalTaxNoChildRelief,
      MalTaxNoChildBelow18 = In_MalTaxNoChildBelow18,
      MalTaxMaritalStatus = In_MalTaxMaritalStatus,
      MalTaxHireDate = In_MalTaxHireDate,
      MalTaxCessationDate = In_MalTaxCessationDate,
      MalTaxPrevERName = In_MalTaxPrevERName,
      MalTaxPrevERAddr = In_MalTaxPrevERAddr,
      MalTaxNewERName = In_MalTaxNewERName,
      MalTaxNewERAddr = In_MalTaxNewERAddr,
      MalTaxGrossSalary = In_MalTaxGrossSalary,
      MalTaxLeavePayCode = In_MalTaxLeavePayCode,
      MalTaxDirCommBonus = In_MalTaxDirCommBonus,
      MalTaxBonusFrom = In_MalTaxBonusFrom,
      MalTaxBonusTo = In_MalTaxBonusTo,
      MalTaxOtherAllowance = In_MalTaxOtherAllowance,
      MalTaxOtherAllowDesc = In_MalTaxOtherAllowDesc,
      MalTaxIncentiveCode = In_MalTaxIncentiveCode,
      MalTaxERTaxPayment = In_MalTaxERTaxPayment,
      MalTaxCarDate = In_MalTaxCarDate,
      MalTaxMotorCarFuel = In_MalTaxMotorCarFuel,
      MalTaxCarType = In_MalTaxCarType,
      MalTaxCarYear = In_MalTaxCarYear,
      MalTaxCarModel = In_MalTaxCarModel,
      MalTaxDriver = In_MalTaxDriver,
      MalTaxUtility = In_MalTaxUtility,
      MalTaxFurniture = In_MalTaxFurniture,
      MalTaxFullKitchenEquip = In_MalTaxFullKitchenEquip,
      MalTaxFittings = In_MalTaxFittings,
      MalTaxKitchenEquip = In_MalTaxKitchenEquip,
      MalTaxEntertainment = In_MalTaxEntertainment,
      MalTaxHandphone = In_MalTaxHandphone,
      MalTaxServant = In_MalTaxServant,
      MalTaxHolidays = In_MalTaxHolidays,
      MalTaxOtherFoodCloth = In_MalTaxOtherFoodCloth,
      MalTaxAccomdation = In_MalTaxAccomdation,
      MalTaxAccomAddr = In_MalTaxAccomAddr,
      MalTaxRefundPension = In_MalTaxRefundPension,
      MalTaxCompensation = In_MalTaxCompensation,
      MalTaxERPension = In_MalTaxERPension,
      MalTaxAnnuity = In_MalTaxAnnuity,
      MalTaxAmount = In_MalTaxAmount,
      MalTaxCP38Amount = In_MalTaxCP38Amount,
      MalTaxWP39Amount = In_MalTaxWP39Amount,
      MalTaxZAKAT = In_MalTaxZAKAT,
      MalTaxProvidentDesc = In_MalTaxProvidentDesc,
      MalTaxEECurrManEPF = In_MalTaxEECurrManEPF,
      MalTaxEESocso = In_MalTaxEESocso,
      MalTaxPrevYear = In_MalTaxPrevYear,
      MalTaxPrevIncomeType = In_MalTaxPrevIncomeType,
      MalTaxPrevTaxAmount = In_MalTaxPrevTaxAmount,
      MalTaxEEPrevManEPF = In_MalTaxEEPrevManEPF,
      MalTaxSubmittedDate = In_MalTaxSubmittedDate,
      MalTaxLastSalary = In_MalTaxLastSalary,
      MalTaxNJAllowance = In_MalTaxNJAllowance,
      MalTaxNJEmoluments = In_MalTaxNJEmoluments,
      MalTaxPrevTaxWage = In_MalTaxPrevTaxWage where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create function DBA.FGetPersonalMalaysiaOldIC(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_IdentityNo char(30);
  select Personal.Mal_OldIdentity into Out_IdentityNo
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  return(Out_IdentityNo)
end
;

create function DBA.FGetPersonalMalaysiaTaxNo(
in In_PersonalSysId integer)
returns char(20)
begin
  declare Out_TaxNo char(20);
  select MalTaxDetails.MalTaxEETaxRefNo into Out_TaxNo
    from MalTaxDetails where MalTaxDetails.PersonalSysId = In_PersonalSysId;
  return(Out_TaxNo)
end
;

create function DBA.FGetTaxBranchNo(
in In_EmployerId char(20))
returns char(20)
begin
  declare Out_BrchTaxNo char(20);
  select MalTaxEmployer.MalTaxBranchENo into Out_BrchTaxNo
    from MalTaxEmployer where MalTaxEmployer.MalTaxEmployerId = In_EmployerId;
  return(Out_BrchTaxNo)
end
;

create function dba.FGetMlsiaEPFFormula(
in In_OrdFormulaId char(20),
in In_AddFormulaId char(20))
returns char(255)
begin
  declare Out_AddDesc char(255);
  declare Out_OrdDesc char(255);
  declare OrdFormulaType char(20);
  declare AddFormulaType char(20);
  declare OrdC1 double;
  declare OrdC2 double;
  declare OrdC3 double;
  declare OrdC4 double;
  declare OrdC5 double;
  declare OrdUserDef1 char(20);
  declare OrdUserDef2 char(20);
  declare AddC1 double;
  declare AddC2 double;
  declare AddC3 double;
  declare AddC4 double;
  declare AddC5 double;
  declare AddUserDef1 char(20);
  declare AddUserDef2 char(20);
  /*
  To Get Ordinary Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    UserDef1,
    UserDef2 into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5,
    OrdUserDef1,
    OrdUserDef2 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
  /*
  To Get Additional Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    UserDef1,
    UserDef2 into AddFormulaType,
    AddC1,
    AddC2,
    AddC3,
    AddC4,
    AddC5,
    AddUserDef1,
    AddUserDef2 from Formula join FormulaRange where Formula.FormulaId = In_AddFormulaId;
  set Out_OrdDesc=null;
  set Out_AddDesc=null;
  /*
  To check the formula type
  */
  if(OrdFormulaType = 'T1') then
    set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% *'+OrdUserDef2+'(Mandatory Wage)]'
  elseif(OrdFormulaType = 'T2') then
    set Out_OrdDesc=OrdUserDef1+'[('+LTrim(Str(OrdC1,8,2))+'% + Voluntary%)*'+OrdUserDef2+'(Mandatory Wage)]'
  elseif(OrdFormulaType = 'T3') then
    set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% *'+OrdUserDef2+'(Mandatory Wage)]'
  elseif(OrdFormulaType = 'T4') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,2))
  end if;
  if(AddFormulaType = 'T3') then
    set Out_AddDesc=AddUserDef1+'[Voluntary%*'+AddUserDef2+'(Voluntary Wage)]'
  end if;
  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
    set Out_OrdDesc=Out_OrdDesc+' and ';
    select FDecodeFormula(In_AddFormulaId) into Out_AddDesc
  end if;
  return Out_OrdDesc+Out_AddDesc
end
;

create procedure DBA.ASQLCalPayPeriodEPFWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_EPFWageType char(20),
out Out_EPFWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare In_SubjectString char(20);
  declare In_DeclaredYear integer;
  set Out_EPFWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_OTBackPayAmt=0;
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrERManEPFWage' then
    set In_SubjectString='SubjERManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrERVolEPFWage' then
    set In_SubjectString='SubjERVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevERManEPFWage' then
    set In_SubjectString='SubjERManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevERVolEPFWage' then
    set In_SubjectString='SubjERVolEPF';
    set In_DeclaredYear=In_PayRecYear-1
  else
    return
  end case
  ;
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjectString) = 1 and
      Year(AllowanceDeclaredDate) = In_DeclaredYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrERManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage' or
      In_EPFWageType = 'CurrERVolEPFWage') then
      /*
      OT Amount
      */
      select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      Shift Amount
      */
      select Sum(ShiftAmount) into Out_ShiftTotal from
        ShiftRecord where
        IsFormulaIdHasProperty(ShiftFormulaId,In_SubjectString) = 1 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if;
    /*
    OT Back Pay Amount Only applicable to Period 1 if Previous 
    */
    if((In_PayRecPeriod > 1 and
      (In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrERManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage' or
      In_EPFWageType = 'CurrERVolEPFWage')) or
      (In_PayRecPeriod = 1 and
      (In_EPFWageType = 'PrevEEManEPFWage' or
      In_EPFWageType = 'PrevERManEPFWage' or
      In_EPFWageType = 'PrevEEVolEPFWage' or
      In_EPFWageType = 'PrevERVolEPFWage'))) then
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_EPFWage=Out_EPFWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_EPFWage=Out_EPFWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay Only applicable to Period 1 if Previous 
  */
  if((In_PayRecPeriod > 1 and
    (In_EPFWageType = 'CurrEEManEPFWage' or
    In_EPFWageType = 'CurrERManEPFWage' or
    In_EPFWageType = 'CurrEEVolEPFWage' or
    In_EPFWageType = 'CurrERVolEPFWage')) or
    (In_PayRecPeriod = 1 and
    (In_EPFWageType = 'PrevEEManEPFWage' or
    In_EPFWageType = 'PrevERManEPFWage' or
    In_EPFWageType = 'PrevEEVolEPFWage' or
    In_EPFWageType = 'PrevERVolEPFWage'))) then
    if(IsWageElementInUsed('BackPay',In_EPFWageType) = 1) then
      select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      set Out_EPFWage=Out_EPFWage+Out_BackPayAmt
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_EPFWage=Out_EPFWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayPeriodSOCSOWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_SOCSOWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_SOCSOWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_OTBackPayAmt=0;
  if(IsWageElementInUsed('SubjSOCSO','SOCSOWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Back Pay
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_SOCSOWage=Out_SOCSOWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','SOCSOWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_SOCSOWage=Out_SOCSOWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','SOCSOWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_SOCSOWage=Out_SOCSOWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','SOCSOWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_SOCSOWage=Out_SOCSOWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayRecEPFWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_EPFWageType char(20),
out Out_EPFWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare In_SubjectString char(20);
  declare In_DeclaredYear integer;
  set Out_EPFWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_OTBackPayAmt=0;
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrERManEPFWage' then
    set In_SubjectString='SubjERManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrERVolEPFWage' then
    set In_SubjectString='SubjERVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevERManEPFWage' then
    set In_SubjectString='SubjERManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevERVolEPFWage' then
    set In_SubjectString='SubjERVolEPF';
    set In_DeclaredYear=In_PayRecYear-1
  else
    return
  end case
  ;
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjectString) = 1 and
      Year(AllowanceDeclaredDate) = In_DeclaredYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrERManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage' or
      In_EPFWageType = 'CurrERVolEPFWage') then
      /*
      OT Amount
      */
      select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID;
      /*
      Shift Amount
      */
      select Sum(ShiftAmount) into Out_ShiftTotal from
        ShiftRecord where
        IsFormulaIdHasProperty(ShiftFormulaId,In_SubjectString) = 1 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if;
    /*
    OT Back Pay Amount Only applicable to Period 1 if Previous 
    */
    if((In_PayRecPeriod > 1 and
      (In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrERManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage' or
      In_EPFWageType = 'CurrERVolEPFWage')) or
      (In_PayRecPeriod = 1 and
      (In_EPFWageType = 'PrevEEManEPFWage' or
      In_EPFWageType = 'PrevERManEPFWage' or
      In_EPFWageType = 'PrevEEVolEPFWage' or
      In_EPFWageType = 'PrevERVolEPFWage'))) then
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_EPFWage=Out_EPFWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_EPFWage=Out_EPFWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay Only applicable to Period 1 if Previous 
  */
  if((In_PayRecPeriod > 1 and
    (In_EPFWageType = 'CurrEEManEPFWage' or
    In_EPFWageType = 'CurrERManEPFWage' or
    In_EPFWageType = 'CurrEEVolEPFWage' or
    In_EPFWageType = 'CurrERVolEPFWage')) or
    (In_PayRecPeriod = 1 and
    (In_EPFWageType = 'PrevEEManEPFWage' or
    In_EPFWageType = 'PrevERManEPFWage' or
    In_EPFWageType = 'PrevEEVolEPFWage' or
    In_EPFWageType = 'PrevERVolEPFWage'))) then
    if(IsWageElementInUsed('BackPay',In_EPFWageType) = 1) then
      select CalBackPay into Out_BackPayAmt from detailrecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID;
      set Out_EPFWage=Out_EPFWage+Out_BackPayAmt
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_EPFWage=Out_EPFWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayRecSOCSOWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_SOCSOWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_SOCSOWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_OTBackPayAmt=0;
  if(IsWageElementInUsed('SubjSOCSO','SOCSOWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_SOCSOWage=Out_SOCSOWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','SOCSOWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_SOCSOWage=Out_SOCSOWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','SOCSOWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_SOCSOWage=Out_SOCSOWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','SOCSOWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_SOCSOWage=Out_SOCSOWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalMalPayPeriodTaxWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurrentNonAllowance double,
out Out_CurrentAllowance double,
out Out_CurrentAdditional double,
out Out_CurrentCompensation double,
out Out_PreviousNonAllowance double,
out Out_PreviousAllowance double,
out Out_PreviousAdditional double,
out Out_PreviousCompensation double,
out Out_CurrentNonAllowanceEPF double,
out Out_CurrentAllowanceEPF double,
out Out_CurrentAdditionalEPF double,
out Out_PreviousNonAllowanceEPF double,
out Out_PreviousAllowanceEPF double,
out Out_PreviousAdditionalEPF double)
begin
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  set Out_CurrentNonAllowance=0;
  set Out_CurrentAllowance=0;
  set Out_CurrentAdditional=0;
  set Out_CurrentCompensation=0;
  set Out_PreviousNonAllowance=0;
  set Out_PreviousAllowance=0;
  set Out_PreviousAdditional=0;
  set Out_PreviousCompensation=0;
  set Out_CurrentNonAllowanceEPF=0;
  set Out_CurrentAllowanceEPF=0;
  set Out_CurrentAdditionalEPF=0;
  set Out_PreviousNonAllowanceEPF=0;
  set Out_PreviousAllowanceEPF=0;
  set Out_PreviousAdditionalEPF=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  /*

  Period 1 will then consider Back Pay and OT Back Pay as Previous Year
  */
  if(In_PayRecPeriod > 1) then
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt+CalOTBackPay+CalBackPay)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Current Non Allowance EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt+CalBackPay)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if
  else
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Current Non Allowance EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if
  end if;
  /*
  Shift Amount
  */
  if(Out_CurrentNonAllowance <> 0) then
    select FConvertNull(Sum(ShiftAmount)) into Out_ShiftTotal from
      ShiftRecord where
      (IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEVolEPF') = 1) and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Current Non Allowance EPF
  */
  set Out_CurrentNonAllowanceEPF=Out_CurrentNonAllowanceEPF+Out_OTTotal+Out_ShiftTotal;
  /*
  Non Taxabale Pay Element:
  ZakatCode
  EPFDedCode
  SOCSODedCode
  WP39Code
  CP38Code
  All Reimbursement
  */
  /*
  Current Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Allowance Subject to EPF          
  */
  if(Out_CurrentAllowance <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowanceEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Current Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Additional EPF
  */
  if(Out_CurrentAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Current Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Period 1 Back Pay and Back Pay OT is considered as Previous Allowance
  */
  if(In_PayRecPeriod = 1) then
    /*
    Previous Non Allowance
    */
    select FConvertNull(Sum(CalOTBackPay+CalBackPay)) into Out_PreviousNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Previous Non Allowance EPF
    */
    if(Out_PreviousNonAllowance <> 0) then
      select FConvertNull(Sum(CalBackPay)) into Out_PreviousNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      OT Amount
      */
      select FConvertNull(Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      set Out_PreviousNonAllowanceEPF=Out_PreviousNonAllowanceEPF+Out_OTTotal
    end if
  end if;
  /*
  Previous Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Allowance EPF
  */
  if(Out_PreviousAllowance <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowanceEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Previous Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Additional EPF
  */
  if(Out_PreviousAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Previous Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod
end
;

create procedure DBA.ASQLCalMalPayRecTaxWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_CurrentNonAllowance double,
out Out_CurrentAllowance double,
out Out_CurrentAdditional double,
out Out_CurrentCompensation double,
out Out_PreviousNonAllowance double,
out Out_PreviousAllowance double,
out Out_PreviousAdditional double,
out Out_PreviousCompensation double,
out Out_CurrentNonAllowanceEPF double,
out Out_CurrentAllowanceEPF double,
out Out_CurrentAdditionalEPF double,
out Out_PreviousNonAllowanceEPF double,
out Out_PreviousAllowanceEPF double,
out Out_PreviousAdditionalEPF double)
begin
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  set Out_CurrentNonAllowance=0;
  set Out_CurrentAllowance=0;
  set Out_CurrentAdditional=0;
  set Out_CurrentCompensation=0;
  set Out_PreviousNonAllowance=0;
  set Out_PreviousAllowance=0;
  set Out_PreviousAdditional=0;
  set Out_PreviousCompensation=0;
  set Out_CurrentNonAllowanceEPF=0;
  set Out_CurrentAllowanceEPF=0;
  set Out_CurrentAdditionalEPF=0;
  set Out_PreviousNonAllowanceEPF=0;
  set Out_PreviousAllowanceEPF=0;
  set Out_PreviousAdditionalEPF=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  /*

  Period 1 will then consider Back Pay and OT Back Pay as Previous Year
  */
  if(In_PayRecPeriod > 1) then
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt+CalOTBackPay+CalBackPay)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId;
    /*
    Current Non Allowance EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt+CalBackPay)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId
    end if
  else
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId;
    /*
    Current Non Allowance EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId
    end if
  end if;
  /*
  Shift Amount
  */
  if(Out_CurrentNonAllowance <> 0) then
    select FConvertNull(Sum(ShiftAmount)) into Out_ShiftTotal from
      ShiftRecord where
      (IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEVolEPF') = 1) and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Current Non Allowance EPF
  */
  set Out_CurrentNonAllowanceEPF=Out_CurrentNonAllowanceEPF+Out_OTTotal+Out_ShiftTotal;
  /*
  Non Taxabale Pay Element:
  ZakatCode
  EPFDedCode
  SOCSODedCode
  WP39Code
  CP38Code
  All Reimbursement
  */
  /*
  Current Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Allowance Subject to EPF          
  */
  if(Out_CurrentAllowance <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowanceEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Current Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Additional EPF
  */
  if(Out_CurrentAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Current Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Period 1 Back Pay and Back Pay OT is considered as Previous Allowance
  */
  if(In_PayRecPeriod = 1) then
    /*
    Previous Non Allowance
    */
    select FConvertNull(Sum(CalOTBackPay+CalBackPay)) into Out_PreviousNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId;
    /*
    Previous Non Allowance EPF
    */
    if(Out_PreviousNonAllowance <> 0) then
      select FConvertNull(Sum(CalBackPay)) into Out_PreviousNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      /*
      OT Amount
      */
      select FConvertNull(Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      set Out_PreviousNonAllowanceEPF=Out_PreviousNonAllowanceEPF+Out_OTTotal
    end if
  end if;
  /*
  Previous Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Allowance EPF
  */
  if(Out_PreviousAllowance <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowanceEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Previous Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Additional EPF
  */
  if(Out_PreviousAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Previous Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId
end
;

create procedure DBA.ASQLGetMalFamilyInfo(
in In_PersonalSysId integer,
out Out_ChildReliefPoint double,
out Out_NoOfReliefChild integer,
out Out_NoOfChildBelow18 integer)
begin
  declare InsidePoint integer;
  declare OutsidePoint integer;
  declare DisablePoint integer;
  declare EducationLevel char(20);
  set Out_ChildReliefPoint=0;
  set Out_NoOfReliefChild=0;
  set Out_NoOfChildBelow18=0;
  FamilyLoop: for FamilyFor as curs dynamic scroll cursor for
    select Family.OccupationId,Family.DOB,FamilyEduRec.EducationId as F_EducationId,Family.RelationshipId,Family.IsHandicapped,FamilyEduRec.EduLocal from Family left outer join FamilyEduRec on(Family.FamilySysId = FamilyEduRec.FamilySysId) where Family.PersonalSysId = In_PersonalSysId do
    select MalChildInside,MalChildOutside,MalChildDisabled into InsidePoint,OutsidePoint,DisablePoint from MalTaxPolicyProg where
      MalTaxPolicyId = 
      any(select MalTaxPolicyId from MalTaxDetails where MalTaxDetails.PersonalSysId = In_PersonalSysId) and
      MalTaxPolicyEffDate = (select max(MalTaxPolicyEffDate) from MalTaxPolicyProg where MalTaxPolicyId = 
        any(select MalTaxPolicyId from MalTaxDetails where MalTaxDetails.PersonalSysId = In_PersonalSysId) and MalTaxPolicyEffDate <= Today(*));
    select EduLevel.EduLevelId into EducationLevel from EduLevel join Education where Education.EducationId = F_EducationId;
    if RelationshipId in('Son','Step Son','Daughter','Step Daughter') then
      if IsHandicapped = 1 then
        if(Years(DOB,Today(*)) <= 18) then
          set Out_NoOfChildBelow18=Out_NoOfChildBelow18+1
        end if;
        set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
        set Out_ChildReliefPoint=Out_ChildReliefPoint+DisablePoint
      else if((Years(Today(*))-Years(DOB)) > 18) then
          if(OccupationId = 'Full-time Student' and
            (EducationLevel = 'Degree' or EducationLevel = 'Diploma' or EducationLevel = 'Masters' or
            EducationLevel = 'N Level' or EducationLevel = 'PhD' or EducationLevel = 'Tertiary')) then
            if EduLocal = 1 then
              set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
              set Out_ChildReliefPoint=Out_ChildReliefPoint+InsidePoint
            else
              set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
              set Out_ChildReliefPoint=Out_ChildReliefPoint+OutsidePoint
            end if
          end if
        else if(Years(DOB,Today(*)) <= 18) then
            if(OccupationId = 'Full-time Student' or OccupationId = '' or OccupationId is null) then
              set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
              set Out_ChildReliefPoint=Out_ChildReliefPoint+1
            end if;
            set Out_NoOfChildBelow18=Out_NoOfChildBelow18+1
          end if
        end if
      end if
    end if end for
end
;

create procedure dba.DeleteMalSTDPolicy(
in In_MalSTDPolicyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
    delete from MalSTDPolicyTable where MalSTDPolicyId = In_MalSTDPolicyId;
    delete from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId;
    commit work;
    if exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMalSTDPolicyTable(
in In_MalSTDPolicySysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalSTDPolicyTable where MalSTDPolicySysId = In_MalSTDPolicySysId) then
    delete from MalSTDPolicyTable where MalSTDPolicySysId = In_MalSTDPolicySysId;
    commit work;
    if exists(select* from MalSTDPolicyTable where MalSTDPolicySysId = In_MalSTDPolicySysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMalTaxBranch(
in In_MalTaxBranchId char(20))
begin
  if exists(select* from MalTaxBranch where
      MalTaxBranchId = In_MalTaxBranchId) then
    delete from MalTaxBranch where
      MalTaxBranchId = In_MalTaxBranchId;
    commit work
  end if
end
;

create procedure dba.DeleteMalTaxDetails(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  delete from MalTaxEmployee where PersonalSysId = In_PersonalSysId;
  delete from MalTaxRecord where PersonalSysId = In_PersonalSysId;
  delete from MalTaxDetails where PersonalSysId = In_PersonalSysId;
  set Out_ErrorCode=1
end
;

create procedure dba.DeleteMalTaxEmployee(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxEESysId integer,
out Out_Code integer)
begin
  set Out_Code=0;
  if exists(select* from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear and
      MalTaxEESysId = In_MalTaxEESysId) then
    delete from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear and
      MalTaxEESysId = In_MalTaxEESysId;
    commit work;
    set Out_Code=1
  end if
end
;

create procedure dba.DeleteMalTaxEmployer(
in In_MalTaxEmployerId char(20),
out ErrorCode integer)
begin
  delete from MalTaxReceipt where MalTaxEmployerId = In_MalTaxEmployerId;
  DeleteTaxEmployee: for DeleteEmployerFor as curs dynamic scroll cursor for
    select PersonalSysId as P_PersonalSysId,MalTaxYear as P_MalTaxYear from MalTaxRecord where MalTaxEmployerId = In_MalTaxEmployerId do
    delete from MalTaxEmployee where MalTaxEmployee.PersonalSysId = P_PersonalSysId and MalTaxEmployee.MalTaxYear = P_MalTaxYear end for;
  delete from MalTaxRecord where MalTaxEmployerId = In_MalTaxEmployerId;
  delete from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId;
  set ErrorCode=1
end
;

create procedure dba.DeleteMalTaxPolicy(
in In_MalTaxPolicyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    /*
    if exists(select* from MalTaxPolicyAssignMalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    set Out_ErrorCode=-1;
    return
    end if;
    if exists(select* from MalTaxPolicyBAssgn where MalTaxPolicyId = In_MalTaxPolicyId) then
    set Out_ErrorCode=-1;
    return
    end if;*/
    delete from MalTaxPolicyProg where MalTaxPolicyId = In_MalTaxPolicyId;
    delete from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId;
    commit work;
    if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMalTaxPolicyProg(
in In_MalTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    delete from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function dba.FGetMalTaxFileNoE(
in In_MalTaxEmployerId char(20))
returns char(20)
begin
  declare Out_MalTaxFileNoE char(20);
  select MalTaxFileNoE into Out_MalTaxFileNoE from MalTaxEmployer where
    MalTaxEmployerId = In_MalTaxEmployerId;
  return(Out_MalTaxFileNoE)
end
;

create function DBA.FGetMalTaxNJEmoluments(
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns char(100)
begin
  declare Out_NJE char(100);
  select MalTaxRecord.MalTaxNJEmoluments into Out_NJE
    from MalTaxRecord where MalTaxYear = In_PayRecYear and
    MalTaxRecord.PersonalSysId = In_PersonalSysId;
  return(Out_NJE)
end
;

create function DBA.FGetMalTaxPrevERAddr(
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns char(100)
begin
  declare Out_Add char(100);
  select MalTaxRecord.MalTaxPrevERAddr into Out_Add
    from MalTaxRecord where MalTaxYear = In_PayRecYear and
    MalTaxRecord.PersonalSysId = In_PersonalSysId;
  return(Out_Add)
end
;

create function DBA.FGetMalTaxPrevERName(
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns char(100)
begin
  declare Out_Name char(100);
  select MalTaxRecord.MalTaxPrevERName into Out_Name
    from MalTaxRecord where MalTaxYear = In_PayRecYear and
    MalTaxRecord.PersonalSysId = In_PersonalSysId;
  return(Out_Name)
end
;

create function DBA.FGetMalTaxReceiptDate(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(20)
begin
  declare Out_ReceiptDate char(20);
  select MalTaxReceiptDate into Out_ReceiptDate
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_ReceiptDate)
end
;

create function DBA.FGetMalTaxReceiptNo(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(30)
begin
  declare Out_ReceiptNo char(30);
  select MalTaxReceiptNo into Out_ReceiptNo
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_ReceiptNo)
end
;

create function DBA.FGetPeriodPCBTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_IncCP38 integer)
returns double
begin
  declare Out_Tax double;
  if(In_IncCP38 = 1) then
    select Sum(PaidCurrentTaxAmt+TotalSINDA+TotalEUCF+PaidPreviousTaxAmt) into Out_Tax
      from PeriodPolicySummary where PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId
  else
    select Sum(PaidCurrentTaxAmt+TotalSINDA+PaidPreviousTaxAmt) into Out_Tax
      from PeriodPolicySummary where PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId
  end if;
  return(Out_Tax)
end
;

create function DBA.FGetPeriodTotalEeEPF(
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare Out_EeEPF double;
  select Sum(ActualOrdEECPF+VolOrdEECPF) into Out_EeEPF
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
  return(Out_EeEPF)
end
;

create function DBA.FGetPeriodTotalPCBTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_IncCP38 integer)
returns double
begin
  declare Out_Tax double;
  if(In_IncCP38 = 1) then
    select Sum(PaidCurrentTaxAmt+TotalSINDA+TotalEUCF+PaidPreviousTaxAmt) into Out_Tax
      from PeriodPolicySummary where PayRecYear = In_PayRecYear and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId
  else
    select Sum(PaidCurrentTaxAmt+TotalSINDA+PaidPreviousTaxAmt) into Out_Tax
      from PeriodPolicySummary where PayRecYear = In_PayRecYear and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId
  end if;
  return(Out_Tax)
end
;

create function DBA.FGetSpouseMalTaxRefNo(
in In_PersonalSysId integer)
returns char(20)
begin
  declare Out_TaxRefNo char(20);
  select MalTaxDetails.MalTaxSpouseTaxRefNo into Out_TaxRefNo
    from MalTaxDetails where MalTaxDetails.PersonalSysId = In_PersonalSysId;
  return(Out_TaxRefNo)
end
;

create procedure dba.InsertNewMalSTDPolicy(
in In_MalSTDPolicyId char(20),
in In_MalSTDPolicyDesc char(100),
in In_MalSTDFormula1Ratio double,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
    insert into MalSTDPolicy(MalSTDPolicyId,
      MalSTDPolicyDesc,MalSTDFormula1Ratio) values(In_MalSTDPolicyId,
      In_MalSTDPolicyDesc,In_MalSTDFormula1Ratio);
    commit work;
    if not exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewMalSTDPolicyTable(
in In_MalSTDPolicyId char(20),
in In_Mal_PFrom double,
in In_Mal_PTo double,
in In_Mal_M double,
in In_Mal_R double,
in In_Mal_BCat13 double,
in In_Mal_BCat2 double,
out Out_MalSTDPolicySysId integer,
out Out_ErrorCode integer)
begin
  select max(MalSTDPolicySysId) into Out_MalSTDPolicySysId from MalSTDPolicyTable;
  if(Out_MalSTDPolicySysId is null) then
    set Out_MalSTDPolicySysId=0
  end if;
  if not exists(select* from MalSTDPolicyTable where
      MalSTDPolicySysId = Out_MalSTDPolicySysId+1) then
    insert into MalSTDPolicyTable(MalSTDPolicySysId,
      MalSTDPolicyId,
      Mal_PFrom,
      Mal_PTo,
      Mal_M,
      Mal_R,
      Mal_BCat13,
      Mal_BCat2) values(Out_MalSTDPolicySysId+1,
      In_MalSTDPolicyId,
      In_Mal_PFrom,
      In_Mal_PTo,
      In_Mal_M,
      In_Mal_R,
      In_Mal_BCat13,
      In_Mal_BCat2);
    commit work;
    if not exists(select* from MalSTDPolicyTable where
        MalSTDPolicySysId = Out_MalSTDPolicySysId+1) then
      set Out_MalSTDPolicySysId=null;
      set Out_ErrorCode=0
    else
      set Out_MalSTDPolicySysId=Out_MalSTDPolicySysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_MalSTDPolicySysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMalTaxBranch(
in In_MalTaxBranchId char(20),
in In_MalTaxLocation char(20),
in In_MalTaxBranchDesc char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_PostalCode char(6),
in In_State char(20),
in In_City char(20),
in In_TelephoneNo char(20),
in In_FaxNo char(20))
begin
  if not exists(select* from MalTaxBranch where MalTaxBranchId = In_MalTaxBranchId) then
    insert into MalTaxBranch(MalTaxBranchId,
      MalTaxLocation,
      MalTaxBranchDesc,
      Address1,
      Address2,
      Address3,
      PostalCode,
      State,
      City,
      TelephoneNo,
      FaxNo) values(
      In_MalTaxBranchId,
      In_MalTaxLocation,
      In_MalTaxBranchDesc,
      In_Address1,
      In_Address2,
      In_Address3,
      In_PostalCode,
      In_State,
      In_City,
      In_TelephoneNo,
      In_FaxNo);
    commit work
  end if
end
;

create procedure dba.InsertNewMalTaxDetails(
in In_PersonalSysId integer,
in In_MalTaxPolicyId char(20),
in In_MalTaxEmployerId char(20),
in In_MalTaxEETaxRefNo char(20),
in In_MalTaxMethod char(20),
in In_MalTaxChildRelief double,
in In_MalTaxNoChildRelief integer,
in In_MalTaxNoChildBelow18 integer,
in In_MalTaxSpouseTaxRefNo char(100),
in In_MalTaxSpouseWorking smallint,
in In_MalTaxSpouseTaxBranchId char(20),
in In_MalTaxPriority smallint,
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from MalTaxDetails where PersonalSysId = In_PersonalSysId) then
    insert into MalTaxDetails(PersonalSysId,
      MalTaxPolicyId,
      MalTaxEmployerId,
      MalTaxEETaxRefNo,
      MalTaxMethod,
      MalTaxChildRelief,
      MalTaxNoChildRelief,
      MalTaxNoChildBelow18,
      MalTaxSpouseTaxRefNo,
      MalTaxSpouseWorking,
      MalTaxSpouseTaxBranchId,
      MalTaxPriority) values(
      In_PersonalSysId,
      In_MalTaxPolicyId,
      In_MalTaxEmployerId,
      In_MalTaxEETaxRefNo,
      In_MalTaxMethod,
      In_MalTaxChildRelief,
      In_MalTaxNoChildRelief,
      In_MalTaxNoChildBelow18,
      In_MalTaxSpouseTaxRefNo,
      In_MalTaxSpouseWorking,
      In_MalTaxSpouseTaxBranchId,
      In_MalTaxPriority);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.InsertNewMalTaxEmployee(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxEESysId integer,
in In_FromPayRecYear integer,
in In_FromPayRecPeriod integer,
in In_FromPayRecSubPeriod integer,
in In_ToPayRecYear integer,
in In_ToPayRecPeriod integer,
in In_ToPayRecSubPeriod integer,
in In_PayRecID char(20),
in In_TaxLastProcessed integer,
out Out_Code integer)
begin
  if In_PersonalSysId is null then set Out_Code=-1;
    return
  end if;
  if In_MalTaxYear is null then set Out_Code=-2;
    return
  end if;
  if In_MalTaxEeSysId is null then set Out_Code=-3;
    return
  end if;
  if In_FromPayRecYear is null then set Out_Code=-4;
    return
  end if;
  if In_FromPayRecPeriod is null then set Out_Code=-5;
    return
  end if;
  if In_FromPayRecSubPeriod is null then set Out_Code=-6;
    return
  end if;
  if In_ToPayRecYear is null then set Out_Code=-7;
    return
  end if;
  if In_ToPayRecPeriod is null then set Out_Code=-8;
    return
  end if;
  if In_ToPayRecSubPeriod is null then set Out_Code=-9;
    return
  end if;
  if In_PayRecID is null then set Out_Code=-10;
    return
  end if;
  set Out_Code=1;
  insert into MalTaxEmployee(PersonalSysId,
    MalTaxYear,
    MalTaxEESysId,
    FromPayRecYear,
    FromPayRecPeriod,
    FromPayRecSubPeriod,
    ToPayRecYear,
    ToPayRecPeriod,
    ToPayRecSubPeriod,
    PayRecID,
    TaxLastProcessed) values(
    In_PersonalSysId,
    In_MalTaxYear,
    In_MalTaxEESysId,
    In_FromPayRecYear,
    In_FromPayRecPeriod,
    In_FromPayRecSubPeriod,
    In_ToPayRecYear,
    In_ToPayRecPeriod,
    In_ToPayRecSubPeriod,
    In_PayRecID,
    In_TaxLastProcessed);
  commit work
end
;

create procedure dba.InsertNewMalTaxEmployer(
in In_MalTaxEmployerId char(20),
in In_MalTaxBranchId char(20),
in In_MalTaxEmployerDesc char(100),
in In_MalTaxAuthoriseName char(100),
in In_MalTaxAuthoriseId char(30),
in In_Designation char(20),
in In_MalTaxFileNoE char(20),
in In_MalTaxERTaxRefNo char(20),
in In_MalTaxBranchENo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_FaxNo char(20),
in In_TypeOfBusiness char(20),
in In_FinancialEndYear integer,
out Out_Code integer)
begin
  if In_MalTaxEmployerId is null then set Out_Code=-1;
    return
  end if;
  if not exists(select* from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId) then
    insert into MalTaxEmployer(MalTaxEmployerId,
      MalTaxBranchId,
      MalTaxEmployerDesc,
      MalTaxAuthoriseName,
      MalTaxAuthoriseId,
      Designation,
      MalTaxFileNoE,
      MalTaxERTaxRefNo,
      MalTaxBranchENo,
      Address1,
      Address2,
      Address3,
      State,
      City,
      PostalCode,
      TelephoneNo,
      FaxNo,
      TypeOfBusiness,
      FinancialEndYear) values(
      In_MalTaxEmployerId,
      In_MalTaxBranchId,
      In_MalTaxEmployerDesc,
      In_MalTaxAuthoriseName,
      In_MalTaxAuthoriseId,
      In_Designation,
      In_MalTaxFileNoE,
      In_MalTaxERTaxRefNo,
      In_MalTaxBranchENo,
      In_Address1,
      In_Address2,
      In_Address3,
      In_State,
      In_City,
      In_PostalCode,
      In_TelephoneNo,
      In_FaxNo,
      In_TypeOfBusiness,
      In_FinancialEndYear);
    commit work;
    set Out_Code=1
  else
    set Out_Code=-2;
    return
  end if
end
;

create procedure dba.InsertNewMalTaxPolicy(
in In_MalTaxPolicyId char(20),
in In_MalTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    insert into MalTaxPolicy(MalTaxPolicyId,
      MalTaxPolicyDesc) values(In_MalTaxPolicyId,
      In_MalTaxPolicyDesc);
    commit work;
    if not exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewMalTaxPolicyProg(
in In_MalTaxPolicyId char(20),
in In_MalSTDPolicyId char(20),
in In_MalTaxPolicyEffDate date,
in In_MalChildOutside integer,
in In_MalChildInside integer,
in In_MalChildDisabled integer,
in In_MalCat1Relief double,
in In_MalCat2ChildRelief double,
in In_MalCat2Relief double,
in In_MalCat3ChildRelief double,
in In_MalCat3Relief double,
in In_EPFCappingOption smallint,
in In_EPFCappingYearly double,
in In_EPFCappingMonthly double,
in In_MalTaxCompenPerYr double,
in In_MalTaxMinTaxAmt double,
out Out_MalTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  select max(MalTaxPolicyProgSysId) into Out_MalTaxPolicyProgSysId from MalTaxPolicyProg;
  if(Out_MalTaxPolicyProgSysId is null) then
    set Out_MalTaxPolicyProgSysId=0
  end if;
  if not exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
    insert into MalTaxPolicyProg(MalTaxPolicyProgSysId,
      MalTaxPolicyId,
      MalSTDPolicyId,
      MalTaxPolicyEffDate,
      MalChildOutside,
      MalChildInside,
      MalChildDisabled,
      MalCat1Relief,
      MalCat2ChildRelief,
      MalCat2Relief,
      MalCat3ChildRelief,
      MalCat3Relief,
      EPFCappingOption,
      EPFCappingYearly,
      EPFCappingMonthly,
      MalTaxCompenPerYr,MalTaxMinTaxAmt) values(Out_MalTaxPolicyProgSysId+1,
      In_MalTaxPolicyId,
      In_MalSTDPolicyId,
      In_MalTaxPolicyEffDate,
      In_MalChildOutside,
      In_MalChildInside,
      In_MalChildDisabled,
      In_MalCat1Relief,
      In_MalCat2ChildRelief,
      In_MalCat2Relief,
      In_MalCat3ChildRelief,
      In_MalCat3Relief,
      In_EPFCappingOption,
      In_EPFCappingYearly,
      In_EPFCappingMonthly,
      In_MalTaxCompenPerYr,
      In_MalTaxMinTaxAmt);
    commit work;
    if not exists(select* from MalTaxPolicyProg where
        MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
      set Out_MalTaxPolicyProgSysId=null;
      set Out_ErrorCode=0
    else
      set Out_MalTaxPolicyProgSysId=Out_MalTaxPolicyProgSysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_MalTaxPolicyProgSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMalSTDPolicy(
in In_MalSTDPolicyId char(20),
in In_MalSTDPolicyDesc char(100),
in In_MalSTDFormula1Ratio double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
    update MalSTDPolicy set
      MalSTDPolicyDesc = In_MalSTDPolicyDesc,
      MalSTDFormula1Ratio = In_MalSTDFormula1Ratio where
      MalSTDPolicyId = In_MalSTDPolicyId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMalSTDPolicyTable(
in In_MalSTDPolicySysId integer,
in In_MalSTDPolicyId char(20),
in In_Mal_PFrom double,
in In_Mal_PTo double,
in In_Mal_M double,
in In_Mal_R double,
in In_Mal_BCat13 double,
in In_Mal_BCat2 double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalSTDPolicyTable where
      MalSTDPolicySysId = In_MalSTDPolicySysId) then
    update MalSTDPolicyTable set
      MalSTDPolicyId = In_MalSTDPolicyId,
      Mal_PFrom = In_Mal_PFrom,
      Mal_PTo = In_Mal_PTo,
      Mal_M = In_Mal_M,
      Mal_R = In_Mal_R,
      Mal_BCat13 = In_Mal_BCat13,
      Mal_BCat2 = In_Mal_BCat2 where
      MalSTDPolicySysId = In_MalSTDPolicySysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMalTaxBranch(
in In_MalTaxBranchId char(20),
in In_MalTaxLocation char(20),
in In_MalTaxBranchDesc char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_PostalCode char(6),
in In_State char(20),
in In_City char(20),
in In_TelephoneNo char(20),
in In_FaxNo char(20))
begin
  if exists(select* from MalTaxBranch where
      MalTaxBranchId = In_MalTaxBranchId) then
    update MalTaxBranch set
      MalTaxLocation = In_MalTaxLocation,
      MalTaxBranchDesc = In_MalTaxBranchDesc,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      PostalCode = In_PostalCode,
      State = In_State,
      City = In_City,
      TelephoneNo = In_TelephoneNo,
      FaxNo = In_FaxNo where
      MalTaxBranchId = In_MalTaxBranchId;
    commit work
  end if
end
;

create procedure DBA.UpdateMalTaxDetails(
in In_PersonalSysId integer,
in In_MalTaxPolicyId char(20),
in In_MalTaxEmployerId char(20),
in In_MalTaxEETaxRefNo char(20),
in In_MalTaxMethod char(20),
in In_MalTaxChildRelief double,
in In_MalTaxNoChildRelief integer,
in In_MalTaxNoChildBelow18 integer,
in In_MalTaxSpouseTaxRefNo char(100),
in In_MalTaxSpouseWorking smallint,
in In_MalTaxSpouseTaxBranchId char(20),
in In_MalTaxPriority smallint,
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from MalTaxDetails where PersonalSysId = In_PersonalSysId) then
    update MalTaxDetails set
      MalTaxPolicyId = In_MalTaxPolicyId,
      MalTaxEmployerId = In_MalTaxEmployerId,
      MalTaxEETaxRefNo = In_MalTaxEETaxRefNo,
      MalTaxMethod = In_MalTaxMethod,
      MalTaxChildRelief = In_MalTaxChildRelief,
      MalTaxNoChildRelief = In_MalTaxNoChildRelief,
      MalTaxNoChildBelow18 = In_MalTaxNoChildBelow18,
      MalTaxSpouseTaxRefNo = In_MalTaxSpouseTaxRefNo,
      MalTaxSpouseWorking = In_MalTaxSpouseWorking,
      MalTaxSpouseTaxBranchId = In_MalTaxSpouseTaxBranchId,
      MalTaxPriority = In_MalTaxPriority where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateMalTaxEmployee(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxEESysId integer,
in In_FromPayRecYear integer,
in In_FromPayRecPeriod integer,
in In_FromPayRecSubPeriod integer,
in In_ToPayRecYear integer,
in In_ToPayRecPeriod integer,
in In_ToPayRecSubPeriod integer,
in In_PayRecID char(20),
in In_TaxLastProcessed integer,
out Out_Code integer)
begin
  if In_PersonalSysId is null then set Out_Code=-1;
    return
  end if;
  if In_MalTaxYear is null then set Out_Code=-2;
    return
  end if;
  if In_MalTaxEeSysId is null then set Out_Code=-3;
    return
  end if;
  if In_FromPayRecYear is null then set Out_Code=-4;
    return
  end if;
  if In_FromPayRecPeriod is null then set Out_Code=-5;
    return
  end if;
  if In_FromPayRecSubPeriod is null then set Out_Code=-6;
    return
  end if;
  if In_ToPayRecYear is null then set Out_Code=-7;
    return
  end if;
  if In_ToPayRecPeriod is null then set Out_Code=-8;
    return
  end if;
  if In_ToPayRecSubPeriod is null then set Out_Code=-9;
    return
  end if;
  if In_PayRecID is null then set Out_Code=-10;
    return
  end if;
  set Out_Code=0;
  if exists(select* from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear and
      MalTaxEESysId = In_MalTaxEESysId) then
    if(In_TaxLastProcessed = 1) then
      update MalTaxEmployee set
        TaxLastProcessed = 0 where
        PersonalSysId = In_PersonalSysId and
        MalTaxYear = In_MalTaxYear
    end if;
    update MalTaxEmployee set
      FromPayRecYear = In_FromPayRecYear,
      FromPayRecPeriod = In_FromPayRecPeriod,
      FromPayRecSubPeriod = In_FromPayRecSubPeriod,
      ToPayRecYear = In_ToPayRecYear,
      ToPayRecPeriod = In_ToPayRecPeriod,
      ToPayRecSubPeriod = In_ToPayRecSubPeriod,
      PayRecID = In_PayRecID,
      TaxLastProcessed = In_TaxLastProcessed where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear and
      MalTaxEESysId = In_MalTaxEESysId;
    commit work;
    set Out_Code=1
  end if
end
;

create procedure dba.UpdateMalTaxEmployer(
in In_MalTaxEmployerId char(20),
in In_MalTaxBranchId char(20),
in In_MalTaxEmployerDesc char(100),
in In_MalTaxAuthoriseName char(100),
in In_MalTaxAuthoriseId char(30),
in In_Designation char(20),
in In_MalTaxFileNoE char(20),
in In_MalTaxERTaxRefNo char(20),
in In_MalTaxBranchENo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_FaxNo char(20),
in In_TypeOfBusiness char(20),
in In_FinancialEndYear integer,
out Out_Code integer)
begin
  if In_MalTaxEmployerId is null then set Out_Code=-1;
    return
  end if;
  if exists(select* from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId) then
    update MalTaxEmployer set
      MalTaxBranchId = In_MalTaxBranchId,
      MalTaxEmployerDesc = In_MalTaxEmployerDesc,
      MalTaxAuthoriseName = In_MalTaxAuthoriseName,
      MalTaxAuthoriseId = In_MalTaxAuthoriseId,
      Designation = In_Designation,
      MalTaxFileNoE = In_MalTaxFileNoE,
      MalTaxERTaxRefNo = In_MalTaxERTaxRefNo,
      MalTaxBranchENo = In_MalTaxBranchENo,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      State = In_State,
      City = In_City,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      FaxNo = In_FaxNo,
      TypeOfBusiness = In_TypeOfBusiness,
      FinancialEndYear = In_FinancialEndYear where MalTaxEmployerId = In_MalTaxEmployerId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-2;
    return
  end if
end
;

create procedure dba.UpdateMalTaxPolicy(
in In_MalTaxPolicyId char(20),
in In_MalTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    update MalTaxPolicy set
      MalTaxPolicyDesc = In_MalTaxPolicyDesc where
      MalTaxPolicyId = In_MalTaxPolicyId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMalTaxPolicyProg(
in In_MalTaxPolicyProgSysId integer,
in In_MalTaxPolicyId char(20),
in In_MalSTDPolicyId char(20),
in In_MalTaxPolicyEffDate date,
in In_MalChildOutside integer,
in In_MalChildInside integer,
in In_MalChildDisabled integer,
in In_MalCat1Relief double,
in In_MalCat2ChildRelief double,
in In_MalCat2Relief double,
in In_MalCat3ChildRelief double,
in In_MalCat3Relief double,
in In_EPFCappingOption smallint,
in In_EPFCappingYearly double,
in In_EPFCappingMonthly double,
in In_MalTaxCompenPerYr double,
in In_MalTaxMinTaxAmt double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    update MalTaxPolicyProg set
      MalTaxPolicyId = In_MalTaxPolicyId,
      MalSTDPolicyId = In_MalSTDPolicyId,
      MalTaxPolicyEffDate = In_MalTaxPolicyEffDate,
      MalChildOutside = In_MalChildOutside,
      MalChildInside = In_MalChildInside,
      MalChildDisabled = In_MalChildDisabled,
      MalCat1Relief = In_MalCat1Relief,
      MalCat2ChildRelief = In_MalCat2ChildRelief,
      MalCat2Relief = In_MalCat2Relief,
      MalCat3ChildRelief = In_MalCat3ChildRelief,
      MalCat3Relief = In_MalCat3Relief,
      EPFCappingOption = In_EPFCappingOption,
      EPFCappingYearly = In_EPFCappingYearly,
      EPFCappingMonthly = In_EPFCappingMonthly,
      MalTaxCompenPerYr = In_MalTaxCompenPerYr,
      MalTaxMinTaxAmt = In_MalTaxMinTaxAmt where
      MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMalTaxRecord(
in In_PersonalSysId integer,
in In_EmployeeSysId integer,
in In_MalTaxYear integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and
      FGetMalTaxRecordEmployeeSysId(PersonalSysId,In_MalTaxYear) = In_EmployeeSysId and
      MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear;
    delete from MalTaxRecord where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  end if;
  if exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and
      FGetMalTaxRecordEmployeeSysId(PersonalSysId,In_MalTaxYear) = In_EmployeeSysId and
      MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if;
  commit work
end
;

create function dba.FGetEAFormDifference(
in In_PersonalSysId integer,
in In_Year integer,
in In_Month integer)
returns double
begin
  declare total double;
  // obtain the total of EA Form's editable values
  // the value will be used in CP159 form, appended into December's gross wage.
  if(In_Month <> 12) then
    return 0
  end if;
  select(MalTaxMotorCarFuel+MalTaxDriver+
    MalTaxUtility+MalTaxFurniture+MalTaxFullKitchenEquip+
    MalTaxFittings+MalTaxKitchenEquip+MalTaxHandphone+
    MalTaxServant+MalTaxHolidays+MalTaxOtherFoodCloth+
    MalTaxAccomdation+MalTaxRefundPension+MalTaxAnnuity) into total
    from MalTaxRecord where
    PersonalSysId = In_PersonalSysId and MalTaxYear = In_Year;
  return total
end
;


create function DBA.FGetMalSpouseTaxRefNoChkMale(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_SpouseTaxNo char(30);
  if exists(select* from Personal where
      Personal.PersonalSysId = In_PersonalSysId and
      Gender = 0 and MaritalStatusCode = 'Married') then
    select MalTaxSpouseTaxRefNo into Out_SpouseTaxNo
      from personal join MalTaxDetails where Personal.PersonalSysId = In_PersonalSysId;
    return(Out_SpouseTaxNo)
  end if
end
;


create function dba.FGetMalTaxEmployerBranch(
in In_MalTaxEmployerId char(20))
returns char(20)
begin
  declare Out_MalTaxBranchId char(20);
  select MalTaxBranchId into Out_MalTaxBranchId from MalTaxEmployer where
    MalTaxEmployerId = In_MalTaxEmployerId;
  return Out_MalTaxBranchId
end
;

create function DBA.FGetMalTaxNJAllowance(
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns char(100)
begin
  declare Out_NJAll char(100);
  select MalTaxRecord.MalTaxNJAllowance into Out_NJAll
    from MalTaxRecord where MalTaxYear = In_PayRecYear and
    MalTaxRecord.PersonalSysId = In_PersonalSysId;
  return(Out_NJAll)
end
;

create function DBA.FGetMalTaxErFileNoEByEmp(
in In_PersonalSysId integer)
returns char(20)
begin
  declare Out_FileNoE char(20);
  select MalTaxFileNoE into Out_FileNoE
    from MalTaxDetails,MalTaxEmployer where
    MalTaxDetails.MalTaxEmployerId = MalTaxEmployer.MalTaxEmployerId and
    MalTaxDetails.PersonalSysId = In_PersonalSysId;
  return(Out_FileNoE)
end
;

create function DBA.FGetPeriodEEEPFWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalEEEPFWage double;
  select Sum(CurrEEManWage+PrevEEManWage) into In_CalEEEPFWage from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalEEEPFWage is null then set In_CalEEEPFWage=0
  end if;
  return In_CalEEEPFWage
end
;

create function DBA.FGetCP159PeriodToMonthYear(
in In_PayGroupId char(20),
in In_Period integer,
in In_Year integer)
returns integer
begin
  declare Out_PhyYear integer;
  set Out_PhyYear=In_Year;
  return(Out_PhyYear)
end
;

create function dba.FGetMalTaxRecordEmployeeSysId(
in In_PersonalSysId integer,
in In_MalTaxYear integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare TaxEmploymentCount integer;
  select Count(*) into TaxEmploymentCount from MalTaxEmployee where
    PersonalSysId = In_PersonalSysId and
    MalTaxYear = In_MalTaxYear;
  /*
  Only 1 Employment (No Rejoin)
  */
  if(TaxEmploymentCount = 1) then
    select MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  else
    /*
    Assume the latest especially for Histroical Records that are not fixed
    User should split the current year records
    */
    select first MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear order by ToPayRecYear desc,ToPayRecPeriod desc
  end if;
  return(Out_EmployeeSysId)
end
;

create function dba.FGetMalTaxRecordYear(
in In_MalTaxYear integer)
returns integer
begin
  declare Out_MalTaxYear integer;
  set Out_MalTaxYear=cast(right((cast(In_MalTaxYear as char(5))),4) as integer);
  return(Out_MalTaxYear)  
end
;

create function DBA.FGetMalTaxErFileNoE(
in In_EmployerID char(20))
returns char(20)
begin
  declare Out_FileNoE char(20);
  select MalTaxFileNoE into Out_FileNoE
    from MalTaxEmployer where MalTaxEmployerId = In_EmployerID;
  return(Out_FileNoE)
end
;

create function DBA.FGetPeriodTotalTaxWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare In_CalTotalTaxWage double;
  select Sum(CurrentTaxWage+CurrentAddTaxWage) into In_CalTotalTaxWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear;
  if In_CalTotalTaxWage is null then set In_CalTotalTaxWage=0
  end if;
  return In_CalTotalTaxWage
end
;

create function DBA.FGetBankBNMCode(
in In_PaymentBankCode char(20))
returns char(100)
begin
  declare Out_BankBNMCode char(10);
  select Bank.BankString1 into Out_BankBNMCode
    from Bank where Bank.BankId = In_PaymentBankCode;
  return(Out_BankBNMCode)
end
;

Create function
DBA.FGetPeriodTotalZakat(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Zakat double;
  select Sum(TotalCDAC) into Out_Zakat
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId and
    PeriodPolicySummary.PayRecPeriod = In_PayRecPeriod;
  return(Out_Zakat)
end
;
