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
	
end;

commit work;
