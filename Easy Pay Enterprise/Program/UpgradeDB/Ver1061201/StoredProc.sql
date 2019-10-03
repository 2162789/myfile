/* CPFProgression */
if exists(select * from sys.sysprocedure where proc_name = 'InsertNewCPFProgression') then
   drop procedure InsertNewCPFProgression;
end if;
create procedure DBA.InsertNewCPFProgression(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFMedisaveSchemeId char(20),
in In_CPFProgRemarks char(255))
begin
  if not exists(select* from CPFProgression where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    insert into CPFProgression(EmployeeSysId,
      CPFEffectiveDate,
      CPFProgCurrent,
      CPFCareerId,
      CPFProgPolicyId,
      CPFProgAccountNo,
      CPFProgSchemeId,
      CPFMAWOption,
      CPFMAWLimit,
      CPFMAWPeriodOrdWage,
      CPFMedisavePaidByER,
      CPFMedisaveSchemeId,
      CPFProgRemarks) values(
      In_EmployeeSysId,
      In_CPFEffectiveDate,
      In_CPFProgCurrent,
      In_CPFCareerId,
      In_CPFProgPolicyId,
      In_CPFProgAccountNo,
      In_CPFProgSchemeId,
      In_CPFMAWOption,
      In_CPFMAWLimit,
      In_CPFMAWPeriodOrdWage,
      In_CPFMedisavePaidByER,
      In_CPFMedisaveSchemeId,
      In_CPFProgRemarks);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateCPFProgression') then
   drop procedure UpdateCPFProgression;
end if;
create procedure DBA.UpdateCPFProgression(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFMedisaveSchemeId char(20),
in In_CPFProgRemarks char(255))
begin
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    if(In_CPFProgCurrent = 1 and
      (FGetDBCountry(*) = 'Singapore' or
      FGetDBCountry(*) = 'Indonesia')) then
      update CPFProgression set
        CPFProgression.CPFProgCurrent = 0 where
        CPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    if(In_CPFProgCurrent = 1 and FGetDBCountry(*) = 'Brunei') then
      update CPFProgression set
        CPFProgression.CPFProgCurrent = 0 where
        CPFProgression.CPFProgSchemeId = In_CPFProgSchemeId and
        CPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update CPFProgression set
      CPFProgression.EmployeeSysId = In_EmployeeSysId,
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate,
      CPFProgression.CPFProgCurrent = In_CPFProgCurrent,
      CPFProgression.CPFCareerId = In_CPFCareerId,
      CPFProgression.CPFProgPolicyId = In_CPFProgPolicyId,
      CPFProgression.CPFProgAccountNo = In_CPFProgAccountNo,
      CPFProgression.CPFProgSchemeId = In_CPFProgSchemeId,
      CPFProgression.CPFMAWOption = In_CPFMAWOption,
      CPFProgression.CPFMAWLimit = In_CPFMAWLimit,
      CPFProgression.CPFMAWPeriodOrdWage = In_CPFMAWPeriodOrdWage,
      CPFProgression.CPFMedisavePaidByER = In_CPFMedisavePaidByER,
      CPFProgression.CPFMedisaveSchemeId = In_CPFMedisaveSchemeId,
      CPFProgression.CPFProgRemarks = In_CPFProgRemarks where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLUpdateCPFProgression') then
   drop procedure ASQLUpdateCPFProgression;
end if;
create procedure DBA.ASQLUpdateCPFProgression(in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_NewCPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFMedisaveSchemeId char(20),
in In_CPFProgRemarks char(255))

BEGIN
    if (In_NewCPFEffectiveDate = In_CPFEffectiveDate) then

       Call UpdateCPFProgression(In_EmployeeSysId, In_CPFEffectiveDate, 
        In_CPFProgCurrent, In_CPFCareerId, In_CPFProgPolicyId, In_CPFProgAccountNo, In_CPFProgSchemeId,
        In_CPFMAWOption, In_CPFMAWLimit , In_CPFMAWPeriodOrdWage, In_CPFMedisavePaidByER, In_CPFMedisaveSchemeId, In_CPFProgRemarks);
    else
        // Remove CPFEddactiveDate record 
        if exists(select * from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
            Call DeleteCPFProgressionRec(In_EmployeeSysId, In_CPFEffectiveDate);
        end if;
        // Remove NewCPFEddactiveDate record if already exists
        if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_NewCPFEffectiveDate) then
            Call DeleteCPFProgressionRec(In_EmployeeSysId, In_NewCPFEffectiveDate);
        end if;
        Call InsertNewCPFProgression(In_EmployeeSysId, In_NewCPFEffectiveDate, 
            In_CPFProgCurrent, In_CPFCareerId, In_CPFProgPolicyId, In_CPFProgAccountNo, In_CPFProgSchemeId,
            In_CPFMAWOption, In_CPFMAWLimit , In_CPFMAWPeriodOrdWage, In_CPFMedisavePaidByER, In_CPFMedisaveSchemeId, In_CPFProgRemarks);
  end if
END
;

commit work;