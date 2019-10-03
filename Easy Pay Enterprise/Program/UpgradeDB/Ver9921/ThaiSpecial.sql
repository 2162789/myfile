UPDATE SubRegistry SET RegProperty4 = 'CurrentTaxAmount'
WHERE RegistryId = 'PayPeriodPolicy' AND SubRegistryId = 'EstimatedTaxAmt';

commit work;
