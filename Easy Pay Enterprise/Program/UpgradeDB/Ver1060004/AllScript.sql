if exists(select 1 from sys.sysviews where viewname = 'View_SYSCOLUMNS') then
  drop view View_SYSCOLUMNS
end if
;

CREATE VIEW DBA.View_SYSCOLUMNS
    AS
  SELECT 
  SYS.SYSCOLUMNS.ColType AS ColType,  
  SYS.SYSCOLUMNS.TName AS TName,
  SYS.SYSCOLUMNS.CName AS CName,
  SYS.SYSCOLUMNS.Length AS Length,
  SYS.SYSCOLUMNS.SysLength AS SysLength,
  SYS.SYSCOLUMNS.ColNo AS ColNo,
  SYS.SYSCOLUMNS.In_Primary_Key AS In_Primary_Key,
  SYS.SYSCOLUMNS.Default_Value AS Default_Value,
  SYS.SYSCOLUMNS.Nulls AS Allow_Nulls   
  FROM SYS.SYSCOLUMNS
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGenNewCalendarYear') then
   drop PROCEDURE ASQLGenNewCalendarYear
end if
;

create PROCEDURE DBA.ASQLGenNewCalendarYear(
in In_CalendarId char(20),
in In_CalendarYear integer)
begin
  declare Count_GroupWorkPattern integer;
  declare Count_GroupLeavePattern integer;
  declare Int_NewFollowingYearDays integer;
  declare @DaysCounter integer;
  declare Date_ActualDate date;
  declare Flag_PublicHoliday smallint;
  declare Int_WeekNo integer;
  declare N84_WorkPattern numeric(8,4);
  declare N84_LeavePattern numeric(8,4);
  declare Char_CountryCode char(20);
  declare Char_WeekWorkPattern char(20);
  declare Char_WeekLeavePattern char(20);
  select Calendar.CountryCode into Char_CountryCode
    from Calendar where
    Calendar.CalendarId = In_CalendarId;
  select COUNT(GroupWorkPattern.CalendarId) into Count_GroupWorkPattern
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarId;
  select COUNT(GroupLeavePattern.CalendarId) into Count_GroupLeavePattern
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarId;
  set Int_NewFollowingYearDays=DATEDIFF(day,YMD(In_CalendarYear-1,12,31),YMD(In_CalendarYear,12,31));
  set @DaysCounter=0;
  set Int_WeekNo=0;
  GenNewFollowingYearDaysLoop:

  while @DaysCounter < Int_NewFollowingYearDays loop
    set @DaysCounter=@DaysCounter+1;
    set Date_ActualDate=DATEADD(Day,@DaysCounter,YMD(In_CalendarYear-1,12,31));
    set Int_WeekNo=WEEKS(Date_ActualDate)-(WEEKS(YMD(In_CalendarYear,1,1))-1);
    set N84_WorkPattern=FGetWorkPattern(In_CalendarId,Date_ActualDate,Int_WeekNo,Count_GroupWorkPattern);   
    set Char_WeekWorkPattern=FGetWeekWorkPattern(In_CalendarId,Int_WeekNo,Count_GroupWorkPattern);    
    if exists(select* from Holidays where
        Holidays.CountryId = Char_CountryCode and
        (Holidays.HolidayStartDate >= Date_ActualDate and
        Holidays.HolidayEndDate <= Date_ActualDate)) then
      set Flag_PublicHoliday=1;
      set N84_LeavePattern=0;
      set Char_WeekLeavePattern=''
    else
      set Flag_PublicHoliday=0;
      set N84_LeavePattern=FGetLeavePattern(In_CalendarId,Date_ActualDate,Int_WeekNo,Count_GroupLeavePattern);
      set Char_WeekLeavePattern=FGetWeekLeavePattern(In_CalendarId,Int_WeekNo,Count_GroupLeavePattern);
    end if;

    insert into CalendarDay(CalendarDate,
      CalendarIdCode,DateType,
      PublicHoliday,WeekNo,
      WkCalenDayWkPattern,WkCalenDayLvePattern,
      WeekWorkPatternCode,WeekLeavePatternCode) values(
      Date_ActualDate,
      In_CalendarId,DAYNAME(Date_ActualDate),
      Flag_PublicHoliday,Int_WeekNo,
      N84_WorkPattern,N84_LeavePattern,
      Char_WeekWorkPattern,Char_WeekLeavePattern)
  end loop GenNewFollowingYearDaysLoop;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalendarDayUpdatePHolidayWeek') then
   drop PROCEDURE ASQLCalendarDayUpdatePHolidayWeek
end if
;

CREATE PROCEDURE DBA.ASQLCalendarDayUpdatePHolidayWeek(
in In_HolidayId char(20),
in In_PublicHolidayDate date,
in In_CountryCode char(20))
begin
  declare Get_HolidayLvePattern double;
  declare Get_HolidayPayPattern double;
  declare Get_HolidayWorkPattern double;
  select HolidayLvePattern,HolidayPayPattern,HolidayWorkPattern into Get_HolidayLvePattern,
    Get_HolidayPayPattern,
    Get_HolidayWorkPattern from Holidays where
    HolidayId = In_HolidayId and
    CountryId = In_CountryCode and
    HolidayStartDate = In_PublicHolidayDate;
  CalendarIdLoop: for CalendarIdFor as Cur_CalendarId dynamic scroll cursor for
    select Calendar.CalendarId as Get_CalendarId from
      Calendar where
      Calendar.CountryCode = In_CountryCode do
    update CalendarDay set
      CalendarDay.PublicHoliday = 1,
      CalendarDay.WkCalenDayLvePattern = 0 where
      CalendarDay.CalendarDate = In_PublicHolidayDate and
      CalendarDay.CalendarIdCode = Get_CalendarId;
    commit work end for
end
;

/* ModuleScreenGroup */
IF not exists(select * from ModuleScreenGroup where ModuleScreenId in ('CoreLengthofSveRpt','LvYTDRpt','LvGCL1Rpt')) Then
   Insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId) 
     Values ('CoreLengthofSveRpt','CoreReports','Length of Service Report','Core',0,0,0,'');
   Insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId) 
     Values ('LvYTDRpt','LeaveReports','Leave YTD Report','Leave',0,0,0,'');
   Insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId) 
     Values ('LvGCL1Rpt','LeaveReports','Childcare Leave Form GCL1','Leave',0,0,0,'');
End if;

IF not exists (select * from ModuleScreenGroup where ModuleScreenId = 'EC_PayImport' ) then 
   Insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
   VALUES('EC_PayImport','EC_PayModules','Import','EPStandard',0,0,1,'0');
End if;
  
Update ModuleScreenGroup Set EC_ModuleScreenId='EC_PayModules' where ModuleScreenId='PayInterfaceImport' and Mod_ModuleScreenId='PayInterface';

COMMIT WORK;
