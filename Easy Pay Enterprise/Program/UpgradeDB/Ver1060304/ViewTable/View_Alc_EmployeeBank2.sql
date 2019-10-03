IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeBank2') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeBank2";
END IF;


CREATE VIEW "DBA"."View_Alc_EmployeeBank2" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, Bank2.BankAccountNo AS Bank2AccountNo
, Bank2.BankAccTypeId AS Bank2AccTypeId
, Bank2.BankBranchId AS Bank2BranchId
, Bank2.BankId AS Bank2Id
, Bank2.BankRemarks AS Bank2Remarks
, Bank2.PaymentMode AS Bank2PaymentMode
, Bank2.PaymentType AS Bank2PaymentType
 FROM Employee
 LEFT OUTER JOIN PaymentBankInfo as Bank2  ON (Bank2.EmployeeSysId=Employee.EmployeeSysId
 AND Bank2.PayBankSGSPGenId IN (SELECT MIN(PayBankSGSPGenId) FROM PaymentBankInfo 
 WHERE PayBankSGSPGenId  NOT IN (SELECT MIN(PayBankSGSPGenId) FROM  PaymentBankInfo GROUP BY EmployeeSysId) GROUP BY EmployeeSysId))