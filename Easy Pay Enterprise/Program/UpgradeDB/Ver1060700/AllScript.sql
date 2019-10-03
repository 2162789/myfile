if not exists(select * from ePortalVersion where EPE = '1060700') then
  insert into ePortalVersion(EPE,ePortal)
  Values('1060700','1030000');
end if;

if exists(select * from sys.sysprocedure where proc_name = 'FGetLstMthTotalWage') then
   drop function FGetLstMthTotalWage
end if;

create FUNCTION "DBA"."FGetLstMthTotalWage"( // For Payroll Summary Report to calculate the last month total wage
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType char(20), 
In In_PayRecId char(20))
returns double
begin
  declare Out_CalTotalWage double;
  declare Temp_Year integer;
  declare Temp_Period integer;
 
  if In_PayRecPeriod = 1 then
     set Temp_Year = In_PayRecYear -1;
     set Temp_Period = 12;
  else 
     set Temp_Year = In_PayRecYear;
     set Temp_Period = In_PayRecPeriod-1;
  end if;
  
  // Sub Period Choose "All"
  if In_PayRecSubPeriod = 0 then
     if In_PayRecType = '' then // Pay Record Type Choose "All"
          if In_PayRecId = '' then // Pay Record Id Choose "All"
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
             where EmployeeSysId = In_EmployeeSysId and PayRecYear = Temp_Year
                   and PayRecPeriod = Temp_Period;
          else
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
             where EmployeeSysId = In_EmployeeSysId and PayRecYear = Temp_Year
                   and PayRecPeriod = Temp_Period and PayRecID = In_PayRecId;
           end if;
     else
          if In_PayRecId = '' then
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
                join PayRecord on DetailRecord.EmployeeSysId = PayRecord.EmployeeSysId
                and DetailRecord.PayRecYear = PayRecord.PayRecYear
                and DetailRecord.PayRecPeriod = PayRecord.PayRecPeriod
                and DetailRecord.PayRecSubPeriod = PayRecord.PayRecSubPeriod
                and DetailRecord.PayRecId = PayRecord.PayRecId
             where DetailRecord.EmployeeSysId = In_EmployeeSysId and DetailRecord.PayRecYear = Temp_Year
                   and DetailRecord.PayRecPeriod = Temp_Period and PayRecord.PayRecType = In_PayRecType;
          else
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
                join PayRecord on DetailRecord.EmployeeSysId = PayRecord.EmployeeSysId
                and DetailRecord.PayRecYear = PayRecord.PayRecYear
                and DetailRecord.PayRecPeriod = PayRecord.PayRecPeriod
                and DetailRecord.PayRecSubPeriod = PayRecord.PayRecSubPeriod
                and DetailRecord.PayRecId = PayRecord.PayRecId
              where DetailRecord.EmployeeSysId = In_EmployeeSysId and DetailRecord.PayRecYear = Temp_Year
                   and DetailRecord.PayRecPeriod = Temp_Period and PayRecord.PayRecType = In_PayRecType and DetailRecord.PayRecID = In_PayRecId;
           end if;
     end if;
  else // Speicific Sub Period
     if In_PayRecType = '' then // Pay Record Type Choose "All"
          if In_PayRecId = '' then // Pay Record Id Choose "All"
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
             where EmployeeSysId = In_EmployeeSysId and PayRecYear = Temp_Year
                   and PayRecPeriod = Temp_Period and PayRecSubPeriod = In_PayRecSubPeriod;
          else
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
             where EmployeeSysId = In_EmployeeSysId and PayRecYear = Temp_Year
                   and PayRecPeriod = Temp_Period and PayRecSubPeriod = In_PayRecSubPeriod and PayRecID = In_PayRecId;
           end if;
     else
          if In_PayRecId = '' then
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
                join PayRecord on DetailRecord.EmployeeSysId = PayRecord.EmployeeSysId
                and DetailRecord.PayRecYear = PayRecord.PayRecYear
                and DetailRecord.PayRecPeriod = PayRecord.PayRecPeriod
                and DetailRecord.PayRecSubPeriod = PayRecord.PayRecSubPeriod
                and DetailRecord.PayRecId = PayRecord.PayRecId
             where DetailRecord.EmployeeSysId = In_EmployeeSysId and DetailRecord.PayRecYear = Temp_Year
                   and DetailRecord.PayRecPeriod = Temp_Period and DetailRecord.PayRecSubPeriod = In_PayRecSubPeriod
                   and PayRecord.PayRecType = In_PayRecType;
          else
             select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord 
                join PayRecord on DetailRecord.EmployeeSysId = PayRecord.EmployeeSysId
                and DetailRecord.PayRecYear = PayRecord.PayRecYear
                and DetailRecord.PayRecPeriod = PayRecord.PayRecPeriod
                and DetailRecord.PayRecSubPeriod = PayRecord.PayRecSubPeriod
                and DetailRecord.PayRecId = PayRecord.PayRecId
              where DetailRecord.EmployeeSysId = In_EmployeeSysId and DetailRecord.PayRecYear = Temp_Year
                   and DetailRecord.PayRecPeriod = Temp_Period and DetailRecord.PayRecSubPeriod = In_PayRecSubPeriod 
                   and PayRecord.PayRecType = In_PayRecType and DetailRecord.PayRecID = In_PayRecId;
           end if;
     end if;
   end if;

  if Out_CalTotalWage is null then set Out_CalTotalWage=0
  end if;
  return Out_CalTotalWage
end;

commit work;