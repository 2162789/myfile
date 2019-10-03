/*-----------------------------------------------------------------------------------------------------------
	Credit Leave
-----------------------------------------------------------------------------------------------------------*/
ALTER FUNCTION "DBA"."FGetLveCreditExpired"(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_ExpiryDate date)
returns double
begin
  declare Out_TotalExpired double;
  declare Out_TotalTaken double;
  declare In_ExpiredTakenDays double;
  declare In_ExpiredDays double;
  declare In_RemainTakenDays double;
  /*
  Create Temporary Table to store the Credit Leave Application so as to strike off one expired if taken
  */
  if not exists(select* from Systable where Table_name = 'ExpiredLeaveRecord') then
    create global temporary table dba.ExpiredLeaveRecord(
      ExpiredLeaveRecordId integer not null default autoincrement,
      LeaveAppSGSPGenId char(30) not null,
      LveRecDate date not null,
      LveRecStartTime time not null,
      LveRecConvertDays double not null,
      primary key(ExpiredLeaveRecordId),
      ) on commit delete rows;
    message 'Expired Leave Record Table Created' type info to client
  else
    delete from ExpiredLeaveRecord
  end if;
  /*
  Get Credit Leave that has expire date
  */
  set Out_TotalExpired=0;
  CreditLeaveLoop: for CreditLeaveFor as CreditLeaveCurs dynamic scroll cursor for
    select CreditExpireDate as In_CreditExpireDate,
      AdjEffectiveDate as In_AdjEffectiveDate,
      AdjDays as In_AdjDays from AdjustCredit where EmployeeSysId = In_EmployeeSysId and
      LeaveTypeId = In_LeaveTypeId and
      CreditExpireDate < In_ExpiryDate and
      CreditExpireDate <> '1899-12-30' order by AdjEffectiveDate asc,CreditExpireDate asc do
    message cast(In_AdjEffectiveDate as char(10))+' '+cast(In_CreditExpireDate as char(10))+' '+cast(In_AdjDays as char) type info to client;
    set In_ExpiredDays=In_AdjDays;
    /*
    Get Credit Leave that has expire date
    */
    LeaveRecordLoop: for LeaveRecordFor as LeaveRecordCurs dynamic scroll cursor for
      select LeaveApplication.LeaveAppSGSPGenId as In_LeaveAppSGSPGenId,
        LeaveRecord.LveRecDate as In_LveRecDate,
        LeaveRecord.LveRecStartTime as In_LveRecStartTime,
        LeaveRecord.LveRecConvertDays as In_TakenDays from
        LeaveRecord join LeaveApplication where EmployeeSysId = In_EmployeeSysId and
        LeaveApplication.LeaveTypeId = In_LeaveTypeId and
        LeaveRecord.LveRecDate <= In_CreditExpireDate and
        LeaveRecord.LveRecDate >= In_AdjEffectiveDate and 
        LveRecApproved = 1 order by LeaveRecord.LveRecDate asc do
      if(In_ExpiredDays > 0) then
        /*
        Sum the total taken from ExpiredLeaveRecord
        */
        select sum(LveRecConvertDays) into In_ExpiredTakenDays from ExpiredLeaveRecord where
          LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
          LveRecDate = In_LveRecDate and
          LveRecStartTime = In_LveRecStartTime;
        if In_ExpiredTakenDays is null then set In_ExpiredTakenDays=0
        end if;
        set In_RemainTakenDays=In_TakenDays-In_ExpiredTakenDays;
        /*
        Leave Record is already consumed
        */
        if(In_RemainTakenDays > 0) then
          message Space(5)+In_LeaveAppSGSPGenId+' '+
            cast(In_LveRecDate as char(10))+' '+
            cast(In_LveRecStartTime as char(8))+' '+
            cast(In_TakenDays as char(8))+' '+
            cast(In_RemainTakenDays as char(8)) type info to client;
          /*
          Leave application is more than Expired Day
          */
          if(In_RemainTakenDays >= In_ExpiredDays) then
            set In_RemainTakenDays=In_ExpiredDays
          end if;
          /*
          Leave application is marked
          */
          insert into ExpiredLeaveRecord(LeaveAppSGSPGenId,
            LveRecDate,
            LveRecStartTime,
            LveRecConvertDays) values(
            In_LeaveAppSGSPGenId,In_LveRecDate,In_LveRecStartTime,In_RemainTakenDays);
          set In_ExpiredDays=In_ExpiredDays-In_RemainTakenDays;
          message Space(10)+'Taken : '+cast(In_RemainTakenDays as char(8)) type info to client
        end if
      end if end for;
    /*
    End of Leave Application Loop
    */
    if In_ExpiredDays > 0 then
      set Out_TotalExpired=Out_TotalExpired+In_ExpiredDays
    end if;
    message Space(5)+'Expired :  '+cast(In_ExpiredDays as char(8)) type info to client end for;
  /*
  End of Credit Leave Loop
  */
  message 'Total Expired :  '+cast(Out_TotalExpired as char(8)) type info to client;
  delete from ExpiredLeaveRecord;
  return Out_TotalExpired
end;




commit work;