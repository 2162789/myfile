if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDatabaseSetup') then
   drop procedure ASQLDatabaseSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAdvReportUpdate') then
   drop procedure ASQLAdvReportUpdate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisBasis') then
   drop procedure ASQLAnalysisBasis
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisBasisAge_ServiceYear') then
   drop procedure ASQLAnalysisBasisAge_ServiceYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisBasisCareerProg') then
   drop procedure ASQLAnalysisBasisCareerProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisBasisTotalWage') then
   drop procedure ASQLAnalysisBasisTotalWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisDriveBasis1') then
   drop procedure ASQLAnalysisDriveBasis1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisDriveBasis2') then
   drop procedure ASQLAnalysisDriveBasis2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisDriveBasis3') then
   drop procedure ASQLAnalysisDriveBasis3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisDriveBasisCommon') then
   drop procedure ASQLAnalysisDriveBasisCommon
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisLookup') then
   drop procedure ASQLAnalysisLookup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisMovement') then
   drop procedure ASQLAnalysisMovement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAnalysisProcessBank') then
   drop procedure ASQLAnalysisProcessBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLApprUpdateBasicRate') then
   drop procedure ASQLApprUpdateBasicRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLApprUpdateCareer') then
   drop procedure ASQLApprUpdateCareer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLBRProgCurrentUpdate') then
   drop procedure ASQLBRProgCurrentUpdate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalCurrentPayPeriod') then
   drop procedure ASQLCalCurrentPayPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalendarDayUpdateLvePatternWeek') then
   drop procedure ASQLCalendarDayUpdateLvePatternWeek
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalendarDayUpdatePHolidayWeek') then
   drop procedure ASQLCalendarDayUpdatePHolidayWeek
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalendarDayUpdateWkPatternWeek') then
   drop procedure ASQLCalendarDayUpdateWkPatternWeek
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalNextPayPeriod') then
   drop procedure ASQLCalNextPayPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBalCPF') then
   drop procedure ASQLCalPayPeriodBalCPF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodCPF') then
   drop procedure ASQLCalPayPeriodCPF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodCPFWage') then
   drop procedure ASQLCalPayPeriodCPFWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodCurAddWage') then
   drop procedure ASQLCalPayPeriodCurAddWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodCurOrdWage') then
   drop procedure ASQLCalPayPeriodCurOrdWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodPrevAddWage') then
   drop procedure ASQLCalPayPeriodPrevAddWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodPrevOrdWage') then
   drop procedure ASQLCalPayPeriodPrevOrdWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodSDFWage') then
   drop procedure ASQLCalPayPeriodSDFWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecCurAddWage') then
   drop procedure ASQLCalPayRecCurAddWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecCurOrdWage') then
   drop procedure ASQLCalPayRecCurOrdWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecGrossWage') then
   drop procedure ASQLCalPayRecGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecNetWage') then
   drop procedure ASQLCalPayRecNetWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecPrevAddWage') then
   drop procedure ASQLCalPayRecPrevAddWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecPrevOrdWage') then
   drop procedure ASQLCalPayRecPrevOrdWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecTotalGrossWage') then
   drop procedure ASQLCalPayRecTotalGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecUserDefinedWage') then
   drop procedure ASQLCalPayRecUserDefinedWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCareerProgUpdateFields') then
   drop procedure ASQLCareerProgUpdateFields
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLChgKeyCareerProgression') then
   drop procedure ASQLChgKeyCareerProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCleanupBankSubmitCompanyBank') then
   drop procedure ASQLCleanupBankSubmitCompanyBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLClearBankRecord') then
   drop procedure ASQLClearBankRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLClearBonusReport') then
   drop procedure ASQLClearBonusReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCloneCPFFormulaRecord') then
   drop procedure ASQLCloneCPFFormulaRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCloneCPFTable') then
   drop procedure ASQLCloneCPFTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLConvertPayAllocation') then
   drop procedure ASQLConvertPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCopyRecruitPosition') then
   drop procedure ASQLCopyRecruitPosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCostCurrentCostPeriod') then
   drop procedure ASQLCostCurrentCostPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCostNextCostPeriod') then
   drop procedure ASQLCostNextCostPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCostRecordCopy') then
   drop procedure ASQLCostRecordCopy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateCostPeriodCostCentre') then
   drop procedure ASQLCreateCostPeriodCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateLeaveDeductionRecord') then
   drop procedure ASQLCreateLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateLeaveInfoRecord') then
   drop procedure ASQLCreateLeaveInfoRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateOTRecord') then
   drop procedure ASQLCreateOTRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreatePayPeriodRecord') then
   drop procedure ASQLCreatePayPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreatePayRecord') then
   drop procedure ASQLCreatePayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreatePeriodPolicySummary') then
   drop procedure ASQLCreatePeriodPolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateShiftRecord') then
   drop procedure ASQLCreateShiftRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateSubPeriodRecord') then
   drop procedure ASQLCreateSubPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateSubPeriodSetting') then
   drop procedure ASQLCreateSubPeriodSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCurrentLeaveDeductionRecord') then
   drop procedure ASQLCurrentLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCurrentLeaveInfoRecord') then
   drop procedure ASQLCurrentLeaveInfoRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCurrentPayPeriodRecord') then
   drop procedure ASQLCurrentPayPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCurrentPayRecord') then
   drop procedure ASQLCurrentPayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCurrentSubPeriodRecord') then
   drop procedure ASQLCurrentSubPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCurrentSubPeriodSetting') then
   drop procedure ASQLCurrentSubPeriodSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteAllPersonal') then
   drop procedure ASQLDeleteAllPersonal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteAndNewCPFPayment') then
   drop procedure ASQLDeleteAndNewCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteAndNewPayAllocation') then
   drop procedure ASQLDeleteAndNewPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteCostItemComponent') then
   drop procedure ASQLDeleteCostItemComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteCostSubPeriod') then
   drop procedure ASQLDeleteCostSubPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteEmployeePayRecords') then
   drop procedure ASQLDeleteEmployeePayRecords
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteEmployeeProgression') then
   drop procedure ASQLDeleteEmployeeProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteEmployment') then
   drop procedure ASQLDeleteEmployment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteEngRPayElement') then
   drop procedure ASQLDeleteEngRPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteInsurance') then
   drop procedure ASQLDeleteInsurance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteLeaveEmployee') then
   drop procedure ASQLDeleteLeaveEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteLoan') then
   drop procedure ASQLDeleteLoan
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteMClaimPolicyFolder') then
   drop procedure ASQLDeleteMClaimPolicyFolder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayEmployee') then
   drop procedure ASQLDeletePayEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayRecords') then
   drop procedure ASQLDeletePayRecords
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePeriodRecords') then
   drop procedure ASQLDeletePeriodRecords
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteRecurring') then
   drop procedure ASQLDeleteRecurring
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteSubPeriodRecords') then
   drop procedure ASQLDeleteSubPeriodRecords
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDropIndex') then
   drop procedure ASQLDropIndex
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnDateDefault') then
   drop procedure ASQLFormDsnDateDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnDeleteApprStruc') then
   drop procedure ASQLFormDsnDeleteApprStruc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnIntegerDefault') then
   drop procedure ASQLFormDsnIntegerDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnNumericDefault') then
   drop procedure ASQLFormDsnNumericDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnSecTotalFullWt') then
   drop procedure ASQLFormDsnSecTotalFullWt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnStringDefault') then
   drop procedure ASQLFormDsnStringDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLFormDsnUpdateApprStruc') then
   drop procedure ASQLFormDsnUpdateApprStruc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGenNewCalendarYear') then
   drop procedure ASQLGenNewCalendarYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGenNewShiftCalendarYear') then
   drop procedure ASQLGenNewShiftCalendarYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGenWTDay') then
   drop procedure ASQLGenWTDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGenWTDayUsingPattern') then
   drop procedure ASQLGenWTDayUsingPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetEmpCurrentCostRecord') then
   drop procedure ASQLGetEmpCurrentCostRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetEmpCurrentPayRecord') then
   drop procedure ASQLGetEmpCurrentPayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetEmpTargetCostRecord') then
   drop procedure ASQLGetEmpTargetCostRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetNextPayPeriod') then
   drop procedure ASQLGetNextPayPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetPeriodLastLveDedDayHourRate') then
   drop procedure ASQLGetPeriodLastLveDedDayHourRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetPeriodLastOTDayHourRate') then
   drop procedure ASQLGetPeriodLastOTDayHourRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGrpLvePatternUpdateCalenDay') then
   drop procedure ASQLGrpLvePatternUpdateCalenDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGrpWkPatternUpdateCalenDay') then
   drop procedure ASQLGrpWkPatternUpdateCalenDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLInsertUserModuleNoAccess') then
   drop procedure ASQLInsertUserModuleNoAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLInterfaceCareerProgression') then
   drop procedure ASQLInterfaceCareerProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLInterfaceCodeMapping') then
   drop procedure ASQLInterfaceCodeMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLItemBatchAssign') then
   drop procedure ASQLItemBatchAssign
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLockAllPayGroupPeriod') then
   drop procedure ASQLLockAllPayGroupPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveClearCrossYear') then
   drop procedure ASQLLveClearCrossYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveCycleRptBF') then
   drop procedure ASQLLveCycleRptBF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveCycleRptNoProgress') then
   drop procedure ASQLLveCycleRptNoProgress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveCycleRptProrate') then
   drop procedure ASQLLveCycleRptProrate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveCycleRptUpdate') then
   drop procedure ASQLLveCycleRptUpdate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveDeleteAllSumRpt') then
   drop procedure ASQLLveDeleteAllSumRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveDeleteReprocessSumRpt') then
   drop procedure ASQLLveDeleteReprocessSumRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLLveDeleteSumRpt') then
   drop procedure ASQLLveDeleteSumRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMapCostCentreIdDesc') then
   drop procedure ASQLMapCostCentreIdDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMarkEContact') then
   drop procedure ASQLMarkEContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMarkHighestEdu') then
   drop procedure ASQLMarkHighestEdu
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMarkLatestResStatus') then
   drop procedure ASQLMarkLatestResStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMarkMailingAddress') then
   drop procedure ASQLMarkMailingAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMedClaimRangeBasis') then
   drop procedure ASQLMedClaimRangeBasis
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMoveEmployment') then
   drop procedure ASQLMoveEmployment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLNewCPFPayment') then
   drop procedure ASQLNewCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLNewPayAllocation') then
   drop procedure ASQLNewPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLPatchUserModuleNoAccess') then
   drop procedure ASQLPatchUserModuleNoAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLPayEmployeeConversion') then
   drop procedure ASQLPayEmployeeConversion
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLPayEmployeeProgression') then
   drop procedure ASQLPayEmployeeProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLPeriodFundSummary') then
   drop procedure ASQLPeriodFundSummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLPeriodLeaveSummary') then
   drop procedure ASQLPeriodLeaveSummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLPeriodSummary') then
   drop procedure ASQLPeriodSummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessEmployeeCostCentre') then
   drop procedure ASQLProcessEmployeeCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessEmployeeItemBatch') then
   drop procedure ASQLProcessEmployeeItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessEmployeeMClaimPolicy') then
   drop procedure ASQLProcessEmployeeMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessEmployeeRPayElement') then
   drop procedure ASQLProcessEmployeeRPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessQueryFolder') then
   drop procedure ASQLProcessQueryFolder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessUpdateLabelName') then
   drop procedure ASQLProcessUpdateLabelName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessUpdatePayLabelName') then
   drop procedure ASQLProcessUpdatePayLabelName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecalLeaveDeductionRecord') then
   drop procedure ASQLRecalLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecalOTRecord') then
   drop procedure ASQLRecalOTRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecalShiftRecord') then
   drop procedure ASQLRecalShiftRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecruitInterviewerPostProcess') then
   drop procedure ASQLRecruitInterviewerPostProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecruitInterviewerPreProcess') then
   drop procedure ASQLRecruitInterviewerPreProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRefreshEmpeeOtherInfo') then
   drop procedure ASQLRefreshEmpeeOtherInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRegisterMain') then
   drop procedure ASQLRegisterMain
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRemovePayElement') then
   drop procedure ASQLRemovePayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRenewInsurProg') then
   drop procedure ASQLRenewInsurProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLResetBankRecord') then
   drop procedure ASQLResetBankRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLSetDefaultEContact') then
   drop procedure ASQLSetDefaultEContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLSetDefaultHighestEdu') then
   drop procedure ASQLSetDefaultHighestEdu
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLSetDefaultResStatus') then
   drop procedure ASQLSetDefaultResStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLSetPersonalAddressDefault') then
   drop procedure ASQLSetPersonalAddressDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLSetUpCalendarDay') then
   drop procedure ASQLSetUpCalendarDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeAllowance') then
   drop procedure ASQLTimeSheetDistributeAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBackPay') then
   drop procedure ASQLTimeSheetDistributeBackPay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBR') then
   drop procedure ASQLTimeSheetDistributeBR
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeLeave') then
   drop procedure ASQLTimeSheetDistributeLeave
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeOT') then
   drop procedure ASQLTimeSheetDistributeOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeSDF') then
   drop procedure ASQLTimeSheetDistributeSDF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeShift') then
   drop procedure ASQLTimeSheetDistributeShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTrainingDeleteNotInBatch') then
   drop procedure ASQLTrainingDeleteNotInBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTrainingLinkAppraisal') then
   drop procedure ASQLTrainingLinkAppraisal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTrainingSysTotalCost') then
   drop procedure ASQLTrainingSysTotalCost
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTrainingUpdateCost') then
   drop procedure ASQLTrainingUpdateCost
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTransferDelInterfaceRecs') then
   drop procedure ASQLTransferDelInterfaceRecs
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateAccrualBasisKeyword') then
   drop procedure ASQLUpdateAccrualBasisKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateAccrualRecord') then
   drop procedure ASQLUpdateAccrualRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateAnlysSystemAttribute') then
   drop procedure ASQLUpdateAnlysSystemAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateAuditTrialBasisSubregistry') then
   drop procedure ASQLUpdateAuditTrialBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCareerAttributeValueAll') then
   drop procedure ASQLUpdateCareerAttributeValueAll
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCareerAttributeValueDateRange') then
   drop procedure ASQLUpdateCareerAttributeValueDateRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCareerAttributeValueLatest') then
   drop procedure ASQLUpdateCareerAttributeValueLatest
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCareerSubregistry') then
   drop procedure ASQLUpdateCareerSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCEBasisSubregistry') then
   drop procedure ASQLUpdateCEBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCostBasisSubregistry') then
   drop procedure ASQLUpdateCostBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCostRecord') then
   drop procedure ASQLUpdateCostRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateDetailRecordCostKeywordLabel') then
   drop procedure ASQLUpdateDetailRecordCostKeywordLabel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateDetailRecordKeywordLabel') then
   drop procedure ASQLUpdateDetailRecordKeywordLabel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateDetailRecordSysAttributeLabel') then
   drop procedure ASQLUpdateDetailRecordSysAttributeLabel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateEmpeeCompeEdu') then
   drop procedure ASQLUpdateEmpeeCompeEdu
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateEmpeeCompeRespon') then
   drop procedure ASQLUpdateEmpeeCompeRespon
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateEmpeeCompeSkill') then
   drop procedure ASQLUpdateEmpeeCompeSkill
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateEmpLeaveInfo') then
   drop procedure ASQLUpdateEmpLeaveInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateEmployeeInsurCoverage') then
   drop procedure ASQLUpdateEmployeeInsurCoverage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateEmployeeSystemAttribute') then
   drop procedure ASQLUpdateEmployeeSystemAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateGovtProgBasisSubregistry') then
   drop procedure ASQLUpdateGovtProgBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateHRBasisSubregistry') then
   drop procedure ASQLUpdateHRBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateImportFieldNameLabel') then
   drop procedure ASQLUpdateImportFieldNameLabel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateIntercorpBasisSubregistry') then
   drop procedure ASQLUpdateIntercorpBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateInterfaceAttributeList') then
   drop procedure ASQLUpdateInterfaceAttributeList
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateInterfaceAttributeMappingLabel') then
   drop procedure ASQLUpdateInterfaceAttributeMappingLabel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateInterfaceCodeMappingLabel') then
   drop procedure ASQLUpdateInterfaceCodeMappingLabel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateInterfaceCodeTable') then
   drop procedure ASQLUpdateInterfaceCodeTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateItemBasisSubregistry') then
   drop procedure ASQLUpdateItemBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateLeaveBasisSubregistry') then
   drop procedure ASQLUpdateLeaveBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateLeaveDeductionRecord') then
   drop procedure ASQLUpdateLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateLeaveKeyword') then
   drop procedure ASQLUpdateLeaveKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateMClaimBasisSubregistry') then
   drop procedure ASQLUpdateMClaimBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateOTBasisSubregistry') then
   drop procedure ASQLUpdateOTBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateOTRecord') then
   drop procedure ASQLUpdateOTRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdatePayBasisAnlysKeyword') then
   drop procedure ASQLUpdatePayBasisAnlysKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdatePayKeyword') then
   drop procedure ASQLUpdatePayKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateRPayElementBasisSubregistry') then
   drop procedure ASQLUpdateRPayElementBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateRptCompItemConfig') then
   drop procedure ASQLUpdateRptCompItemConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateShiftBasisSubregistry') then
   drop procedure ASQLUpdateShiftBasisSubregistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateShiftRecord') then
   drop procedure ASQLUpdateShiftRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateUtilityUsage') then
   drop procedure ASQLUpdateUtilityUsage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLWordWarp') then
   drop procedure ASQLWordWarp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'CanDeleteDefaultShortStrAttr') then
   drop procedure CanDeleteDefaultShortStrAttr
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DBPatchCreateAttachment') then
   drop procedure DBPatchCreateAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrGWItem') then
   drop procedure DeleteAccrGWItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrItemBasis') then
   drop procedure DeleteAccrItemBasis
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualEligible') then
   drop procedure DeleteAccrualEligible
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualField') then
   drop procedure DeleteAccrualField
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualGrossWage') then
   drop procedure DeleteAccrualGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualGroup') then
   drop procedure DeleteAccrualGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualItem') then
   drop procedure DeleteAccrualItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualMethod') then
   drop procedure DeleteAccrualMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAccrualPeriodSetup') then
   drop procedure DeleteAccrualPeriodSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteActionTaken') then
   drop procedure DeleteActionTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdHocQueryFields') then
   drop procedure DeleteAdHocQueryFields
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdHocQueryFieldsRecord') then
   drop procedure DeleteAdHocQueryFieldsRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdHocQueryRecord') then
   drop procedure DeleteAdHocQueryRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdjustCredit') then
   drop procedure DeleteAdjustCredit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdjustCreditByEmployeeSysID') then
   drop procedure DeleteAdjustCreditByEmployeeSysID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdvanceProcess') then
   drop procedure DeleteAdvanceProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAdvanceReport') then
   drop procedure DeleteAdvanceReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAlertGroup') then
   drop procedure DeleteAlertGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAlertGroupItem') then
   drop procedure DeleteAlertGroupItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAlertGroupItemAttach') then
   drop procedure DeleteAlertGroupItemAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAlertItemAssignMsg') then
   drop procedure DeleteAlertItemAssignMsg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAlertRole') then
   drop procedure DeleteAlertRole
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAllCountryState') then
   drop procedure DeleteAllCountryState
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAllowanceHistoryRecord') then
   drop procedure DeleteAllowanceHistoryRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAllowanceRecord') then
   drop procedure DeleteAllowanceRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnalyser') then
   drop procedure DeleteAnalyser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnlysBasisPolicy') then
   drop procedure DeleteAnlysBasisPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnlysDispSection') then
   drop procedure DeleteAnlysDispSection
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnlysItemSetup') then
   drop procedure DeleteAnlysItemSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnlysPolicyRange') then
   drop procedure DeleteAnlysPolicyRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnlysProject') then
   drop procedure DeleteAnlysProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAnlysSetup') then
   drop procedure DeleteAnlysSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteApplicant') then
   drop procedure DeleteApplicant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteApplicantAttach') then
   drop procedure DeleteApplicantAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisal') then
   drop procedure DeleteAppraisal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisalDetail') then
   drop procedure DeleteAppraisalDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisalDetailByPersysIdAndDate') then
   drop procedure DeleteAppraisalDetailByPersysIdAndDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisalGrade') then
   drop procedure DeleteAppraisalGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisalGradeByPtSysId') then
   drop procedure DeleteAppraisalGradeByPtSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisalHistory') then
   drop procedure DeleteAppraisalHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAppraisalType') then
   drop procedure DeleteAppraisalType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteApprCategory') then
   drop procedure DeleteApprCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteApprPtSystem') then
   drop procedure DeleteApprPtSystem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteApprTemplate') then
   drop procedure DeleteApprTemplate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteApprTraining') then
   drop procedure DeleteApprTraining
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAreaSpecialised') then
   drop procedure DeleteAreaSpecialised
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAwardCode') then
   drop procedure DeleteAwardCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAwardDisc') then
   drop procedure DeleteAwardDisc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteAwardDiscAttach') then
   drop procedure DeleteAwardDiscAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBalPayElement') then
   drop procedure DeleteBalPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBalPayElementId') then
   drop procedure DeleteBalPayElementId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBank') then
   drop procedure DeleteBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankAccountType') then
   drop procedure DeleteBankAccountType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankAccType') then
   drop procedure DeleteBankAccType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankAllocGroup') then
   drop procedure DeleteBankAllocGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankBranch') then
   drop procedure DeleteBankBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankBranches') then
   drop procedure DeleteBankBranches
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankFilter') then
   drop procedure DeleteBankFilter
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankRecord') then
   drop procedure DeleteBankRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBankSubmitCompanyBank') then
   drop procedure DeleteBankSubmitCompanyBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBasicRatePolicyProgressionRec') then
   drop procedure DeleteBasicRatePolicyProgressionRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBasicRateProgression') then
   drop procedure DeleteBasicRateProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBasicRateProgressionRec') then
   drop procedure DeleteBasicRateProgressionRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBatchRpt') then
   drop procedure DeleteBatchRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBatchRptItem') then
   drop procedure DeleteBatchRptItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBenefitDetails') then
   drop procedure DeleteBenefitDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBloodGroup') then
   drop procedure DeleteBloodGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBond') then
   drop procedure DeleteBond
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBondAttachment') then
   drop procedure DeleteBondAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBonusProcess') then
   drop procedure DeleteBonusProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBonusRecord') then
   drop procedure DeleteBonusRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBonusReport') then
   drop procedure DeleteBonusReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBonusReportRec') then
   drop procedure DeleteBonusReportRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteBranchGov') then
   drop procedure DeleteBranchGov
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCalendar') then
   drop procedure DeleteCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCalendarDay') then
   drop procedure DeleteCalendarDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCalendarDayByCalendarAndYear') then
   drop procedure DeleteCalendarDayByCalendarAndYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCalendarDayYear') then
   drop procedure DeleteCalendarDayYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCareer') then
   drop procedure DeleteCareer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCareerAttribute') then
   drop procedure DeleteCareerAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCareerAttributeTwoId') then
   drop procedure DeleteCareerAttributeTwoId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCareerProgression') then
   drop procedure DeleteCareerProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCategory') then
   drop procedure DeleteCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCCCode1') then
   drop procedure DeleteCCCode1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCCCode2') then
   drop procedure DeleteCCCode2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCCCode3') then
   drop procedure DeleteCCCode3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCCCode4') then
   drop procedure DeleteCCCode4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCCCode5') then
   drop procedure DeleteCCCode5
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCessation') then
   drop procedure DeleteCessation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCETmsExportEmpEmp') then
   drop procedure DeleteCETmsExportEmpEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCity') then
   drop procedure DeleteCity
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCityCountry') then
   drop procedure DeleteCityCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCityState') then
   drop procedure DeleteCityState
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteClassification') then
   drop procedure DeleteClassification
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteColourScheme') then
   drop procedure DeleteColourScheme
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteComBank') then
   drop procedure DeleteComBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyBranch') then
   drop procedure DeleteCompanyBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyBranches') then
   drop procedure DeleteCompanyBranches
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyGovt') then
   drop procedure DeleteCompanyGovt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyGovtCompany') then
   drop procedure DeleteCompanyGovtCompany
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyGovType') then
   drop procedure DeleteCompanyGovType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyGovTypeCountry') then
   drop procedure DeleteCompanyGovTypeCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyRecord') then
   drop procedure DeleteCompanyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompanyType') then
   drop procedure DeleteCompanyType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCompetency') then
   drop procedure DeleteCompetency
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteContactLoc') then
   drop procedure DeleteContactLoc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteContractCategory') then
   drop procedure DeleteContractCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteContractProgression') then
   drop procedure DeleteContractProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostAccount') then
   drop procedure DeleteCostAccount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostCentre') then
   drop procedure DeleteCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostComponent') then
   drop procedure DeleteCostComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostCond') then
   drop procedure DeleteCostCond
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostCreditDebit') then
   drop procedure DeleteCostCreditDebit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostGroup') then
   drop procedure DeleteCostGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostingDetails') then
   drop procedure DeleteCostingDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostingMethod') then
   drop procedure DeleteCostingMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostItem') then
   drop procedure DeleteCostItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostPeriod') then
   drop procedure DeleteCostPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostPeriodHistory') then
   drop procedure DeleteCostPeriodHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCostProgression') then
   drop procedure DeleteCostProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCountry') then
   drop procedure DeleteCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourse') then
   drop procedure DeleteCourse
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseAttachment') then
   drop procedure DeleteCourseAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseAttachmentByCourseCode') then
   drop procedure DeleteCourseAttachmentByCourseCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseCategory') then
   drop procedure DeleteCourseCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseContact') then
   drop procedure DeleteCourseContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseContactByKeys') then
   drop procedure DeleteCourseContactByKeys
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseFamily') then
   drop procedure DeleteCourseFamily
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseGrade') then
   drop procedure DeleteCourseGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseGradeByCourseCode') then
   drop procedure DeleteCourseGradeByCourseCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseRole') then
   drop procedure DeleteCourseRole
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseSchedule') then
   drop procedure DeleteCourseSchedule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseScheduleByCourseCode') then
   drop procedure DeleteCourseScheduleByCourseCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCourseSkillType') then
   drop procedure DeleteCourseSkillType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFAgeGroup') then
   drop procedure DeleteCPFAgeGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFGovernmentProgression') then
   drop procedure DeleteCPFGovernmentProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFPayment') then
   drop procedure DeleteCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFPolicy') then
   drop procedure DeleteCPFPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFPolicyMember') then
   drop procedure DeleteCPFPolicyMember
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFPolicyMemberById') then
   drop procedure DeleteCPFPolicyMemberById
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFProgression') then
   drop procedure DeleteCPFProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFProgressionRec') then
   drop procedure DeleteCPFProgressionRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFSalaryGroup') then
   drop procedure DeleteCPFSalaryGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFTableCode') then
   drop procedure DeleteCPFTableCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCPFTableComponent') then
   drop procedure DeleteCPFTableComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomAttribute') then
   drop procedure DeleteCustomAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomAttributeByCustomQueryID') then
   drop procedure DeleteCustomAttributeByCustomQueryID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomAttributeByCustomTableID') then
   drop procedure DeleteCustomAttributeByCustomTableID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomAttributeByQueryFolderID') then
   drop procedure DeleteCustomAttributeByQueryFolderID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomIntConfig') then
   drop procedure DeleteCustomIntConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomIntConfigItem') then
   drop procedure DeleteCustomIntConfigItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomQuery') then
   drop procedure DeleteCustomQuery
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomQueryByQueryFolderID') then
   drop procedure DeleteCustomQueryByQueryFolderID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomRelation') then
   drop procedure DeleteCustomRelation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomSearch') then
   drop procedure DeleteCustomSearch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomSearchByCustomQueryID') then
   drop procedure DeleteCustomSearchByCustomQueryID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomSearchByQueryFolderID') then
   drop procedure DeleteCustomSearchByQueryFolderID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomTable') then
   drop procedure DeleteCustomTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomTableByCustomQueryID') then
   drop procedure DeleteCustomTableByCustomQueryID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomTableByQueryFolderID') then
   drop procedure DeleteCustomTableByQueryFolderID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomVariables') then
   drop procedure DeleteCustomVariables
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDefault') then
   drop procedure DeleteDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDefaultCPFPayment') then
   drop procedure DeleteDefaultCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDefaultCPFPaymentGrp') then
   drop procedure DeleteDefaultCPFPaymentGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDefaultPayAllocation') then
   drop procedure DeleteDefaultPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDefaultPayAllocationGrp') then
   drop procedure DeleteDefaultPayAllocationGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDepartment') then
   drop procedure DeleteDepartment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDetailRecord') then
   drop procedure DeleteDetailRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEduAttachment') then
   drop procedure DeleteEduAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEducation') then
   drop procedure DeleteEducation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEducationRec') then
   drop procedure DeleteEducationRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpCode1') then
   drop procedure DeleteEmpCode1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpCode2') then
   drop procedure DeleteEmpCode2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpCode3') then
   drop procedure DeleteEmpCode3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpCode4') then
   drop procedure DeleteEmpCode4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpCode5') then
   drop procedure DeleteEmpCode5
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpColItem') then
   drop procedure DeleteEmpColItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpColItemRec') then
   drop procedure DeleteEmpColItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpeeOtherInfo') then
   drop procedure DeleteEmpeeOtherInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpeeWkCalen') then
   drop procedure DeleteEmpeeWkCalen
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpeeWkCalenCal') then
   drop procedure DeleteEmpeeWkCalenCal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpeeWkCalenEmp') then
   drop procedure DeleteEmpeeWkCalenEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpGrpItem') then
   drop procedure DeleteEmpGrpItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpGrpItemRec') then
   drop procedure DeleteEmpGrpItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpLeaveRecord') then
   drop procedure DeleteEmpLeaveRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpLocation1') then
   drop procedure DeleteEmpLocation1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmployeeRecord') then
   drop procedure DeleteEmployeeRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmployeeRpt') then
   drop procedure DeleteEmployeeRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmploymentStatus') then
   drop procedure DeleteEmploymentStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmploymentType') then
   drop procedure DeleteEmploymentType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmployPassProgression') then
   drop procedure DeleteEmployPassProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpRecurAllow') then
   drop procedure DeleteEmpRecurAllow
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpSortItem') then
   drop procedure DeleteEmpSortItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmpSortItemRec') then
   drop procedure DeleteEmpSortItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEPByEmpSysId') then
   drop procedure DeleteEPByEmpSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExcelSpreadsheet') then
   drop procedure DeleteExcelSpreadsheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExcelWkSheet') then
   drop procedure DeleteExcelWkSheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExcelWkSheetItem') then
   drop procedure DeleteExcelWkSheetItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExcelWkSheetItemRec') then
   drop procedure DeleteExcelWkSheetItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExchangeRate') then
   drop procedure DeleteExchangeRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExitIntAttach') then
   drop procedure DeleteExitIntAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteExitInterview') then
   drop procedure DeleteExitInterview
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFamily') then
   drop procedure DeleteFamily
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFamilyAttachment') then
   drop procedure DeleteFamilyAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFamilyEduRec') then
   drop procedure DeleteFamilyEduRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFieldMajor') then
   drop procedure DeleteFieldMajor
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFieldSecuirtyNoAccessFld') then
   drop procedure DeleteFieldSecuirtyNoAccessFld
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFieldSecurityNoAccessGrp') then
   drop procedure DeleteFieldSecurityNoAccessGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFieldSecurityNoAccessRec') then
   drop procedure DeleteFieldSecurityNoAccessRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceColItem') then
   drop procedure DeleteFinanceColItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceColItemRec') then
   drop procedure DeleteFinanceColItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceGrpItem') then
   drop procedure DeleteFinanceGrpItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceGrpItemRec') then
   drop procedure DeleteFinanceGrpItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceRowItem') then
   drop procedure DeleteFinanceRowItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceRowItemRec') then
   drop procedure DeleteFinanceRowItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceSortItem') then
   drop procedure DeleteFinanceSortItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinanceSortItemRec') then
   drop procedure DeleteFinanceSortItemRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinancialRpt') then
   drop procedure DeleteFinancialRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinColAccumulated') then
   drop procedure DeleteFinColAccumulated
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFinColAccumulatedRec') then
   drop procedure DeleteFinColAccumulatedRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteForeignWorkerRecord') then
   drop procedure DeleteForeignWorkerRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteForeignWorkerRecordEmp') then
   drop procedure DeleteForeignWorkerRecordEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteForeignWorkerType') then
   drop procedure DeleteForeignWorkerType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteForm') then
   drop procedure DeleteForm
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormControlProperty') then
   drop procedure DeleteFormControlProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormPoint') then
   drop procedure DeleteFormPoint
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormula') then
   drop procedure DeleteFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormulaProperty') then
   drop procedure DeleteFormulaProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormulaPropertyById') then
   drop procedure DeleteFormulaPropertyById
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormulaRange') then
   drop procedure DeleteFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFormulaRangeById') then
   drop procedure DeleteFormulaRangeById
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteFWLProgression') then
   drop procedure DeleteFWLProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGLCode') then
   drop procedure DeleteGLCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGovContirbType') then
   drop procedure DeleteGovContirbType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGovernmentGrant') then
   drop procedure DeleteGovernmentGrant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGrade') then
   drop procedure DeleteGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupLvePatternCal') then
   drop procedure DeleteGroupLvePatternCal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupLvePatternGrp') then
   drop procedure DeleteGroupLvePatternGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupLvePatternRec') then
   drop procedure DeleteGroupLvePatternRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupLvePatternWkP') then
   drop procedure DeleteGroupLvePatternWkP
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupWorkPatternCal') then
   drop procedure DeleteGroupWorkPatternCal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupWorkPatternGrp') then
   drop procedure DeleteGroupWorkPatternGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupWorkPatternRec') then
   drop procedure DeleteGroupWorkPatternRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteGroupWorkPatternWkP') then
   drop procedure DeleteGroupWorkPatternWkP
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHiProgression') then
   drop procedure DeleteHiProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHoliday') then
   drop procedure DeleteHoliday
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHolidayCountry') then
   drop procedure DeleteHolidayCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRDetails') then
   drop procedure DeleteHRDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRFormula') then
   drop procedure DeleteHRFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRFormulaRange') then
   drop procedure DeleteHRFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRKeyword') then
   drop procedure DeleteHRKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRProjectAllAttach') then
   drop procedure DeleteHRProjectAllAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRProjectAllTeam') then
   drop procedure DeleteHRProjectAllTeam
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRProjectRecord') then
   drop procedure DeleteHRProjectRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRProjectSingleAttach') then
   drop procedure DeleteHRProjectSingleAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRProjectSingleWorker') then
   drop procedure DeleteHRProjectSingleWorker
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRTestAllAttach') then
   drop procedure DeleteHRTestAllAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRTestRecord') then
   drop procedure DeleteHRTestRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteHRTestSingleAttach') then
   drop procedure DeleteHRTestSingleAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteIdentityType') then
   drop procedure DeleteIdentityType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteIllness') then
   drop procedure DeleteIllness
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurance') then
   drop procedure DeleteInsurance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsuranceAttach') then
   drop procedure DeleteInsuranceAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurAttach') then
   drop procedure DeleteInsurAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurBenefit') then
   drop procedure DeleteInsurBenefit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurFamilyAdd') then
   drop procedure DeleteInsurFamilyAdd
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurGroup') then
   drop procedure DeleteInsurGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurPlan') then
   drop procedure DeleteInsurPlan
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurPolicy') then
   drop procedure DeleteInsurPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurProg') then
   drop procedure DeleteInsurProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInsurProgDetails') then
   drop procedure DeleteInsurProgDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteIntercorpTmsExportEmpEmp') then
   drop procedure DeleteIntercorpTmsExportEmpEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterfaceAttribute') then
   drop procedure DeleteInterfaceAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterfaceCodeMapping') then
   drop procedure DeleteInterfaceCodeMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterfaceCodeTable') then
   drop procedure DeleteInterfaceCodeTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterfaceProcess') then
   drop procedure DeleteInterfaceProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterfaceProject') then
   drop procedure DeleteInterfaceProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterviewer') then
   drop procedure DeleteInterviewer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteInterviewSchedule') then
   drop procedure DeleteInterviewSchedule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItem') then
   drop procedure DeleteItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItemAssignItem') then
   drop procedure DeleteItemAssignItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItemAttrName') then
   drop procedure DeleteItemAttrName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItemAttrValue') then
   drop procedure DeleteItemAttrValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItemBAssgn') then
   drop procedure DeleteItemBAssgn
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItemBatch') then
   drop procedure DeleteItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteItemType') then
   drop procedure DeleteItemType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteJobAdAttach') then
   drop procedure DeleteJobAdAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteJobCode') then
   drop procedure DeleteJobCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteJobGrade') then
   drop procedure DeleteJobGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteJobHistory') then
   drop procedure DeleteJobHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteJobOpenTo') then
   drop procedure DeleteJobOpenTo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteJobResponsibility') then
   drop procedure DeleteJobResponsibility
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteKeyWord') then
   drop procedure DeleteKeyWord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLanguage') then
   drop procedure DeleteLanguage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveAllocatGroupLveType') then
   drop procedure DeleteLeaveAllocatGroupLveType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveAllocation') then
   drop procedure DeleteLeaveAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveAllocationGroup') then
   drop procedure DeleteLeaveAllocationGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveAllocationGroupGrpType') then
   drop procedure DeleteLeaveAllocationGroupGrpType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveAllocationGroupType') then
   drop procedure DeleteLeaveAllocationGroupType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveApplication') then
   drop procedure DeleteLeaveApplication
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveApplicationByGenId') then
   drop procedure DeleteLeaveApplicationByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveApplicationEmp') then
   drop procedure DeleteLeaveApplicationEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveApply') then
   drop procedure DeleteLeaveApply
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveApplyDayDate') then
   drop procedure DeleteLeaveApplyDayDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveApplyDayNo') then
   drop procedure DeleteLeaveApplyDayNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveComputation') then
   drop procedure DeleteLeaveComputation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveCutOffDate') then
   drop procedure DeleteLeaveCutOffDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveCutOffDateGrp') then
   drop procedure DeleteLeaveCutOffDateGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveCutOffDateSubPeriod') then
   drop procedure DeleteLeaveCutOffDateSubPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveCycleRpt') then
   drop procedure DeleteLeaveCycleRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveDeductionRecord') then
   drop procedure DeleteLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveEmployee') then
   drop procedure DeleteLeaveEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveFormula') then
   drop procedure DeleteLeaveFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveGroup') then
   drop procedure DeleteLeaveGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveGroupCalendar') then
   drop procedure DeleteLeaveGroupCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveInfoRecord') then
   drop procedure DeleteLeaveInfoRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveInitialisedGroup') then
   drop procedure DeleteLeaveInitialisedGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveKeyword') then
   drop procedure DeleteLeaveKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeavePolicy') then
   drop procedure DeleteLeavePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeavePolicyRecByLeavePolicy') then
   drop procedure DeleteLeavePolicyRecByLeavePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeavePolicyRecord') then
   drop procedure DeleteLeavePolicyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveRange') then
   drop procedure DeleteLeaveRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveReason') then
   drop procedure DeleteLeaveReason
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveRecord') then
   drop procedure DeleteLeaveRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveRecordByGenId') then
   drop procedure DeleteLeaveRecordByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLeaveType') then
   drop procedure DeleteLeaveType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLicenseRecord') then
   drop procedure DeleteLicenseRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLoanEmployee') then
   drop procedure DeleteLoanEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLoanEmployeeEmp') then
   drop procedure DeleteLoanEmployeeEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLoanFrom') then
   drop procedure DeleteLoanFrom
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLoginRec') then
   drop procedure DeleteLoginRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLoginRecBatch') then
   drop procedure DeleteLoginRecBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLoginRecUser') then
   drop procedure DeleteLoginRecUser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLveAllocation') then
   drop procedure DeleteLveAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLveAllocationRec') then
   drop procedure DeleteLveAllocationRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLveAllocFormRecByCostMethId') then
   drop procedure DeleteLveAllocFormRecByCostMethId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLveAllocFormulaRec') then
   drop procedure DeleteLveAllocFormulaRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLveAllocRecbyAllocId') then
   drop procedure DeleteLveAllocRecbyAllocId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLvePeriodBalance') then
   drop procedure DeleteLvePeriodBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLvePeriodBalRpt') then
   drop procedure DeleteLvePeriodBalRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLvePeriodBF') then
   drop procedure DeleteLvePeriodBF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLvePeriodSummary') then
   drop procedure DeleteLvePeriodSummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLvePolicyProg') then
   drop procedure DeleteLvePolicyProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteLvePolicySummary') then
   drop procedure DeleteLvePolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMandatoryContributeProg') then
   drop procedure DeleteMandatoryContributeProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapCostCentre') then
   drop procedure DeleteMapCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapDonation') then
   drop procedure DeleteMapDonation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapGovtProg') then
   drop procedure DeleteMapGovtProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapItemBatch') then
   drop procedure DeleteMapItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapMClaimPolicy') then
   drop procedure DeleteMapMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapOT') then
   drop procedure DeleteMapOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapRPayElement') then
   drop procedure DeleteMapRPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMapShift') then
   drop procedure DeleteMapShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMaritalStatus') then
   drop procedure DeleteMaritalStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMClaimAttachment') then
   drop procedure DeleteMClaimAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMClaimPolicy') then
   drop procedure DeleteMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMClaimPolicyRec') then
   drop procedure DeleteMClaimPolicyRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMClaimReason') then
   drop procedure DeleteMClaimReason
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMClaimType') then
   drop procedure DeleteMClaimType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMClaimTypeRange') then
   drop procedure DeleteMClaimTypeRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMedClaim') then
   drop procedure DeleteMedClaim
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMedClaimByPersonalSysId') then
   drop procedure DeleteMedClaimByPersonalSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMedClaimHistory') then
   drop procedure DeleteMedClaimHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMedExDetType') then
   drop procedure DeleteMedExDetType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMedExRec') then
   drop procedure DeleteMedExRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMedia') then
   drop procedure DeleteMedia
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMediHistory') then
   drop procedure DeleteMediHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMediHistoryAttach') then
   drop procedure DeleteMediHistoryAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMembershipCode') then
   drop procedure DeleteMembershipCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMemship') then
   drop procedure DeleteMemship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteModuleScreenGroup') then
   drop procedure DeleteModuleScreenGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOccupation') then
   drop procedure DeleteOccupation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOffenceType') then
   drop procedure DeleteOffenceType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOrganisation') then
   drop procedure DeleteOrganisation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOrganisationIndustry') then
   drop procedure DeleteOrganisationIndustry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOrganisationType') then
   drop procedure DeleteOrganisationType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOrganiser') then
   drop procedure DeleteOrganiser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOrgCWorker') then
   drop procedure DeleteOrgCWorker
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOrgPubChart') then
   drop procedure DeleteOrgPubChart
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOtherBankInfo') then
   drop procedure DeleteOtherBankInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOTMember') then
   drop procedure DeleteOTMember
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOTRecord') then
   drop procedure DeleteOTRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOutEmailMessage') then
   drop procedure DeleteOutEmailMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOutEmailMsgMapping') then
   drop procedure DeleteOutEmailMsgMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteOverTime') then
   drop procedure DeleteOverTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayAllocation') then
   drop procedure DeletePayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayEmployee') then
   drop procedure DeletePayEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayEmployeePolicy') then
   drop procedure DeletePayEmployeePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayGroup') then
   drop procedure DeletePayGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayGroupGrp') then
   drop procedure DeletePayGroupGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayGroupPeriod') then
   drop procedure DeletePayGroupPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayGroupPeriodGrp') then
   drop procedure DeletePayGroupPeriodGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayLeaveSetting') then
   drop procedure DeletePayLeaveSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePaymentBankInfo') then
   drop procedure DeletePaymentBankInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePaymentBankInfoEmp') then
   drop procedure DeletePaymentBankInfoEmp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayPeriodRecord') then
   drop procedure DeletePayPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePayRecord') then
   drop procedure DeletePayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePensionOption') then
   drop procedure DeletePensionOption
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePeriodEEHistory') then
   drop procedure DeletePeriodEEHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePeriodMessage') then
   drop procedure DeletePeriodMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePeriodPolicySetting') then
   drop procedure DeletePeriodPolicySetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePeriodPolicySummary') then
   drop procedure DeletePeriodPolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalAddressAll') then
   drop procedure DeletePersonalAddressAll
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalAddressRec') then
   drop procedure DeletePersonalAddressRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalContactAll') then
   drop procedure DeletePersonalContactAll
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalContactRec') then
   drop procedure DeletePersonalContactRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalEducationRecord') then
   drop procedure DeletePersonalEducationRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalEmailAll') then
   drop procedure DeletePersonalEmailAll
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalEmailRecord') then
   drop procedure DeletePersonalEmailRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalRecord') then
   drop procedure DeletePersonalRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalResStatusRec') then
   drop procedure DeletePersonalResStatusRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePolicyProgression') then
   drop procedure DeletePolicyProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePolicyProgressionRec') then
   drop procedure DeletePolicyProgressionRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePolicyRecord') then
   drop procedure DeletePolicyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePosGrp') then
   drop procedure DeletePosGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePositionCode') then
   drop procedure DeletePositionCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteProjCostType') then
   drop procedure DeleteProjCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteQueryFolder') then
   drop procedure DeleteQueryFolder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRace') then
   drop procedure DeleteRace
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRecruitPosition') then
   drop procedure DeleteRecruitPosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRegistry') then
   drop procedure DeleteRegistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRelationship') then
   drop procedure DeleteRelationship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteReligion') then
   drop procedure DeleteReligion
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteReportAccess') then
   drop procedure DeleteReportAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteReportExport') then
   drop procedure DeleteReportExport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteResidenceType') then
   drop procedure DeleteResidenceType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteResponsibility') then
   drop procedure DeleteResponsibility
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteResStatusRecord') then
   drop procedure DeleteResStatusRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteResStatusRecordBySysId') then
   drop procedure DeleteResStatusRecordBySysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteReviewAttachment') then
   drop procedure DeleteReviewAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteReviewType') then
   drop procedure DeleteReviewType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRptCompItemConfig') then
   drop procedure DeleteRptCompItemConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRptConfig') then
   drop procedure DeleteRptConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSalaryGrade') then
   drop procedure DeleteSalaryGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteScreenDesigner') then
   drop procedure DeleteScreenDesigner
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteScreenProject') then
   drop procedure DeleteScreenProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSDFProgression') then
   drop procedure DeleteSDFProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSection') then
   drop procedure DeleteSection
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteShift') then
   drop procedure DeleteShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteShiftCalendarByEmployeeAndYear') then
   drop procedure DeleteShiftCalendarByEmployeeAndYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteShiftMember') then
   drop procedure DeleteShiftMember
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteShiftMemberByShiftId') then
   drop procedure DeleteShiftMemberByShiftId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteShiftRecord') then
   drop procedure DeleteShiftRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSIHIGovtProgression') then
   drop procedure DeleteSIHIGovtProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSIProgression') then
   drop procedure DeleteSIProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSkill') then
   drop procedure DeleteSkill
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSkillGrade') then
   drop procedure DeleteSkillGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSkillGradeBySkillCode') then
   drop procedure DeleteSkillGradeBySkillCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSkillLevel') then
   drop procedure DeleteSkillLevel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSkillLevelByPersonalSysID') then
   drop procedure DeleteSkillLevelByPersonalSysID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSponsorGrant') then
   drop procedure DeleteSponsorGrant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSponsorship') then
   drop procedure DeleteSponsorship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteState') then
   drop procedure DeleteState
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSubPeriodRecord') then
   drop procedure DeleteSubPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSubPeriodSetting') then
   drop procedure DeleteSubPeriodSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSubPeriodTemplate') then
   drop procedure DeleteSubPeriodTemplate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSubPeriodTemplateGrp') then
   drop procedure DeleteSubPeriodTemplateGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSubRegistry') then
   drop procedure DeleteSubRegistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSuccession') then
   drop procedure DeleteSuccession
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSystemUser') then
   drop procedure DeleteSystemUser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteSystemUserGroup') then
   drop procedure DeleteSystemUserGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTest') then
   drop procedure DeleteTest
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTimeSheet') then
   drop procedure DeleteTimeSheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTitleCode') then
   drop procedure DeleteTitleCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSAllowance') then
   drop procedure DeleteTMSAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSAllowanceByGenId') then
   drop procedure DeleteTMSAllowanceByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSDetail') then
   drop procedure DeleteTMSDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSDistribute') then
   drop procedure DeleteTMSDistribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSDistributeByGenId') then
   drop procedure DeleteTMSDistributeByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSLeaveDeduction') then
   drop procedure DeleteTMSLeaveDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSLeaveDeductionByGenId') then
   drop procedure DeleteTMSLeaveDeductionByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSOverTime') then
   drop procedure DeleteTMSOverTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSOverTimeByGenId') then
   drop procedure DeleteTMSOverTimeByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSShift') then
   drop procedure DeleteTMSShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTMSShiftByGenId') then
   drop procedure DeleteTMSShiftByGenId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainCostType') then
   drop procedure DeleteTrainCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTraining') then
   drop procedure DeleteTraining
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingAttachment') then
   drop procedure DeleteTrainingAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingAttachmentByKeys') then
   drop procedure DeleteTrainingAttachmentByKeys
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingBatch') then
   drop procedure DeleteTrainingBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingHistory') then
   drop procedure DeleteTrainingHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingPersonnel') then
   drop procedure DeleteTrainingPersonnel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingPersonnelByBatchID') then
   drop procedure DeleteTrainingPersonnelByBatchID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTrainingType') then
   drop procedure DeleteTrainingType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteTreatmentType') then
   drop procedure DeleteTreatmentType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserGroup') then
   drop procedure DeleteUserGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserModuleNoAccessModule') then
   drop procedure DeleteUserModuleNoAccessModule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserModuleNoAccessRecord') then
   drop procedure DeleteUserModuleNoAccessRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserModuleNoAccessUserGrp') then
   drop procedure DeleteUserModuleNoAccessUserGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserSearchSetting') then
   drop procedure DeleteUserSearchSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserSearchSettingByUserID') then
   drop procedure DeleteUserSearchSettingByUserID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserSecurityQuery') then
   drop procedure DeleteUserSecurityQuery
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserSecurityQueryRec') then
   drop procedure DeleteUserSecurityQueryRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUserSecurityQueryUser') then
   drop procedure DeleteUserSecurityQueryUser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteUtilityUsage') then
   drop procedure DeleteUtilityUsage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVenue') then
   drop procedure DeleteVenue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnC04Record') then
   drop procedure DeleteVnC04Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnC45Record') then
   drop procedure DeleteVnC45Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnC47aRecord') then
   drop procedure DeleteVnC47aRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnC47Record') then
   drop procedure DeleteVnC47Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnERSubmission') then
   drop procedure DeleteVnERSubmission
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnERTaxPayment') then
   drop procedure DeleteVnERTaxPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnTaxDetails') then
   drop procedure DeleteVnTaxDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnTaxEmployee') then
   drop procedure DeleteVnTaxEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnTaxEmployer') then
   drop procedure DeleteVnTaxEmployer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnTaxPolicy') then
   drop procedure DeleteVnTaxPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnTaxProgression') then
   drop procedure DeleteVnTaxProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteVnTaxRecord') then
   drop procedure DeleteVnTaxRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWageProperty') then
   drop procedure DeleteWageProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWagePropertyById') then
   drop procedure DeleteWagePropertyById
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWeekLeavePattern') then
   drop procedure DeleteWeekLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWeekWorkPattern') then
   drop procedure DeleteWeekWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWorkTime') then
   drop procedure DeleteWorkTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWorkTimeByWTProfileId') then
   drop procedure DeleteWorkTimeByWTProfileId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWTCalendar') then
   drop procedure DeleteWTCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWTCalendarPattern') then
   drop procedure DeleteWTCalendarPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWTDay') then
   drop procedure DeleteWTDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWTDayByCalendarId') then
   drop procedure DeleteWTDayByCalendarId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWTDayByWTCalendarIdAndYear') then
   drop procedure DeleteWTDayByWTCalendarIdAndYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteWTProfile') then
   drop procedure DeleteWTProfile
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FAddZero') then
   drop procedure FAddZero
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FCheckContractProgAvail') then
   drop procedure FCheckContractProgAvail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FCheckGroupWeekPattern') then
   drop procedure FCheckGroupWeekPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FCheckIsPaymentBalance') then
   drop procedure FCheckIsPaymentBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FCheckResStatusDate') then
   drop procedure FCheckResStatusDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FChkEmpPaymentBankValue') then
   drop procedure FChkEmpPaymentBankValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FClearPaymentBankBalance') then
   drop procedure FClearPaymentBankBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FConvertNRIC') then
   drop procedure FConvertNRIC
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FConvertNull') then
   drop procedure FConvertNull
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FConvertNullString') then
   drop procedure FConvertNullString
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FCPFAccNumberWithoutDot') then
   drop procedure FCPFAccNumberWithoutDot
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FCPFConvertNegativeToZero') then
   drop procedure FCPFConvertNegativeToZero
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FDecodeFormula') then
   drop procedure FDecodeFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FDecodeHRFormula') then
   drop procedure FDecodeHRFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FDecodeLeaveFormula') then
   drop procedure FDecodeLeaveFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAccrFormulaDesc') then
   drop procedure FGetAccrFormulaDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAccumulatedMVCPercent') then
   drop procedure FGetAccumulatedMVCPercent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetActualServiceYear') then
   drop procedure FGetActualServiceYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAlertDayName') then
   drop procedure FGetAlertDayName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAlertFilterBy') then
   drop procedure FGetAlertFilterBy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAlertKeyWordUserDefinedName') then
   drop procedure FGetAlertKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAlertMonthName') then
   drop procedure FGetAlertMonthName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAllowanceElementYTD') then
   drop procedure FGetAllowanceElementYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAllowanceVarianceCount') then
   drop procedure FGetAllowanceVarianceCount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAnlysItemRecordAmt') then
   drop procedure FGetAnlysItemRecordAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAnlysItemRecordStr') then
   drop procedure FGetAnlysItemRecordStr
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBackPayOT') then
   drop procedure FGetBackPayOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBankAddress') then
   drop procedure FGetBankAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBankBranchDesc') then
   drop procedure FGetBankBranchDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBankCity') then
   drop procedure FGetBankCity
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBankCountry') then
   drop procedure FGetBankCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBankName') then
   drop procedure FGetBankName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBankState') then
   drop procedure FGetBankState
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBasicRateProgressionForeignLocalRate') then
   drop procedure FGetBasicRateProgressionForeignLocalRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBenefitKeyWordUserDefinedName') then
   drop procedure FGetBenefitKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBloodGroupType') then
   drop procedure FGetBloodGroupType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBooleanIntegerString') then
   drop procedure FGetBooleanIntegerString
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBranchName') then
   drop procedure FGetBranchName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBRProgNextIncDate') then
   drop procedure FGetBRProgNextIncDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBRProgPeriodBasicRate') then
   drop procedure FGetBRProgPeriodBasicRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBRProgPrevBasicRate') then
   drop procedure FGetBRProgPrevBasicRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBRProgPreviousProgDate') then
   drop procedure FGetBRProgPreviousProgDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCareerDesc') then
   drop procedure FGetCareerDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCareerNewValueDesc') then
   drop procedure FGetCareerNewValueDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCategoryDesc') then
   drop procedure FGetCategoryDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCategorySameCodeAllowanceAmount') then
   drop procedure FGetCategorySameCodeAllowanceAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCessationDesc') then
   drop procedure FGetCessationDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCityName') then
   drop procedure FGetCityName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetClassificationDesc') then
   drop procedure FGetClassificationDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCodeDescription') then
   drop procedure FGetCodeDescription
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCodeDescriptionByPersonal') then
   drop procedure FGetCodeDescriptionByPersonal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyAddress') then
   drop procedure FGetCompanyAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyContact') then
   drop procedure FGetCompanyContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyCurrency') then
   drop procedure FGetCompanyCurrency
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyEmailAddress') then
   drop procedure FGetCompanyEmailAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyFax') then
   drop procedure FGetCompanyFax
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyName') then
   drop procedure FGetCompanyName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyReg') then
   drop procedure FGetCompanyReg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompanyTypeDesc') then
   drop procedure FGetCompanyTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCompCodeDesc') then
   drop procedure FGetCompCodeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetComSameCodeAllowanceAmount') then
   drop procedure FGetComSameCodeAllowanceAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetConfirmationDue') then
   drop procedure FGetConfirmationDue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCoreKeyWordUserDefinedName') then
   drop procedure FGetCoreKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostAccountId') then
   drop procedure FGetCostAccountId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostCentreDesc') then
   drop procedure FGetCostCentreDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostCentreValueInPeriod') then
   drop procedure FGetCostCentreValueInPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostEmperCPFRate') then
   drop procedure FGetCostEmperCPFRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostItemDesc') then
   drop procedure FGetCostItemDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostKeyWordUserDefinedName') then
   drop procedure FGetCostKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostPeriodYearToCalenMthYear') then
   drop procedure FGetCostPeriodYearToCalenMthYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostPeriodYearToPayPeriodYear') then
   drop procedure FGetCostPeriodYearToPayPeriodYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostRecordSum') then
   drop procedure FGetCostRecordSum
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostStartDate') then
   drop procedure FGetCostStartDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCountCalenLeavePattern') then
   drop procedure FGetCountCalenLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCountCalenWorkPattern') then
   drop procedure FGetCountCalenWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCountryCurrency') then
   drop procedure FGetCountryCurrency
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCountryName') then
   drop procedure FGetCountryName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseDurationConv') then
   drop procedure FGetCourseDurationConv
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseRefNo') then
   drop procedure FGetCourseRefNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseStartDate') then
   drop procedure FGetCourseStartDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFAccNoFormat') then
   drop procedure FGetCPFAccNoFormat
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFDetailLine') then
   drop procedure FGetCPFDetailLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFFormula') then
   drop procedure FGetCPFFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFHeaderLine') then
   drop procedure FGetCPFHeaderLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFLineDetailLine') then
   drop procedure FGetCPFLineDetailLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFLineSummaryLine') then
   drop procedure FGetCPFLineSummaryLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFLineTotalLine') then
   drop procedure FGetCPFLineTotalLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPalDetailLine') then
   drop procedure FGetCPFPalDetailLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPalHeaderLine') then
   drop procedure FGetCPFPalHeaderLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPalSummaryLine') then
   drop procedure FGetCPFPalSummaryLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPalTrailerLine') then
   drop procedure FGetCPFPalTrailerLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPaymentDetails') then
   drop procedure FGetCPFPaymentDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPaymentTotalLine') then
   drop procedure FGetCPFPaymentTotalLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFPreviousContrib') then
   drop procedure FGetCPFPreviousContrib
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFProgAccountNo') then
   drop procedure FGetCPFProgAccountNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFProgPreviousProgDate') then
   drop procedure FGetCPFProgPreviousProgDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFSummaryLine') then
   drop procedure FGetCPFSummaryLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCPFTrailerLine') then
   drop procedure FGetCPFTrailerLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCrossCycTaken') then
   drop procedure FGetCrossCycTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentBasicRateProgressionDate') then
   drop procedure FGetCurrentBasicRateProgressionDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentBRProgDate') then
   drop procedure FGetCurrentBRProgDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentCareerEffectiveDate') then
   drop procedure FGetCurrentCareerEffectiveDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentCostProgEffectiveDate') then
   drop procedure FGetCurrentCostProgEffectiveDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentCPFPolicyTable') then
   drop procedure FGetCurrentCPFPolicyTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentCPFScheme') then
   drop procedure FGetCurrentCPFScheme
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentEmployment') then
   drop procedure FGetCurrentEmployment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentFWLClass') then
   drop procedure FGetCurrentFWLClass
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurrentResStatus') then
   drop procedure FGetCurrentResStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDateFormat') then
   drop procedure FGetDateFormat
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDateTimeFormat') then
   drop procedure FGetDateTimeFormat
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDBCountry') then
   drop procedure FGetDBCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDBOTDecimal') then
   drop procedure FGetDBOTDecimal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDBPayDecimal') then
   drop procedure FGetDBPayDecimal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDecodeForeignStr') then
   drop procedure FGetDecodeForeignStr
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDecodeLocalStr') then
   drop procedure FGetDecodeLocalStr
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDepartmentAllowanceVarianceCount') then
   drop procedure FGetDepartmentAllowanceVarianceCount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDepartmentDesc') then
   drop procedure FGetDepartmentDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetDosPayslipPeriodMessage') then
   drop procedure FGetDosPayslipPeriodMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEasyToReachContact') then
   drop procedure FGetEasyToReachContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEducationDesc') then
   drop procedure FGetEducationDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEEPropertyAllowanceAmt') then
   drop procedure FGetEEPropertyAllowanceAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEEPropertyShiftAmt') then
   drop procedure FGetEEPropertyShiftAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEETerminationStatus') then
   drop procedure FGetEETerminationStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCode1Desc') then
   drop procedure FGetEmpCode1Desc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCode2Desc') then
   drop procedure FGetEmpCode2Desc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCode3Desc') then
   drop procedure FGetEmpCode3Desc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCode4Desc') then
   drop procedure FGetEmpCode4Desc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCode5Desc') then
   drop procedure FGetEmpCode5Desc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCompleteMailAddress') then
   drop procedure FGetEmpCompleteMailAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCompleteResAddress') then
   drop procedure FGetEmpCompleteResAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpCountOnFund') then
   drop procedure FGetEmpCountOnFund
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpeeCPFAge') then
   drop procedure FGetEmpeeCPFAge
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpeeOtherInfoBooleanInfo') then
   drop procedure FGetEmpeeOtherInfoBooleanInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpeeOtherInfoDateInfo') then
   drop procedure FGetEmpeeOtherInfoDateInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpeeOtherInfoNumericInfo') then
   drop procedure FGetEmpeeOtherInfoNumericInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpeeOtherInfoStringInfo') then
   drop procedure FGetEmpeeOtherInfoStringInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpLocation1Desc') then
   drop procedure FGetEmpLocation1Desc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeAge') then
   drop procedure FGetEmployeeAge
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeBranch') then
   drop procedure FGetEmployeeBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCalendarId') then
   drop procedure FGetEmployeeCalendarId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCareerAttributeValue') then
   drop procedure FGetEmployeeCareerAttributeValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCategory') then
   drop procedure FGetEmployeeCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCessationDate') then
   drop procedure FGetEmployeeCessationDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCompanyName') then
   drop procedure FGetEmployeeCompanyName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeConfirmationDate') then
   drop procedure FGetEmployeeConfirmationDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCostGroup') then
   drop procedure FGetEmployeeCostGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCPFAge') then
   drop procedure FGetEmployeeCPFAge
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCurrentSalaryType') then
   drop procedure FGetEmployeeCurrentSalaryType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCurrentTotalWage') then
   drop procedure FGetEmployeeCurrentTotalWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeDepartment') then
   drop procedure FGetEmployeeDepartment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeHireDate') then
   drop procedure FGetEmployeeHireDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeId') then
   drop procedure FGetEmployeeId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeIdByPersonalSysId') then
   drop procedure FGetEmployeeIdByPersonalSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeIdentityNo') then
   drop procedure FGetEmployeeIdentityNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeKeyCostCentre') then
   drop procedure FGetEmployeeKeyCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeKeyShiftTeam') then
   drop procedure FGetEmployeeKeyShiftTeam
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeLeaveGroup') then
   drop procedure FGetEmployeeLeaveGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeName') then
   drop procedure FGetEmployeeName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeNamebyEmployeeID') then
   drop procedure FGetEmployeeNamebyEmployeeID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeePersonalAddress') then
   drop procedure FGetEmployeePersonalAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeePosition') then
   drop procedure FGetEmployeePosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeePreviousTotalWage') then
   drop procedure FGetEmployeePreviousTotalWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeSection') then
   drop procedure FGetEmployeeSection
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeServiceYear') then
   drop procedure FGetEmployeeServiceYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeSupervisor') then
   drop procedure FGetEmployeeSupervisor
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeSysId') then
   drop procedure FGetEmployeeSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployerRefNo') then
   drop procedure FGetEmployerRefNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpPaymentBankCount') then
   drop procedure FGetEmpPaymentBankCount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmpPositionDescByEmployeeID') then
   drop procedure FGetEmpPositionDescByEmployeeID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEPProgPrevProgDate') then
   drop procedure FGetEPProgPrevProgDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyAddress') then
   drop procedure FGetFamilyAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyAge') then
   drop procedure FGetFamilyAge
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyIdentityNo') then
   drop procedure FGetFamilyIdentityNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyIdentityNoChkMale') then
   drop procedure FGetFamilyIdentityNoChkMale
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyName') then
   drop procedure FGetFamilyName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyNameChkMale') then
   drop procedure FGetFamilyNameChkMale
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetForeignCountry') then
   drop procedure FGetForeignCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetForeignCurrency') then
   drop procedure FGetForeignCurrency
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetForeignNameByEmployeeSysId') then
   drop procedure FGetForeignNameByEmployeeSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetForeignNameByPersonalSysId') then
   drop procedure FGetForeignNameByPersonalSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormDsnApprMatch') then
   drop procedure FGetFormDsnApprMatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaCategory') then
   drop procedure FGetFormulaCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaConstant1') then
   drop procedure FGetFormulaConstant1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaDesc') then
   drop procedure FGetFormulaDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaIDProperty') then
   drop procedure FGetFormulaIDProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaKeyWordUserDefinedName') then
   drop procedure FGetFormulaKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaRange') then
   drop procedure FGetFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaSubCategory') then
   drop procedure FGetFormulaSubCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFormulaType') then
   drop procedure FGetFormulaType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFWLFirstPermitNo') then
   drop procedure FGetFWLFirstPermitNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFWLProgPrevProgDate') then
   drop procedure FGetFWLProgPrevProgDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetGenderDesc') then
   drop procedure FGetGenderDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetGeneratedId') then
   drop procedure FGetGeneratedId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetGLCodeDesc') then
   drop procedure FGetGLCodeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetHighestEduCode') then
   drop procedure FGetHighestEduCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetHolidayDesc') then
   drop procedure FGetHolidayDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetHRKeyWordUserDefinedName') then
   drop procedure FGetHRKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetHRRangeBasisDesc') then
   drop procedure FGetHRRangeBasisDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetIdentityNo') then
   drop procedure FGetIdentityNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetIdentityTypeDesc') then
   drop procedure FGetIdentityTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetInvalidDate') then
   drop procedure FGetInvalidDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetJobHisExperienceYear') then
   drop procedure FGetJobHisExperienceYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetKeyWordUserDefinedName') then
   drop procedure FGetKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLastInitPayPeriod') then
   drop procedure FGetLastInitPayPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLastInitSubPeriodEndDate') then
   drop procedure FGetLastInitSubPeriodEndDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLastPayDate') then
   drop procedure FGetLastPayDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLatestBREffectiveDate') then
   drop procedure FGetLatestBREffectiveDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLatestEPEffectiveDate') then
   drop procedure FGetLatestEPEffectiveDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLatestFWLEffectiveDate') then
   drop procedure FGetLatestFWLEffectiveDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLatestResStatusEffectiveDate') then
   drop procedure FGetLatestResStatusEffectiveDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLeaveCycleCrossCycTaken') then
   drop procedure FGetLeaveCycleCrossCycTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLeaveCycleCrossCycTakenAmt') then
   drop procedure FGetLeaveCycleCrossCycTakenAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLeavePattern') then
   drop procedure FGetLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLeavePeriodToPayPeriod') then
   drop procedure FGetLeavePeriodToPayPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLeaveTypeRoundingMethod') then
   drop procedure FGetLeaveTypeRoundingMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLicenseCount') then
   drop procedure FGetLicenseCount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLicenseCountExceed') then
   drop procedure FGetLicenseCountExceed
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLicenseEmployeeCount') then
   drop procedure FGetLicenseEmployeeCount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLicenseEmployeeCountExceed') then
   drop procedure FGetLicenseEmployeeCountExceed
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLoanBal') then
   drop procedure FGetLoanBal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveAutoOption') then
   drop procedure FGetLveAutoOption
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCosting') then
   drop procedure FGetLveCosting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditBalance') then
   drop procedure FGetLveCreditBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditEarned') then
   drop procedure FGetLveCreditEarned
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditExpired') then
   drop procedure FGetLveCreditExpired
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditFutureBalance') then
   drop procedure FGetLveCreditFutureBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditFutureTaken') then
   drop procedure FGetLveCreditFutureTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditNotEarned') then
   drop procedure FGetLveCreditNotEarned
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditTaken') then
   drop procedure FGetLveCreditTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCrossTaken') then
   drop procedure FGetLveCrossTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveDayRateID') then
   drop procedure FGetLveDayRateID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveEntReportPeriod') then
   drop procedure FGetLveEntReportPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveEntReportYTDBFForfeit') then
   drop procedure FGetLveEntReportYTDBFForfeit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveEntReportYTDDayTaken') then
   drop procedure FGetLveEntReportYTDDayTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveHourRateID') then
   drop procedure FGetLveHourRateID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLvKeyWordUserDefinedName') then
   drop procedure FGetLvKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMaritalStatusDesc') then
   drop procedure FGetMaritalStatusDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMasnetDetailLine') then
   drop procedure FGetMasnetDetailLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMasnetHeaderLine') then
   drop procedure FGetMasnetHeaderLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMasnetNJEHeaderLine') then
   drop procedure FGetMasnetNJEHeaderLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMaxPeriod') then
   drop procedure FGetMaxPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMaxSubPeriodCurrLveEntitlement') then
   drop procedure FGetMaxSubPeriodCurrLveEntitlement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMaxSubPeriodLveBroughtForward') then
   drop procedure FGetMaxSubPeriodLveBroughtForward
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMClaimCycleLimitPerPolicy') then
   drop procedure FGetMClaimCycleLimitPerPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMClaimCycleMedClaimCycleEnd') then
   drop procedure FGetMClaimCycleMedClaimCycleEnd
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMClaimCycleMedClaimCycleStart') then
   drop procedure FGetMClaimCycleMedClaimCycleStart
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMClaimEmployeeLimitPerCycle') then
   drop procedure FGetMClaimEmployeeLimitPerCycle
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMedClaimCycleAccAmt') then
   drop procedure FGetMedClaimCycleAccAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMedClaimPolicyAccAmt') then
   drop procedure FGetMedClaimPolicyAccAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMedClaimPolicyAccNo') then
   drop procedure FGetMedClaimPolicyAccNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMedisaveAmt') then
   drop procedure FGetMedisaveAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMinPeriod') then
   drop procedure FGetMinPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMVCCurrentAccPercent') then
   drop procedure FGetMVCCurrentAccPercent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMVCPrevRate') then
   drop procedure FGetMVCPrevRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNationality') then
   drop procedure FGetNationality
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNearestPeriodForeignLocalRate') then
   drop procedure FGetNearestPeriodForeignLocalRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNetAmt') then
   drop procedure FGetNetAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNewCPFGeneratedIndex') then
   drop procedure FGetNewCPFGeneratedIndex
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNewLeavePattern') then
   drop procedure FGetNewLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNewSGSPEmpNoGeneratedIndex') then
   drop procedure FGetNewSGSPEmpNoGeneratedIndex
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNewSGSPGeneratedIndex') then
   drop procedure FGetNewSGSPGeneratedIndex
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNewWorkPattern') then
   drop procedure FGetNewWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNextExitIntDetSysId') then
   drop procedure FGetNextExitIntDetSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetNWCPrevRate') then
   drop procedure FGetNWCPrevRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetOrganisationName') then
   drop procedure FGetOrganisationName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetOTElementYTD') then
   drop procedure FGetOTElementYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetOTOvertimeAmount') then
   drop procedure FGetOTOvertimeAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetOTTotalWage') then
   drop procedure FGetOTTotalWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetOTType') then
   drop procedure FGetOTType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayAllocationTypeID') then
   drop procedure FGetPayAllocationTypeID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayAllocationValue') then
   drop procedure FGetPayAllocationValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayCategoryID') then
   drop procedure FGetPayCategoryID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayDepartmentID') then
   drop procedure FGetPayDepartmentID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayEmployeeAge') then
   drop procedure FGetPayEmployeeAge
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayGroupID') then
   drop procedure FGetPayGroupID
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayIncrementDesc') then
   drop procedure FGetPayIncrementDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBankInfoBeneficiaryName') then
   drop procedure FGetPaymentBankInfoBeneficiaryName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentMethod') then
   drop procedure FGetPaymentMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank1AccNo') then
   drop procedure FGetPayPeriodBank1AccNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank1Amount') then
   drop procedure FGetPayPeriodBank1Amount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank1Branch') then
   drop procedure FGetPayPeriodBank1Branch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank1Code') then
   drop procedure FGetPayPeriodBank1Code
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank1Name') then
   drop procedure FGetPayPeriodBank1Name
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank1PaymentMode') then
   drop procedure FGetPayPeriodBank1PaymentMode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank2AccNo') then
   drop procedure FGetPayPeriodBank2AccNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank2Amount') then
   drop procedure FGetPayPeriodBank2Amount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank2Branch') then
   drop procedure FGetPayPeriodBank2Branch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank2Code') then
   drop procedure FGetPayPeriodBank2Code
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank2Name') then
   drop procedure FGetPayPeriodBank2Name
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodBank2PaymentMode') then
   drop procedure FGetPayPeriodBank2PaymentMode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodLveAmount') then
   drop procedure FGetPayPeriodLveAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodPayGroupId') then
   drop procedure FGetPayPeriodPayGroupId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodYearToCostPeriodYear') then
   drop procedure FGetPayPeriodYearToCostPeriodYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllAllowance') then
   drop procedure FGetPayRecAllAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllDeduction') then
   drop procedure FGetPayRecAllDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllPayElement') then
   drop procedure FGetPayRecAllPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllReimbursement') then
   drop procedure FGetPayRecAllReimbursement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllStatutoryDeduction') then
   drop procedure FGetPayRecAllStatutoryDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllUserDefinedAllowance') then
   drop procedure FGetPayRecAllUserDefinedAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllUserDefinedDeduction') then
   drop procedure FGetPayRecAllUserDefinedDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllUserDefinedReimbursement') then
   drop procedure FGetPayRecAllUserDefinedReimbursement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecBackPayOT') then
   drop procedure FGetPayRecBackPayOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecCPFAllowance') then
   drop procedure FGetPayRecCPFAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecCPFAmountYTD') then
   drop procedure FGetPayRecCPFAmountYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecCPFDeduction') then
   drop procedure FGetPayRecCPFDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecCPFUserDefinedAllowance') then
   drop procedure FGetPayRecCPFUserDefinedAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecCPFUserDefinedDeduction') then
   drop procedure FGetPayRecCPFUserDefinedDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecCPFWageYTD') then
   drop procedure FGetPayRecCPFWageYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecGrossWageYTD') then
   drop procedure FGetPayRecGrossWageYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecLeaveBalance') then
   drop procedure FGetPayRecLeaveBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecLveDedYTDDayTaken') then
   drop procedure FGetPayRecLveDedYTDDayTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecLveDedYTDHoursTaken') then
   drop procedure FGetPayRecLveDedYTDHoursTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecNetWageYTD') then
   drop procedure FGetPayRecNetWageYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecNonCPFAllowance') then
   drop procedure FGetPayRecNonCPFAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecNonCPFDeduction') then
   drop procedure FGetPayRecNonCPFDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecNonCPFUserDefinedAllowance') then
   drop procedure FGetPayRecNonCPFUserDefinedAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecNonCPFUserDefinedDeduction') then
   drop procedure FGetPayRecNonCPFUserDefinedDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecPayGroup') then
   drop procedure FGetPayRecPayGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecTotalGrossWageYTD') then
   drop procedure FGetPayRecTotalGrossWageYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecTotalOT') then
   drop procedure FGetPayRecTotalOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecType') then
   drop procedure FGetPayRecType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecYTDLeaveTaken') then
   drop procedure FGetPayRecYTDLeaveTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecYTDTaken') then
   drop procedure FGetPayRecYTDTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayrollPeriodGivenPhyYrMth') then
   drop procedure FGetPayrollPeriodGivenPhyYrMth
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayrollYearGivenPhyYrMth') then
   drop procedure FGetPayrollYearGivenPhyYrMth
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayServiceYear') then
   drop procedure FGetPayServiceYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeAllAllowance') then
   drop procedure FGetPayTypeAllAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeAllDeduction') then
   drop procedure FGetPayTypeAllDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeAllReimbursement') then
   drop procedure FGetPayTypeAllReimbursement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank1AccNo') then
   drop procedure FGetPayTypeBank1AccNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank1Amount') then
   drop procedure FGetPayTypeBank1Amount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank1Branch') then
   drop procedure FGetPayTypeBank1Branch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank1Code') then
   drop procedure FGetPayTypeBank1Code
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank1Name') then
   drop procedure FGetPayTypeBank1Name
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank1PaymentMode') then
   drop procedure FGetPayTypeBank1PaymentMode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank2AccNo') then
   drop procedure FGetPayTypeBank2AccNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank2Amount') then
   drop procedure FGetPayTypeBank2Amount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank2Branch') then
   drop procedure FGetPayTypeBank2Branch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank2Code') then
   drop procedure FGetPayTypeBank2Code
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank2Name') then
   drop procedure FGetPayTypeBank2Name
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeBank2PaymentMode') then
   drop procedure FGetPayTypeBank2PaymentMode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAbsentTaken') then
   drop procedure FGetPeriodAbsentTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAllowance') then
   drop procedure FGetPeriodAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAllowanceElement') then
   drop procedure FGetPeriodAllowanceElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAnnualLeaveBalance') then
   drop procedure FGetPeriodAnnualLeaveBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAnnualLeaveEntitle') then
   drop procedure FGetPeriodAnnualLeaveEntitle
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAnnualLeaveTaken') then
   drop procedure FGetPeriodAnnualLeaveTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAnnualLeaveYTD') then
   drop procedure FGetPeriodAnnualLeaveYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodBackPay') then
   drop procedure FGetPeriodBackPay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodBasicRate') then
   drop procedure FGetPeriodBasicRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodBasisValue') then
   drop procedure FGetPeriodBasisValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodBonus') then
   drop procedure FGetPeriodBonus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodCategory') then
   drop procedure FGetPeriodCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodCPFWage') then
   drop procedure FGetPeriodCPFWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodCurBasicRateType') then
   drop procedure FGetPeriodCurBasicRateType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodCurrentHrDays') then
   drop procedure FGetPeriodCurrentHrDays
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodDeduction') then
   drop procedure FGetPeriodDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodDepartment') then
   drop procedure FGetPeriodDepartment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodEECount') then
   drop procedure FGetPeriodEECount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodEECPF') then
   drop procedure FGetPeriodEECPF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodEmployeeStatus') then
   drop procedure FGetPeriodEmployeeStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodEndDate') then
   drop procedure FGetPeriodEndDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodERCPF') then
   drop procedure FGetPeriodERCPF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodFund') then
   drop procedure FGetPeriodFund
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodFWL') then
   drop procedure FGetPeriodFWL
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodGrossWage') then
   drop procedure FGetPeriodGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodLateHours') then
   drop procedure FGetPeriodLateHours
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodLongMessage') then
   drop procedure FGetPeriodLongMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodLveDeductAmt') then
   drop procedure FGetPeriodLveDeductAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodMonth') then
   drop procedure FGetPeriodMonth
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodMonthWord') then
   drop procedure FGetPeriodMonthWord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodMVC') then
   drop procedure FGetPeriodMVC
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNetWage') then
   drop procedure FGetPeriodNetWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNPLDaysTaken') then
   drop procedure FGetPeriodNPLDaysTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNPLDaysYTD') then
   drop procedure FGetPeriodNPLDaysYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNPLHoursTaken') then
   drop procedure FGetPeriodNPLHoursTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNPLHoursYTD') then
   drop procedure FGetPeriodNPLHoursYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNPLTaken') then
   drop procedure FGetPeriodNPLTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodNWC') then
   drop procedure FGetPeriodNWC
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodOTAmount') then
   drop procedure FGetPeriodOTAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodOTBackPay') then
   drop procedure FGetPeriodOTBackPay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodOTElement') then
   drop procedure FGetPeriodOTElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPayrollMth') then
   drop procedure FGetPeriodPayrollMth
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPayrollMthName') then
   drop procedure FGetPeriodPayrollMthName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPayTypeAllAllowance') then
   drop procedure FGetPeriodPayTypeAllAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPayTypeAllDeduction') then
   drop procedure FGetPeriodPayTypeAllDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPayTypeAllReimbursement') then
   drop procedure FGetPeriodPayTypeAllReimbursement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPreviousHrDays') then
   drop procedure FGetPeriodPreviousHrDays
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodReimbursement') then
   drop procedure FGetPeriodReimbursement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodSDF') then
   drop procedure FGetPeriodSDF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodShiftAmount') then
   drop procedure FGetPeriodShiftAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodShiftElement') then
   drop procedure FGetPeriodShiftElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodShortMessage') then
   drop procedure FGetPeriodShortMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodSickLeaveBalance') then
   drop procedure FGetPeriodSickLeaveBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodSickLeaveEntitle') then
   drop procedure FGetPeriodSickLeaveEntitle
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodSickLeaveTaken') then
   drop procedure FGetPeriodSickLeaveTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodSickLeaveYTD') then
   drop procedure FGetPeriodSickLeaveYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodStartDate') then
   drop procedure FGetPeriodStartDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTaxBenefit') then
   drop procedure FGetPeriodTaxBenefit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodToMonthYear') then
   drop procedure FGetPeriodToMonthYear
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTotalCPF') then
   drop procedure FGetPeriodTotalCPF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTotalGrossWage') then
   drop procedure FGetPeriodTotalGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTotalWage') then
   drop procedure FGetPeriodTotalWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodYTDTaken') then
   drop procedure FGetPeriodYTDTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddPCode') then
   drop procedure FGetPersonalAddPCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddress1') then
   drop procedure FGetPersonalAddress1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddress2') then
   drop procedure FGetPersonalAddress2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddress3') then
   drop procedure FGetPersonalAddress3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalBirthDate') then
   drop procedure FGetPersonalBirthDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalContactNumber') then
   drop procedure FGetPersonalContactNumber
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalGender') then
   drop procedure FGetPersonalGender
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalIdentityNo') then
   drop procedure FGetPersonalIdentityNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalIdentityTypeId') then
   drop procedure FGetPersonalIdentityTypeId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalMaritalStatus') then
   drop procedure FGetPersonalMaritalStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalName') then
   drop procedure FGetPersonalName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalSysId') then
   drop procedure FGetPersonalSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalSysIdByEmployeeSysId') then
   drop procedure FGetPersonalSysIdByEmployeeSysId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalTypeDesc') then
   drop procedure FGetPersonalTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalTypeId') then
   drop procedure FGetPersonalTypeId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPhyMonthGivenPayYrPeriod') then
   drop procedure FGetPhyMonthGivenPayYrPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPhyYearGivenPayYrPeriod') then
   drop procedure FGetPhyYearGivenPayYrPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPositionDesc') then
   drop procedure FGetPositionDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPosSameCodeAllowanceAmount') then
   drop procedure FGetPosSameCodeAllowanceAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRaceDesc') then
   drop procedure FGetRaceDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRangeBasisDesc') then
   drop procedure FGetRangeBasisDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRecentEmployeeId') then
   drop procedure FGetRecentEmployeeId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRecurBalanceAmount') then
   drop procedure FGetRecurBalanceAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRecurBalanceCounter') then
   drop procedure FGetRecurBalanceCounter
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRecurKeyWordUserDefinedName') then
   drop procedure FGetRecurKeyWordUserDefinedName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetReligionDesc') then
   drop procedure FGetReligionDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetResidenceTypeDesc') then
   drop procedure FGetResidenceTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetResidentialPhone') then
   drop procedure FGetResidentialPhone
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRetirementDue') then
   drop procedure FGetRetirementDue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSalaryGradeDesc') then
   drop procedure FGetSalaryGradeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSameCodeAllowanceAmount') then
   drop procedure FGetSameCodeAllowanceAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSecSameCodeAllowanceAmount') then
   drop procedure FGetSecSameCodeAllowanceAmount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSectionDesc') then
   drop procedure FGetSectionDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetServiceYearDate') then
   drop procedure FGetServiceYearDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetShiftElementYTD') then
   drop procedure FGetShiftElementYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStateName') then
   drop procedure FGetStateName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticAbsentTakenElement') then
   drop procedure FGetStatisticAbsentTakenElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticAllowanceRecordDetails') then
   drop procedure FGetStatisticAllowanceRecordDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticAnnualLeaveElement') then
   drop procedure FGetStatisticAnnualLeaveElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticBackPayElement') then
   drop procedure FGetStatisticBackPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticCPFWageElement') then
   drop procedure FGetStatisticCPFWageElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticDescriptionLine') then
   drop procedure FGetStatisticDescriptionLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticEECPFElement') then
   drop procedure FGetStatisticEECPFElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticEmployeeCountElement') then
   drop procedure FGetStatisticEmployeeCountElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticERCPFElement') then
   drop procedure FGetStatisticERCPFElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticGrossWageElement') then
   drop procedure FGetStatisticGrossWageElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticLateHoursElement') then
   drop procedure FGetStatisticLateHoursElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticLveDeductElement') then
   drop procedure FGetStatisticLveDeductElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticNetWageElement') then
   drop procedure FGetStatisticNetWageElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticNPLDaysElement') then
   drop procedure FGetStatisticNPLDaysElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticNPLHoursElement') then
   drop procedure FGetStatisticNPLHoursElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticOTRecordDetails') then
   drop procedure FGetStatisticOTRecordDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticPeriodAllowanceElement') then
   drop procedure FGetStatisticPeriodAllowanceElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticPeriodOTElement') then
   drop procedure FGetStatisticPeriodOTElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticPeriodShiftElement') then
   drop procedure FGetStatisticPeriodShiftElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticPeriodShiftFreqElement') then
   drop procedure FGetStatisticPeriodShiftFreqElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticSDFElement') then
   drop procedure FGetStatisticSDFElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticSeparatorLine') then
   drop procedure FGetStatisticSeparatorLine
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticShiftRecordDetails') then
   drop procedure FGetStatisticShiftRecordDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticSickLeaveElement') then
   drop procedure FGetStatisticSickLeaveElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticTotalCPFElement') then
   drop procedure FGetStatisticTotalCPFElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticTotalGrossWageElement') then
   drop procedure FGetStatisticTotalGrossWageElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticTotalOTBackPayElement') then
   drop procedure FGetStatisticTotalOTBackPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticTotalOTElement') then
   drop procedure FGetStatisticTotalOTElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetStatisticTotalWageElement') then
   drop procedure FGetStatisticTotalWageElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSubPeriodEndDate') then
   drop procedure FGetSubPeriodEndDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSubPeriodLongMessage') then
   drop procedure FGetSubPeriodLongMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSubPeriodShortMessage') then
   drop procedure FGetSubPeriodShortMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSubPeriodStartDate') then
   drop procedure FGetSubPeriodStartDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSumPaidPremium') then
   drop procedure FGetSumPaidPremium
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetSystemColumnType') then
   drop procedure FGetSystemColumnType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTitleCodeDesc') then
   drop procedure FGetTitleCodeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTotalOT') then
   drop procedure FGetTotalOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTrainForClaimByCostType') then
   drop procedure FGetTrainForClaimByCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetUpdatedExchangeRate') then
   drop procedure FGetUpdatedExchangeRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVenueDesc') then
   drop procedure FGetVenueDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPeriodAdj') then
   drop procedure FGetVnERSubmitPeriodAdj
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPeriodKeptByCompany') then
   drop procedure FGetVnERSubmitPeriodKeptByCompany
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPeriodPayment') then
   drop procedure FGetVnERSubmitPeriodPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPeriodPenalty') then
   drop procedure FGetVnERSubmitPeriodPenalty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPeriodRemainingAmt') then
   drop procedure FGetVnERSubmitPeriodRemainingAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPeriodTotalDue') then
   drop procedure FGetVnERSubmitPeriodTotalDue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPrevAdj') then
   drop procedure FGetVnERSubmitPrevAdj
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPrevDue') then
   drop procedure FGetVnERSubmitPrevDue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPrevKeptByCompany') then
   drop procedure FGetVnERSubmitPrevKeptByCompany
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPrevPaid') then
   drop procedure FGetVnERSubmitPrevPaid
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPrevPenalty') then
   drop procedure FGetVnERSubmitPrevPenalty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnERSubmitPrevRemainingAmt') then
   drop procedure FGetVnERSubmitPrevRemainingAmt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnTaxProgSysIdAtDate') then
   drop procedure FGetVnTaxProgSysIdAtDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetVnTaxReport10Column4') then
   drop procedure FGetVnTaxReport10Column4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWageElementTotal') then
   drop procedure FGetWageElementTotal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWeekLeavePattern') then
   drop procedure FGetWeekLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWeekPatternDayDesc') then
   drop procedure FGetWeekPatternDayDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWeekWorkPattern') then
   drop procedure FGetWeekWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWorkPattern') then
   drop procedure FGetWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWorkTimeEndTime') then
   drop procedure FGetWorkTimeEndTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetWorkTimeStartTime') then
   drop procedure FGetWorkTimeStartTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYearsDiff') then
   drop procedure FGetYearsDiff
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYesNoDesc') then
   drop procedure FGetYesNoDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYTDLeaveDeductionDaysFreq') then
   drop procedure FGetYTDLeaveDeductionDaysFreq
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYTDLeaveDeductionHoursFreq') then
   drop procedure FGetYTDLeaveDeductionHoursFreq
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYTDLeaveInfoDaysFreq') then
   drop procedure FGetYTDLeaveInfoDaysFreq
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYTDPayment') then
   drop procedure FGetYTDPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FRemoveDecimal') then
   drop procedure FRemoveDecimal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FRoundHalf') then
   drop procedure FRoundHalf
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FRoundQuarter') then
   drop procedure FRoundQuarter
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FSearchEmployeeId') then
   drop procedure FSearchEmployeeId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FSearchEmployeeSysIdHired') then
   drop procedure FSearchEmployeeSysIdHired
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FSetBlank') then
   drop procedure FSetBlank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FSetNewSGSPGeneratedIndex') then
   drop procedure FSetNewSGSPGeneratedIndex
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FStringWrap') then
   drop procedure FStringWrap
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FUpdatePaymentBankBalance') then
   drop procedure FUpdatePaymentBankBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GenAccrNoOfChild') then
   drop procedure GenAccrNoOfChild
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GenAccrYTD') then
   drop procedure GenAccrYTD
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GenYearFromHireDate') then
   drop procedure GenYearFromHireDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeBloodGroupId') then
   drop procedure GlbChangeBloodGroupId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeBranchCode') then
   drop procedure GlbChangeBranchCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeCategoryId') then
   drop procedure GlbChangeCategoryId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeCessationCode') then
   drop procedure GlbChangeCessationCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeCessationDate') then
   drop procedure GlbChangeCessationDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeClassification') then
   drop procedure GlbChangeClassification
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeConfirmationDate') then
   drop procedure GlbChangeConfirmationDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeCountryOfBirth') then
   drop procedure GlbChangeCountryOfBirth
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeDepartmentId') then
   drop procedure GlbChangeDepartmentId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEducationId') then
   drop procedure GlbChangeEducationId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpCode1Id') then
   drop procedure GlbChangeEmpCode1Id
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpCode2Id') then
   drop procedure GlbChangeEmpCode2Id
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpCode3Id') then
   drop procedure GlbChangeEmpCode3Id
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpCode4Id') then
   drop procedure GlbChangeEmpCode4Id
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpCode5Id') then
   drop procedure GlbChangeEmpCode5Id
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpLocation1Id') then
   drop procedure GlbChangeEmpLocation1Id
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmploymentStatusId') then
   drop procedure GlbChangeEmploymentStatusId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeEmpRetirementAge') then
   drop procedure GlbChangeEmpRetirementAge
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeHireDate') then
   drop procedure GlbChangeHireDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeIdentityTypeId') then
   drop procedure GlbChangeIdentityTypeId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeIsSupervisor') then
   drop procedure GlbChangeIsSupervisor
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeMaritalStatusCode') then
   drop procedure GlbChangeMaritalStatusCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeNationality') then
   drop procedure GlbChangeNationality
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangePositionCode') then
   drop procedure GlbChangePositionCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeProbationPeriod') then
   drop procedure GlbChangeProbationPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeProbationUnit') then
   drop procedure GlbChangeProbationUnit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeRaceId') then
   drop procedure GlbChangeRaceId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeReligionId') then
   drop procedure GlbChangeReligionId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeRetirementDate') then
   drop procedure GlbChangeRetirementDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeSalaryGrade') then
   drop procedure GlbChangeSalaryGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeSectionId') then
   drop procedure GlbChangeSectionId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeSupervisor') then
   drop procedure GlbChangeSupervisor
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'GlbChangeTitleId') then
   drop procedure GlbChangeTitleId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrGWItem') then
   drop procedure InsertNewAccrGWItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrItemBasis') then
   drop procedure InsertNewAccrItemBasis
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualEligible') then
   drop procedure InsertNewAccrualEligible
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualField') then
   drop procedure InsertNewAccrualField
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualGrossWage') then
   drop procedure InsertNewAccrualGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualGroup') then
   drop procedure InsertNewAccrualGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualItem') then
   drop procedure InsertNewAccrualItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualMethod') then
   drop procedure InsertNewAccrualMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAccrualPeriodSetup') then
   drop procedure InsertNewAccrualPeriodSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewActionTaken') then
   drop procedure InsertNewActionTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAdHocQueryFields') then
   drop procedure InsertNewAdHocQueryFields
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAdHocQueryRec') then
   drop procedure InsertNewAdHocQueryRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAdjustCredit') then
   drop procedure InsertNewAdjustCredit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAdvanceProcess') then
   drop procedure InsertNewAdvanceProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAdvanceReport') then
   drop procedure InsertNewAdvanceReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAlertGroup') then
   drop procedure InsertNewAlertGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAlertGroupItem') then
   drop procedure InsertNewAlertGroupItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAlertGroupItemAttach') then
   drop procedure InsertNewAlertGroupItemAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAlertItemAssignMsg') then
   drop procedure InsertNewAlertItemAssignMsg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAlertRole') then
   drop procedure InsertNewAlertRole
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAllowanceHistoryRecord') then
   drop procedure InsertNewAllowanceHistoryRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAllowanceRecord') then
   drop procedure InsertNewAllowanceRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnalyser') then
   drop procedure InsertNewAnalyser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnlysBasisPolicy') then
   drop procedure InsertNewAnlysBasisPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnlysDispSection') then
   drop procedure InsertNewAnlysDispSection
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnlysItemSetup') then
   drop procedure InsertNewAnlysItemSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnlysPolicyRange') then
   drop procedure InsertNewAnlysPolicyRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnlysProject') then
   drop procedure InsertNewAnlysProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAnlysSetup') then
   drop procedure InsertNewAnlysSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewApplicant') then
   drop procedure InsertNewApplicant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewApplicantAttach') then
   drop procedure InsertNewApplicantAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAppraisal') then
   drop procedure InsertNewAppraisal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAppraisalDetail') then
   drop procedure InsertNewAppraisalDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAppraisalGrade') then
   drop procedure InsertNewAppraisalGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAppraisalHistory') then
   drop procedure InsertNewAppraisalHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAppraisalType') then
   drop procedure InsertNewAppraisalType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewApprCategory') then
   drop procedure InsertNewApprCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewApprPtSystem') then
   drop procedure InsertNewApprPtSystem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewApprTemplate') then
   drop procedure InsertNewApprTemplate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewApprTraining') then
   drop procedure InsertNewApprTraining
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAreaSpecialised') then
   drop procedure InsertNewAreaSpecialised
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAutoGenerationKey') then
   drop procedure InsertNewAutoGenerationKey
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAwardCode') then
   drop procedure InsertNewAwardCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAwardDisc') then
   drop procedure InsertNewAwardDisc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewAwardDiscAttach') then
   drop procedure InsertNewAwardDiscAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBalancePayElement') then
   drop procedure InsertNewBalancePayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBank') then
   drop procedure InsertNewBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankAccountType') then
   drop procedure InsertNewBankAccountType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankAccType') then
   drop procedure InsertNewBankAccType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankAllocGroup') then
   drop procedure InsertNewBankAllocGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankBranch') then
   drop procedure InsertNewBankBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankDiskRecord') then
   drop procedure InsertNewBankDiskRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankFilter') then
   drop procedure InsertNewBankFilter
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankRecord') then
   drop procedure InsertNewBankRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBankSubmitCompanyBank') then
   drop procedure InsertNewBankSubmitCompanyBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBasicRateProgression') then
   drop procedure InsertNewBasicRateProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBatchRpt') then
   drop procedure InsertNewBatchRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBatchRptItem') then
   drop procedure InsertNewBatchRptItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBenefitDetails') then
   drop procedure InsertNewBenefitDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBloodGroup') then
   drop procedure InsertNewBloodGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBond') then
   drop procedure InsertNewBond
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBondAttachment') then
   drop procedure InsertNewBondAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBonusProcess') then
   drop procedure InsertNewBonusProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBonusRecord') then
   drop procedure InsertNewBonusRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBonusReport') then
   drop procedure InsertNewBonusReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBranchGov') then
   drop procedure InsertNewBranchGov
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewBranchGovByComBranch') then
   drop procedure InsertNewBranchGovByComBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCalendar') then
   drop procedure InsertNewCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCareer') then
   drop procedure InsertNewCareer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCareerAttribute') then
   drop procedure InsertNewCareerAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCareerProgression') then
   drop procedure InsertNewCareerProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCategory') then
   drop procedure InsertNewCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCCCode1') then
   drop procedure InsertNewCCCode1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCCCode2') then
   drop procedure InsertNewCCCode2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCCCode3') then
   drop procedure InsertNewCCCode3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCCCode4') then
   drop procedure InsertNewCCCode4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCCCode5') then
   drop procedure InsertNewCCCode5
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCessation') then
   drop procedure InsertNewCessation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCity') then
   drop procedure InsertNewCity
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewClassification') then
   drop procedure InsertNewClassification
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewColourScheme') then
   drop procedure InsertNewColourScheme
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewComBank') then
   drop procedure InsertNewComBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCompany') then
   drop procedure InsertNewCompany
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCompanyBranch') then
   drop procedure InsertNewCompanyBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCompanyGovt') then
   drop procedure InsertNewCompanyGovt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCompanyGovType') then
   drop procedure InsertNewCompanyGovType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCompanyType') then
   drop procedure InsertNewCompanyType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCompetency') then
   drop procedure InsertNewCompetency
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewContactLoc') then
   drop procedure InsertNewContactLoc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewContractCategory') then
   drop procedure InsertNewContractCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewContractProgression') then
   drop procedure InsertNewContractProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostAccount') then
   drop procedure InsertNewCostAccount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostCentre') then
   drop procedure InsertNewCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostComponent') then
   drop procedure InsertNewCostComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostCond') then
   drop procedure InsertNewCostCond
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostCreditDebit') then
   drop procedure InsertNewCostCreditDebit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostGroup') then
   drop procedure InsertNewCostGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostGroupPeriod') then
   drop procedure InsertNewCostGroupPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostingDetails') then
   drop procedure InsertNewCostingDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostingMethod') then
   drop procedure InsertNewCostingMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostItem') then
   drop procedure InsertNewCostItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostPeriod') then
   drop procedure InsertNewCostPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostPeriodCostCentre') then
   drop procedure InsertNewCostPeriodCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostPeriodHistory') then
   drop procedure InsertNewCostPeriodHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostProgression') then
   drop procedure InsertNewCostProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostRecord') then
   drop procedure InsertNewCostRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostSubPeriod') then
   drop procedure InsertNewCostSubPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCostTimeSheetRecord') then
   drop procedure InsertNewCostTimeSheetRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCountry') then
   drop procedure InsertNewCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourse') then
   drop procedure InsertNewCourse
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseAttachment') then
   drop procedure InsertNewCourseAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseCategory') then
   drop procedure InsertNewCourseCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseContact') then
   drop procedure InsertNewCourseContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseFamily') then
   drop procedure InsertNewCourseFamily
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseGrade') then
   drop procedure InsertNewCourseGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseRole') then
   drop procedure InsertNewCourseRole
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseSchedule') then
   drop procedure InsertNewCourseSchedule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCourseSkillType') then
   drop procedure InsertNewCourseSkillType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFAgeGroup') then
   drop procedure InsertNewCPFAgeGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFGovernmentProgression') then
   drop procedure InsertNewCPFGovernmentProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFPayment') then
   drop procedure InsertNewCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFPolicy') then
   drop procedure InsertNewCPFPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFPolicyMember') then
   drop procedure InsertNewCPFPolicyMember
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFProgression') then
   drop procedure InsertNewCPFProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFSalaryGroup') then
   drop procedure InsertNewCPFSalaryGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFTableCode') then
   drop procedure InsertNewCPFTableCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCPFTableComponent') then
   drop procedure InsertNewCPFTableComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomAttribute') then
   drop procedure InsertNewCustomAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomIntConfig') then
   drop procedure InsertNewCustomIntConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomIntConfigItem') then
   drop procedure InsertNewCustomIntConfigItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomQuery') then
   drop procedure InsertNewCustomQuery
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomRelation') then
   drop procedure InsertNewCustomRelation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomSearch') then
   drop procedure InsertNewCustomSearch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomTable') then
   drop procedure InsertNewCustomTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomVariables') then
   drop procedure InsertNewCustomVariables
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDefaultCPFPayment') then
   drop procedure InsertNewDefaultCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDefaultPayAllocation') then
   drop procedure InsertNewDefaultPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDepartment') then
   drop procedure InsertNewDepartment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDetailRecord') then
   drop procedure InsertNewDetailRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEduAttachment') then
   drop procedure InsertNewEduAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEducation') then
   drop procedure InsertNewEducation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEducationRec') then
   drop procedure InsertNewEducationRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpCode1') then
   drop procedure InsertNewEmpCode1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpCode2') then
   drop procedure InsertNewEmpCode2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpCode3') then
   drop procedure InsertNewEmpCode3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpCode4') then
   drop procedure InsertNewEmpCode4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpCode5') then
   drop procedure InsertNewEmpCode5
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpColItem') then
   drop procedure InsertNewEmpColItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpeeOtherInfo') then
   drop procedure InsertNewEmpeeOtherInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpeeWkCalen') then
   drop procedure InsertNewEmpeeWkCalen
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpGrpItem') then
   drop procedure InsertNewEmpGrpItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpLocation1') then
   drop procedure InsertNewEmpLocation1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmployeeRecord') then
   drop procedure InsertNewEmployeeRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmployeeRpt') then
   drop procedure InsertNewEmployeeRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmploymentStatus') then
   drop procedure InsertNewEmploymentStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmploymentType') then
   drop procedure InsertNewEmploymentType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmployPassProgression') then
   drop procedure InsertNewEmployPassProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpRecurAllow') then
   drop procedure InsertNewEmpRecurAllow
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEmpSortItem') then
   drop procedure InsertNewEmpSortItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewExcelSpreadsheet') then
   drop procedure InsertNewExcelSpreadsheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewExcelWkSheet') then
   drop procedure InsertNewExcelWkSheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewExcelWkSheetItem') then
   drop procedure InsertNewExcelWkSheetItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewExchangeRate') then
   drop procedure InsertNewExchangeRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewExitIntAttach') then
   drop procedure InsertNewExitIntAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewExitInterview') then
   drop procedure InsertNewExitInterview
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFamily') then
   drop procedure InsertNewFamily
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFamilyAttachment') then
   drop procedure InsertNewFamilyAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFamilyEduRec') then
   drop procedure InsertNewFamilyEduRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFieldMajor') then
   drop procedure InsertNewFieldMajor
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFieldSecurityNoAccess') then
   drop procedure InsertNewFieldSecurityNoAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFinanceColItem') then
   drop procedure InsertNewFinanceColItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFinanceGrpItem') then
   drop procedure InsertNewFinanceGrpItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFinanceRowItem') then
   drop procedure InsertNewFinanceRowItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFinanceSortItem') then
   drop procedure InsertNewFinanceSortItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFinancialRpt') then
   drop procedure InsertNewFinancialRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFinColAccumulated') then
   drop procedure InsertNewFinColAccumulated
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewForeignWorkerRecord') then
   drop procedure InsertNewForeignWorkerRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewForeignWorkerType') then
   drop procedure InsertNewForeignWorkerType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewForm') then
   drop procedure InsertNewForm
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFormControlProperty') then
   drop procedure InsertNewFormControlProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFormPoint') then
   drop procedure InsertNewFormPoint
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFormula') then
   drop procedure InsertNewFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFormulaProperty') then
   drop procedure InsertNewFormulaProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFormulaRange') then
   drop procedure InsertNewFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewFWLProgression') then
   drop procedure InsertNewFWLProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGLCode') then
   drop procedure InsertNewGLCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGovContribType') then
   drop procedure InsertNewGovContribType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGovernmentGrant') then
   drop procedure InsertNewGovernmentGrant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGrade') then
   drop procedure InsertNewGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGroupLvePattern') then
   drop procedure InsertNewGroupLvePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGroupWeekPattern') then
   drop procedure InsertNewGroupWeekPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewGroupWorkPattern') then
   drop procedure InsertNewGroupWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHIProgression') then
   drop procedure InsertNewHIProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHoliday') then
   drop procedure InsertNewHoliday
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRFormula') then
   drop procedure InsertNewHRFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRFormulaRange') then
   drop procedure InsertNewHRFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRKeyword') then
   drop procedure InsertNewHRKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRProject') then
   drop procedure InsertNewHRProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRProjectAttach') then
   drop procedure InsertNewHRProjectAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRProjectWorker') then
   drop procedure InsertNewHRProjectWorker
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRTestAttach') then
   drop procedure InsertNewHRTestAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewHRTestRecord') then
   drop procedure InsertNewHRTestRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewIdentityType') then
   drop procedure InsertNewIdentityType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewIllness') then
   drop procedure InsertNewIllness
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurance') then
   drop procedure InsertNewInsurance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsuranceAttach') then
   drop procedure InsertNewInsuranceAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurBenefit') then
   drop procedure InsertNewInsurBenefit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurFamilyAdd') then
   drop procedure InsertNewInsurFamilyAdd
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurGroup') then
   drop procedure InsertNewInsurGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurPlan') then
   drop procedure InsertNewInsurPlan
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurPolicy') then
   drop procedure InsertNewInsurPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurProg') then
   drop procedure InsertNewInsurProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInsurProgDetails') then
   drop procedure InsertNewInsurProgDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterfaceAttribute') then
   drop procedure InsertNewInterfaceAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterfaceCodeMapping') then
   drop procedure InsertNewInterfaceCodeMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterfaceCodeTable') then
   drop procedure InsertNewInterfaceCodeTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterfaceProcess') then
   drop procedure InsertNewInterfaceProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterfaceProject') then
   drop procedure InsertNewInterfaceProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterviewer') then
   drop procedure InsertNewInterviewer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewInterviewSchedule') then
   drop procedure InsertNewInterviewSchedule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItem') then
   drop procedure InsertNewItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemAssignItem') then
   drop procedure InsertNewItemAssignItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemAttrName') then
   drop procedure InsertNewItemAttrName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemAttrValue') then
   drop procedure InsertNewItemAttrValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemBAssgn') then
   drop procedure InsertNewItemBAssgn
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemBatch') then
   drop procedure InsertNewItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewItemType') then
   drop procedure InsertNewItemType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewJobAdAttach') then
   drop procedure InsertNewJobAdAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewJobCode') then
   drop procedure InsertNewJobCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewJobGrade') then
   drop procedure InsertNewJobGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewJobHistory') then
   drop procedure InsertNewJobHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewJobOpenTo') then
   drop procedure InsertNewJobOpenTo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewJobResponsibility') then
   drop procedure InsertNewJobResponsibility
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewKeyWord') then
   drop procedure InsertNewKeyWord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLanguage') then
   drop procedure InsertNewLanguage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveAllocation') then
   drop procedure InsertNewLeaveAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveAllocationGroup') then
   drop procedure InsertNewLeaveAllocationGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveAllocationGroupType') then
   drop procedure InsertNewLeaveAllocationGroupType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveApplication') then
   drop procedure InsertNewLeaveApplication
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveComputation') then
   drop procedure InsertNewLeaveComputation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveCutOffDate') then
   drop procedure InsertNewLeaveCutOffDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveCycleRpt') then
   drop procedure InsertNewLeaveCycleRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveDeductionRecord') then
   drop procedure InsertNewLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveEmployee') then
   drop procedure InsertNewLeaveEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveFormula') then
   drop procedure InsertNewLeaveFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveGroup') then
   drop procedure InsertNewLeaveGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveGroupCalendar') then
   drop procedure InsertNewLeaveGroupCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveInfoRecord') then
   drop procedure InsertNewLeaveInfoRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveInitialisedGroup') then
   drop procedure InsertNewLeaveInitialisedGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveKeyword') then
   drop procedure InsertNewLeaveKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeavePolicy') then
   drop procedure InsertNewLeavePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeavePolicyRecord') then
   drop procedure InsertNewLeavePolicyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveRange') then
   drop procedure InsertNewLeaveRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveReason') then
   drop procedure InsertNewLeaveReason
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveRecord') then
   drop procedure InsertNewLeaveRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveType') then
   drop procedure InsertNewLeaveType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLicenseRecord') then
   drop procedure InsertNewLicenseRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLoanEmployee') then
   drop procedure InsertNewLoanEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLoanFrom') then
   drop procedure InsertNewLoanFrom
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLoginRec') then
   drop procedure InsertNewLoginRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLveAllocation') then
   drop procedure InsertNewLveAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLveAllocationRec') then
   drop procedure InsertNewLveAllocationRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLveAllocFormulaRec') then
   drop procedure InsertNewLveAllocFormulaRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLvePeriodBalance') then
   drop procedure InsertNewLvePeriodBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLvePeriodBalRpt') then
   drop procedure InsertNewLvePeriodBalRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLvePeriodBF') then
   drop procedure InsertNewLvePeriodBF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLvePeriodSummary') then
   drop procedure InsertNewLvePeriodSummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLvePolicyProg') then
   drop procedure InsertNewLvePolicyProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLvePolicySummary') then
   drop procedure InsertNewLvePolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMandatoryContributeProg') then
   drop procedure InsertNewMandatoryContributeProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapCostCentre') then
   drop procedure InsertNewMapCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapDonation') then
   drop procedure InsertNewMapDonation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapGovtProg') then
   drop procedure InsertNewMapGovtProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapItemBatch') then
   drop procedure InsertNewMapItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapMClaimPolicy') then
   drop procedure InsertNewMapMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapOT') then
   drop procedure InsertNewMapOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapRPayElement') then
   drop procedure InsertNewMapRPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMapShift') then
   drop procedure InsertNewMapShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMaritalStatus') then
   drop procedure InsertNewMaritalStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMClaimAttachment') then
   drop procedure InsertNewMClaimAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMClaimPolicy') then
   drop procedure InsertNewMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMClaimReason') then
   drop procedure InsertNewMClaimReason
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMClaimType') then
   drop procedure InsertNewMClaimType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMClaimTypeRange') then
   drop procedure InsertNewMClaimTypeRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMedClaim') then
   drop procedure InsertNewMedClaim
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMedClaimHistory') then
   drop procedure InsertNewMedClaimHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMedExDetType') then
   drop procedure InsertNewMedExDetType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMedExRec') then
   drop procedure InsertNewMedExRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMedia') then
   drop procedure InsertNewMedia
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMediHistory') then
   drop procedure InsertNewMediHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMediHistoryAttach') then
   drop procedure InsertNewMediHistoryAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMembershipCode') then
   drop procedure InsertNewMembershipCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMemship') then
   drop procedure InsertNewMemship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewModifyPayElement') then
   drop procedure InsertNewModifyPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewModuleScreenGroup') then
   drop procedure InsertNewModuleScreenGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMPFSubmitScheme') then
   drop procedure InsertNewMPFSubmitScheme
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOccupation') then
   drop procedure InsertNewOccupation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOffenceType') then
   drop procedure InsertNewOffenceType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOrganisation') then
   drop procedure InsertNewOrganisation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOrganisationIndustry') then
   drop procedure InsertNewOrganisationIndustry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOrganisationType') then
   drop procedure InsertNewOrganisationType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOrganiser') then
   drop procedure InsertNewOrganiser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOrgCWorker') then
   drop procedure InsertNewOrgCWorker
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOrgPubChart') then
   drop procedure InsertNewOrgPubChart
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOtherBankInfo') then
   drop procedure InsertNewOtherBankInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOTMember') then
   drop procedure InsertNewOTMember
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOTRecord') then
   drop procedure InsertNewOTRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOutEmailMessage') then
   drop procedure InsertNewOutEmailMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOutEmailMsgMapping') then
   drop procedure InsertNewOutEmailMsgMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewOverTime') then
   drop procedure InsertNewOverTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayAllocation') then
   drop procedure InsertNewPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayEmployee') then
   drop procedure InsertNewPayEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayEmployeePolicy') then
   drop procedure InsertNewPayEmployeePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayGroup') then
   drop procedure InsertNewPayGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayGroupPeriod') then
   drop procedure InsertNewPayGroupPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayLeaveSetting') then
   drop procedure InsertNewPayLeaveSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPaymentBankInfo') then
   drop procedure InsertNewPaymentBankInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayPeriodRecord') then
   drop procedure InsertNewPayPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPayRecord') then
   drop procedure InsertNewPayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPensionOption') then
   drop procedure InsertNewPensionOption
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPeriodEEHistory') then
   drop procedure InsertNewPeriodEEHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPeriodMessage') then
   drop procedure InsertNewPeriodMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPeriodPolicySetting') then
   drop procedure InsertNewPeriodPolicySetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPeriodPolicySummary') then
   drop procedure InsertNewPeriodPolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPersonalAddress') then
   drop procedure InsertNewPersonalAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPersonalAddressEPE') then
   drop procedure InsertNewPersonalAddressEPE
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPersonalContact') then
   drop procedure InsertNewPersonalContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPersonalDetail') then
   drop procedure InsertNewPersonalDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPersonalEmail') then
   drop procedure InsertNewPersonalEmail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPolicyProgression') then
   drop procedure InsertNewPolicyProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPolicyRecord') then
   drop procedure InsertNewPolicyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPosGrp') then
   drop procedure InsertNewPosGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPositionCode') then
   drop procedure InsertNewPositionCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewProjCostType') then
   drop procedure InsertNewProjCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewQueryFolder') then
   drop procedure InsertNewQueryFolder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRace') then
   drop procedure InsertNewRace
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRecruitPosition') then
   drop procedure InsertNewRecruitPosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRegistry') then
   drop procedure InsertNewRegistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRelationship') then
   drop procedure InsertNewRelationship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewReligion') then
   drop procedure InsertNewReligion
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewReportAccess') then
   drop procedure InsertNewReportAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewReportExport') then
   drop procedure InsertNewReportExport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewResidenceStatusRec') then
   drop procedure InsertNewResidenceStatusRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewResidenceType') then
   drop procedure InsertNewResidenceType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewResponsibility') then
   drop procedure InsertNewResponsibility
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewReviewAttachment') then
   drop procedure InsertNewReviewAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewReviewType') then
   drop procedure InsertNewReviewType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewRptConfig') then
   drop procedure InsertNewRptConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSalaryGrade') then
   drop procedure InsertNewSalaryGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewScreenDesign') then
   drop procedure InsertNewScreenDesign
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSDFProgression') then
   drop procedure InsertNewSDFProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSection') then
   drop procedure InsertNewSection
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewShift') then
   drop procedure InsertNewShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewShiftMember') then
   drop procedure InsertNewShiftMember
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewShiftRecord') then
   drop procedure InsertNewShiftRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSIHIGovtProgression') then
   drop procedure InsertNewSIHIGovtProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSIProgression') then
   drop procedure InsertNewSIProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSkill') then
   drop procedure InsertNewSkill
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSkillGrade') then
   drop procedure InsertNewSkillGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSkillLevel') then
   drop procedure InsertNewSkillLevel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSponsorGrant') then
   drop procedure InsertNewSponsorGrant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSponsorship') then
   drop procedure InsertNewSponsorship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewState') then
   drop procedure InsertNewState
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSubPeriodRecord') then
   drop procedure InsertNewSubPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSubPeriodSetting') then
   drop procedure InsertNewSubPeriodSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSubPeriodTemplate') then
   drop procedure InsertNewSubPeriodTemplate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSubRegistry') then
   drop procedure InsertNewSubRegistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSuccession') then
   drop procedure InsertNewSuccession
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewSystemUser') then
   drop procedure InsertNewSystemUser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTest') then
   drop procedure InsertNewTest
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTimeSheet') then
   drop procedure InsertNewTimeSheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTitleCode') then
   drop procedure InsertNewTitleCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTMSAllowance') then
   drop procedure InsertNewTMSAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTMSDetail') then
   drop procedure InsertNewTMSDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTMSDistribute') then
   drop procedure InsertNewTMSDistribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTMSLeaveDeduction') then
   drop procedure InsertNewTMSLeaveDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTMSOverTime') then
   drop procedure InsertNewTMSOverTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTMSShift') then
   drop procedure InsertNewTMSShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainCostType') then
   drop procedure InsertNewTrainCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTraining') then
   drop procedure InsertNewTraining
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainingAttachment') then
   drop procedure InsertNewTrainingAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainingBatch') then
   drop procedure InsertNewTrainingBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainingHistory') then
   drop procedure InsertNewTrainingHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainingPersonnel') then
   drop procedure InsertNewTrainingPersonnel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTrainingType') then
   drop procedure InsertNewTrainingType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewTreatmentType') then
   drop procedure InsertNewTreatmentType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewUserGroup') then
   drop procedure InsertNewUserGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewUserModuleNoAccess') then
   drop procedure InsertNewUserModuleNoAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewUserSearchSetting') then
   drop procedure InsertNewUserSearchSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewUserSecurityQuery') then
   drop procedure InsertNewUserSecurityQuery
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewUtilityUsage') then
   drop procedure InsertNewUtilityUsage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVenue') then
   drop procedure InsertNewVenue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnC04Record') then
   drop procedure InsertNewVnC04Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnC45Record') then
   drop procedure InsertNewVnC45Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnC47aRecord') then
   drop procedure InsertNewVnC47aRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnC47Record') then
   drop procedure InsertNewVnC47Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnERSubmission') then
   drop procedure InsertNewVnERSubmission
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnERTaxPayment') then
   drop procedure InsertNewVnERTaxPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnTaxDetails') then
   drop procedure InsertNewVnTaxDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnTaxEmployee') then
   drop procedure InsertNewVnTaxEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnTaxEmployer') then
   drop procedure InsertNewVnTaxEmployer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnTaxPolicy') then
   drop procedure InsertNewVnTaxPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnTaxProgression') then
   drop procedure InsertNewVnTaxProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewVnTaxRecord') then
   drop procedure InsertNewVnTaxRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWageProperty') then
   drop procedure InsertNewWageProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWeekLeavePattern') then
   drop procedure InsertNewWeekLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWeekWorkPattern') then
   drop procedure InsertNewWeekWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWorkTime') then
   drop procedure InsertNewWorkTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWTCalendar') then
   drop procedure InsertNewWTCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWTCalendarPattern') then
   drop procedure InsertNewWTCalendarPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWTDay') then
   drop procedure InsertNewWTDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewWTProfile') then
   drop procedure InsertNewWTProfile
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsAllowanceRecordKeyWordsHas') then
   drop procedure IsAllowanceRecordKeyWordsHas
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsCalendarDatePublicHoliday') then
   drop procedure IsCalendarDatePublicHoliday
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsConfirmAfterMarkCareerProg') then
   drop procedure IsConfirmAfterMarkCareerProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsCostHasPayRecord') then
   drop procedure IsCostHasPayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsDateWithin') then
   drop procedure IsDateWithin
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsFormulaId') then
   drop procedure IsFormulaId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsFormulaIdCanDelete') then
   drop procedure IsFormulaIdCanDelete
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsFormulaIdHasCategory') then
   drop procedure IsFormulaIdHasCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsFormulaIdHasProperty') then
   drop procedure IsFormulaIdHasProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsFormulaIdHasSelectedProperty') then
   drop procedure IsFormulaIdHasSelectedProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsGroupInsurance') then
   drop procedure IsGroupInsurance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsHideWageRequire') then
   drop procedure IsHideWageRequire
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsHistoryRecord') then
   drop procedure IsHistoryRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsLastSubPeriod') then
   drop procedure IsLastSubPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsLvePeriodBalRptLastInitPayPeriod') then
   drop procedure IsLvePeriodBalRptLastInitPayPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsMedClaimTypeEligible') then
   drop procedure IsMedClaimTypeEligible
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsModuleAccessible') then
   drop procedure IsModuleAccessible
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsMVCCappingOver') then
   drop procedure IsMVCCappingOver
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsNoEmployment') then
   drop procedure IsNoEmployment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsNonLoopingAllowance') then
   drop procedure IsNonLoopingAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsNonLoopingPayElement') then
   drop procedure IsNonLoopingPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPayElementCanCalculate') then
   drop procedure IsPayElementCanCalculate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPayElementKeyWordsHas') then
   drop procedure IsPayElementKeyWordsHas
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPayRecordExist') then
   drop procedure IsPayRecordExist
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPayRecordWithin') then
   drop procedure IsPayRecordWithin
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPeriodGreaterThan') then
   drop procedure IsPeriodGreaterThan
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPeriodLessThan') then
   drop procedure IsPeriodLessThan
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsPeriodWithin') then
   drop procedure IsPeriodWithin
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsSubPeriodWithin') then
   drop procedure IsSubPeriodWithin
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsTimeSheetExistDate') then
   drop procedure IsTimeSheetExistDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsTimeSheetExistSubPeriod') then
   drop procedure IsTimeSheetExistSubPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsVnResidenceStatusChange') then
   drop procedure IsVnResidenceStatusChange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsWageElementInUsed') then
   drop procedure IsWageElementInUsed
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchBranchGov') then
   drop procedure PatchBranchGov
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchCostDetails') then
   drop procedure PatchCostDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchInterfaceDetails') then
   drop procedure PatchInterfaceDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'PCountCalenLeavePattern') then
   drop procedure PCountCalenLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'PCountCalenWorkPattern') then
   drop procedure PCountCalenWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'PGetPositionMaxMinWage') then
   drop procedure PGetPositionMaxMinWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'RptGetEmergencyMainContact') then
   drop procedure RptGetEmergencyMainContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrGWItem') then
   drop procedure UpdateAccrGWItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrItemBasis') then
   drop procedure UpdateAccrItemBasis
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualEligible') then
   drop procedure UpdateAccrualEligible
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualField') then
   drop procedure UpdateAccrualField
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualGrossWage') then
   drop procedure UpdateAccrualGrossWage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualGroup') then
   drop procedure UpdateAccrualGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualItem') then
   drop procedure UpdateAccrualItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualMethod') then
   drop procedure UpdateAccrualMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAccrualPeriodSetup') then
   drop procedure UpdateAccrualPeriodSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateActionTaken') then
   drop procedure UpdateActionTaken
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAdHocQueryFields') then
   drop procedure UpdateAdHocQueryFields
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAdHocQueryRecord') then
   drop procedure UpdateAdHocQueryRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAdjustCredit') then
   drop procedure UpdateAdjustCredit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAdvanceProcess') then
   drop procedure UpdateAdvanceProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAdvanceReport') then
   drop procedure UpdateAdvanceReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAlertGroup') then
   drop procedure UpdateAlertGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAlertGroupItem') then
   drop procedure UpdateAlertGroupItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAlertGroupItemAttach') then
   drop procedure UpdateAlertGroupItemAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAlertItemAssignMsg') then
   drop procedure UpdateAlertItemAssignMsg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAlertRole') then
   drop procedure UpdateAlertRole
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAllNewLabelToDefault') then
   drop procedure UpdateAllNewLabelToDefault
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAllowanceHistoryRecord') then
   drop procedure UpdateAllowanceHistoryRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAllowanceRecord') then
   drop procedure UpdateAllowanceRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnalyserSetEndTime') then
   drop procedure UpdateAnalyserSetEndTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnlysBasisPolicy') then
   drop procedure UpdateAnlysBasisPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnlysDispSection') then
   drop procedure UpdateAnlysDispSection
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnlysItemSetup') then
   drop procedure UpdateAnlysItemSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnlysPolicyRange') then
   drop procedure UpdateAnlysPolicyRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnlysProject') then
   drop procedure UpdateAnlysProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAnlysSetup') then
   drop procedure UpdateAnlysSetup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApplicant') then
   drop procedure UpdateApplicant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApplicantAttach') then
   drop procedure UpdateApplicantAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAppraisal') then
   drop procedure UpdateAppraisal
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAppraisalDetail') then
   drop procedure UpdateAppraisalDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAppraisalGrade') then
   drop procedure UpdateAppraisalGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAppraisalHistory') then
   drop procedure UpdateAppraisalHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAppraisalTmpRecSortCatOrder') then
   drop procedure UpdateAppraisalTmpRecSortCatOrder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAppraisalType') then
   drop procedure UpdateAppraisalType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApprCategory') then
   drop procedure UpdateApprCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApprPtSystem') then
   drop procedure UpdateApprPtSystem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApprQuestionSortQuestionNo') then
   drop procedure UpdateApprQuestionSortQuestionNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApprTemplate') then
   drop procedure UpdateApprTemplate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateApprTraining') then
   drop procedure UpdateApprTraining
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAreaSpecialised') then
   drop procedure UpdateAreaSpecialised
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAwardCode') then
   drop procedure UpdateAwardCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAwardDisc') then
   drop procedure UpdateAwardDisc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateAwardDiscAttach') then
   drop procedure UpdateAwardDiscAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBalancePayElement') then
   drop procedure UpdateBalancePayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankAccountTypeDesc') then
   drop procedure UpdateBankAccountTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankAccType') then
   drop procedure UpdateBankAccType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankAllocGroup') then
   drop procedure UpdateBankAllocGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankBranch') then
   drop procedure UpdateBankBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankDiskRecord') then
   drop procedure UpdateBankDiskRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankFilter') then
   drop procedure UpdateBankFilter
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankName') then
   drop procedure UpdateBankName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankRecord') then
   drop procedure UpdateBankRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankSubmitCompanyBank') then
   drop procedure UpdateBankSubmitCompanyBank
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBankSubmitFormat') then
   drop procedure UpdateBankSubmitFormat
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBasicRateProgression') then
   drop procedure UpdateBasicRateProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBenefitDetails') then
   drop procedure UpdateBenefitDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBloodGroupDesc') then
   drop procedure UpdateBloodGroupDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBond') then
   drop procedure UpdateBond
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBondAttachment') then
   drop procedure UpdateBondAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBonusProcess') then
   drop procedure UpdateBonusProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBonusRecord') then
   drop procedure UpdateBonusRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBonusReport') then
   drop procedure UpdateBonusReport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateBranchGov') then
   drop procedure UpdateBranchGov
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCalendar') then
   drop procedure UpdateCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCalendarDayWKLvePattern') then
   drop procedure UpdateCalendarDayWKLvePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCareer') then
   drop procedure UpdateCareer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCareerAttribute') then
   drop procedure UpdateCareerAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCareerNewValueinPayPeriodRec') then
   drop procedure UpdateCareerNewValueinPayPeriodRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCareerProgression') then
   drop procedure UpdateCareerProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCareerProgressionMarkCurrent') then
   drop procedure UpdateCareerProgressionMarkCurrent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCategoryDesc') then
   drop procedure UpdateCategoryDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCCCode1') then
   drop procedure UpdateCCCode1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCCCode2') then
   drop procedure UpdateCCCode2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCCCode3') then
   drop procedure UpdateCCCode3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCCCode4') then
   drop procedure UpdateCCCode4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCCCode5') then
   drop procedure UpdateCCCode5
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCessationDesc') then
   drop procedure UpdateCessationDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCityName') then
   drop procedure UpdateCityName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateClassification') then
   drop procedure UpdateClassification
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateColourScheme') then
   drop procedure UpdateColourScheme
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateComBankAccNo') then
   drop procedure UpdateComBankAccNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateComBankAccount') then
   drop procedure UpdateComBankAccount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateComBankAccType') then
   drop procedure UpdateComBankAccType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateComBankBranch') then
   drop procedure UpdateComBankBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCompanyBranch') then
   drop procedure UpdateCompanyBranch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCompanyGovt') then
   drop procedure UpdateCompanyGovt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCompanyGovTypeDesc') then
   drop procedure UpdateCompanyGovTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCompanyRecord') then
   drop procedure UpdateCompanyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCompanyTypeDesc') then
   drop procedure UpdateCompanyTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCompetency') then
   drop procedure UpdateCompetency
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateContactLocDesc') then
   drop procedure UpdateContactLocDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateContractCategory') then
   drop procedure UpdateContractCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateContractProgression') then
   drop procedure UpdateContractProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostAccount') then
   drop procedure UpdateCostAccount
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostCentre') then
   drop procedure UpdateCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostComponent') then
   drop procedure UpdateCostComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostCond') then
   drop procedure UpdateCostCond
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostCreditDebit') then
   drop procedure UpdateCostCreditDebit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostGroup') then
   drop procedure UpdateCostGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostingDetails') then
   drop procedure UpdateCostingDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostingMethod') then
   drop procedure UpdateCostingMethod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostItem') then
   drop procedure UpdateCostItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostPeriodHistory') then
   drop procedure UpdateCostPeriodHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostProgression') then
   drop procedure UpdateCostProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCostRecord') then
   drop procedure UpdateCostRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCountry') then
   drop procedure UpdateCountry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourse') then
   drop procedure UpdateCourse
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseAttachment') then
   drop procedure UpdateCourseAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseCategory') then
   drop procedure UpdateCourseCategory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseContact') then
   drop procedure UpdateCourseContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseFamily') then
   drop procedure UpdateCourseFamily
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseGrade') then
   drop procedure UpdateCourseGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseRole') then
   drop procedure UpdateCourseRole
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseSchedule') then
   drop procedure UpdateCourseSchedule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCourseSkillType') then
   drop procedure UpdateCourseSkillType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFAgeGroup') then
   drop procedure UpdateCPFAgeGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFGovernmentProgression') then
   drop procedure UpdateCPFGovernmentProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFPayment') then
   drop procedure UpdateCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFPolicy') then
   drop procedure UpdateCPFPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFProgression') then
   drop procedure UpdateCPFProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFSalaryGroup') then
   drop procedure UpdateCPFSalaryGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFTableCode') then
   drop procedure UpdateCPFTableCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCPFTableComponent') then
   drop procedure UpdateCPFTableComponent
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomAttribute') then
   drop procedure UpdateCustomAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomAttributeGroupPosition') then
   drop procedure UpdateCustomAttributeGroupPosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomAttributeSortPosition') then
   drop procedure UpdateCustomAttributeSortPosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomIntConfig') then
   drop procedure UpdateCustomIntConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomIntConfigItem') then
   drop procedure UpdateCustomIntConfigItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomQuery') then
   drop procedure UpdateCustomQuery
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomRelation') then
   drop procedure UpdateCustomRelation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomSearch') then
   drop procedure UpdateCustomSearch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomTable') then
   drop procedure UpdateCustomTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomVariables') then
   drop procedure UpdateCustomVariables
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDefaultCPFPayment') then
   drop procedure UpdateDefaultCPFPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDefaultPayAllocation') then
   drop procedure UpdateDefaultPayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDepartmentDesc') then
   drop procedure UpdateDepartmentDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDetailRecord') then
   drop procedure UpdateDetailRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEduAttachment') then
   drop procedure UpdateEduAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEducation') then
   drop procedure UpdateEducation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEducationRec') then
   drop procedure UpdateEducationRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpCode1') then
   drop procedure UpdateEmpCode1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpCode2') then
   drop procedure UpdateEmpCode2
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpCode3') then
   drop procedure UpdateEmpCode3
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpCode4') then
   drop procedure UpdateEmpCode4
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpCode5') then
   drop procedure UpdateEmpCode5
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpColItem') then
   drop procedure UpdateEmpColItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpeeOtherInfo') then
   drop procedure UpdateEmpeeOtherInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpeeWkCalen') then
   drop procedure UpdateEmpeeWkCalen
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpGrpItem') then
   drop procedure UpdateEmpGrpItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpLocation1') then
   drop procedure UpdateEmpLocation1
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmployeeRecord') then
   drop procedure UpdateEmployeeRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmployeeRpt') then
   drop procedure UpdateEmployeeRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmploymentCareerAttribute') then
   drop procedure UpdateEmploymentCareerAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmploymentStatus') then
   drop procedure UpdateEmploymentStatus
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmploymentType') then
   drop procedure UpdateEmploymentType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmployPassProgression') then
   drop procedure UpdateEmployPassProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpRecurAllow') then
   drop procedure UpdateEmpRecurAllow
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEmpSortItem') then
   drop procedure UpdateEmpSortItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateExcelSpreadsheet') then
   drop procedure UpdateExcelSpreadsheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateExcelWkSheet') then
   drop procedure UpdateExcelWkSheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateExcelWkSheetItem') then
   drop procedure UpdateExcelWkSheetItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateExchangeRate') then
   drop procedure UpdateExchangeRate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateExitIntAttach') then
   drop procedure UpdateExitIntAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateExitInterview') then
   drop procedure UpdateExitInterview
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFamily') then
   drop procedure UpdateFamily
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFamilyAttachment') then
   drop procedure UpdateFamilyAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFamilyEduRec') then
   drop procedure UpdateFamilyEduRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFieldMajor') then
   drop procedure UpdateFieldMajor
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFieldSecurityNoAccess') then
   drop procedure UpdateFieldSecurityNoAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFinanceColItem') then
   drop procedure UpdateFinanceColItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFinanceGrpItem') then
   drop procedure UpdateFinanceGrpItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFinanceRowItem') then
   drop procedure UpdateFinanceRowItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFinanceSortItem') then
   drop procedure UpdateFinanceSortItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFinancialRpt') then
   drop procedure UpdateFinancialRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFinColAccumulated') then
   drop procedure UpdateFinColAccumulated
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateForeignWorkerRecord') then
   drop procedure UpdateForeignWorkerRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateForeignWorkerType') then
   drop procedure UpdateForeignWorkerType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateForm') then
   drop procedure UpdateForm
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFormControlProperty') then
   drop procedure UpdateFormControlProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFormPoint') then
   drop procedure UpdateFormPoint
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFormula') then
   drop procedure UpdateFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFormulaProperty') then
   drop procedure UpdateFormulaProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFormulaRange') then
   drop procedure UpdateFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFWLProgression') then
   drop procedure UpdateFWLProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGenderDesc') then
   drop procedure UpdateGenderDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGLCode') then
   drop procedure UpdateGLCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGovContribType') then
   drop procedure UpdateGovContribType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGovernmentGrant') then
   drop procedure UpdateGovernmentGrant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGrade') then
   drop procedure UpdateGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGroupLeavePatternWeekNo') then
   drop procedure UpdateGroupLeavePatternWeekNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateGroupWorkPatternWeekNo') then
   drop procedure UpdateGroupWorkPatternWeekNo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHIProgression') then
   drop procedure UpdateHIProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHoliday') then
   drop procedure UpdateHoliday
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRFormula') then
   drop procedure UpdateHRFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRFormulaRange') then
   drop procedure UpdateHRFormulaRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRKeyword') then
   drop procedure UpdateHRKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRProjectAttach') then
   drop procedure UpdateHRProjectAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRProjectRecord') then
   drop procedure UpdateHRProjectRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRProjectWorker') then
   drop procedure UpdateHRProjectWorker
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRTestAttachRecord') then
   drop procedure UpdateHRTestAttachRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateHRTestRecord') then
   drop procedure UpdateHRTestRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateIdentityTypeDesc') then
   drop procedure UpdateIdentityTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateIllness') then
   drop procedure UpdateIllness
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurance') then
   drop procedure UpdateInsurance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsuranceAttach') then
   drop procedure UpdateInsuranceAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurAttach') then
   drop procedure UpdateInsurAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurBenefit') then
   drop procedure UpdateInsurBenefit
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurGroup') then
   drop procedure UpdateInsurGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurPlan') then
   drop procedure UpdateInsurPlan
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurPolicy') then
   drop procedure UpdateInsurPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurProg') then
   drop procedure UpdateInsurProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInsurProgDetails') then
   drop procedure UpdateInsurProgDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterfaceAttribute') then
   drop procedure UpdateInterfaceAttribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterfaceCodeMapping') then
   drop procedure UpdateInterfaceCodeMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterfaceCodeTable') then
   drop procedure UpdateInterfaceCodeTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterfaceProcess') then
   drop procedure UpdateInterfaceProcess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterfaceProject') then
   drop procedure UpdateInterfaceProject
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterviewer') then
   drop procedure UpdateInterviewer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterviewSchedule') then
   drop procedure UpdateInterviewSchedule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateInterviewScheduleCommand') then
   drop procedure UpdateInterviewScheduleCommand
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItem') then
   drop procedure UpdateItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItemAssignItem') then
   drop procedure UpdateItemAssignItem
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItemAttrName') then
   drop procedure UpdateItemAttrName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItemAttrValue') then
   drop procedure UpdateItemAttrValue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItemBAssgn') then
   drop procedure UpdateItemBAssgn
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItemBatch') then
   drop procedure UpdateItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateItemType') then
   drop procedure UpdateItemType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateJobAdAttach') then
   drop procedure UpdateJobAdAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateJobCode') then
   drop procedure UpdateJobCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateJobGrade') then
   drop procedure UpdateJobGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateJobHistory') then
   drop procedure UpdateJobHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateJobOpenTo') then
   drop procedure UpdateJobOpenTo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateJobResponsibility') then
   drop procedure UpdateJobResponsibility
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateKeyWord') then
   drop procedure UpdateKeyWord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLanguage') then
   drop procedure UpdateLanguage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveAllocation') then
   drop procedure UpdateLeaveAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveAllocationGroupDesc') then
   drop procedure UpdateLeaveAllocationGroupDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveAllocationGroupType') then
   drop procedure UpdateLeaveAllocationGroupType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveApplication') then
   drop procedure UpdateLeaveApplication
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveApplyDay') then
   drop procedure UpdateLeaveApplyDay
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveComputation') then
   drop procedure UpdateLeaveComputation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveCutOffDate') then
   drop procedure UpdateLeaveCutOffDate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveCycleRpt') then
   drop procedure UpdateLeaveCycleRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveDeductionRecord') then
   drop procedure UpdateLeaveDeductionRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveEmployee') then
   drop procedure UpdateLeaveEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveFormula') then
   drop procedure UpdateLeaveFormula
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveGroup') then
   drop procedure UpdateLeaveGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveInfoRecord') then
   drop procedure UpdateLeaveInfoRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveInitialisedGroup') then
   drop procedure UpdateLeaveInitialisedGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveKeyword') then
   drop procedure UpdateLeaveKeyword
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeavePolicy') then
   drop procedure UpdateLeavePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeavePolicyRecord') then
   drop procedure UpdateLeavePolicyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveRange') then
   drop procedure UpdateLeaveRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveReason') then
   drop procedure UpdateLeaveReason
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveReasonDesc') then
   drop procedure UpdateLeaveReasonDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveRecord') then
   drop procedure UpdateLeaveRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveType') then
   drop procedure UpdateLeaveType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLicenseRecord') then
   drop procedure UpdateLicenseRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLoanEmployee') then
   drop procedure UpdateLoanEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLoanFrom') then
   drop procedure UpdateLoanFrom
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLoginRec') then
   drop procedure UpdateLoginRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLoginRecIPModule') then
   drop procedure UpdateLoginRecIPModule
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLoginRecQueryId') then
   drop procedure UpdateLoginRecQueryId
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLveAllocation') then
   drop procedure UpdateLveAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLveAllocationRec') then
   drop procedure UpdateLveAllocationRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLveAllocFormulaRec') then
   drop procedure UpdateLveAllocFormulaRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLvePeriodBalance') then
   drop procedure UpdateLvePeriodBalance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLvePeriodBalRpt') then
   drop procedure UpdateLvePeriodBalRpt
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLvePeriodBF') then
   drop procedure UpdateLvePeriodBF
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLvePeriodSummary') then
   drop procedure UpdateLvePeriodSummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLvePolicyProg') then
   drop procedure UpdateLvePolicyProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLvePolicySummary') then
   drop procedure UpdateLvePolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMandatoryContributeProg') then
   drop procedure UpdateMandatoryContributeProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapCostCentre') then
   drop procedure UpdateMapCostCentre
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapDonation') then
   drop procedure UpdateMapDonation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapGovtProg') then
   drop procedure UpdateMapGovtProg
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapItemBatch') then
   drop procedure UpdateMapItemBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapMClaimPolicy') then
   drop procedure UpdateMapMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapOT') then
   drop procedure UpdateMapOT
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapRPayElement') then
   drop procedure UpdateMapRPayElement
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMapShift') then
   drop procedure UpdateMapShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMaritalStatusDesc') then
   drop procedure UpdateMaritalStatusDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMClaimAttachment') then
   drop procedure UpdateMClaimAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMClaimPolicy') then
   drop procedure UpdateMClaimPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMClaimReason') then
   drop procedure UpdateMClaimReason
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMClaimType') then
   drop procedure UpdateMClaimType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMClaimTypeRange') then
   drop procedure UpdateMClaimTypeRange
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMedClaim') then
   drop procedure UpdateMedClaim
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMedClaimHistory') then
   drop procedure UpdateMedClaimHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMedExDetType') then
   drop procedure UpdateMedExDetType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMedExRec') then
   drop procedure UpdateMedExRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMedia') then
   drop procedure UpdateMedia
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMediHistory') then
   drop procedure UpdateMediHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMediHistoryAttach') then
   drop procedure UpdateMediHistoryAttach
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMembershipCode') then
   drop procedure UpdateMembershipCode
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMemship') then
   drop procedure UpdateMemship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateModuleScreenGroup') then
   drop procedure UpdateModuleScreenGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateNewLabelName') then
   drop procedure UpdateNewLabelName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOccupation') then
   drop procedure UpdateOccupation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOffenceType') then
   drop procedure UpdateOffenceType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOrganisation') then
   drop procedure UpdateOrganisation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOrganisationIndustry') then
   drop procedure UpdateOrganisationIndustry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOrganisationType') then
   drop procedure UpdateOrganisationType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOrganiser') then
   drop procedure UpdateOrganiser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOrgCWorker') then
   drop procedure UpdateOrgCWorker
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOrgPubChart') then
   drop procedure UpdateOrgPubChart
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOtherBankInfo') then
   drop procedure UpdateOtherBankInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOTRecord') then
   drop procedure UpdateOTRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOutEmailMessage') then
   drop procedure UpdateOutEmailMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOutEmailMsgMapping') then
   drop procedure UpdateOutEmailMsgMapping
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateOverTime') then
   drop procedure UpdateOverTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayAllocation') then
   drop procedure UpdatePayAllocation
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayEmployee') then
   drop procedure UpdatePayEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayEmployeeOTTable') then
   drop procedure UpdatePayEmployeeOTTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayEmployeePolicy') then
   drop procedure UpdatePayEmployeePolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayEmployeeShiftTable') then
   drop procedure UpdatePayEmployeeShiftTable
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayGroup') then
   drop procedure UpdatePayGroup
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayGroupPeriod') then
   drop procedure UpdatePayGroupPeriod
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayLeaveSetting') then
   drop procedure UpdatePayLeaveSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePaymentBankInfo') then
   drop procedure UpdatePaymentBankInfo
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayPeriodRecord') then
   drop procedure UpdatePayPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePayRecord') then
   drop procedure UpdatePayRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePensionOptionDesc') then
   drop procedure UpdatePensionOptionDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePeriodEEHistory') then
   drop procedure UpdatePeriodEEHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePeriodMessage') then
   drop procedure UpdatePeriodMessage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePeriodPolicySetting') then
   drop procedure UpdatePeriodPolicySetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePeriodPolicySummary') then
   drop procedure UpdatePeriodPolicySummary
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePersonalAddress') then
   drop procedure UpdatePersonalAddress
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePersonalAddressEPE') then
   drop procedure UpdatePersonalAddressEPE
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePersonalContact') then
   drop procedure UpdatePersonalContact
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePersonalDetails') then
   drop procedure UpdatePersonalDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePersonalEmail') then
   drop procedure UpdatePersonalEmail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePolicyProgression') then
   drop procedure UpdatePolicyProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePolicyRecord') then
   drop procedure UpdatePolicyRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePosGrp') then
   drop procedure UpdatePosGrp
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePosition') then
   drop procedure UpdatePosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateProjCostType') then
   drop procedure UpdateProjCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateQueryFolder') then
   drop procedure UpdateQueryFolder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRaceDesc') then
   drop procedure UpdateRaceDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRecruitPosition') then
   drop procedure UpdateRecruitPosition
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRegistry') then
   drop procedure UpdateRegistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRelationshipDesc') then
   drop procedure UpdateRelationshipDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateReligionDesc') then
   drop procedure UpdateReligionDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateReportExport') then
   drop procedure UpdateReportExport
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateResidenceTypeDesc') then
   drop procedure UpdateResidenceTypeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateResponsibility') then
   drop procedure UpdateResponsibility
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateResStatusRec') then
   drop procedure UpdateResStatusRec
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateReviewAttachment') then
   drop procedure UpdateReviewAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateReviewType') then
   drop procedure UpdateReviewType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateRptConfig') then
   drop procedure UpdateRptConfig
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSalaryGrade') then
   drop procedure UpdateSalaryGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateScreenDesignItemsOrder') then
   drop procedure UpdateScreenDesignItemsOrder
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateScrProjMemberSequence') then
   drop procedure UpdateScrProjMemberSequence
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSDFProgression') then
   drop procedure UpdateSDFProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSectionDesc') then
   drop procedure UpdateSectionDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateShift') then
   drop procedure UpdateShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateShiftRecord') then
   drop procedure UpdateShiftRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSIHIGovtProgression') then
   drop procedure UpdateSIHIGovtProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSIProgression') then
   drop procedure UpdateSIProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSkill') then
   drop procedure UpdateSkill
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSkillGrade') then
   drop procedure UpdateSkillGrade
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSkillLevel') then
   drop procedure UpdateSkillLevel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSponsorGrant') then
   drop procedure UpdateSponsorGrant
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSponsorship') then
   drop procedure UpdateSponsorship
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateStateName') then
   drop procedure UpdateStateName
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSubPeriodRecord') then
   drop procedure UpdateSubPeriodRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSubPeriodSetting') then
   drop procedure UpdateSubPeriodSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSubPeriodTemplate') then
   drop procedure UpdateSubPeriodTemplate
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSubRegistry') then
   drop procedure UpdateSubRegistry
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSuccession') then
   drop procedure UpdateSuccession
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateSystemUser') then
   drop procedure UpdateSystemUser
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTest') then
   drop procedure UpdateTest
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTimeSheet') then
   drop procedure UpdateTimeSheet
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTitleCodeDesc') then
   drop procedure UpdateTitleCodeDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTMSAllowance') then
   drop procedure UpdateTMSAllowance
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTMSDetail') then
   drop procedure UpdateTMSDetail
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTMSDistribute') then
   drop procedure UpdateTMSDistribute
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTMSLeaveDeduction') then
   drop procedure UpdateTMSLeaveDeduction
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTMSOverTime') then
   drop procedure UpdateTMSOverTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTMSShift') then
   drop procedure UpdateTMSShift
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainCostType') then
   drop procedure UpdateTrainCostType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTraining') then
   drop procedure UpdateTraining
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainingAttachment') then
   drop procedure UpdateTrainingAttachment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainingBatch') then
   drop procedure UpdateTrainingBatch
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainingHistory') then
   drop procedure UpdateTrainingHistory
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainingPersonnel') then
   drop procedure UpdateTrainingPersonnel
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTrainingType') then
   drop procedure UpdateTrainingType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateTreatmentType') then
   drop procedure UpdateTreatmentType
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateUserGroupDesc') then
   drop procedure UpdateUserGroupDesc
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateUserModuleNoAccess') then
   drop procedure UpdateUserModuleNoAccess
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateUserSearchSetting') then
   drop procedure UpdateUserSearchSetting
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateUserSecurityQuery') then
   drop procedure UpdateUserSecurityQuery
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateUtilityUsage') then
   drop procedure UpdateUtilityUsage
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVenue') then
   drop procedure UpdateVenue
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnC04Record') then
   drop procedure UpdateVnC04Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnC45Record') then
   drop procedure UpdateVnC45Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnC47aRecord') then
   drop procedure UpdateVnC47aRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnC47Record') then
   drop procedure UpdateVnC47Record
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnERSubmission') then
   drop procedure UpdateVnERSubmission
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnERTaxPayment') then
   drop procedure UpdateVnERTaxPayment
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnTaxDetails') then
   drop procedure UpdateVnTaxDetails
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnTaxEmployee') then
   drop procedure UpdateVnTaxEmployee
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnTaxEmployer') then
   drop procedure UpdateVnTaxEmployer
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnTaxPolicy') then
   drop procedure UpdateVnTaxPolicy
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnTaxProgression') then
   drop procedure UpdateVnTaxProgression
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateVnTaxRecord') then
   drop procedure UpdateVnTaxRecord
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWageProperty') then
   drop procedure UpdateWageProperty
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWeekLeavePattern') then
   drop procedure UpdateWeekLeavePattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWeekWorkPattern') then
   drop procedure UpdateWeekWorkPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWorkTime') then
   drop procedure UpdateWorkTime
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWTCalendar') then
   drop procedure UpdateWTCalendar
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWTCalendarPattern') then
   drop procedure UpdateWTCalendarPattern
end if
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateWTProfile') then
   drop procedure UpdateWTProfile
end if
;

COMMIT WORK;