Insert into ModuleScreenGroup Values ('PayManContriProg','PayModules','SCP Progression','Pay',0,0,0,'');

Update ModuleScreenGroup Set ModuleScreenName = 'TAP / SCP Setup Reports' Where ModuleScreenId = 'PayCPFSetupRpts';
Update ModuleScreenGroup Set ModuleScreenName = 'TAP / SCP Table Report' Where ModuleScreenId = 'PayCPFTableRpt';
Update ModuleScreenGroup Set ModuleScreenName = 'TAP / SCP Policy Report' Where ModuleScreenId = 'PayCPFPolicyRpt';
Update ModuleScreenGroup Set ModuleScreenName = 'TAP / SCP Setup' Where ModuleScreenId = 'PayCPFSetup';
Update ModuleScreenGroup Set ModuleScreenName = 'TAP / SCP Table Setup' Where ModuleScreenId = 'PayCPFTableSetup';
Update ModuleScreenGroup Set ModuleScreenName = 'TAP / SCP Policy Setup' Where ModuleScreenId = 'PayCPFPolicySetup';