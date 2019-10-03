IF EXISTS (SELECT * FROM sys.systriggers where trigname = 'ESSInsertLeaveCycleRpt') THEN 
  DROP TRIGGER ESSInsertLeaveCycleRpt
END IF;
CREATE TRIGGER "ESSInsertLeaveCycleRpt" after insert
ORDER 33 ON DBA.LeaveCycleRpt
referencing new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then 
    -- Send Employee requires employee's leave type so need to update ESSEEmpModifiedDate
	Update ESSEmployee
	set ESSELveModifiedDate = Now(), ESSEEmpModifiedDate = NOW() 
	Where EmployeeSysId = NewTable.EmployeeSysId;
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
	Update ESSEmployee
	set ESSELveModifiedDate = Now()
	Where EmployeeSysId = NewTable.EmployeeSysId;
  end if;
end;


IF EXISTS (SELECT * FROM sys.systriggers where trigname = 'ESSDeleteLeaveCycleRpt') THEN 
  DROP TRIGGER ESSDeleteLeaveCycleRpt
END IF;

CREATE TRIGGER "ESSDeleteLeaveCycleRpt" after delete
ORDER 35 ON DBA.LeaveCycleRpt
referencing old as OLDTable
for each row
begin
  If IsESSTrigger() = 1 then
    -- Send Employee requires employee's leave type so need to update ESSEEmpModifiedDate
	Update ESSEmployee
	set ESSELveModifiedDate = Now(), ESSEEmpModifiedDate = Now()
	Where EmployeeSysId = OLDTable.EmployeeSysId;
  end if;
end;

commit work;