if exists(select 1 from sys.sysprocedure where proc_name = 'DBMergeYTDSGExport') then
   drop procedure DBMergeYTDSGExport
end if
;

create procedure DBA.DBMergeYTDSGExport(in In_Year int, in In_FilePath char(50))
BEGIN

DECLARE FilePath char(50);    
IF LENGTH(In_FilePath)=0 then
    SET In_FilePath='c:\\temp';
END IF;      
 
/*------ Export To iYTDGeneral ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDGeneral.txt';
UNLOAD 
SELECT 
FGetEmployeeID(EmployeeSysId) AS YTDEmployeeId
, PayRecYear AS YTDYear
, PayRecPeriod AS YTDStartPeriod
, PayRecPeriod AS YTDEndPeriod
, FGetPeriodCurBasicRateType(EmployeeSysId,PayRecYear,PayRecPeriod) AS BasicRateType
, AllocatedBasicRate AS AllocatedBasicRate
, FGetPeriodMVC(EmployeeSysId,PayRecYear,PayRecPeriod) AS AllocatedMVC
, FGetPeriodNWC(EmployeeSysId,PayRecYear,PayRecPeriod) AS AllocatedNWC
, CalBackPay AS BackPay
, CurrentHrDays AS CurrentHrDay
, PreviousHrDays AS BefAdjHrDay
, FullBackPayFreq AS BackPayHrDay
, FGetPeriodSickLeaveTaken(EmployeeSysId,PayRecYear,PayRecPeriod) AS SickLeaveTaken
, FGetPeriodAnnualLeaveTaken(EmployeeSysId,PayRecYear,PayRecPeriod) AS AnnualLeaveTaken
, CalOTAmount AS OTAmount
, CalOTBackPay AS OTBackPayAmount
, CalShiftAmount AS ShiftAmount
, CalLveDeductAmt AS LeaveDeductionAmount
, FreeNumeric1 AS FreeNumeric1
, FreeNumeric2 AS FreeNumeric2
, FreeNumeric3 AS FreeNumeric3
, FreeNumeric4 AS FreeNumeric4
, FreeNumeric5 AS FreeNumeric5
, '' AS FreeString1
, '' AS FreeString2
, '' AS FreeString3
, '' AS FreeString4
, '' AS FreeString5
, 0 AS Processed
, NULL AS ProcessedDateTime
, '' AS ErrorMessage
, '' AS CreatedBy
, 0 AS InterfaceGranted

FROM
(
SELECT 
EmployeeSysID
,PayRecYear
,PayRecPeriod
, Sum(AllocatedBasicRate)
, Sum(CalBackPay)
, Sum(CurrentHrDays)
, Sum(PreviousHrDays)
, Sum(FullBackPayFreq)
, Sum(CalOTAmount)
, Sum(CalOTBackPay)
, Sum(CalShiftAmount)
, Sum(CalLveDeductAmt)
, Sum(FreeNumeric1)
, Sum(FreeNumeric2)
, Sum(FreeNumeric3)
, Sum(FreeNumeric4)
, Sum(FreeNumeric5)
 FROM DetailRecord
WHERE PayRecYear=In_Year
GROUP BY EmployeeSysID, PayRecYear,PayRecPeriod
) AS A(
EmployeeSysID
,PayRecYear
,PayRecPeriod
,AllocatedBasicRate
,CalBackPay
,CurrentHrDays
,PreviousHrDays
,FullBackPayFreq
,CalOTAmount
,CalOTBackPay
,CalShiftAmount
,CalLveDeductAmt
,FreeNumeric1
,FreeNumeric2
,FreeNumeric3
,FreeNumeric4
,FreeNumeric5
)
 ORDER BY YTDEmployeeID, YTDYear, YTDStartPeriod
TO FilePath FORMAT ASCII;


/*------ Export To iYTDSGPolicy ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDSGPolicy.txt';
UNLOAD 
SELECT 
FGetEmployeeID(EmployeeSysId) AS YTDSGPolicyEmployeeId
, PayRecYear AS YTDSGPolicyYear
, PayRecPeriod AS YTDSGPolicyPeriod
, TotalContriEECPF AS TotalContriEECPF
, TotalContriERCPF AS TotalContriERCPF
, ContriOrdEECPF AS ContriOrdEECPF
, ContriOrdERCPF AS ContriOrdERCPF
, ContriAddEECPF AS ContriAddEECPF
, ContriAddERCPF AS ContriAddERCPF
, SupIR8AOrdEECPF AS SupIR8AOrdEECPF
, SupIR8AOrdERCPF AS SupIR8AOrdERCPF
, SupIR8AAddEECPF AS SupIR8AAddEECPF
, SupIR8AAddERCPF AS SupIR8AAddERCPF
, CPFClass AS CPFClass
, CPFStatus AS CPFStatus
, OverseasEECPF AS OverseasEECPF
, OverseasERCPF AS OverseasERCPF
, ContriFWL AS ContriFWL
, ContriSDF AS ContriSDF
, 0 AS Processed
, NULL AS ProcessedDateTime
, '' AS ErrorMessage
, '' AS CreatedBy
, 0 AS InterfaceGranted
, MediSaveOrdinary AS MediSaveOrdinary
, MediSaveAdditional AS MediSaveAdditional
 FROM PeriodPolicySummary
WHERE PayRecYear=In_Year
 ORDER BY YTDSGPolicyEmployeeId, YTDSGPolicyYear, YTDSGPolicyPeriod
 TO FilePath FORMAT ASCII;

/*------ Export To iYTDAllowanceRecord ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDAllowanceRecord.txt';
UNLOAD 
SELECT 
FGetEmployeeID(EmployeeSysId) AS AllowanceEmployeeID
, PayRecYear AS PayRecYear
, PayRecPeriod AS PayRecPeriod
, AllowanceFormulaID AS AllowanceID
, AllowanceAmount AS AllowanceAmount
, AllowanceRemarks AS AllowanceRemarks
, AllowanceDeclaredDate AS AllowanceDeclaredDate
, 0 AS Processed
, NULL AS ProcessedDateTime
, '' AS ErrorMessage
, '' AS CreatedBy
, 0 AS InterfaceGranted
FROM
(

SELECT 
EmployeeSysId
, PayRecYear
, PayRecPeriod
, AllowanceFormulaID
, Sum(AllowanceAmount)
, AllowanceRemarks
, AllowanceDeclaredDate
, AllowanceRecurSysId
 FROM AllowanceRecord
WHERE PayRecYear=In_Year
GROUP BY EmployeeSysId
, PayRecYear
, PayRecPeriod
, AllowanceFormulaID
, AllowanceRemarks
, AllowanceDeclaredDate
, AllowanceRecurSysId
) AS A(
EmployeeSysId
, PayRecYear
, PayRecPeriod
, AllowanceFormulaID
, AllowanceAmount
, AllowanceRemarks
, AllowanceDeclaredDate
, AllowanceRecurSysId
)
 ORDER BY AllowanceEmployeeID, PayRecYear, PayRecPeriod, AllowanceID
 TO FilePath FORMAT ASCII;

/*------ Export To iYTDOTRecord ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDOTRecord.txt';
UNLOAD 
SELECT 
 FGetEmployeeID(EmployeeSysId) AS YTDOTEmployeeId
, PayRecYear AS YTDOTYear
, PayRecPeriod AS YTDOTPeriod
, OTFormulaId AS YTDOTId
, CurrentOTFreq AS CurrentOTFreq
, CurrentOTAmount AS CurrentOTAmt
, LastOTFreq AS LastOTFreq
, LastOTAmount AS LastOTAmt
, BackPayOTFreq AS BackPayOTFreq
, BackPayOTAmount AS BackPayOTAmt
, 0 AS Processed
, NULL AS ProcessedDateTime
, '' AS ErrorMessage
, '' AS CreatedBy
, 0 AS InterfaceGranted
FROM
(
SELECT 
EmployeeSysID
, PayRecYear
, PayRecPeriod
, OTFormulaId
, Sum(CurrentOTFreq)
, Sum(CurrentOTAmount)
, Sum(LastOTFreq)
, Sum(LastOTAmount)
, Sum(BackPayOTFreq)
, Sum(BackPayOTAmount)
 FROM OTRecord
WHERE PayRecYear=In_Year
GROUP BY EmployeeSysID
, PayRecYear
, PayRecPeriod
, OTFormulaId
) AS A(
EmployeeSysID
, PayRecYear
, PayRecPeriod
, OTFormulaId
, CurrentOTFreq
, CurrentOTAmount
, LastOTFreq
, LastOTAmount
, BackPayOTFreq
, BackPayOTAmount
)
 ORDER BY YTDOTEmployeeId, YTDOTYear, YTDOTPeriod
TO FilePath FORMAT ASCII;

/*------ Export To iYTDShiftRecord ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDShiftRecord.txt';
UNLOAD 
SELECT 
FGetEmployeeID(EmployeeSysId) AS YTDShiftEmployeeId
, PayRecYear AS YTDShiftYear
, PayRecPeriod AS YTDShiftPeriod
, ShiftFormulaId AS YTDShiftId
, ShiftFrequency AS ShiftFrequency
, ShiftAmount AS ShiftAmount
, 0 AS Processed
, NULL AS ProcessedDateTime
, '' AS ErrorMessage
, '' AS CreatedBy
, 0 AS InterfaceGranted
FROM
(
SELECT 
EmployeeSysID
, PayRecYear
, PayRecPeriod
, ShiftFormulaId
, Sum(ShiftFrequency)
, Sum(ShiftAmount)
 FROM ShiftRecord
WHERE PayRecYear=In_Year
GROUP BY EmployeeSysID
, PayRecYear
, PayRecPeriod
, ShiftFormulaId
) AS A(
EmployeeSysID
, PayRecYear
, PayRecPeriod
, ShiftFormulaId
, ShiftFrequency
, ShiftAmount
)
 ORDER BY YTDShiftEmployeeId, YTDShiftYear, YTDShiftPeriod
TO FilePath FORMAT ASCII;

/*------ Export To iYTDLeaveDeductionRecord ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDLeaveDeductionRecord.txt';
UNLOAD 
SELECT 
FGetEmployeeID(EmployeeSysId) AS YTDLveDedEmployeeId
, PayRecYear AS YTDLveDedYear
, PayRecPeriod AS YTDLveDedPeriod
, LeaveTypeFunctCode AS YTDLveTypeFunctCode
, CurrentLveDays AS CurrentLveDays
, CurrentLveHours AS CurrentLveHours
, PreviousLveIncDays AS PreviousLveIncDays
, PreviousLveIncHours AS PreviousLveIncHours
, LveAmount AS LveAmount
, 0 AS Processed
, NULL AS ProcessedDateTime
, '' AS ErrorMessage
, '' AS CreatedBy
, 0 AS InterfaceGranted

FROM
(
SELECT 
 EmployeeSysId
, PayRecYear
, PayRecPeriod
, LeaveTypeFunctCode
, Sum(CurrentLveDays)
, Sum(CurrentLveHours)
, Sum(PreviousLveIncDays)
, Sum(PreviousLveIncHours)
, Sum(LveAmount)
 FROM LeaveDeductionRecord
WHERE PayRecYear=In_Year
GROUP BY EmployeeSysID
, PayRecYear
, PayRecPeriod
, LeaveTypeFunctCode
) AS A(
EmployeeSysId
, PayRecYear
, PayRecPeriod
, LeaveTypeFunctCode
, CurrentLveDays
, CurrentLveHours
, PreviousLveIncDays
, PreviousLveIncHours
, LveAmount
)
 ORDER BY YTDLveDedEmployeeId, YTDLveDedYear, YTDLveDedPeriod
TO FilePath FORMAT ASCII;

commit work;
    
END;
commit work;