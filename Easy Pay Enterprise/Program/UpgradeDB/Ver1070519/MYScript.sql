/* This SP is not in use */
IF EXISTS (select * from sys.sysprocedure where proc_name = 'FGetEFormLatestEmploymentByYear') THEN
   DROP FUNCTION FGetEFormLatestEmploymentByYear;
END IF;

IF EXISTS (select * from sys.sysprocedure where proc_name = 'FGetEFormCount') THEN
   DROP FUNCTION FGetEFormCount;
END IF;
CREATE FUNCTION "DBA"."FGetEFormCount"(
in In_PersonalSysId int,
in In_Year int,
in In_Status char(1) 
)
RETURNS integer
BEGIN
    DECLARE OUT_Count integer; 
    Declare LatestEmployeeSysId integer;
    Declare Year_StartDate date;
    Set OUT_Count = 0;
    Set Year_StartDate = cast(cast(In_Year as char(4)) + '-01-01' as date);

    /* Get the latest Employment record within the year */
    Select First EmployeeSysId into LatestEmployeeSysId From Employee
      Where PersonalSysid = In_PersonalSysId
        And ((HireDate <= Year_StartDate And (CessationDate = '1899-12-30' Or CessationDate >= Year_StartDate))
              Or (Year(HireDate) = In_Year))
    Order By HireDate Desc;
    
    /* Check the Employment belongs to which status */
    /* It can be N - New Employment; E - Existing Employment; C - Cessation without Leave Country; L - Cessation with Leave country */
    if(In_Status = 'N') then
      Select 1 into OUT_Count From Employee
      Where EmployeeSysId = LatestEmployeeSysId and (Year(HireDate) = In_Year and (CessationDate = '1899-12-30' or Year(CessationDate) > In_Year))
    elseif(In_Status = 'E') then
       Select 1 into OUT_Count From Employee
      Where EmployeeSysId = LatestEmployeeSysId and ((CessationDate = '1899-12-30' and Year(HireDate) <= In_Year) or (Year(CessationDate) > In_Year and Year(HireDate) <= In_Year))   
    elseif(In_Status = 'C') then
       Select 1 into OUT_Count From Employee
      Where EmployeeSysId = LatestEmployeeSysId and Year(CessationDate) = In_Year and CessationCode != 'Leave Country';    
    elseif(In_Status = 'L') then
      Select 1 into OUT_Count From Employee
      Where EmployeeSysId = LatestEmployeeSysId and Year(CessationDate) = In_Year and CessationCode = 'Leave Country';                
    end if;

    RETURN OUT_Count;
END;

commit work;