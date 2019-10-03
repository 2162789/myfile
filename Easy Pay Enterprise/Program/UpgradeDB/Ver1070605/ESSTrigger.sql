/* Personal */
if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdatePersonal') then
   drop trigger ESSUpdatePersonal
end if;
CREATE TRIGGER DBA.ESSUpdatePersonal after update of PersonalName, DateOfBirth, TitleId, Gender, MaritalStatusCode, Alias, PersonalTypeId
order 24 on DBA.Personal
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
	Update ESSEmployee
	set ESSEmployee.ESSEEmpModifiedDate = Now()
	Where EmployeeSysId = FGetEmployeeSysId(NewTable.EmployeeId);
  end if; 
end;

/* Employee */
if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdateEmployee') then
   drop trigger ESSUpdateEmployee
end if;
CREATE TRIGGER DBA.ESSUpdateEmployee after update of BranchId, PositionId, HireDate, CessationCode
order 25 ON DBA.Employee
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
    Update ESSEmployee
    set ESSEmployee.ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = NewTable.EmployeeSysId;
  end if;
end;

if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdateEmployeeCessDate') then
   drop trigger ESSUpdateEmployeeCessDate
end if;
CREATE TRIGGER DBA.ESSUpdateEmployeeCessDate after update of CessationDate
order 26 ON DBA.Employee
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
    begin
      if not exists(select * from ESSEmployee where EmployeeSysId = NewTable.EmployeeSysId) then 
        call InsertNewESSEmployee(NewTable.EmployeeSysId, Now(),0,Now(),0)
      else
        Update ESSEmployee
        set ESSEmployee.ESSEEmpModifiedDate = Now()
        Where EmployeeSysId = NewTable.EmployeeSysId; 
      end if;
	end
  end if;
end;

/* PersonalAddress */
if exists(select 1 from sys.systrigger where trigger_name = 'ESSInsertPersonalAddress') then
   drop trigger ESSInsertPersonalAddress
end if;
CREATE TRIGGER DBA.ESSInsertPersonalAddress after insert
ORDER 27 ON DBA.PersonalAddress
referencing new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
    Update ESSEmployee
    set ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = FGetEmployeeSysId(FGetEmployeeIdByPersonalSysId(NewTable.PersonalSysId));
  end if;
end;

if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdateDeletePersonalAddress') then
   drop trigger ESSUpdateDeletePersonalAddress
end if;
CREATE TRIGGER DBA.ESSUpdateDeletePersonalAddress after update, delete
ORDER 28 ON DBA.PersonalAddress
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
    Update ESSEmployee
    set ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = FGetEmployeeSysId(FGetEmployeeIdByPersonalSysId(OLDTable.PersonalSysId));
  end if;
end;

/* PersonalContact */
if exists(select 1 from sys.systrigger where trigger_name = 'ESSInsertPersonalContact') then
   drop trigger ESSInsertPersonalContact
end if;
CREATE TRIGGER DBA.ESSInsertPersonalContact after insert
ORDER 29 ON DBA.PersonalContact
referencing new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
    Update ESSEmployee
    set ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = FGetEmployeeSysId(FGetEmployeeIdByPersonalSysId(NewTable.PersonalSysId));
  end if;
end;

if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdateDeletePersonalContact') then
   drop trigger ESSUpdateDeletePersonalContact
end if;
CREATE TRIGGER DBA.ESSUpdateDeletePersonalContact after update, delete
ORDER 30 ON DBA.PersonalContact
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then
    Update ESSEmployee
    set ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = FGetEmployeeSysId(FGetEmployeeIdByPersonalSysId(OLDTable.PersonalSysId));
  end if;
end;

/* PersonalEmail */
if exists(select 1 from sys.systrigger where trigger_name = 'ESSInsertPersonalEmail') then
   drop trigger ESSInsertPersonalEmail
end if;
CREATE TRIGGER DBA.ESSInsertPersonalEmail after insert
ORDER 31 ON DBA.PersonalEmail
referencing new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then 
    Update ESSEmployee
    set ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = FGetEmployeeSysId(FGetEmployeeIdByPersonalSysId(NewTable.PersonalSysId));
  end if;
end;

if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdateDeletePersonalEmail') then
   drop trigger ESSUpdateDeletePersonalEmail
end if;
CREATE TRIGGER DBA.ESSUpdateDeletePersonalEmail after update, delete
ORDER 32 ON DBA.PersonalEmail
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then 
    Update ESSEmployee
    set ESSEEmpModifiedDate = Now()
    Where EmployeeSysId = FGetEmployeeSysId(FGetEmployeeIdByPersonalSysId(OLDTable.PersonalSysId));
  end if;
end;

/* LeaveCycleRpt */
if exists(select 1 from sys.systrigger where trigger_name = 'ESSInsertLeaveCycleRpt') then
   drop trigger ESSInsertLeaveCycleRpt
end if;
CREATE TRIGGER DBA.ESSInsertLeaveCycleRpt after insert
ORDER 33 ON DBA.LeaveCycleRpt
referencing new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then 
    -- Only update if it's current year 
    If NewTable.LveYearRpt = Year(Now()) then 
	    Update ESSEmployee
	    set ESSELveModifiedDate = Now()
	    Where EmployeeSysId = NewTable.EmployeeSysId;
    End if;
  end if;
end;

if exists(select 1 from sys.systrigger where trigger_name = 'ESSUpdateLeaveCycleRpt') then
   drop trigger ESSUpdateLeaveCycleRpt
end if;
CREATE TRIGGER DBA.ESSUpdateLeaveCycleRpt after update of CycCrossCycTaken, CycBalance
ORDER 34 ON DBA.LeaveCycleRpt
referencing old as OLDTable new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then 
    -- Only update if it's current year 
    If NewTable.LveYearRpt = Year(Now()) then 
	    Update ESSEmployee
	    set ESSELveModifiedDate = Now()
	    Where EmployeeSysId = NewTable.EmployeeSysId;
    End if;
  end if;
end;

if exists(select 1 from sys.systrigger where trigger_name = 'ESSDeleteLeaveCycleRpt') then
   drop trigger ESSDeleteLeaveCycleRpt
end if;
CREATE TRIGGER DBA.ESSDeleteLeaveCycleRpt after delete
ORDER 35 ON DBA.LeaveCycleRpt
referencing old as OLDTable
for each row
begin
  If IsESSTrigger() = 1 then
    -- Only update if it's current year 
    If OLDTable.LveYearRpt = Year(Now()) then 
	    Update ESSEmployee
	    set ESSELveModifiedDate = Now()
	    Where EmployeeSysId = OLDTable.EmployeeSysId;
    End if;
  end if;
end;

commit work;