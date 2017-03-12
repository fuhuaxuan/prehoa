--创建数据库表

--使用系统数据EXCEL报表的权限导入数据脚本

--系统
DELETE sys_ver;
insert into sys_ver(sysename,syscname,sysver,sysupdinfo,appename,appcname,appver,appupdinfo,email,homepage,support,copyright,userinfo,thanks,memo,createdate,lastupddate)
values('HDNet','海鼎网络系统平台','v3.00','','','','','','webmaster@hd123.com', 'http://www.hd123.net', '','上海海鼎网络信息有限责任公司','上海海鼎网络信息有限责任公司'||chr(13)||chr(10)||'客户编号：9999','','',sysdate,sysdate);

--企业
DELETE ent WHERE Gid = '10000000000000000000000000000000';
insert into ent(gid,hdcode,code,name,stat,atype,shortname,password,phone,email,memo,url,urllogin,urllogout,createdate,lastupddate,limitcount,limitbdate,limitedate,pwdchangeday,useusrcode)
values('10000000000000000000000000000000','0000','system','上海海鼎网络信息工程有限责任公司',10,20,'网络公司','hd123.com','021-54325000','dongsijie@hd123.com','系统管理网站', 'http://localhost','','',sysdate,sysdate,0, TRUNC(sysdate) ,sysdate + 18000,30,20);

DELETE ent_authmode WHERE EntGid = '10000000000000000000000000000000';
insert into ent_authmode(entgid,atype,isuse,multiassign) values('10000000000000000000000000000000',10,20,20);

DELETE ent_rt WHERE EntGid = '10000000000000000000000000000000';
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','logout');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','main');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','menu');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','mainpage');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','mainpageremind');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','ver');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','help');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','datainterface');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysusrselfpswmod');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysusrselfpswmodsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysusrselfpinmod');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysusrselfpinmodsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysusrselfinfmod');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysusrselfinfmodsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysloglist');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','syslogdel');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','syslogdelsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentlist');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentadd');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentaddsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentmod');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentmodsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentdel');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentrtmod');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentrtmodsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentadmin');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentadminsave');
insert into ent_rt(entgid,rtid) values('10000000000000000000000000000000','sysentdtl');


--用户
DELETE Usr WHERE EntGid = '10000000000000000000000000000000';
insert into usr(entgid,gid,code,name,stat,alevel,phone,email,memo,password,psdmoddate,createdate,lastupddate,stoped,locked,lockerrortimes,logintimes,lastlogindate,limitbdate,limitedate)
values('10000000000000000000000000000000','10000000000000000000000000000001','admin','管理员',10,10,'','','','123456',sysdate,sysdate,sysdate,20,20,0,0,sysdate,sysdate,sysdate + 18000);

DELETE usr_alias WHERE EntGid = '10000000000000000000000000000000';
insert into usr_alias(entgid,gid,code,password,psdmoddate,createdate,lastupddate,logintimes,lastlogindate)
values('10000000000000000000000000000000','10000000000000000000000000000001','admin','123456',sysdate,sysdate,sysdate,0,sysdate);

DELETE usr_authmode WHERE EntGid = '10000000000000000000000000000000';
insert into usr_authmode(entgid,usrgid,usrcode,atype,isuse,sn,pin)
values('10000000000000000000000000000000','10000000000000000000000000000001','admin',10,20,'','123456');

DELETE usr_rt WHERE EntGid = '10000000000000000000000000000000';
insert into usr_rt(entgid,usrgid,rtid,atype) 
select '10000000000000000000000000000000', '10000000000000000000000000000001', rtid, 10 from ent_rt where entgid = '10000000000000000000000000000000'; 

--企业组织类别关系
DELETE org_root_sort;
insert into org_root_sort(id,name) values('1000','用户组');
insert into org_root_sort(id,name) values('2000','部门组');
insert into org_root_sort(id,name) values('3000','职务组');
--insert into org_root_sort(id,name) values('4000','短信组');

DELETE org_sort;
insert into org_sort(id,name) values('1001','用户组');
insert into org_sort(id,name) values('2001','部门');
insert into org_sort(id,name) values('3001','职务');
--insert into org_sort(id,name) values('4001','短信组');

DELETE org_sort_relation;
insert into org_sort_relation(rootsortid,sortid) values('1000','1001');
insert into org_sort_relation(rootsortid,sortid) values('2000','2001');
insert into org_sort_relation(rootsortid,sortid) values('3000','3001');
--insert into org_sort_relation(rootsortid,sortid) values('4000','4001');

--新增默认组织
DELETE Org WHERE EntGid = '10000000000000000000000000000000';
insert into org(entgid, gid, layercode, code, name, atype, isdel, isusr, isroot, rootsortid, sortid, childcount)
  values('10000000000000000000000000000000', '10000000000000000000000000000002', '0000', 'All_Usr_Grp', '全体用户组', 10, 20, 10, 10, '1000', '1001', 1);
insert into org(entgid, gid, layercode, code, name, atype, isdel, isusr, isroot, rootsortid, sortid, parentgid)
  values('10000000000000000000000000000000', '10000000000000000000000000000003', '00000000', 'Admin_Grp', '管理员组', 20, 20, 10, 20, '1000', '1001', '10000000000000000000000000000002');

DELETE org_rt_relation WHERE EntGid = '10000000000000000000000000000000';
DELETE org_rt WHERE EntGid = '10000000000000000000000000000000';
DELETE org_rt_all WHERE EntGid = '10000000000000000000000000000000';
DELETE org_usr WHERE EntGid = '10000000000000000000000000000000';

insert into org_rt_relation(entgid, orggid, atype)
  values('10000000000000000000000000000000', '10000000000000000000000000000002', 20);

insert into org_rt(entgid,orggid,rtid,atype) 
  select '10000000000000000000000000000000', '10000000000000000000000000000002', rtid, 10 from ent_rt where entgid = '10000000000000000000000000000000' and rtid not in (select id from rt where alevel = 20); 
insert into org_rt(entgid,orggid,rtid,atype) 
  select '10000000000000000000000000000000', '10000000000000000000000000000003', rtid, 10 from ent_rt where entgid = '10000000000000000000000000000000'; 

insert into org_rt_all(entgid,orggid,rtid,atype) 
  select '10000000000000000000000000000000', '10000000000000000000000000000002', rtid, 10 from ent_rt where entgid = '10000000000000000000000000000000' and rtid not in (select id from rt where alevel = 20); 
insert into org_rt_all(entgid,orggid,rtid,atype) 
  select '10000000000000000000000000000000', '10000000000000000000000000000003', rtid, 10 from ent_rt where entgid = '10000000000000000000000000000000'; 

insert into org_usr(entgid, orggid, usrgid) values('10000000000000000000000000000000', '10000000000000000000000000000002', '10000000000000000000000000000001');
insert into org_usr(entgid, orggid, usrgid) values('10000000000000000000000000000000', '10000000000000000000000000000003', '10000000000000000000000000000001');

commit;
