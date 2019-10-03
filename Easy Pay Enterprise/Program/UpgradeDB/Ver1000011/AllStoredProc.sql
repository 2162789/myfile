if exists(select 1 from sys.sysprocedure where proc_name = 'IsEPClassicDB') then
   drop procedure IsEPClassicDB
end if
;

CREATE FUNCTION "DBA"."IsEPClassicDB"()
returns smallint
begin
  declare Out_IsEPClassic smallint;

  select locate(FunctionList, 'EP Standard', 1) into Out_IsEPClassic 
    from LicenseRecord where 
    ProductName = 'Easy Pay Enterprise' and 
    SubProductName = 'Main' and
    length(FunctionList) > 0;

  return(Out_IsEPClassic)
end
;