---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_company','公司设置','总部流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_company','800501','公司设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_companysave','公司设置','总部流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_companysave','800502','公司设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_app','流程设置','总部流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_app','800503','流程设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_appsave','流程设置','总部流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_appsave','800504','流程设置');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave');

end;
/
commit;