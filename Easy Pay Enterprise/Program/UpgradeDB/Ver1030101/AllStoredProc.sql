if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodFreeString1') then
   drop procedure FGetPayPeriodFreeString1
end if
;

create function DBA.FGetPayPeriodFreeString1(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString1 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return BankName
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodFreeString2') then
   drop procedure FGetPayPeriodFreeString2
end if
;

create function DBA.FGetPayPeriodFreeString2(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString2 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return BankName
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodFreeString3') then
   drop procedure FGetPayPeriodFreeString3
end if
;

create function DBA.FGetPayPeriodFreeString3(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString3 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return BankName
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodFreeString4') then
   drop procedure FGetPayPeriodFreeString4
end if
;
create function DBA.FGetPayPeriodFreeString4(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString4 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return BankName
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayPeriodFreeString5') then
   drop procedure FGetPayPeriodFreeString5
end if
;
create function DBA.FGetPayPeriodFreeString5(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString5 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or
    ((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return BankName
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeFreeString1') then
   drop procedure FGetPayTypeFreeString1
end if
;

create function
dba.FGetPayTypeFreeString1(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString1 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return FreeString
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeFreeString2') then
   drop procedure FGetPayTypeFreeString2
end if
;

create function
dba.FGetPayTypeFreeString2(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString2 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return FreeString
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeFreeString3') then
   drop procedure FGetPayTypeFreeString3
end if
;

create function
dba.FGetPayTypeFreeString3(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString3 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return FreeString
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeFreeString4') then
   drop procedure FGetPayTypeFreeString4
end if
;

create function
dba.FGetPayTypeFreeString4(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString4 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return FreeString
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayTypeFreeString5') then
   drop procedure FGetPayTypeFreeString5
end if
;

create function
dba.FGetPayTypeFreeString5(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(200)
begin
  declare FreeString char(200);
  select first FreeString5 into FreeString from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType1) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType2) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType3) or((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = DetailRecord.PayRecID) = In_PayRecType4)) order by
    FreeString asc;
  if FreeString is null then set FreeString=''
  end if;
  return FreeString
end
;

commit work;



