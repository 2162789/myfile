/*Severance Pay */

if not exists(select * from keyword where KeywordId = 'SeverancePayCode' ) then
  Insert into keyword(KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,
  KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP) 
  Values('SeverancePayCode','Severance Pay Code','Severance Pay Code','System',1,0,0,'Only available if it has Non Taxabe Code',0,0,0,'G');
end if;

if not exists(select * from keyword where KeywordId = 'SeverancePayTaxCode' ) then
  Insert into keyword(KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,
  KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP) 
  Values('SeverancePayTaxCode','Severance Pay Tax Code','Severance Pay Tax Code','System',1,0,0,'Only available if it has Non Taxabe Code',0,0,0,'G');
end if;


if exists (select 1 from sys.sysprocedure where proc_name = 'FGetIndoTaxPercentage') then
  drop FUNCTION FGetIndoTaxPercentage;
end if;

CREATE FUNCTION "DBA"."FGetIndoTaxPercentage"(
in In_EmployeeSysID char(20),
in In_TaxPolicyID char(20),
in In_TaxYear integer)

RETURNS integer
BEGIN
    DECLARE Out_TaxPercentage integer;
    DECLARE Out_PayRecordPeriod int;
    DECLARE Out_SubPeriodEndDate date;
    DECLARE Out_TaxMonthlyID char(20);
    DECLARE Out_Taxableamount double;
    
    Select First PayRecPeriod,CurOrdinaryWage into Out_PayRecordPeriod,Out_Taxableamount from POLICYRECORD where PayRecYear=In_TaxYear 
    and EmployeeSysID=In_EmployeeSysID order by PayRecYear,PayRecPeriod desc;

    Select First SubPeriodEndDate into Out_SubPeriodEndDate From PayGroupPeriod where PayGroupYear=In_TaxYear and PayGroupPeriod=Out_PayRecordPeriod
    and PaygroupID=FGetPayGroupID(In_EmployeeSysID) order by PayGroupSubPeriod Desc;    

    Select First IndoTaxMonthlyID into Out_TaxMonthlyID From IndoTaxPolicyProg where
    IndoTaxPolicyId =In_TaxPolicyID AND IndoTaxEffectiveDate <=Out_SubPeriodEndDate  Order By IndoTaxEffectiveDate Desc;

    SELECT MIN(IndoTaxRate) into Out_TaxPercentage  from IndoTaxMthFormula 
    WHERE IndoTaxMonthlyId=Out_TaxMonthlyID and Out_Taxableamount<=IndoTaxRangeUpTo;

   RETURN Out_TaxPercentage ;

END;



if exists (select 1 from sys.sysprocedure where proc_name = 'FGetIndoSeverancePay') then
  drop FUNCTION FGetIndoSeverancePay;
end if;


CREATE FUNCTION "DBA"."FGetIndoSeverancePay"(
in In_QueryType char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
   declare In_SeverancePay double;

   if(In_QueryType='SeverancePay') Then
      select Sum(AllowanceAmount) into In_SeverancePay from AllowanceRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and  
      AllowanceFormulaId in
      (Select FormulaId as AllowanceFormulaId From Formula Where 
      (FormulaSubCategory = 'Allowance') And 
      IsFormulaIdHasProperty(FormulaId,'SeverancePayCode') = 1 );
   end if;
 
   if(In_QueryType='SeverancePayTax') Then
     Select Sum(UserDef2Value) into In_SeverancePay From AllowanceHistoryRecord 
     where AllowanceSGSPGenId in
     (Select  AllowanceSGSPGENID from AllowanceRecord Where 
     EmployeeSysId = In_EmployeeSysId and
     PayRecYear = In_PayRecYear and
     AllowanceFormulaId in
    (Select FormulaId as AllowanceFormulaId From Formula Where
    (FormulaSubCategory = 'Deduction') And
    IsFormulaIdHasProperty(FormulaId,'SeverancePayTaxCode') = 1 ) ) ;
   end if;

   if(In_QueryType='SeverancePayTaxPer') Then
     Select Top 1 UserDef1Value into In_SeverancePay From AllowanceHistoryRecord 
     where AllowanceSGSPGenId in
     (Select  AllowanceSGSPGENID from AllowanceRecord Where 
     EmployeeSysId = In_EmployeeSysId and
     PayRecYear = In_PayRecYear and
     AllowanceFormulaId in
    (Select FormulaId as AllowanceFormulaId From Formula Where
    (FormulaSubCategory = 'Deduction') And
    IsFormulaIdHasProperty(FormulaId,'SeverancePayTaxCode') = 1 ) ) 
    Order by UserDef1Value desc ;
   end if;

 if In_SeverancePay >0 then return In_SeverancePay
 end if;

 return 0;

end;





/*Show/Hide Menu */

if not exists (select 1 from KeyWord where KeyWordId = 'IncomeTaxReports') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('IncomeTaxReports','InvokeIndoTaxSubmission','Income Tax Reports','Reports','','','','RIndoIncomeTax.dll',5,0,0,'');
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'Final(1721-III)') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('Final(1721-III)','InvokeIndoTax1721FinalCSV','Bukit Potong Final CSV','Submissions','','','','RIndoIncomeTax.dll',4,1,0,'');
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'TidakFinal(1721-II)') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('TidakFinal(1721-II)','InvokeIndoTax1721TidakFinalCSV','Bukit Potong Tidak Final CSV','Submissions','','','','RIndoIncomeTax.dll',5,1,0,'');
end if;

/*Module Screen*/

If Not Exists(Select MODULESCREENID From ModuleScreenGroup Where MODULESCREENID='PayTax1721FinalCSV') Then
Insert Into ModuleScreenGroup(MODULESCREENID,MOD_MODULESCREENID,MODULESCREENNAME,MAINMODULENAME,HIDEONLYWAGE,HIDESCREENFORWAGE,ISEPCLASSIC,EC_MODULESCREENID)
Values('PayTax1721FinalCSV','PayeSPTImport','Bukit Potong Final CSV','Pay',0,1,0,'');
End If;

If Not Exists(Select MODULESCREENID From ModuleScreenGroup Where MODULESCREENID='PayTax1721TidakFinal') Then
Insert Into ModuleScreenGroup(MODULESCREENID,MOD_MODULESCREENID,MODULESCREENNAME,MAINMODULENAME,HIDEONLYWAGE,HIDESCREENFORWAGE,ISEPCLASSIC,EC_MODULESCREENID)
Values('PayTax1721TidakFinal','PayeSPTImport','Bukit Potong Tidak Final CSV','Pay',0,1,0,'');
End If;

commit work;