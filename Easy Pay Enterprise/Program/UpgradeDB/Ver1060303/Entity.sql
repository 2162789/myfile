if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'ParamNameU1') then
  alter table RemFunction alter ParamNameU1 char(50);
end if;  

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'ParamNameU2') then
  alter table RemFunction alter ParamNameU2 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'ParamNameU3') then
  alter table RemFunction alter ParamNameU3 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'ParamNameU4') then
  alter table RemFunction alter ParamNameU4 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'ParamNameU5') then
  alter table RemFunction alter ParamNameU5 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyAttributeId1') then
  alter table RemFunction alter FuncKeyAttributeId1 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyAttributeId2') then
  alter table RemFunction alter FuncKeyAttributeId2 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyAttributeId3') then
  alter table RemFunction alter FuncKeyAttributeId3 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyAttributeId4') then
  alter table RemFunction alter FuncKeyAttributeId4 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyAttributeId5') then
  alter table RemFunction alter FuncKeyAttributeId5 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyword1') then
  alter table RemFunction alter FuncKeyword1 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyword2') then
  alter table RemFunction alter FuncKeyword2 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyword3') then
  alter table RemFunction alter FuncKeyword3 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyword4') then
  alter table RemFunction alter FuncKeyword4 char(50);
end if; 

if exists(select 1 from sys.syscolumns where tname = 'RemFunction' and cname = 'FuncKeyword5') then
  alter table RemFunction alter FuncKeyword5 char(50);
end if; 

commit work;