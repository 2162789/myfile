READ UpgradeDB\Ver1050810\CPFPolicyTable.sql;
READ UpgradeDB\Ver1050810\CPF_EP.sql;
READ UpgradeDB\Ver1050810\CPF_FW.sql;
READ UpgradeDB\Ver1050810\CPF_Local.sql;
READ UpgradeDB\Ver1050810\CPF_PR1Full.sql;
READ UpgradeDB\Ver1050810\CPF_PR1Grad.sql;
READ UpgradeDB\Ver1050810\CPF_PR2Full.sql;
READ UpgradeDB\Ver1050810\CPF_PR2Grad.sql;
READ UpgradeDB\Ver1050810\CPF_PR3.sql;

Insert into CPFProgression (EmployeeSysId, 
CPFEffectiveDate, 
CPFCareerId,
CPFProgPolicyId, 
CPFProgCurrent, 
CPFProgAccountNo, 
CPFProgSchemeId,
CPFMAWOption,
CPFMAWLimit,
CPFProgRemarks,
CPFMAWPeriodOrdWage,
CPFMedisavePaidByER)
Select CPFProgression.EmployeeSysId, 
'2011-09-01', 
'',
'Year2011Sep', 
0, 
CPFProgAccountNo, 
CPFProgSchemeId,
CPFMAWOption,
CPFMAWLimit,
'',
CPFMAWPeriodOrdWage,
CPFMedisavePaidByER
From PayEmployee join CPFProgression 
On PayEmployee.EmployeeSysId = CPFProgression.EmployeeSysId
Where CPFProgCurrent = 1 and CPFEffectiveDate < '2011-09-01' and CPFProgSchemeId != ''
And (LastPayDate = '1899-12-30' Or LastPayDate >= '2011-09-01')
And Not exists(Select * From CPFProgression as CheckCPF where CheckCPF.CPFEffectiveDate = '2011-09-01' and CheckCPF.EmployeeSysID = CPFProgression.EmployeeSysId)
;

Update SubRegistry Set ShortStringAttr='Year2011Sep'
Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';
;

Update CPFProgression Set CPFMAWLimit = 23333 Where CPFEffectiveDate = '2011-09-01' And CPFMAWLimit = 22500;