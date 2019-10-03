READ UpgradeDB\Ver1060302\StoredProc.sql;

delete from RemDetailsTmpl where RemFunctionID = 'PayNSTrainingStart';
delete from RemFunction where RemFunctionID = 'PayNSTrainingStart';

commit work;