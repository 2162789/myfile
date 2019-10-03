update MalTaxRecord set MalTaxShareRemainingAmt= 0 where MalTaxShareRemainingAmt is NULL;

commit work;