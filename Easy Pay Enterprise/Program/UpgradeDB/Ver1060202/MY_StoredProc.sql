if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxExemptFromEr' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalTaxExemptFromEr
end if;

create function DBA.FGetMalTaxExemptFromEr(
in In_RebateID char(20))
returns integer
begin
  declare Out_result integer;

  select(if In_RebateID in('Petrol Non Official','Petrol Official','Parking','Meal','Childcare','Communication','Loan Interest','Innovation') then
      1 else 0 endif) into Out_result;

  /* 2010
  select(if In_RebateID in('Petrol Non Official','Petrol Official','Parking','Meal','Childcare','Communication','Loan Interest','Innovation','Gift New Computer') then
      1 else 0 endif) into Out_result;
  */

  /* 2009
  select(if In_RebateID in('Petrol Non Official','Petrol Official','Parking','Meal','Childcare','Communication',
  'Employer Goods','Employer Service','Loan Interest','Other Medical','Innovation',
  'Gift New Computer','Lve Passage','Lve Passage Overseas','Foreign Insurance','Group Insurance') then
  1 else 0 endif) into Out_result;
  */
  return(Out_result)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearTaxByYear' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalArrearTaxByYear
end if;

create function DBA.FGetMalArrearTaxByYear(
in In_EmployeeSysId int,
in In_PayRecYear int, 
in In_PayRecPeriod int, 
in In_ArrearYear char(20))
RETURNS double
BEGIN
	DECLARE Out_Tax double;
	   
    Select Sum(UserDef4Value) into Out_Tax From AllowanceRecord join AllowanceHistoryRecord Where
        EmployeeSysId = In_EmployeeSysId And
        PayRecYear = In_PayRecYear And
        PayRecPeriod = In_PayRecPeriod And
        UserDef1Value = In_ArrearYear And
        AllowanceFormulaId in 
            (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');

    if Out_Tax is null then set Out_Tax = 0 end if;
	return Out_Tax;
END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearTax' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalArrearTax
end if;

create function DBA.FGetMalArrearTax(
in In_EmployeeSysId int,
in In_PayRecYear int, 
in In_PayRecPeriod int, 
in In_PayRecId char(20))
RETURNS double
BEGIN
	DECLARE Out_Tax double;
	   
    if (In_PayRecId = '' or In_PayRecId = 'All' or In_PayRecId = 'ALL') then
        Select Sum(UserDef4Value) into Out_Tax From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    else
        Select Sum(UserDef4Value) into Out_Tax From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            PayRecId = In_PayRecId And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    end if;

    if Out_Tax is null then set Out_Tax = 0 end if;
	return Out_Tax;
END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearEREPF' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalArrearEREPF
end if;

create function DBA.FGetMalArrearEREPF(
in In_EmployeeSysId int,
in In_PayRecYear int, 
in In_PayRecPeriod int, 
in In_PayRecId char(20))
RETURNS double
BEGIN
	DECLARE Out_EREPF double;
	   
    if (In_PayRecId = '' or In_PayRecId = 'All' or In_PayRecId = 'ALL') then
        Select Sum(UserDef3Value) into Out_EREPF From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    else
        Select Sum(UserDef3Value) into Out_EREPF From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            PayRecId = In_PayRecId And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    end if;

    if Out_EREPF is null then set Out_EREPF = 0 end if;
	return Out_EREPF;
END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearEEEPFWage' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalArrearEEEPFWage
end if;

create function DBA.FGetMalArrearEEEPFWage(
in In_EmployeeSysId int,
in In_PayRecYear int, 
in In_PayRecPeriod int, 
in In_PayRecId char(20))
RETURNS double
BEGIN
	DECLARE Out_EREPFWage double;
	    
    if (In_PayRecId = '' or In_PayRecId = 'All' or In_PayRecId = 'ALL') then
        Select Sum(UserDef1Value) into Out_EREPFWage From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    else
        Select Sum(UserDef1Value) into Out_EREPFWage From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            PayRecId = In_PayRecId And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    end if;

    if Out_EREPFWage is null then set Out_EREPFWage = 0 end if;
	return Out_EREPFWage;
END;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearEEEPF' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalArrearEEEPF
end if;

create function DBA.FGetMalArrearEEEPF(in In_EmployeeSysId int,
in In_PayRecYear int, 
in In_PayRecPeriod int, 
in In_PayRecId char(20))
RETURNS double
BEGIN
	DECLARE Out_EEEPF double;
	    
    if (In_PayRecId = '' or In_PayRecId = 'All' or In_PayRecId = 'ALL') then
        Select Sum(UserDef2Value) into Out_EEEPF From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    else
        Select Sum(UserDef2Value) into Out_EEEPF From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            PayRecId = In_PayRecId And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
    end if;

    if Out_EEEPF is null then set Out_EEEPF = 0 end if;
	return Out_EEEPF;
END;
