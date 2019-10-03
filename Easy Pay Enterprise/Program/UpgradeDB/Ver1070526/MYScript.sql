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
    DECLARE LatestHireYear integer;
    DECLARE LatestCessationYear integer;
    DECLARE LatestCessationCode char(20);

    Set OUT_Count = 0;

    /* Get the latest Employment record*/
    SELECT FIRST Year(HireDate), Year(CessationDate), CessationCode  
	INTO LatestHireYear, LatestCessationYear, LatestCessationCode 
	FROM Employee WHERE PersonalSysid = In_PersonalSysId  ORDER BY HireDate DESC;

    /* N - New Employment and  E - Existing Employment */
    if (LatestHireYear = In_Year and LatestCessationYear != In_Year) then
	  if (In_Status = 'N' OR In_Status = 'E') then 
		 Set OUT_Count = 1;
	  end if;
    /* C - Cessation and not Leaving Country */
    elseif (LatestCessationYear != '1899' AND LatestCessationYear <= In_Year AND LatestCessationCode  != 'Leave Country') then
	   if (In_Status = 'C') then
		Set OUT_Count = 1;
	   end if;
    /* L - Cessation and Leaving Country */
    elseif (LatestCessationYear != '1899' AND LatestCessationYear <= In_Year AND LatestCessationCode = 'Leave Country') then
	  if (In_Status = 'L') then
		Set OUT_Count = 1;
	  end if;    
    /* E - Existing Employment */
    elseif (In_Status = 'E') then
	    Set OUT_Count = 1;
    end if; 	

    RETURN OUT_Count;
END;

commit work;