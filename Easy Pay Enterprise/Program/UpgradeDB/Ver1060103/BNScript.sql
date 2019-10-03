READ UpgradeDB\Ver1060103\Keyword_BN.sql;
READ UpgradeDB\Ver1060103\BruneiSecurity_BN.sql;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBruneiCPFFormula') then
   drop function FGetBruneiCPFFormula
end if
;
create function dba.FGetBruneiCPFFormula(
in In_OrdFormulaId char(20),
in In_AddFormulaId char(20))
returns char(255)
begin
  declare Out_AddDesc char(255);
  declare Out_OrdDesc char(255);
  declare OrdFormulaType char(20);
  declare AddFormulaType char(20);
  declare OrdC1 double;
  declare OrdC2 double;
  declare OrdC3 double;
  declare OrdC4 double;
  declare OrdC5 double;
  declare OrdK1 char(20);
  declare AddC1 double;
  declare AddC2 double;
  declare AddC3 double;
  declare AddC4 double;
  declare AddC5 double;
  /*
  To Get Ordinary Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    FGetKeyWordUserDefinedName(Keywords1) into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5,
    OrdK1 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
  /*
  To Get Additional Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5 into AddFormulaType,
    AddC1,
    AddC2,
    AddC3,
    AddC4,
    AddC5 from Formula join FormulaRange where Formula.FormulaId = In_AddFormulaId;
  set Out_OrdDesc=null;
  set Out_AddDesc=null;
  /*
  To check the formula type
  */
  if(OrdFormulaType = 'T1') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,2))+'% of the employee''s '+OrdK1+' for the month'
  end if;
  if(OrdFormulaType = 'T2') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,2))+'% of the employee''s '+OrdK1+' for the month, between ' + LTrim(Str(OrdC2,8,2)) + ' and ' + LTrim(Str(OrdC3,8,2))    
  end if;

  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
    set Out_OrdDesc=Out_OrdDesc+' and ';
    select FDecodeFormula(In_AddFormulaId) into Out_AddDesc
  end if;
  return Out_OrdDesc+Out_AddDesc
end
;

Update Keyword Set KeywordDefaultName = 'Non TAP / SCP Allowance', 
KeywordUserDefinedName = 'Non TAP / SCP Allowance' 
where KeywordId='NonTAPAllowance';

Update Keyword Set 
KeywordDefaultName = 'Non TAP / SCP Deduction',
KeywordUserDefinedName = 'Non TAP / SCP Deduction' 
where KeywordId='NonTAPDeduction';

Update Keyword Set 
KeywordDefaultName = 'TAP / SCP Allowance', 
KeywordUserDefinedName = 'TAP / SCP Allowance' 
where KeywordId='TAPAllowance';

Update Keyword Set 
KeywordDefaultName = 'TAP / SCP Deduction',
KeywordUserDefinedName = 'TAP / SCP Deduction' 
where KeywordId='TAPDeduction';

commit work;