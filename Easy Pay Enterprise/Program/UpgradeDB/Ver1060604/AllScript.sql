update ModuleScreenGroup set ModuleScreenName = 'Manage Customized Crystal Reports' where ModuleScreenId = 'PayCRCustomMgr';
update ModuleScreenGroup set ModuleScreenName = 'Manage Customized Crystal Reports' where ModuleScreenId = 'LvCRCustomMgr';

Update SubRegistry set IntegerAttr = 0 where registryid = 'OldReport' and subregistryid = 'ReportOn';

commit work;