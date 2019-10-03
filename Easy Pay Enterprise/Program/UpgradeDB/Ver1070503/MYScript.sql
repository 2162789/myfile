/* Hide away Rebate ID 'KWSP' from InterfaceCodeTable */
UPDATE Subregistry SET RegProperty6 = 'AND RebateID not in (''Lve Passage'' ,''Lve Passage Overseas'',''Childcare'',''Meal'',''Parking'',''Petrol Official'',''Petrol Non Official'',''Compensation'',''Loan Interest'',''KWSP'') Order By RebateId'
where registryid = 'InterfaceCodeTable'
and subregistryid = 'RebateID'
and Regproperty1 = 'Rebate Claim Process'

commit work;