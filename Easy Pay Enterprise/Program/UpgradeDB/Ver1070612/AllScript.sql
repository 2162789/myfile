IF EXISTS (SELECT * FROM sys.systriggers where trigname = 'ESSInsertLeaveCycleRpt') THEN 
  DROP TRIGGER ESSInsertLeaveCycleRpt
END IF;

CREATE TRIGGER "ESSInsertLeaveCycleRpt" after insert
ORDER 33 ON DBA.LeaveCycleRpt
referencing new as NewTable
for each row
begin
  If IsESSTrigger() = 1 then 
    -- Only update if it's current year 
    If NewTable.LveYearRpt = Year(Now()) then 
	    Update ESSEmployee
	    set ESSELveModifiedDate = Now(), ESSEEMPModifiedDate = NOW()
	    Where EmployeeSysId = NewTable.EmployeeSysId;
    End if;
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
    -- Only update if it's current year 
    If OLDTable.LveYearRpt = Year(Now()) then 
	    Update ESSEmployee
	    set ESSELveModifiedDate = Now(), ESSEEmpModifiedDate = Now()
	    Where EmployeeSysId = OLDTable.EmployeeSysId;
    End if;
  end if;
end;

commit work;