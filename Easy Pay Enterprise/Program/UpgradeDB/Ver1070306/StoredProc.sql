If exists(select 1 from sys.sysprocedure where proc_name = 'IsDepartmentInUsed') then
  drop function IsDepartmentInUsed
end if;

CREATE FUNCTION "DBA"."IsDepartmentInUsed"(
IN In_DepartmentID char(100)
)
RETURNS smallint

begin
		
	/* Future Career Effective Date is greater than Current Effective Date */
	if exists(select * from careerprogression as cp1, careerAttribute ca,
				(select employeesysid, careereffectiveDate  from careerprogression where careerCurrent = 1 group by employeesysid, careereffectivedate) as cpCurrent 
			where cp1.careereffectivedate > cpCurrent.careereffectiveDate and cp1.employeesysid = cpCurrent.employeesysid 
				and cp1.employeesysid = ca.employeesysid and cp1.careerEffectiveDate = ca.careerEffectiveDate and ca.careerAttributeId = 'CareerDepartment' and careerNewValue = In_DepartmentID) then
		return 1;
	end if;
	
	/* Current Employee Department*/
	if exists(select * from Employee where departmentID = In_DepartmentID) then
		return 1;	
	end if;
	
	/* Employee Default Data */
	if exists(select * from SubRegistry where 
		RegistryId = 'EmployeeSetupData' and SubRegistryId = 'Department' and ShortStringAttr = In_DepartmentID) then
		return 1;
	end if;
		  
	/* Recurring Pay Element */
	if exists(select * from MapRPayElement where 
		RPayElementBasis1 = In_DepartmentID or RPayElementBasis2 = In_DepartmentID or RPayElementBasis3 = In_DepartmentID) then
		return 1;
	end if;
	
	/* Map Shift Table*/
	if exists(select * from MapShift where 
		ShiftBasis1 = In_DepartmentID or ShiftBasis2 = In_DepartmentID or ShiftBasis3 = In_DepartmentID) then
		return 1;
	end if;
	
	/* Map OT Table */
	if exists(select * from MapOT where 
		OTBasis1 = In_DepartmentID or OTBasis2 = In_DepartmentID or OTBasis3 = In_DepartmentID) then
		return 1;
	end if;

	/* Map Donation Table */
	if exists(select * from MapDonation where 
		DonationBasis1 = In_DepartmentID or DonationBasis2 = In_DepartmentID or DonationBasis3 = In_DepartmentID) then
		return 1;
	end if;

	/* Map Cost Centre */
	if exists(select * from MapCostCentre where 
		CostCentreBasis1 = In_DepartmentID or CostCentreBasis2 = In_DepartmentID or CostCentreBasis3 = In_DepartmentID) then
		return 1;
	end if;

	/* Cost Condition */
	if exists(select * from CostCondValue where 
		CostStrValue = In_DepartmentID) then
		return 1;
	end if;

	/* Accrual Eligibility*/
	if exists(select * from AccrualEligibleBasis where 
		AccrualBasis1 = In_DepartmentID or AccrualBasis2 = In_DepartmentID or AccrualBasis3 = In_DepartmentID) then
		return 1;
	end if;

	/* Batch Item */
	if exists(select * from MapItemBatch where 
		ItemBatchBasis1 = In_DepartmentID or ItemBatchBasis2 = In_DepartmentID or ItemBatchBasis3 = In_DepartmentID) then
		return 1;
	end if;

	/* M Claim Policy Default*/
	if exists(select * from MapMClaimPolicy where 
		MClaimPolicyBasis1 = In_DepartmentID or MClaimPolicyBasis2 = In_DepartmentID or MClaimPolicyBasis3 = In_DepartmentID) then
		return 1;
	end if;

	/* M Claim Type*/
	if exists(select * from MClaimTypeRange where 
		MedClaimStringMatch = In_DepartmentID) then
		return 1;
	end if;

	/* M Claim Policy*/
	if exists(select * from MClaimPolicyRec where 
		MedClaimStringMatch = In_DepartmentID) then
		return 1;
	end if;

	/* Leave Allocation Table */
	if exists(select * from LveAllocationRec where 
		LveAllocStringMatch = In_DepartmentID) then
		return 1;
	end if;

	/* Leave Policy */
	if exists(select * from LeavePolicyRecord where 
		PolicyStringMatch = In_DepartmentID) then
		return 1;
	end if;
	
	return 0;
	
commit work;
end;

If exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEducationRec') then
  drop procedure InsertNewEducationRec
end if;

CREATE PROCEDURE "DBA"."InsertNewEducationRec"(
in In_EducationId char(20),
in In_PersonalSysId integer,
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult double,
out Out_EduRecId integer,
out Out_ErrorCode integer)
begin
  declare Out_EducationRecord integer;
  if(FGetInvalidDate(In_EduStartDate) <> '' and FGetInvalidDate(In_EduEndDate) <> '') then
    if(In_EduStartDate < In_EduEndDate) then
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=-1
    end if
  else
    set Out_ErrorCode=1
  end if;
  if(In_EducationId <> '') then
    if(Out_ErrorCode = 1) then
      if not exists(select* from EducationRec where PersonalSysId = In_PersonalSysId and
          EducationId = In_EducationId and EduStartDate = In_EduStartDate and EduEndDate = In_EduEndDate and
          EduInsitution = In_EduInstitution and EduHighest = In_EduHighest and EduResult = In_EduResult) then
        if(In_EduHighest = 1) then
          update EducationRec set EduHighest = 0 where
            PersonalSysId = In_PersonalSysId and EduHighest = 1
        end if;
        select count(*) into Out_EducationRecord from EducationRec where
          PersonalSysId = In_PersonalSysId and EduHighest = 1;
        if(Out_EducationRecord = 0) then set In_EduHighest=1
        end if;
        insert into EducationRec(EducationId,
          PersonalSysId,
          EduStartDate,
          EduEndDate,
          EduInsitution,
          EduHighest,
          EduResult) values(
          In_EducationId,
          In_PersonalSysId,
          In_EduStartDate,
          In_EduEndDate,
          In_EduInstitution,
          In_EduHighest,
          In_EduResult);
        if(In_EduHighest = 1) then
          if exists(select* from Employee where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = '') then
            update Employee set
              HighestEduCode = In_EducationId where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = ''
          end if
        end if;
        commit work;
        if not exists(select* from EducationRec where PersonalSysId = In_PersonalSysId and
            EducationId = In_EducationId and EduStartDate = In_EduStartDate and EduEndDate = In_EduEndDate and
            EduInsitution = In_EduInstitution and EduHighest = In_EduHighest and EduResult = In_EduResult) then
          set Out_ErrorCode=0
        else
          select MAX(EduRecId) into Out_EduRecId from EducationRec where PersonalSysId = In_PersonalSysId;
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    end if
  else
    set Out_ErrorCode=-2
  end if
end;

If exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEducationRec') then
  drop procedure UpdateEducationRec
end if;

CREATE PROCEDURE "DBA"."UpdateEducationRec"(
in In_EduRecId integer,
in In_EducationId char(20),
in In_PersonalSysId integer,
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult double,
out Out_ErrorCode integer)
begin
  if(FGetInvalidDate(In_EduStartDate) <> '' and FGetInvalidDate(In_EduEndDate) <> '') then
    if(In_EduStartDate < In_EduEndDate) then
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=-1
    end if
  else
    set Out_ErrorCode=1
  end if;
  if(In_EducationId <> '') then
    if(Out_ErrorCode = 1) then
      if exists(select* from EducationRec where
          EducationRec.EduRecId = In_EduRecId) then
        if(In_EduHighest = 1) then
          update EducationRec set EducationRec.EduHighest = 0 where
            EducationRec.EduHighest = 1 and
            EducationRec.PersonalSysId = In_PersonalSysId
        end if;
        update EducationRec set
          EducationRec.EducationId = In_EducationId,
          EducationRec.PersonalSysId = In_PersonalSysId,
          EducationRec.EduStartDate = In_EduStartDate,
          EducationRec.EduEndDate = In_EduEndDate,
          EducationRec.EduInsitution = In_EduInstitution,
          EducationRec.EduHighest = In_EduHighest,
          EducationRec.EduResult = In_EduResult where
          EducationRec.EduRecId = In_EduRecId;
        if(In_EduHighest = 1) then
          if exists(select* from Employee where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = '') then
            update Employee set
              HighestEduCode = In_EducationId where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = ''
          end if
        end if;
        commit work;
        set Out_ErrorCode=1
      else
        set Out_ErrorCode=0
      end if
    end if
  else
    set Out_ErrorCode=-2
  end if
end;

commit work;
