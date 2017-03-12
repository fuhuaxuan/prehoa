--新增企业
delete ent where gid = getEntGid;
delete ent_authmode where entgid = getEntGid;
delete ent_rt where entgid = getEntGid;

insert into ent (gid,hdcode,code,name,stat,atype,shortname,password,phone,email,memo,url,urllogin,urllogout,createdate,lastupddate,limitcount,limitbdate,limitedate,pwdchangeday,useusrcode)
values(getEntGid,getEntCode,getHDNetCode,getEntName,10,10,getEntSName,'hd123.com','','','','','','',sysdate,sysdate,getUsrCount,sysdate-1,sysdate+18000,30,20);

--新增企业认证方式
insert into ent_authmode(entgid,atype,isuse,multiassign) values(getEntGid,10,20,10);

--新增权限
insert into ent_rt select getEntGid, id from rt where alevel in (10,11);
--需要新增该企业已有的应用模块权限------------------------------------

--报表
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '20%';
--工作流程
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '21%';
--文件管理器
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '22%';
--信件
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '40%';
--论坛
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '41%';
--公告
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '42%';

--投票 + 公共讨论
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '43%';

--图书等资源管理（暂不作为标准功能。）
--insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '44%';
--人力资源
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '60%';
--工作日志
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '61%';
--月度考核
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '62%';
--日程安排
insert into ent_rt select getEntGid, id from rt where alevel = 30 and aorder like '7006%';



commit;

--插入管理员，海鼎管理员：heading；系统管理员：admin
delete usr where entgid = getEntGid;
delete usr_alias where entgid = getEntGid;
delete usr_rt where entgid = getEntGid;
delete usr_authmode where entgid = getEntGid;

insert into usr_alias(entgid, gid, code, password, psdmoddate, createdate, lastupddate, logintimes, lastlogindate) 
  values(getEntGid, sys_guid(), 'admin', '123456', sysdate, sysdate, sysdate, 0, sysdate);

insert into usr(entgid, gid, code, name, stat, alevel, phone, email, memo, sessionexpire, password, psdmoddate, createdate, lastupddate, stoped, locked, lockerrortimes, logintimes, lastlogindate, limitbdate, limitedate) 
  select getEntGid, gid, 'admin', '管理员', 10, 20, null, null, null, 60, '123456', sysdate, sysdate, sysdate, 20, 20, 0, 0, sysdate, sysdate-1, sysdate+18000 from usr_alias where entgid = getEntGid and code = 'admin';

insert into usr_authmode(entgid, usrgid, usrcode, atype, isuse, sn, pin)
  select getEntGid, gid, 'admin', 10, 20, null, null from usr_alias where entgid = getEntGid and code = 'admin';

insert into usr_alias(entgid, gid, code, password, psdmoddate, createdate, lastupddate, logintimes, lastlogindate) 
  values(getEntGid, sys_guid(), 'heading', '123456', sysdate, sysdate, sysdate, 0, sysdate);

insert into usr(entgid, gid, code, name, stat, alevel, phone, email, memo, sessionexpire, password, psdmoddate, createdate, lastupddate, stoped, locked, lockerrortimes, logintimes, lastlogindate, limitbdate, limitedate) 
  select getEntGid, gid, 'heading', '海鼎管理员', 10, 20, null, null, null, 60, '123456', sysdate, sysdate, sysdate, 20, 20, 0, 0, sysdate, sysdate-1, sysdate+18000 from usr_alias where entgid = getEntGid and code = 'heading';

insert into usr_authmode(entgid, usrgid, usrcode, atype, isuse, sn, pin)
  select getEntGid, gid, 'heading', 10, 20, null, null from usr_alias where entgid = getEntGid and code = 'heading';
commit;


--插入用户组：全体用户组、
delete from org where entgid=getEntGid;
delete from org_rt_relation where entgid=getEntGid;
delete from org_common where entgid=getEntGid;
delete from org_rt where  entgid=getEntGid;
delete from org_rt_all where  entgid=getEntGid;


insert into org_common(entgid,gid,code,name,sortid,memo,createdate,lastupddate)
  values( getEntGid,getGid3,'All_Usr_Grp','全体用户组','1001','系统用户组，不能删除',sysdate,sysdate);

insert into org_common(entgid,gid,code,name,sortid,memo,createdate,lastupddate)
  values( getEntGid,sys_guid(),'Admin_Grp','管理员组','1001','系统用户组，不能删除',sysdate,sysdate);

insert into org (entgid, gid, layercode, code, name, atype, isusr, isdel, isroot, rootsortid, sortid, parentgid, childcount, createdate, lastupddate)
  select getEntGid, gid , '0000', 'All_Usr_Grp', '全体用户组', 10, 10, 20, 10, '1000', '1001', '', 1, sysdate, sysdate from org_common where entgid=getEntGid and code = 'All_Usr_Grp';

insert into org(entgid, gid, layercode, code, name, atype, isusr, isdel, isroot, rootsortid, sortid, parentgid, childcount, createdate, lastupddate)
  select getEntGid, a.gid,  '00000000', 'Admin_Grp', '管理员组', 20, 10, 20, 20, '1000', '1001', b.Gid, 0, sysdate, sysdate from org_common a, org b 
  where a.entgid=getEntGid and b.entgid = getEntGid
  and a.code = 'Admin_Grp'
  and b.code = 'All_Usr_Grp';


update org set parentgid = (select gid from org 
  where entgid = getEntGid and lower(code) = 'all_usr_grp') where entgid = getEntGid and lower(code) <> 'all_usr_grp';

insert into org_rt_relation(entgid,orggid,atype) 
  select getEntGid,gid,10 from org where entgid = getEntGid;

insert into org_rt(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'all_usr_grp' and rtid  in ('logout','main','menu','mainpage','mainpageremind','ver','help','datainterface','sysusrselfpswmod','sysusrselfpswmodsave','sysusrselfpinmod','sysusrselfpinmodsave','sysusrselfinfmod','sysusrselfinfmodsave','mainpageconfig','mainpageconfigsave'); 

insert into org_rt_all(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'all_usr_grp' and rtid in ('logout','main','menu','mainpage','mainpageremind','ver','help','datainterface','sysusrselfpswmod','sysusrselfpswmodsave','sysusrselfpinmod','sysusrselfpinmodsave','sysusrselfinfmod','sysusrselfinfmodsave','mainpageconfig','mainpageconfigsave'); 

insert into org_rt(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'admin_grp' and rtid not in (select id from rt where alevel = 20); 

insert into org_rt_all(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'admin_grp' and rtid not in (select id from rt where alevel = 20); 

--用户组与用户关系
delete org_usr where entgid=getEntGid;

insert into org_usr(entgid,orggid,usrgid)
  select getEntGid, a.Gid, b.Gid from Org a, Usr b 
  where a.EntGid = getEntGid and b.EntGid = getEntGid ;


--插入部门组织
delete from org_dept where entgid=getEntGid and code='Dept';
insert into org_dept (entgid,gid,code,name,sortid,depttype,address,phone,faxno,contactor,createdate,lastupddate) values(getEntGid, getGid4, 'Dept', '企业部门组', '2001', 10, '', '', '', '', sysdate,sysdate);	
insert into org_rt_relation(entgid,orggid,atype) 	
select entgid,gid,10 from org_dept where entgid = getEntGid and code = 'Dept';	


insert into org(entgid,gid,layercode,code,name,atype,isusr,isdel,isroot,rootsortid,sortid,parentgid,childcount,createdate,lastupddate)	
select entgid,gid,'0001',code,name,null,20,10,20,'2000','2001','',0,createdate,lastupddate from org_dept where entgid = getEntGid  and code = 'Dept';	


update org set isroot = 10 where code = 'Dept' and entgid = getEntGid;	

--给部门组织赋权限
--个人信息以及首页配置等
insert into org_rt(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'dept' and rtid in ('repapplist','repdisplay','wfflowpage','wftodotasklist','wfalltasklist','wfflowadd','workflowgraphi','wfflowlist','wfflowtrace','wfflowsetstate','wfflowtracesave','ftexplorer','ftexplorertreeview','ftexplorerfilelist','ftexplorerproperty','ftexplorercreatefolder','ftexplorerupload','ftexplorerfileinfo','ftexplorerpaste','ftexplorerrename','ftexplorersecurity','ftexplorerextract','ftexplorerdelete','ftsearch','ftfilelist','maildraftlist','mailmod','mailmodsave','mailmodsendsave','mailsenddirect','mailadd','mailaddsave','mailchangesend','mailreceivechange','mailaddsendsave','mailabolish','mailreceiveabolish','maildel','mailreceivedel','mailsendlist','mailsenddellist','mailsenddtl','mailsendusrlist','mailrecall','mailreceivelist','mailreceivedellist','mailreceiverestore','mailreceiverestoresave','mailreceiverestoresendsave','mailreceiveread','maileditusr','mailintoorg','mailorglist','mailusrlist','bbs','bbslist','bbsadd','bbsaddsave','bbsread','bbsreadsave','bbsset','bbsmod','bbsmodsave','bbstrans','bbstranssave');

insert into org_rt(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'dept' and rtid in ('docsendlist','docadd','docaddsave','docmod','docmodsave','docabolish','docsenddtl','docreadlist','docreceivelist','docreceivedtl','voteprjlist','voteprjdtl','vote','votesave','voteresult','discussact','discussactsave','discussdtl','discussiframelist','discusslist','discusslistsave','discussprocess','discussread','discussreadsave','discussmod','discussmodsave','discussactmod','discussactmodsave','discussadd','discussaddsave','trc_book','trc_booklist','trc_bookdtl','trc_bookneedlist','trc_bookneedadd','trc_bookneedaddsave','trc_booklend','trc_bookrecordself','trc_bookrecord','trc_bookcontinue','trc_bookreturn','trc_bookneeddel','roomset','roomsetsave','roomlendrecord','roomlendrecordsave','roomlendset','roomlendsetsave','carset','carsetsave','carlendrecord','carlendrecordsave','carlendset','carlendsetsave','hr','hrtreesearch','hrdept','hrinfolist','hrinfodtl','hrinfodown','hrempstate','hrempstatehistory','worklog','workloglist','worklogmod','worklogmodsave','worklogimport','kh','khnav2','khnav1','khwac','khmodwac','khmodwacsave','khwbc','khmodwbc','khmodwbcsave','equipmentset','equipmentsetsave','equipmentlendrecord','equipmentlendrecordsave','equipmentlendset','equipmentlendsetsave','workcalendarlist','workcalendaradd','workcalendaraddsave','workcalendarmod','workcalendarmodsave','workcalendardel','workcalendarmainremind','workcalendarmainremindsave'); 

--报表个人管理 + 工作流程个人管理 + 组织扩展管理（目前只分配给企业，但未分配给普通用户。）
--'replistadmin','repmodifyadmin','repmodifyadminSave','reprightadmin1','reprightadminsave1','wfpmodellist','wfpexecermod','wfpexecermodsave','wfpconditionmod','wfpconditionmodsave','wfpmodelmod','wfpmodelmodsave','sysorgexlist','sysorgtreeex','sysorgtreeexlist','sysorgtreeexdtl','sysorgtreeexsearch'


insert into org_rt_all(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'dept' and rtid in ('repapplist','repdisplay','wfflowpage','wftodotasklist','wfalltasklist','wfflowadd','workflowgraphi','wfflowlist','wfflowtrace','wfflowsetstate','wfflowtracesave','ftexplorer','ftexplorertreeview','ftexplorerfilelist','ftexplorerproperty','ftexplorercreatefolder','ftexplorerupload','ftexplorerfileinfo','ftexplorerpaste','ftexplorerrename','ftexplorersecurity','ftexplorerextract','ftexplorerdelete','ftsearch','ftfilelist','maildraftlist','mailmod','mailmodsave','mailmodsendsave','mailsenddirect','mailadd','mailaddsave','mailchangesend','mailreceivechange','mailaddsendsave','mailabolish','mailreceiveabolish','maildel','mailreceivedel','mailsendlist','mailsenddellist','mailsenddtl','mailsendusrlist','mailrecall','mailreceivelist','mailreceivedellist','mailreceiverestore','mailreceiverestoresave','mailreceiverestoresendsave','mailreceiveread','maileditusr','mailintoorg','mailorglist','mailusrlist','bbs','bbslist','bbsadd','bbsaddsave','bbsread','bbsreadsave','bbsset','bbsmod','bbsmodsave','bbstrans','bbstranssave');

insert into org_rt_all(entgid,orggid,rtid,atype) 
select getEntGid, r.gid, e.rtid, 10 from ent_rt e,org r where e.entgid = getEntGid and r.entgid = getEntGid and lower(r.code) = 'dept' and rtid in ('docsendlist','docadd','docaddsave','docmod','docmodsave','docabolish','docsenddtl','docreadlist','docreceivelist','docreceivedtl','voteprjlist','voteprjdtl','vote','votesave','voteresult','discussact','discussactsave','discussdtl','discussiframelist','discusslist','discusslistsave','discussprocess','discussread','discussreadsave','discussmod','discussmodsave','discussactmod','discussactmodsave','discussadd','discussaddsave','trc_book','trc_booklist','trc_bookdtl','trc_bookneedlist','trc_bookneedadd','trc_bookneedaddsave','trc_booklend','trc_bookrecordself','trc_bookrecord','trc_bookcontinue','trc_bookreturn','trc_bookneeddel','roomset','roomsetsave','roomlendrecord','roomlendrecordsave','roomlendset','roomlendsetsave','carset','carsetsave','carlendrecord','carlendrecordsave','carlendset','carlendsetsave','hr','hrtreesearch','hrdept','hrinfolist','hrinfodtl','hrinfodown','hrempstate','hrempstatehistory','worklog','workloglist','worklogmod','worklogmodsave','worklogimport','kh','khnav2','khnav1','khwac','khmodwac','khmodwacsave','khwbc','khmodwbc','khmodwbcsave','equipmentset','equipmentsetsave','equipmentlendrecord','equipmentlendrecordsave','equipmentlendset','equipmentlendsetsave','workcalendarlist','workcalendaradd','workcalendaraddsave','workcalendarmod','workcalendarmodsave','workcalendardel','workcalendarmainremind','workcalendarmainremindsave'); 




--文件管理器
delete ft where entgid=getEntGid;
delete ft_rt where entgid=getEntGid;

insert into ft(entgid, gid, vpath, rpath, filename, info) values( getEntGid , 'root', 'root', lower(getHDNetPath || 'Web\Files\' || getHDNetCode ||'\ft'), 'Intranet', 'root' );
insert into ft_rt(entgid, ftgid, usrgidex, sec) select entgid, 'root', gid, 3 from v_usr where entgid = getEntGid and lower(code) = 'admin_grp';
insert into ft_rt(entgid, ftgid, usrgidex, sec) select entgid, 'root', gid, 1 from v_usr where entgid = getEntGid and lower(code) = 'all_usr_grp';


commit;
