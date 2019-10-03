if exists(select * from sys.sysprocedure where proc_name = 'InsertNewMalTaxRecord') then
   drop procedure InsertNewMalTaxRecord
end if;

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
in In_MalTaxPrevIncomeType2 char(50),
in In_MalTaxCorrespAddress1 char(100),
in In_MalTaxCorrespAddress2 char(100),
in In_MalTaxAgentAddress smallint,
in In_MalTaxStockOfferDate date,
in In_MalTaxStockExerciseDate date,
in In_MalTaxStockTotalBenefit double,
in In_MalTaxOtherAmtPaymentType char(100),
in In_MalTaxOtherAmtPaymentDate date,
in In_MalTaxOtherAmtPaymentAmt double,
in In_MalTaxShareSchemeType char(100),
in In_MalTaxShareNoOfShare integer,
in In_MalTaxShareOptionDate date,
in In_MalTaxShareRemainingAmt double,
in In_MalTaxOtherAwsPerquisitesCode double,
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
      MalTaxPrevTaxWage,
      MalTaxPrevIncomeType2,
      MalTaxCorrespAddress1,
      MalTaxCorrespAddress2,
      MalTaxAgentAddress,
      MalTaxStockOfferDate,
      MalTaxStockExerciseDate,
      MalTaxStockTotalBenefit,
      MalTaxOtherAmtPaymentType,
      MalTaxOtherAmtPaymentDate,
      MalTaxOtherAmtPaymentAmt,
      MalTaxShareSchemeType,
      MalTaxShareNoOfShare,
      MalTaxShareOptionDate,
      MalTaxShareRemainingAmt,
      MalTaxOtherAwsPerquisitesCode) values(
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
      In_MalTaxPrevTaxWage,
      In_MalTaxPrevIncomeType2,
      In_MalTaxCorrespAddress1,
      In_MalTaxCorrespAddress2,
      In_MalTaxAgentAddress,
      In_MalTaxStockOfferDate,
      In_MalTaxStockExerciseDate,
      In_MalTaxStockTotalBenefit,
      In_MalTaxOtherAmtPaymentType,
      In_MalTaxOtherAmtPaymentDate,
      In_MalTaxOtherAmtPaymentAmt,
      In_MalTaxShareSchemeType,
      In_MalTaxShareNoOfShare,
      In_MalTaxShareOptionDate,
      In_MalTaxShareRemainingAmt,
      In_MalTaxOtherAwsPerquisitesCode);
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

if exists(select * from sys.sysprocedure where proc_name = 'UpdateMalTaxRecord') then
   drop procedure UpdateMalTaxRecord
end if;

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
in In_MalTaxPrevIncomeType2 char(50),
in In_MalTaxCorrespAddress1 char(100),
in In_MalTaxCorrespAddress2 char(100),
in In_MalTaxAgentAddress smallint,
in In_MalTaxStockOfferDate date,
in In_MalTaxStockExerciseDate date,
in In_MalTaxStockTotalBenefit double,
in In_MalTaxOtherAmtPaymentType char(100),
in In_MalTaxOtherAmtPaymentDate date,
in In_MalTaxOtherAmtPaymentAmt double,
in In_MalTaxShareSchemeType char(100),
in In_MalTaxShareNoOfShare integer,
in In_MalTaxShareOptionDate date,
in In_MalTaxShareRemainingAmt double,
in In_MalTaxOtherAwsPerquisitesCode double,
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
      MalTaxPrevTaxWage = In_MalTaxPrevTaxWage,
      MalTaxPrevIncomeType2 = In_MalTaxPrevIncomeType2,
      MalTaxCorrespAddress1 = In_MalTaxCorrespAddress1,
      MalTaxCorrespAddress2 = In_MalTaxCorrespAddress2,
      MalTaxAgentAddress = In_MalTaxAgentAddress,
      MalTaxStockOfferDate = In_MalTaxStockOfferDate,
      MalTaxStockExerciseDate = In_MalTaxStockExerciseDate,
      MalTaxStockTotalBenefit = In_MalTaxStockTotalBenefit,
      MalTaxOtherAmtPaymentType = In_MalTaxOtherAmtPaymentType,
      MalTaxOtherAmtPaymentDate = In_MalTaxOtherAmtPaymentDate,
      MalTaxOtherAmtPaymentAmt = In_MalTaxOtherAmtPaymentAmt,
      MalTaxShareSchemeType = In_MalTaxShareSchemeType,
      MalTaxShareNoOfShare = In_MalTaxShareNoOfShare,
      MalTaxShareOptionDate = In_MalTaxShareOptionDate,
      MalTaxShareRemainingAmt = In_MalTaxShareRemainingAmt,
      MalTaxOtherAwsPerquisitesCode = In_MalTaxOtherAwsPerquisitesCode where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

/* Keyword Table */
if not exists(select * from keyword where KeyWordId = '0' and KeyWordCategory = 'SOCSOEmpStatus') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                       KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('0','','[Blank] - Existing','SOCSOEmpStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where KeyWordId = '1' and KeyWordCategory = 'SOCSOEmpStatus') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                       KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('1','B','B - New Join','SOCSOEmpStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where KeyWordId = '2' and KeyWordCategory = 'SOCSOEmpStatus') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                       KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('2','H','H - Cessation','SOCSOEmpStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where KeyWordId = '3' and KeyWordCategory = 'SOCSOEmpStatus') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                       KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('3','M','M - Decease','SOCSOEmpStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where KeyWordId = '4' and KeyWordCategory = 'SOCSOEmpStatus') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                       KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('4','S','S - On SOCSO Benefit Leave','SOCSOEmpStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where KeyWordId = '5' and KeyWordCategory = 'SOCSOEmpStatus') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                       KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('5','T','T - On 1 Month NPL','SOCSOEmpStatus',0,0,0,'',0,0,0,'');
end if;

/* SubRegistry table */
if not exists(select * from subregistry where registryid = 'PayPeriodPolicy'  and subregistryId = 'SOCSOEmpStatus') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,
                       RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('PayPeriodPolicy','SOCSOEmpStatus','Local','SOCSO','SOCSO Employment Status','MAWContriOption','','','SELECT KeywordId, KeywordUserDefinedName FROM Keyword WHERE KeywordCategory = ''SOCSOEmpStatus'' ORDER BY KeywordUserDefinedName','','','',0,3,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'RHB Bank Reflex System') then
   insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised)
   Values('Salary','RHB Bank Reflex System','RMalayBankFormatRHBReflexSystem.dll','InvokeSalaryFormatter',0);
end if;

commit work;