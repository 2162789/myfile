

IF EXISTS (select * from sys.sysprocedure where proc_name = 'FGetPayGroupDesc') THEN
	DROP FUNCTION FGetPayGroupDesc;
END IF;

CREATE FUNCTION "DBA"."FGetPayGroupDesc"(
in In_Id char(20))
returns char(100)
begin
  declare Out_Desc char(100);
  select PayGroupDesc into Out_Desc
    from PayGroup where
    PayGroupId = In_Id;
  return(Out_Desc)
end;

IF EXISTS (select * from sys.sysprocedure where proc_name = 'FGetBasisDescByType') THEN
    DROP FUNCTION FGetBasisDescByType;
END IF;
CREATE FUNCTION "DBA"."FGetBasisDescByType"(in In_Type char(50), in In_BasisId char(20), in In_Default char(100))
returns char(100)
begin
  declare Out_Desc char(100);
  select CASE WHEN In_Type = 'Department' THEN FGetDepartmentDesc(In_BasisId) 
    WHEN In_Type = 'Section' THEN FGetSectionDesc(In_BasisId) 
    WHEN In_Type = 'CostCentre' THEN FGetCostCentreDesc(In_BasisId) 
    WHEN In_Type = 'Category' THEN FGetCategoryDesc(In_BasisId) 
    WHEN In_Type = 'Branch' THEN FGetBranchName(In_BasisId) 
	WHEN In_Type = 'PayGroup' THEN FGetPayGroupDesc(In_BasisId) 
    WHEN In_Type = 'PositionCode' THEN FGetPositionDesc(In_BasisId) 
    WHEN In_Type = 'WTCalendar' THEN FGetWTCalendarDesc(In_BasisId) 
    WHEN In_Type = 'LeaveGroup' THEN FGetLeaveGroupDesc(In_BasisId)
    WHEN In_Type = 'SalaryGrade' THEN FGetSalaryGradeDesc(In_BasisId)
    WHEN In_Type = 'Classification' THEN FGetClassificationDesc(In_BasisId)
    WHEN In_Type = 'EmpCode1' THEN FGetEmpCode1Desc(In_BasisId) 
    WHEN In_Type = 'EmpCode2' THEN FGetEmpCode2Desc(In_BasisId) 
    WHEN In_Type = 'EmpCode3' THEN FGetEmpCode3Desc(In_BasisId) 
    WHEN In_Type = 'EmpCode4' THEN FGetEmpCode4Desc(In_BasisId)
    WHEN In_Type = 'EmpCode5' THEN FGetEmpCode5Desc(In_BasisId)         
ELSE In_Default END 
    into Out_Desc;
  return(Out_Desc)
end;

commit work;