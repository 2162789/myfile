IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeBank1') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeBank1";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeBank1" AS 
 SELECT Employee.EmployeeId
, Employee.EmployeeName
, Bank1.BankAccountNo AS Bank1AccountNo
, Bank1.BankAccTypeId AS Bank1AccTypeId
, Bank1.BankBranchId AS Bank1BranchId
, Bank1.BankId AS Bank1Id
, Bank1.BankRemarks AS Bank1Remarks
, Bank1.PaymentMode AS Bank1PaymentMode
, Bank1.PaymentType AS Bank1PaymentType
 FROM Employee
 LEFT OUTER JOIN PaymentBankInfo AS Bank1 ON (Bank1.EmployeeSysId =Employee.EmployeeSysId
  AND Bank1.PayBankSGSPGenId IN (SELECT MIN(PayBankSGSPGenId) FROM  PaymentBankInfo GROUP BY EmployeeSysId))