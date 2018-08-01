---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('wfflowdown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('wfflowdown','流程实例管理','工作流程管理','30','/bin/hdnet.dll/__explainmodule?url=wfflowdown','210014','流程实例管理');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('wfflowdown');
insert into ent_rt select v_EntGid , id from rt where id in ('wfflowdown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('wfflowdown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('wfflowdown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('wfflowdown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('wfflowdown');

end;
/
commit;

-- 插入已有权限用户组的权限
delete Org_RT
 where EntGid = getEntGid
   and RTID in ('wfflowdown');
insert into Org_rt
  select getEntGid, o.OrgGid, r.id, o.ATYPE
    from Org_rt o, rt r
   where o.EntGid = getEntGid
     and o.RTID = 'wfflowlist'
     and r.id in ('wfflowdown');

delete Org_RT_All
 where EntGid = getEntGid
   and RTID in ('wfflowdown');

insert into Org_RT_All
  select getEntGid, o.OrgGid, r.id, o.ATYPE
    from Org_RT_All o, rt r
   where o.EntGid = getEntGid
     and o.RTID = 'wfflowlist'
     and r.id in ('wfflowdown');
commit;