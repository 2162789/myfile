/* Patch the wrong policy for BPJSTK */
BEGIN

DECLARE Is_FirstTimeRunScript char(1);
DECLARE Pre_DefaultBPJSTKPolicy char(20);
DECLARE Pre_StaGovBPJSTKPolicy char(20);
DECLARE Existing_BPJSTKPolicy char(20);
DECLARE Existing_BPJSTKPolicy2 char(20);
DECLARE NewHire_EffectiveDate datetime;
DECLARE NewHire_BPJSTKPolicy char(20); 

SELECT RegProperty8 INTO Is_FirstTimeRunScript FROM SubRegistry
WHERE SubRegistryId = 'DBVersion';

IF Is_FirstTimeRunScript <> '1' THEN 
	IF EXISTS (SELECT * from sys.sysprocedure WHERE proc_name = 'TempFGetBPJSTKPolicy') THEN
	   DROP FUNCTION DBA.TempFGetBPJSTKPolicy
	END IF;

	/* Get the correct new Policy based on the old policy */
	CREATE FUNCTION DBA.TempFGetBPJSTKPolicy
	(
	IN In_OldBPJSTKPolicy char(20)
	)
	RETURNS char(20)
	BEGIN
	   DECLARE OUT_NEWBPJSTKPolicy char(20);
	   
	   SET OUT_NEWBPJSTKPolicy = (CASE In_OldBPJSTKPolicy WHEN 'BPJS-TKGrp1-2004Jan' THEN 'BPJS-TKGrp1-2017Mar' 
														  WHEN 'BPJS-TKGrp2-2004Jan' THEN 'BPJS-TKGrp2-2017Mar'
														  WHEN 'BPJS-TKGrp4-2004Jan' THEN 'BPJS-TKGrp4-2017Mar'
														  WHEN 'BPJS-TKGrp5-2004Jan' THEN 'BPJS-TKGrp5-2017Mar'
														  ELSE 'BPJS-TKGrp3-2017Mar' END);
	   RETURN OUT_NEWBPJSTKPolicy;
	END;

	/* Update Pay Details Default */
	/* Get the policy from BPJSTK Progression latest effective date as previous default setup, then update it accordingly */
	SELECT TOP 1 CPFProgPolicyId INTO Pre_DefaultBPJSTKPolicy FROM CPFProgression
	ORDER BY CPFEffectiveDate DESC;

	IF Pre_DefaultBPJSTKPolicy IN ('BPJS-TKGrp1-2004Jan','BPJS-TKGrp2-2004Jan','BPJS-TKGrp3-2004Jan','BPJS-TKGrp4-2004Jan','BPJS-TKGrp5-2004Jan') THEN 
	  Update SubRegistry Set ShortStringAttr = TempFGetBPJSTKPolicy(Pre_DefaultBPJSTKPolicy)
	  Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';
	ELSE 
	  Update SubRegistry Set ShortStringAttr = Pre_DefaultBPJSTKPolicy
	  Where RegistryId='PaySetupData' And SubRegistryId='CPFProgPolicyId';	  
	END IF;

	/* Update Statutory Government Steup  */
	/* Get the previous policy for effective date "2017-03-01", then update it accordingly */
	SELECT Top 1 CPFGovtPolicyId INTO Pre_StaGovBPJSTKPolicy FROM CPFGovernmentProgression
	WHERE CPFGovtSchemeId = 'BPJSTK' AND CPFGovtEffectiveDate < '2017-03-01'
	ORDER BY CPFGovtEffectiveDate DESC;
	   
	IF Pre_StaGovBPJSTKPolicy IN ('BPJS-TKGrp1-2004Jan','BPJS-TKGrp2-2004Jan','BPJS-TKGrp3-2004Jan','BPJS-TKGrp4-2004Jan','BPJS-TKGrp5-2004Jan') THEN 
	  UPDATE CPFGovernmentProgression 
	  SET CPFGovtPolicyId = TempFGetBPJSTKPolicy(Pre_StaGovBPJSTKPolicy)
	  WHERE CPFGovtEffectiveDate = '2017-03-01' and CPFGovtSchemeId = 'BPJSTK';
    ELSE 
	  DELETE CPFGovernmentProgression WHERE CPFGovtEffectiveDate = '2017-03-01' and CPFGovtSchemeId = 'BPJSTK';
    END IF;

	/* Update BPJSTK Progression  */
	/* For employee who join before 2017-03-01 and latest effective date is 2017-03-01, get the previous policy from progression. IF Policy belongs to group 1 to 5, then update it for progression with effective date "2017-03-01". Otherwise delete latest progression */
	BPJSTKProgLoopExisting: FOR BPJSTKProgExisting AS BPJSTKProgExistingCur DYNAMIC SCROLL CURSOR FOR 
	   SELECT EmployeeSysId AS OUT_EmployeeSysId, MAX(CPFEffectiveDate) AS OUT_LatestEffectiveDate FROM CPFProgression
	   GROUP BY EmployeeSysId
	   HAVING OUT_LatestEffectiveDate = '2017-03-01'
	   AND EmployeeSysId IN (SELECT EmployeeSysId FROM Employee WHERE HireDate < '2017-03-01')
	   DO
		  SELECT TOP 1 CPFProgPolicyId INTO Existing_BPJSTKPolicy FROM CPFProgression
		  WHERE EmployeeSysId = OUT_EmployeeSysId AND CPFEffectiveDate < '2017-03-01'
		  ORDER BY CPFEffectiveDate DESC;
		  
		  IF Existing_BPJSTKPolicy IN ('BPJS-TKGrp1-2004Jan','BPJS-TKGrp2-2004Jan','BPJS-TKGrp3-2004Jan','BPJS-TKGrp4-2004Jan','BPJS-TKGrp5-2004Jan') THEN  
		    UPDATE CPFProgression 
		    SET CPFProgPolicyId = TempFGetBPJSTKPolicy(Existing_BPJSTKPolicy)
		    WHERE EmployeeSysId = OUT_EmployeeSysId AND CPFEffectiveDate = '2017-03-01' AND CPFProgSchemeId = 'BPJSTK';  
		  ELSE 
		    DELETE CPFProgression WHERE EmployeeSysId = OUT_EmployeeSysId AND CPFEffectiveDate = '2017-03-01' AND CPFProgSchemeId = 'BPJSTK'; 
		  END IF;
	   END FOR;

	/* For employee who join before 2017-03-01 and latest effective date is greater than 2017-03-01, get the latest policy from progression, then update is accordingly */
	BPJSTKProgLoopExisting2: FOR BPJSTKProgExisting2 AS BPJSTKProgExistingCur2 DYNAMIC SCROLL CURSOR FOR 
	   SELECT EmployeeSysId AS OUT_EmployeeSysId, MAX(CPFEffectiveDate) AS OUT_LatestEffectiveDate FROM CPFProgression
	   GROUP BY EmployeeSysId
	   HAVING OUT_LatestEffectiveDate > '2017-03-01'
	   AND EmployeeSysId IN (SELECT EmployeeSysId FROM Employee WHERE HireDate < '2017-03-01')
	   DO
		  SELECT CPFProgPolicyId INTO Existing_BPJSTKPolicy2 FROM CPFProgression
		  WHERE EmployeeSysId = OUT_EmployeeSysId AND CPFEffectiveDate = OUT_LatestEffectiveDate;
		  
		  IF Existing_BPJSTKPolicy2 IN ('BPJS-TKGrp1-2004Jan','BPJS-TKGrp2-2004Jan','BPJS-TKGrp3-2004Jan','BPJS-TKGrp4-2004Jan','BPJS-TKGrp5-2004Jan') THEN  
		    UPDATE CPFProgression 
		    SET CPFProgPolicyId = TempFGetBPJSTKPolicy(Existing_BPJSTKPolicy2)
		    WHERE EmployeeSysId = OUT_EmployeeSysId AND CPFEffectiveDate = OUT_LatestEffectiveDate AND CPFProgSchemeId = 'BPJSTK';	
          END IF;			
	   END FOR;

	/* For employee who join on or after 2017-03-01, get the latest policy from progression, then update it accordingly */
	BPJSTKProgLoopNewHire: FOR BPJSTKProgNewHire AS BPJSTKProgNewHireCur DYNAMIC SCROLL CURSOR FOR 
	   SELECT DISTINCT EmployeeSysId AS OUT_EmployeeSysId FROM Employee
	   WHERE HireDate >= '2017-03-01'
	   DO
		  SELECT TOP 1 CPFEffectiveDate, CPFProgPolicyId INTO NewHire_EffectiveDate, NewHire_BPJSTKPolicy FROM CPFProgression
		  WHERE EmployeeSysId = OUT_EmployeeSysId
		  ORDER BY CPFEffectiveDate DESC;
		  
		  IF NewHire_BPJSTKPolicy IN ('BPJS-TKGrp1-2004Jan','BPJS-TKGrp2-2004Jan','BPJS-TKGrp3-2004Jan','BPJS-TKGrp4-2004Jan','BPJS-TKGrp5-2004Jan') THEN 
		    UPDATE CPFProgression 
		    SET CPFProgPolicyId = TempFGetBPJSTKPolicy(NewHire_BPJSTKPolicy)
		    WHERE EmployeeSysId = OUT_EmployeeSysId AND CPFEffectiveDate = NewHire_EffectiveDate AND CPFProgSchemeId = 'BPJSTK';	
          END IF;			
	   END FOR;

	DROP FUNCTION DBA.TempFGetBPJSTKPolicy;

	/* update subregistry record to stamp that system ran this script */
	UPDATE SubRegistry 
	SET RegProperty8 = '1'
	WHERE SubRegistryId = 'DBVersion';

END IF;

/* Remove the stamp from the subregistry record */
UPDATE SubRegistry
SET RegProperty8 = ''
WHERE SubRegistryId = 'DBVersion';

END;

commit work;