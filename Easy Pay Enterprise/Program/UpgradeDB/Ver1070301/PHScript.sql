if exists(select * from sys.sysprocedure where proc_name = 'FGetPHICFormula') then
   drop FUNCTION FGetPHICFormula
end if;
create FUNCTION "DBA"."FGetPHICFormula"(
in In_OrdFormulaId char(20),
in In_AddFormulaId char(20)
)
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
    Constant5 into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
  /*
  To Get Additional Formula which currently not in use   
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
  set Out_AddDesc='';
  /*
  To check the formula type
  */
  if(OrdFormulaType = 'T2') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,2))+' * '+LTrim(Str(OrdC2,8,3)) + '%'
  elseif(OrdFormulaType = 'T5') then
    set Out_OrdDesc=LTrim(Str(OrdC2,8,3))+'% of PHIC Wage'
  end if;
  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
  end if;
  return Out_OrdDesc+Out_AddDesc
end
;

commit work;