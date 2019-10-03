if exists(select * from sys.sysprocedure where proc_name = 'FGetLstMthTotalWage') then
  drop function FGetLstMthTotalWage
end if;

create FUNCTION DBA.FGetLstMthTotalWage( 
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
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
  
  if In_PayRecSubPeriod = 0 then
     if In_PayRecId = '' then
         select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord where
             EmployeeSysId = In_EmployeeSysId and
             PayRecYear = Temp_Year and
             PayRecPeriod = Temp_Period;
     else
         select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord where
             EmployeeSysId = In_EmployeeSysId and
             PayRecYear = Temp_Year and
             PayRecPeriod = Temp_Period and
             PayRecID = In_PayRecId;
     end if;
  else
     if In_PayRecId = '' then
         select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord where
             EmployeeSysId = In_EmployeeSysId and
             PayRecYear = Temp_Year and
             PayRecPeriod = Temp_Period and 
             PayRecSubPeriod = In_PayRecSubPeriod;  
     else
         select Sum(CalTotalWage) into Out_CalTotalWage from DetailRecord where
             EmployeeSysId = In_EmployeeSysId and
             PayRecYear = Temp_Year and
             PayRecPeriod = Temp_Period and
             PayRecSubPeriod = In_PayRecSubPeriod and
             PayRecID = In_PayRecId;
     end if;   
   end if;  

  if Out_CalTotalWage is null then set Out_CalTotalWage=0
  end if;
  return Out_CalTotalWage
end;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewCRCustom') then
  drop function InsertNewCRCustom
end if;

create PROCEDURE DBA.InsertNewCRCustom(
IN In_CRId char(20),
IN In_CRFilename char(50),
IN In_CRTitle char(50),
IN In_CRDesc char(100),
OUT Out_CRCustomSysId integer)

BEGIN
    SET Out_CRCustomSysId = (SELECT MAX(CRCustomSysId) FROM CRCustom);
    IF Out_CRCustomSysId IS NULL THEN
        SET Out_CRCustomSysId = 0
    END IF;

    INSERT INTO CRCustom(CRCustomSysId, CRId, CRFilename, CRTitle, CRDesc) 
    VALUES(Out_CRCustomSysId+1, In_CRId, In_CRFilename, In_CRTitle, In_CRDesc);
    COMMIT WORK;

    IF Out_CRCustomSysId+1 = (SELECT MAX(CRCustomSysId) FROM CRCustom) THEN
        SET Out_CRCustomSysId = Out_CRCustomSysId+1;    
    ELSE
        SET Out_CRCustomSysId = 0;
    END IF
END
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateCRCustom') then
  drop function UpdateCRCustom
end if;
create PROCEDURE DBA.UpdateCRCustom(
IN In_CRCustomSysId integer,
IN In_CRId char(20),
IN In_CRFilename char(50),
IN In_CRTitle char(50),
IN In_CRDesc char(100),
OUT Out_ErrorCode integer)

BEGIN
    IF EXISTS(SELECT * FROM CRCustom WHERE CRCustomSysId = In_CRCustomSysId) THEN
        UPDATE CRCustom SET 
            CRId = In_CRId,
            CRFilename = In_CRFilename,
            CRTitle = In_CRTitle,
            CRDesc = In_CRDesc
        WHERE CRCustomSysId = In_CRCustomSysId;
       	COMMIT WORK;
        SET Out_ErrorCode = In_CRCustomSysId
    ELSE
        SET Out_ErrorCode = 0
    END IF;
END
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteCRCustom') then
  drop function DeleteCRCustom
end if;
create PROCEDURE DBA.DeleteCRCustom(
IN In_CRCustomSysId integer,
OUT Out_CRCustomSysId integer)

BEGIN
    IF NOT EXISTS(SELECT * FROM CRCustom WHERE CRCustomSysId = In_CRCustomSysId) THEN
        SET Out_CRCustomSysId = 0;
        RETURN
    ELSE
        DELETE FROM CRCustom WHERE CRCustomSysId = In_CRCustomSysId;
        COMMIT WORK;
    END IF ;

    IF EXISTS(SELECT * FROM CRCustom WHERE CRCustomSysId = In_CRCustomSysId) THEN
        SET Out_CRCustomSysId = 0;
    ELSE
        SET Out_CRCustomSysId = In_CRCustomSysId;
    END IF;
END
;

commit work;