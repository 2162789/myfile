if exists(select 1 from sys.sysprocedure where proc_name = 'FGetA8AS3C1Value') then
   drop function FGetA8AS3C1Value
end if
;
create function dba.FGetA8AS3C1Value(
in In_PersonalSysId integer,
in In_YEYear integer)
returns double
begin
  declare Out_ValueResult double;
  declare AnnTotalWage double;
  declare C1Percent double;
  declare StartDate date;
  declare EndDate date;
  declare OccDays double;
  set AnnTotalWage=0;
  set C1Percent=0;
  set Out_ValueResult=0;
  //
  // Compute C1 Value
  //
  //
  // 2% X GrossTotal X OccupationDays(A8AS3.Sec3Period where A8AS3.Sec3No = 'A1')
  //    ---------------
  //      365 or 366(leap year)
  //
  //
  // Get Annual Total Wage 
  // 
  select GrossTotal into AnnTotalWage from IR8A where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear and IR8AType = 'CurIR8A';
  if AnnTotalWage is null then
    set AnnTotalWage=0
  end if;
  //
  // Get A8A
  //
  if In_YEYear <= 2011 then
    select Sec3Period into OccDays from A8AS3 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear and Sec3No = 'A1';
  else
    select Sec3Period into OccDays from A8AS3 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear and Sec3No = 'A';
  end if;
  //
  // Get Year Days
  //
  select(cast(In_YEYear as char(4))+'-01-01'),(cast(In_YEYear+1 as char(4))+'-01-01') into StartDate,EndDate;
  //
  // Get C1 Percent
  //
  select YEProperty6 into C1Percent from YEKeyword where YEKeywordId = 'Plus2%';
  //
  // Compute C1 Value
  //
  set Out_ValueResult=ROUND(C1Percent/100.0*OccDays/Days(StartDate,EndDate)*AnnTotalWage,2);
  if Out_ValueResult is null then
    return(0)
  end if;
  return(Out_ValueResult)
end
;

commit work;