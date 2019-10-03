delete from ModuleScreenGroup where ModuleScreenId='EC_FormatAddress';
Update ModuleScreenGroup 
Set EC_ModuleScreenId=''
where ModuleScreenId='CoreFormatAddress';

commit work;