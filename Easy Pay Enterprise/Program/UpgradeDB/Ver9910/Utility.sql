/* ============================================================ */
/*   Database name:  Model_2                                    */
/*   DBMS name:      Sybase AS Anywhere 6                       */
/*   Created on:     8/10/2004  10:59 AM                        */
/* ============================================================ */


create procedure dba.ASQLUpdateUtilityUsage()
begin
  declare thisMonth integer;
  declare thisYear integer;
  declare noOfPersonal integer;
  declare noOfEmployee integer;
  select year(today(*)),month(today(*)) into thisYear,thisMonth;
  select FGetLicenseCount(*) into noOfPersonal;
  select FGetLicenseEmployeeCount(*) into noOfEmployee;
  if not exists(select* from UtilityUsage where UtilityYear = thisYear and UtilityMonth = thisMonth) then
    // insert new record
    call InsertNewUtilityUsage(thisYear,thisMonth,noOfPersonal,noOfEmployee);
    return
  else
    // update existing record
    call UpdateUtilityUsage(thisYear,thisMonth,noOfPersonal,noOfEmployee);
    return
  end if
end
;


create procedure dba.DeleteUtilityUsage(
in In_UtilityYear integer,
in In_UtilityMonth integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from UtilityUsage where
      UtilityYear = In_UtilityYear and
      UtilityMonth = In_UtilityMonth;
    commit work
  end if;
  if exists(select* from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.InsertNewUtilityUsage(
in In_UtilityYear integer,
in In_UtilityMonth integer,
in In_UtilityCnt integer,
in In_UtilityEmployeeCnt integer,
out Out_ErrorCode integer)
begin
  if exists(select* from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth) then
    set Out_ErrorCode=-1; // Record exists
    return
  else
    insert into UtilityUsage(UtilityYear,UtilityMonth,UtilityCnt,UtilityEmployeeCnt) values(
      In_UtilityYear,In_UtilityMonth,In_UtilityCnt,In_UtilityEmployeeCnt);
    commit work
  end if;
  if not exists(select* from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.UpdateUtilityUsage(
in In_UtilityYear integer,
in In_UtilityMonth integer,
in In_UtilityCnt integer,
in In_UtilityEmployeeCnt integer,
out Out_ErrorCode integer)
begin
  declare Old_PersonalCnt integer;
  declare Old_EmployeeCnt integer;
  declare New_PersonalCnt integer;
  declare New_EmployeeCnt integer;
  if not exists(select* from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth) then
    set Out_ErrorCode=-1; // Record not exists
    return
  end if;
  // find the old personal and employee count
  select UtilityCnt into Old_PersonalCnt from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth;
  select UtilityEmployeeCnt into Old_EmployeeCnt from UtilityUsage where UtilityYear = In_UtilityYear and UtilityMonth = In_UtilityMonth;
  // update personal count
  if In_UtilityCnt > Old_PersonalCnt then
    set New_PersonalCnt=In_UtilityCnt
  else
    set New_PersonalCnt=Old_PersonalCnt
  end if;
  // update employee count
  if In_UtilityEmployeeCnt > Old_EmployeeCnt then
    set New_EmployeeCnt=In_UtilityEmployeeCnt
  else
    set New_EmployeeCnt=Old_EmployeeCnt
  end if;
  update UtilityUsage set
    UtilityCnt = New_PersonalCnt,
    UtilityEmployeeCnt = New_EmployeeCnt where
    UtilityYear = In_UtilityYear and
    UtilityMonth = In_UtilityMonth;
  commit work;
  set Out_ErrorCode=1 // Successful
end
;

