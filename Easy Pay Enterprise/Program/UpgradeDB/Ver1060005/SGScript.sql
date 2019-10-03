READ UpgradeDB\Ver1060005\SG_FWL.sql;

begin
  declare Out_CPFEffectiveDate date;
  declare Out_CPFCareerId char(20);
  declare Out_CPFProgAccountNo char(30);
  declare Out_CPFProgSchemeId char(20);
  declare Out_CPFMAWOption smallint;
  declare Out_CPFMAWLimit double;
  declare Out_CPFMAWPeriodOrdWage double;
  declare Out_CPFMedisavePaidByER smallint;

  if IsEPClassicDB() = 0 then return; end if;

  /* To fix Year2010Sep Not using '2010-09-01' as Effective Date */  	
  Update CPFProgression set CPFEffectiveDate = '2010-09-01' Where CPFProgPolicyId ='Year2010Sep' And CPFEffectiveDate <> '2010-09-01'
  And (Select HireDate From Employee where Employee.EmployeesysId = CPFProgression.EmployeesysId) < '2010-09-01';

  /* To fix Year2011March Not using '2011-03-01' as Effective Date */  	
  Update CPFProgression set CPFEffectiveDate = '2011-03-01' Where CPFProgPolicyId ='Year2011March' And CPFEffectiveDate <> '2011-03-01'
  And (Select HireDate From Employee where Employee.EmployeesysId = CPFProgression.EmployeesysId) < '2011-03-01';
 
  /* Active in Year 2011 */  
  EmployeeLoop: for EmployeeFor as curs dynamic scroll cursor for 
   select Employee.EmployeeSysId as Out_EmployeeSysId,
      HireDate as Out_HireDate  
      from
      Employee join PayEmployee where
      HireDate <= '2012-01-01' And 
      (LastPayDate = '1899-12-30' or LastPayDate >= '2011-12-31' or Year(LastPayDate) = 2011) do
 
    if exists(select * from CPFProgression where EmployeeSysID = Out_EmployeeSysId and CPFEffectiveDate <= '2011-12-31' and CPFProgPolicyId <> '' and CPFProgSchemeId <> '') then

      Message 'EmployeeSysId : ' + Cast(Out_EmployeeSysId as char(30)) to client;
   
      set Out_CPFEffectiveDate = null;
	
      /* Get latest record before end of 2011*/  	
      select first 
        CPFCareerId,
        CPFProgAccountNo,
        CPFProgSchemeId,
        CPFMAWOption,
        CPFMAWLimit,
        CPFMAWPeriodOrdWage,
        CPFMedisavePaidByER into 
        Out_CPFCareerId,
        Out_CPFProgAccountNo,
        Out_CPFProgSchemeId,
        Out_CPFMAWOption,
        Out_CPFMAWLimit,
        Out_CPFMAWPeriodOrdWage,
        Out_CPFMedisavePaidByER from CPFProgression where
        EmployeeSysID = Out_EmployeeSysId and
        CPFEffectiveDate <= '2011-12-31' and
        CPFProgPolicyId <> '' and
        CPFProgSchemeId <> '' order by
        CPFEffectiveDate desc;

      /* To fix missing Year2010Sep */  	
      if not exists(select * from CPFProgression where CPFProgPolicyId='Year2010Sep' and EmployeeSysID = Out_EmployeeSysId) then

        Set Out_CPFEffectiveDate = '2010-09-01';        
        if (Out_HireDate > '2010-09-01') then Set Out_CPFEffectiveDate = Out_HireDate; end if;

        Message 'Insert Year2010Sep' to client;

        call InsertNewCPFProgression(
        Out_EmployeeSysId,
        Out_CPFEffectiveDate,
        0,
        Out_CPFCareerId,
        'Year2010Sep',
        Out_CPFProgAccountNo,
        Out_CPFProgSchemeId,
        Out_CPFMAWOption,
        Out_CPFMAWLimit,
        Out_CPFMAWPeriodOrdWage,
        Out_CPFMedisavePaidByER,'')
      end if;

      /* To fix missing Year2011March */  	
      if not exists(select * from CPFProgression where CPFProgPolicyId='Year2011March' and EmployeeSysID = Out_EmployeeSysId) then
        Set Out_CPFEffectiveDate = '2011-03-01';        
        if (Out_HireDate > '2011-03-01') then Set Out_CPFEffectiveDate = Out_HireDate; end if;

        Message 'Year2011March' to client;

        call InsertNewCPFProgression(
        Out_EmployeeSysId,
        '2011-03-01',
        0,
        Out_CPFCareerId,
        'Year2011March',
        Out_CPFProgAccountNo,
        Out_CPFProgSchemeId,
        Out_CPFMAWOption,
        Out_CPFMAWLimit,
        Out_CPFMAWPeriodOrdWage,
        Out_CPFMedisavePaidByER,'')

      end if;

    end if end for
end
;

Commit Work;