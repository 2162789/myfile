if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPh1601CPenalties') then
   drop procedure FGetPh1601CPenalties
end if
;

CREATE FUNCTION "DBA"."FGetPh1601CPenalties"(
in In_Ph1601CYear integer, 
in In_Ph1601CMth char(5))
RETURNS double
BEGIN
	DECLARE "Out_Penalties" double;
	    SELECT (PhSurcharge + PhInterest + PhCompromise) into Out_Penalties 
        FROM Ph1601C 
        WHERE Ph1601CYear = In_Ph1601CYear   and Ph1601CMth = In_Ph1601CMth;
	RETURN "Out_Penalties";
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPh1601CAdjustment') then
   drop procedure FGetPh1601CAdjustment
end if
;

CREATE FUNCTION "DBA"."FGetPh1601CAdjustment"(
in In_Ph1601CYear integer, 
in In_Ph1601CMth char(5))
RETURNS double
BEGIN
	DECLARE "Out_Adjustment" double;
	    SELECT sum((Ph1601CSectionA.PhCurrYrAdj + Ph1601CSectionA.PhYrEndAdj)) into Out_Adjustment
        FROM Ph1601C JOIN Ph1601CSectionA
        WHERE Ph1601CSectionA.Ph1601CYear = In_Ph1601CYear   and Ph1601CSectionA.Ph1601CMth = In_Ph1601CMth;
        if (Out_Adjustment is null) then 
        set Out_Adjustment = 0;
        end if;
	RETURN "Out_Adjustment";
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPh1601CDateRemittance') then
   drop procedure FGetPh1601CDateRemittance
end if
;

CREATE FUNCTION "DBA"."FGetPh1601CDateRemittance"(
in In_PhRecYear integer, 
in In_Ph1601CMth char(5))
RETURNS date
BEGIN
	DECLARE "Out_DateRemittance" date;
	    SELECT PhDateRemittance into Out_DateRemittance
        FROM Ph1601C
        WHERE Ph1601CYear = In_PhRecYear and Ph1601CMth = In_Ph1601CMth;
	RETURN "Out_DateRemittance";
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPh1601CRORNo') then
   drop procedure FGetPh1601CRORNo
end if
;

CREATE FUNCTION "DBA"."FGetPh1601CRORNo"(
in In_Ph1601CYear integer, 
in In_Ph1601CMth char(5))
RETURNS char(30)
BEGIN
	DECLARE "Out_RORNo" char(30);
	    SELECT PhRORNo into Out_RORNo
        FROM Ph1601C
        WHERE Ph1601CYear = In_Ph1601CYear and Ph1601CMth = In_Ph1601CMth;
	RETURN "Out_RORNo";
END
;