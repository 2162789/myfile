if exists(Select * from SystemUser Where UserId='epe') then
  Call DeleteSystemUser('epe');
end if;
if exists(SELECT 1 FROM SysUsers where name='epe') then
  REVOKE CONNECT FROM epe;
end if;
GRANT CONNECT TO EPE IDENTIFIED BY epe;

if not exists(select * from ePortalVersion where EPE='10000' and ePortal='10000') then
   INSERT INTO ePortalVersion VALUES ('10000','10000');
end if;
