/*
*  Create a stored procedure to get Swift Code based on Company Bank
*/
IF EXISTS (select * from sys.sysprocedure where proc_name = 'FGetCompanyBankSwiftCode') THEN
   DROP FUNCTION FGetCompanyBankSwiftCode;
END IF;
CREATE FUNCTION "DBA"."FGetCompanyBankSwiftCode"(
in In_AccountNo char(50))
returns char(100)
begin
  declare Out_CompanyBankSwiftCode char(100);
  
  SELECT BankBranchString1 Into Out_CompanyBankSwiftCode from BankBranch bb JOIN CompanyBank cb ON bb.BankId = cb.ComBankCode
  AND bb.BankBranchId = cb.ComBankBranchCode
  WHERE cb.ComAccountNo = In_AccountNo;
  
  return Out_CompanyBankSwiftCode;
END;

commit work;