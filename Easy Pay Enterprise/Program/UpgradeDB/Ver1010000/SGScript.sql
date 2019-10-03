UPDATE ModuleScreenGroup SET HideScreenForWage = 1 
WHERE ModuleScreenId 
IN ('YEDirectCurIR8ARpt','YEDirectSupIR8ARpt','YEDirectIR8SRpt','EC_YEDirectCurIR8A','EC_YEDirectSupIR8A','EC_YEDirectIR8S');

commit work;