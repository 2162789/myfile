if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLoanTypeDesc' and user_name(creator) = 'DBA') then
   drop function DBA.FGetLoanTypeDesc
end if;

create function DBA.FGetLoanTypeDesc(in In_LoanFromId char(20),
in In_LoanTypeId char(20))
returns char(100)
begin
  declare Out_LoanTypeDesc char(100);
  select LoanTypeDesc into Out_LoanTypeDesc from LoanType where
    LoanFromId = In_LoanFromId and
    LoanTypeId = In_LoanTypeId;
  return(Out_LoanTypeDesc)
end;

