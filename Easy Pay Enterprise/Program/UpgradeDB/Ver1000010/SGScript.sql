update ModuleScreenGroup set ModuleScreenId = 'EC_CPFFWLSDFRpt', ModuleScreenName = 'CPF/FWL/SDF Report' where ModuleScreenId = 'EC_FWLSDFRpt';
update ModuleScreenGroup set EC_ModuleScreenId = '' where ModuleScreenId = 'PayFWLSDFRpt';
update ModuleScreenGroup set EC_ModuleScreenId = 'EC_CPFFWLSDFRpt' where ModuleScreenId = 'PayFWLSetupRpt';
commit work;