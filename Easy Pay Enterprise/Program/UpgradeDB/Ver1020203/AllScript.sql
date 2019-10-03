UPDATE AlertField SET 
   AlertCondition = 'ResStatusCurrent= 1 and IsResidenceStatusChanged(ResidenceStatusRecord.PersonalSysId, ResStatusEffectiveDate, ResStatusEffectiveDate) = 1 And ' 
WHERE AlertFieldId = 'AlertResStatEffDate';

commit work;

