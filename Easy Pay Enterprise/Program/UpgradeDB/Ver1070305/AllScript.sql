READ UpgradeDB\Ver1070305\Entity.sql;
READ UpgradeDB\Ver1070305\StoredProc.sql;

/* Core Global Change */
UPDATE SubRegistry 
SET RegProperty7 = 'Select DepartmentId, DepartmentDesc from Department where DepartmentHist = 0'
WHERE RegistryId = 'EmployeeSetupData' AND SubRegistryId = 'Department';

/* Career Progression */
UPDATE SubRegistry
SET RegProperty7 = 'Select DepartmentId as A,DepartmentDesc as B from Department where DepartmentHist = 0'
WHERE registryid = 'careerAttribute' AND subregistryid = 'careerDepartment';

/* Automation Setup & Cost Condition Setup & Casual Daily Entry*/
UPDATE SubRegistry
SET RegProperty7 = 'Select 1, DepartmentId as A, DepartmentDesc as B from Department where DepartmentHist = 0'
WHERE 
(RegistryId = 'RPayElementBasis' AND SubRegistryId = 'RPayEleDepartment') OR 
(registryId = 'ShiftBasis' AND SubRegistryId = 'ShiftDepartment') OR 
(registryId = 'OTBasis' AND SubRegistryId = 'OTDepartment') OR 
(registryId = 'DonationBasis' AND SubRegistryId = 'DonateDepartment') OR 
(registryId = 'CostBasis' AND SubRegistryId = 'CostDepartment') OR 
(registryId = 'ItemBasis' AND SubRegistryId = 'ItemDepartment') OR 
(registryId = 'MClaimBasis' AND SubRegistryId = 'MClaimDepartment');

/* 
LeaveRangeBasis - Leave Allocation, Leave Policy, 
HRRangeBasis - Medical Claim Policy, Medical Claim Type
*/
UPDATE SubRegistry
SET RegProperty7 = 'Select DepartmentId as A,DepartmentDesc as B from Department where DepartmentHist = 0 union select ''???'', ''Wild Card'''
WHERE 
(RegistryId = 'LeaveRangeBasis' AND SubRegistryId = 'Department') OR 
(RegistryId = 'HRRangeBasis' AND SubRegistryId = 'Department');
commit work;