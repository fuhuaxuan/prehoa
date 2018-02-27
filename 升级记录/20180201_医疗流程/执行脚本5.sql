declare
  v_EntGid       varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');
--删除模块权限
delete rt where id like 'prlyy_%';

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_company','公司设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_company','800501','公司设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_companysave','公司设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_companysave','800502','公司设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_app','流程审批设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_app','800503','流程审批设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_appsave','流程审批设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_appsave','800504','流程审批设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_acg_post','项目审批设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_acg_post','800505','项目审批设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_acg_postsave','项目审批设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_acg_postsave','800506','项目审批设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_stamp_app','用印审批设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_stamp_app','800507','用印审批设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_stamp_appsave','用印审批设置','医院流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlyy_stamp_appsave','800508','用印审批设置');

--将权限默认给管理员组和海鼎公司用户组
--插入企业权限
delete ent_rt where rtid like 'prlyy_%';
insert into Ent_RT (EntGid, RTID) select v_EntGid, ID from rt  where id like 'prlyy_%';

--插入管理员权限
delete Org_RT where EntGid = v_EntGid and OrgGid = (select Gid from Org where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp')) and RTID like 'prlyy_%';
insert into Org_rt select v_EntGid, a.Gid, b.rtid, 10 from Org a, Ent_Rt b
where a.EntGid = v_EntGid AND b.EntGid = v_EntGid and lower(a.Code) = lower('Admin_Grp') and b.RTID like 'prlyy_%';

--插入组织所有权限表
delete Org_RT_All where EntGid = v_EntGid and OrgGid = (select Gid from Org where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp'))  and RTID like 'prlyy_%';
insert into Org_rt_All select v_EntGid, a.Gid, b.rtid, 10 from Org a, Ent_Rt b
where a.EntGid = v_EntGid AND b.EntGid = v_EntGid and lower(a.Code) = lower('Admin_Grp') and b.RTID like 'prlyy_%';

end;
/
commit;