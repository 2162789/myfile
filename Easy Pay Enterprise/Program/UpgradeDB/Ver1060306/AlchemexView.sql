IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeDetails') THEN
    DROP VIEW View_Alc_EmployeeDetails;
END IF;

CREATE VIEW DBA.View_Alc_EmployeeDetails AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, Bank1.BankAccountNo AS Bank1AccountNo
, Bank1.BankAccTypeId AS Bank1AccTypeId
, Bank1.BankBranchId AS Bank1BranchId
, Bank1.BankId AS Bank1Id
, Bank1.BankRemarks AS Bank1Remarks
, Bank1.PaymentMode AS Bank1PaymentMode
, Bank1.PaymentType AS Bank1PaymentType
, Bank2.BankAccountNo AS Bank2AccountNo
, Bank2.BankAccTypeId AS Bank2AccTypeId
, Bank2.BankBranchId AS Bank2BranchId
, Bank2.BankId AS Bank2Id
, Bank2.BankRemarks AS Bank2Remarks
, Bank2.PaymentMode AS Bank2PaymentMode
, Bank2.PaymentType AS Bank2PaymentType
, CPFProgression.CPFMAWLimit AS CPFMAWLimit
, CPFProgression.CPFMAWOption AS CPFMAWOption
, CPFProgression.CPFProgAccountNo AS CPFProgAccountNo
, CPFProgression.CPFProgPolicyId AS CPFProgPolicyId
, CPFProgression.CPFProgSchemeId AS CPFProgSchemeId
, EmpeeWkCalen.CalendarId AS CalendarId
, Employee.BranchId AS BranchId
, Employee.CategoryId AS CategoryId
, Employee.CessationCode AS CessationCode
, Employee.CessationDate AS CessationDate
, Employee.ClassificationCode AS ClassificationCode
, Employee.ConfirmationDate AS ConfirmationDate
, Employee.CustBoolean1 AS CustBoolean1
, Employee.CustBoolean2 AS CustBoolean2
, Employee.CustBoolean3 AS CustBoolean3
, Employee.CustDate1 AS CustDate1
, Employee.CustDate2 AS CustDate2
, Employee.CustDate3 AS CustDate3
, Employee.CustInteger1 AS CustInteger1
, Employee.CustInteger2 AS CustInteger2
, Employee.CustInteger3 AS CustInteger3
, Employee.CustNumeric1 AS CustNumeric1
, Employee.CustNumeric2 AS CustNumeric2
, Employee.CustNumeric3 AS CustNumeric3
, Employee.CustString1 AS CustString1
, Employee.CustString2 AS CustString2
, Employee.CustString3 AS CustString3
, Employee.CustString4 AS CustString4
, Employee.CustString5 AS CustString5
, Employee.DepartmentId AS DepartmentId
, Employee.EmpCode1Id AS EmpCode1Id
, Employee.EmpCode2Id AS EmpCode2Id
, Employee.EmpCode3Id AS EmpCode3Id
, Employee.EmpCode4Id AS EmpCode4Id
, Employee.EmpCode5Id AS EmpCode5Id
, Employee.HireDate AS HireDate
, FGetMVCCurrentAccPercent(Employee.EmployeeSysId) AS MVCCurrentAccPercent
, Employee.PositionId AS PositionId
, Employee.ResidenceStatus AS ResidenceStatus
, FGetResidenceTypeDesc(Employee.ResidenceStatus) as ResidenceStatusDesc
, Employee.RetirementDate AS RetirementDate
, Employee.SalaryGradeId AS SalaryGradeId
, Employee.SectionId AS SectionId
, Employee.Supervisor AS Supervisor
, FGetEmployeeCurrentTotalWage(Employee.EmployeeSysId) AS TotalWage
, EmployPassProgression.EPFin AS EPFin
, FWLProgression.FWLFormulaId AS FWLFormulaId
, FWLProgression.FWLPermitNumber AS FWLPermitNumber
, PayEmployee.BasicRateExchangeId AS BasicRateExchangeId
, PayEmployee.BonusFactor AS BonusFactor
, PayEmployee.CurrentBasicRate AS CurrentBasicRate
, PayEmployee.CurrentBasicRateType AS CurrentBasicRateType
, PayEmployee.EEHoursperDay AS EEHoursperDay
, PayEmployee.LastPayDate AS LastPayDate
, PayEmployee.OTTableId AS OTTableId
, PayEmployee.ShiftTableId AS ShiftTableId
, PayEmployeePolicy.CurrentMVC AS CurrentMVC
, PayEmployeePolicy.CurrentNWC AS CurrentNWC
, Personal.Alias AS Alias
, Personal.BloodGroupId AS BloodGroupId
, Personal.CountryOfBirth AS CountryOfBirth
, Personal.DateOfBirth AS DateOfBirth
, Personal.Gender AS Gender
, Personal.Height AS Height
, Personal.IdentityNo AS IdentityNo
, Personal.IdentityTypeId AS IdentityTypeId
, Personal.Mal_OldIdentity AS Mal_OldIdentity
, Personal.MaritalStatusCode AS MaritalStatusCode
, Personal.Nationality AS Nationality
, Personal.PassportIssue AS PassportIssue
, Personal.RaceId AS RaceId
, FGetRaceDesc(Personal.RaceId) as RaceDesc
, Personal.ReligionID AS ReligionID
, Personal.TitleId AS TitleId
, Personal.Weight AS Weight
, PersonalAddress.CustString1 AS PersonalAddCustString1
, PersonalAddress.CustString2 AS PersonalAddCustString2
, PersonalAddress.CustString3 AS PersonalAddCustString3
, PersonalAddress.CustString4 AS PersonalAddCustString4
, PersonalAddress.CustString5 AS PersonalAddCustString5
, PersonalAddress.PersonalAddAddress AS PersonalAddAddress
, PersonalAddress.PersonalAddAddress2 AS PersonalAddAddress2
, PersonalAddress.PersonalAddAddress3 AS PersonalAddAddress3
, PersonalAddress.PersonalAddCity AS PersonalAddCity
, PersonalAddress.PersonalAddCountry AS PersonalAddCountry
, PersonalAddress.PersonalAddPCode AS PersonalAddPCode
, PersonalAddress.PersonalAddState AS PersonalAddState
, PersonalContact.ContactNumber AS ContactNumber
, PersonalEmail.PersonalEmail AS PersonalEmail
, Education.EduLevelId As EduLevelId
  FROM Employee
 LEFT OUTER JOIN PaymentBankInfo AS Bank1 ON (Bank1.EmployeeSysId =Employee.EmployeeSysId
  AND Bank1.PayBankSGSPGenId IN (SELECT MIN(PayBankSGSPGenId) FROM  PaymentBankInfo GROUP BY EmployeeSysId))
 LEFT OUTER JOIN PaymentBankInfo as Bank2  ON (Bank2.EmployeeSysId=Employee.EmployeeSysId
 AND Bank2.PayBankSGSPGenId IN (SELECT MIN(PayBankSGSPGenId) FROM PaymentBankInfo 
 WHERE PayBankSGSPGenId  NOT IN (SELECT MIN(PayBankSGSPGenId) FROM  PaymentBankInfo GROUP BY EmployeeSysId) GROUP BY 

EmployeeSysId))
 LEFT OUTER JOIN CPFProgression ON (CPFProgression.EmployeeSysId=Employee.EmployeeSysId AND CPFProgCurrent=1)
 LEFT OUTER JOIN EmpeeWkCalen
 LEFT OUTER JOIN EmployPassProgression ON (EmployPassProgression.EmployeeSysId=Employee.EmployeeSysId AND EPCurrent=1)
 LEFT OUTER JOIN FWLProgression ON (FWLProgression.EmployeeSysId=Employee.EmployeeSysId AND FWLCurrent=1)
 LEFT OUTER JOIN PayEmployee
 LEFT OUTER JOIN PayEmployeePolicy
 LEFT OUTER JOIN Personal
 LEFT OUTER JOIN PersonalAddress ON(Employee.PersonalSysId=PersonalAddress.PersonalSysId AND PersonalAddMailing=1)
 LEFT OUTER JOIN PersonalContact ON(Employee.PersonalSysId=PersonalContact.PersonalSysId AND 

PersonalContact.ContactLocationId='ePortal')
 LEFT OUTER JOIN PersonalEmail ON(Employee.PersonalSysId=PersonalEmail.PersonalSysId AND 

PersonalEmail.ContactLocationId='ePortal')
 LEFT OUTER JOIN Education ON (Employee.HighestEduCode=Education.EducationId)
;

IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LveApplication') THEN
    DROP VIEW View_Alc_LveApplication;
END IF;

CREATE VIEW DBA.View_Alc_LveApplication AS 
SELECT EmployeeId, EmployeeName
, A.LeaveTypeId
, LeaveTypeDesc
, LveAppFromDate
, LveAppStartTime
, LveAppToDate
, LveAppEndTime
, LeaveReasonId
, LveAppIsHour
, LveRecApproved
, Remarks
, [Status]
, LastModified 
FROM(
    LeaveApplication AS A JOIN LeaveType AS B) NATURAL JOIN Employee AS C
;

IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='ASQLGrantSelect') THEN
    DROP PROCEDURE ASQLGrantSelect;
END IF;
CREATE PROCEDURE DBA.ASQLGrantSelect(In In_UserID char(20))
BEGIN
	GrantLoop: for GrantFor as GrantCurs dynamic scroll cursor for
    SELECT table_name AS In_TableName FROM SysTable WHERE table_type='VIEW' AND table_name LIKE 'View_Alc%' do
    EXECUTE IMMEDIATE ('GRANT SELECT ON ' + In_TableName + ' TO ' + In_UserID);
    end for;
    
	GrantExeLoop: for GrantExeFor as GrantExeCurs dynamic scroll cursor for
	SELECT proc_name as In_ProcName from SysProcedure where Creator=1 and proc_defn like 'create function%' do
    EXECUTE IMMEDIATE ('GRANT EXECUTE ON ' + In_ProcName + ' TO ' + In_UserID);
    end for;
END;

CALL DBA.ASQLGrantSelect('AlchemexUser');
DROP Procedure DBA.ASQLGrantSelect;

commit work;