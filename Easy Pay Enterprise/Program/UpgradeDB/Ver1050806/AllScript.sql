if exists(select 1 from sys.sysprocedure where proc_name = 'DBMergeYTDImport') then
   drop procedure DBMergeYTDImport
end if
;

create procedure DBA.DBMergeYTDImport(in In_FilePath char(50)) 
BEGIN

DECLARE FilePath char(50);    
IF LENGTH(In_FilePath)=0 then
    SET In_FilePath='c:\\temp';
END IF;      

/*------ Import to iYTDGeneral ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDGeneral.txt';
LOAD TABLE iYTDGeneral 
(
YTDEmployeeId
, YTDYear
, YTDStartPeriod
, YTDEndPeriod
, BasicRateType
, AllocatedBasicRate
, AllocatedMVC
, AllocatedNWC
, BackPay
, CurrentHrDay
, BefAdjHrDay
, BackPayHrDay
, SickLeaveTaken
, AnnualLeaveTaken
, OTAmount
, OTBackPayAmount
, ShiftAmount
, LeaveDeductionAmount
, FreeNumeric1
, FreeNumeric2
, FreeNumeric3
, FreeNumeric4
, FreeNumeric5
, FreeString1
, FreeString2
, FreeString3
, FreeString4
, FreeString5
, Processed
, ProcessedDateTime
, ErrorMessage
, CreatedBy
, InterfaceGranted
) FROM FilePath DEFAULTS ON FORMAT ASCII;


/*------ Import to iYTDSGPolicy ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDSGPolicy.txt';
LOAD TABLE iYTDSGPolicy 
(
YTDSGPolicyEmployeeId
, YTDSGPolicyYear
, YTDSGPolicyPeriod
, TotalContriEECPF
, TotalContriERCPF
, ContriOrdEECPF
, ContriOrdERCPF
, ContriAddEECPF
, ContriAddERCPF
, SupIR8AOrdEECPF
, SupIR8AOrdERCPF
, SupIR8AAddEECPF
, SupIR8AAddERCPF
, CPFClass
, CPFStatus
, OverseasEECPF
, OverseasERCPF
, ContriFWL
, ContriSDF
, Processed
, ProcessedDateTime
, ErrorMessage
, CreatedBy
, InterfaceGranted
, MediSaveOrdinary
, MediSaveAdditional
) FROM FilePath DEFAULTS ON FORMAT ASCII;

/*------ Import to iYTDAllowanceRecord ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDAllowanceRecord.txt';
LOAD TABLE iYTDAllowanceRecord 
(
AllowanceEmployeeID
, PayRecYear
, PayRecPeriod
, AllowanceID
, AllowanceAmount
, AllowanceRemarks
, AllowanceDeclaredDate
, Processed
, ProcessedDateTime
, ErrorMessage
, CreatedBy
, InterfaceGranted
) FROM FilePath DEFAULTS ON FORMAT ASCII ;

/*------ Import to iYTDOTRecord  ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDOTRecord.txt';
LOAD TABLE iYTDOTRecord   
(
YTDOTEmployeeId
, YTDOTYear
, YTDOTPeriod
, YTDOTId
, CurrentOTFreq
, CurrentOTAmt
, LastOTFreq
, LastOTAmt
, BackPayOTFreq
, BackPayOTAmt
, Processed
, ProcessedDateTime
, ErrorMessage
, CreatedBy
, InterfaceGranted
) FROM FilePath DEFAULTS ON FORMAT ASCII ;


/*------ Import to iYTDShiftRecord  ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDShiftRecord.txt';
LOAD TABLE iYTDShiftRecord  
(
YTDShiftEmployeeId
, YTDShiftYear
, YTDShiftPeriod
, YTDShiftId
, ShiftFrequency
, ShiftAmount
, Processed
, ProcessedDateTime
, ErrorMessage
, CreatedBy
, InterfaceGranted
) FROM FilePath DEFAULTS ON FORMAT ASCII;


/*------ Import to iYTDLeaveDeductionRecord  ------*/
SET FilePath=In_FilePath + '\\ExportToiYTDLeaveDeductionRecord.txt';
LOAD TABLE iYTDLeaveDeductionRecord  
(
YTDLveDedEmployeeId
, YTDLveDedYear
, YTDLveDedPeriod
, YTDLveTypeFunctCode
, CurrentLveDays
, CurrentLveHours
, PreviousLveIncDays
, PreviousLveIncHours
, LveAmount
, Processed
, ProcessedDateTime
, ErrorMessage
, CreatedBy
, InterfaceGranted
) FROM FilePath DEFAULTS ON FORMAT ASCII;


commit work;


END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetRelationshipDesc') then
   drop procedure FGetRelationshipDesc 
end if
;

create function DBA.FGetRelationshipDesc(
in In_RelationshipId char(20))
RETURNS char(100)
BEGIN
	DECLARE Out_RelationshipDesc char(100);
	
    SELECT RelationshipDesc INTO Out_RelationshipDesc FROM Relationship WHERE RelationshipId = In_RelationshipId;
    RETURN Out_RelationshipDesc;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1BankAccNo') then
   drop procedure FGetPaymentBank1BankAccNo
end if
;

create function DBA.FGetPaymentBank1BankAccNo(in In_EmployeeSysId integer)
RETURNS CHAR(30)
BEGIN
	DECLARE Out_BankAccNo char(30);
	
    SELECT FIRST BankAccountNo into Out_BankAccNo FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_BankAccNo = null THEN
        SET Out_BankAccNo = ''
    END IF;

	RETURN Out_BankAccNo;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1BankAllocGrpId') then
   drop procedure FGetPaymentBank1BankAllocGrpId
end if
;

create function DBA.FGetPaymentBank1BankAllocGrpId(in In_EmployeeSysId integer)
RETURNS char(20)
BEGIN
	DECLARE Out_BankAllocGrpId char(20);
	
    SELECT FIRST BankAllocGpId into Out_BankAllocGrpId FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_BankAllocGrpId = null THEN
        SET Out_BankAllocGrpId = ''
    END IF;

	RETURN Out_BankAllocGrpId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1BankBranchId') then
   drop procedure FGetPaymentBank1BankBranchId
end if
;

create function DBA.FGetPaymentBank1BankBranchId(in In_EmployeeSysId integer)
RETURNS CHAR(20)
BEGIN
	DECLARE Out_BankBranchId char(20);
	
    SELECT FIRST BankBranchId into Out_BankBranchId FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_BankBranchId = null THEN
        SET Out_BankBranchId = ''
    END IF;

	RETURN Out_BankBranchId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1BankId') then
   drop procedure FGetPaymentBank1BankId
end if
;

create function DBA.FGetPaymentBank1BankId(in In_EmployeeSysId integer)
RETURNS CHAR(20)
BEGIN
	DECLARE Out_BankId char(20);
	
    SELECT FIRST BankId into Out_BankId FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_BankId = null THEN
        SET Out_BankId = ''
    END IF;

	RETURN Out_BankId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1BeneficiaryName') then
   drop procedure FGetPaymentBank1BeneficiaryName
end if
;

create function DBA.FGetPaymentBank1BeneficiaryName(in In_EmployeeSysId integer)
RETURNS CHAR(150)
BEGIN
	DECLARE Out_BeneficiaryName char(150);
	
    SELECT FIRST BeneficiaryName into Out_BeneficiaryName FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_BeneficiaryName = null THEN
        SET Out_BeneficiaryName = ''
    END IF;

	RETURN Out_BeneficiaryName;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1PaymentType') then
   drop procedure FGetPaymentBank1PaymentType
end if
;

create function DBA.FGetPaymentBank1PaymentType(in In_EmployeeSysId integer)
RETURNS CHAR(20)
BEGIN
	DECLARE Out_PaymentType char(20);
	
    SELECT FIRST PaymentType into Out_PaymentType FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_PaymentType = null THEN
        SET Out_PaymentType = ''
    END IF;

	RETURN Out_PaymentType;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank1PaymentValue') then
   drop procedure FGetPaymentBank1PaymentValue
end if
;

create function DBA.FGetPaymentBank1PaymentValue(in In_EmployeeSysId integer)
RETURNS DOUBLE
BEGIN
	DECLARE Out_PaymentValue double;
	
    SELECT FIRST PaymentValue into Out_PaymentValue FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Out_PaymentValue = null THEN
        SET Out_PaymentValue = 0
    END IF;

	RETURN Out_PaymentValue;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2BankAccNo') then
   drop procedure FGetPaymentBank2BankAccNo
end if
;

create function DBA.FGetPaymentBank2BankAccNo(in In_EmployeeSysId integer)
RETURNS CHAR(30)
BEGIN
	DECLARE Out_BankAccNo char(30);
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1BankAccNo char(30);
	
    SELECT FIRST PayBankSGSPGenId, BankAccountNo into Bank1PayBankSGSPGenId, Bank1BankAccNo FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1BankAccNo = null THEN
        SET Out_BankAccNo = ''
    ELSE
        SELECT FIRST BankAccountNo into Out_BankAccNo FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_BankAccNo = null THEN 
            SET Out_BankAccNo = ''
        END IF
    END IF;

	RETURN Out_BankAccNo;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2BankAllocGrpId') then
   drop procedure FGetPaymentBank2BankAllocGrpId
end if
;

create function DBA.FGetPaymentBank2BankAllocGrpId(in In_EmployeeSysId integer)
RETURNS char(20)
BEGIN
	DECLARE Out_BankAllocGrpId char(20);
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1BankAllocGrpId char(20);
	
    SELECT FIRST PayBankSGSPGenId, BankAllocGpId into Bank1PayBankSGSPGenId, Bank1BankAllocGrpId FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1BankAllocGrpId = null THEN
        SET Out_BankAllocGrpId = ''
    ELSE
        SELECT FIRST BankAllocGpId into Out_BankAllocGrpId FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_BankAllocGrpId = null THEN 
            SET Out_BankAllocGrpId = ''
        END IF
    END IF;

	RETURN Out_BankAllocGrpId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2BankBranchId') then
   drop procedure FGetPaymentBank2BankBranchId
end if
;

create function DBA.FGetPaymentBank2BankBranchId(in In_EmployeeSysId integer)
RETURNS CHAR(20)
BEGIN
	DECLARE Out_BankBranchId char(20);
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1BankBranchId char(20);
	
    SELECT FIRST PayBankSGSPGenId, BankBranchId into Bank1PayBankSGSPGenId, Bank1BankBranchId FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1BankBranchId = null THEN
        SET Out_BankBranchId = ''
    ELSE
        SELECT FIRST BankBranchId into Out_BankBranchId FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_BankBranchId = null THEN 
            SET Out_BankBranchId = ''
        END IF
    END IF;

	RETURN Out_BankBranchId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2BankId') then
   drop procedure FGetPaymentBank2BankId
end if
;

create function DBA.FGetPaymentBank2BankId(in In_EmployeeSysId integer)
RETURNS CHAR(20)
BEGIN
	DECLARE Out_BankId char(20);
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1BankId char(20);
	
    SELECT FIRST PayBankSGSPGenId, BankId into Bank1PayBankSGSPGenId, Bank1BankId FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1BankId = null THEN
        SET Out_BankId = ''
    ELSE
        SELECT FIRST BankId into Out_BankId FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_BankId = null THEN 
            SET Out_BankId = ''
        END IF
    END IF;

	RETURN Out_BankId;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2BeneficiaryName') then
   drop procedure FGetPaymentBank2BeneficiaryName
end if
;

create function DBA.FGetPaymentBank2BeneficiaryName(in In_EmployeeSysId integer)
RETURNS CHAR(150)
BEGIN
	DECLARE Out_BeneficiaryName char(150);
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1BeneficiaryName char(30);
	
    SELECT FIRST PayBankSGSPGenId, BeneficiaryName into Bank1PayBankSGSPGenId, Bank1BeneficiaryName FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1BeneficiaryName = null THEN
        SET Out_BeneficiaryName = ''
    ELSE
        SELECT FIRST BeneficiaryName into Out_BeneficiaryName FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_BeneficiaryName = null THEN 
            SET Out_BeneficiaryName = ''
        END IF
    END IF;

	RETURN Out_BeneficiaryName;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2PaymentType') then
   drop procedure FGetPaymentBank2PaymentType
end if
;

create function DBA.FGetPaymentBank2PaymentType(in In_EmployeeSysId integer)
RETURNS CHAR(30)
BEGIN
	DECLARE Out_PaymentType char(30);
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1PaymentType char(30);
	
    SELECT FIRST PayBankSGSPGenId, PaymentType into Bank1PayBankSGSPGenId, Bank1PaymentType FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1PaymentType = null THEN
        SET Out_PaymentType = ''
    ELSE
        SELECT FIRST PaymentType into Out_PaymentType FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_PaymentType = null THEN 
            SET Out_PaymentType = ''
        END IF
    END IF;

	RETURN Out_PaymentType;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPaymentBank2PaymentValue') then
   drop procedure FGetPaymentBank2PaymentValue
end if
;

create function DBA.FGetPaymentBank2PaymentValue(in In_EmployeeSysId integer)
RETURNS DOUBLE
BEGIN
	DECLARE Out_PaymentValue double;
    DECLARE Bank1PayBankSGSPGenId char(30);
    DECLARE Bank1PaymentValue double;
	
    SELECT FIRST PayBankSGSPGenId, PaymentValue into Bank1PayBankSGSPGenId, Bank1PaymentValue FROM PaymentBankInfo 
    WHERE EmployeeSysId = In_EmployeeSysId ORDER BY PayBankSGSPGenId;

    IF Bank1PaymentValue = null THEN
        SET Out_PaymentValue = 0
    ELSE
        SELECT FIRST PaymentValue into Out_PaymentValue FROM PaymentBankInfo
        WHERE EmployeeSysId = In_EmployeeSysId AND PayBankSGSPGenId <> Bank1PayBankSGSPGenId ORDER BY PayBankSGSPGenId;

        IF Out_PaymentValue = null THEN 
            SET Out_PaymentValue = 0
        END IF
    END IF;

	RETURN Out_PaymentValue;
END
;

commit work;

IF NOT EXISTS (SELECT * FROM "DBA"."ModuleScreenGroup" WHERE ModuleScreenId = 'HRTrainingSummary')
THEN
  INSERT INTO ModuleScreenGroup
  VALUES ('HRTrainingSummary','HRTrainingMod','Training Summary','HR',0,0,0,'');
END IF;
COMMIT WORK;