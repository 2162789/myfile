if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveTotalEntitlement') then
   drop procedure FGetLveTotalEntitlement
end if
;

CREATE FUNCTION "DBA"."FGetLveTotalEntitlement"(
in In_LeaveTypeId char(20),
in In_EntEarned double,
in In_EntAdjEarned double,
in In_BFEarned double,
in In_BFForfeit double)
returns double
begin
  declare Out_RoundingMethod char(20);
  declare Out_TotalEntRoundMethod smallint;
  select LeaveRoundMethod,TotalEntRoundMethod into Out_RoundingMethod,Out_TotalEntRoundMethod from LeaveComputation where LeaveComputation.LeaveTypeID = In_LeaveTypeId;
  if Out_RoundingMethod = 'Half' then
    if(Out_TotalEntRoundMethod = 0) then return FRoundHalf(In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit)
    end if;
    if(Out_TotalEntRoundMethod = 1) then return FRoundHalf(In_EntEarned+In_EntAdjEarned)+In_BFEarned-In_BFForfeit
    end if;
    if(Out_TotalEntRoundMethod = 2) then return FRoundHalf(In_EntEarned)+In_EntAdjEarned+In_BFEarned-In_BFForfeit
    end if
  end if;
  if Out_RoundingMethod = 'RoundWhole' then
    if(Out_TotalEntRoundMethod = 0) then return Round(In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit,0)
    end if;
    if(Out_TotalEntRoundMethod = 1) then return Round(In_EntEarned+In_EntAdjEarned,0)+In_BFEarned-In_BFForfeit
    end if;
    if(Out_TotalEntRoundMethod = 2) then return Round(In_EntEarned,0)+In_EntAdjEarned+In_BFEarned-In_BFForfeit
    end if
  end if;
  if Out_RoundingMethod = 'Round' then
    if(Out_TotalEntRoundMethod = 0) then return Round(In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit,2)
    end if;
    if(Out_TotalEntRoundMethod = 1) then return Round(In_EntEarned+In_EntAdjEarned,2)+In_BFEarned-In_BFForfeit
    end if;
    if(Out_TotalEntRoundMethod = 2) then return Round(In_EntEarned,2)+In_EntAdjEarned+In_BFEarned-In_BFForfeit
    end if
  end if;
  if Out_RoundingMethod = 'Fixed' then
    if(Out_TotalEntRoundMethod = 0) then return "TRUNCATE"(In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit+.0000001,2)
    end if;
    if(Out_TotalEntRoundMethod = 1) then return "TRUNCATE"(In_EntEarned+In_EntAdjEarned+.0000001,2)+In_BFEarned-In_BFForfeit
    end if;
    if(Out_TotalEntRoundMethod = 2) then return "TRUNCATE"(In_EntEarned+.0000001,2)+In_EntAdjEarned+In_BFEarned-In_BFForfeit
    end if
  end if;
  if Out_RoundingMethod = 'QuarterToHalf' then
    if(Out_TotalEntRoundMethod = 0) then return FRoundQuarter(In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit)
    end if;
    if(Out_TotalEntRoundMethod = 1) then return FRoundQuarter(In_EntEarned+In_EntAdjEarned)+In_BFEarned-In_BFForfeit
    end if;
    if(Out_TotalEntRoundMethod = 2) then return FRoundQuarter(In_EntEarned)+In_EntAdjEarned+In_BFEarned-In_BFForfeit
    end if
  end if;
  if Out_RoundingMethod = 'TruncWhole' then
    if(Out_TotalEntRoundMethod = 0) then return "TRUNCATE"(In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit,0)
    end if;
    if(Out_TotalEntRoundMethod = 1) then return "TRUNCATE"(In_EntEarned+In_EntAdjEarned,0)+In_BFEarned-In_BFForfeit
    end if;
    if(Out_TotalEntRoundMethod = 2) then return "TRUNCATE"(In_EntEarned,0)+In_EntAdjEarned+In_BFEarned-In_BFForfeit
    end if
  end if;
  return In_EntEarned+In_EntAdjEarned+In_BFEarned-In_BFForfeit
end
;