READ UpgradeDB\Ver1060107\StoredProc.sql;

/* Update ModuleScreenGroup */
UPDATE ModuleScreenGroup SET EC_ModuleScreenId='EC_WTProfile' 
WHERE ModuleScreenId='LvWTProfile';

Commit Work;