---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');


--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');
insert into ent_rt select v_EntGid , id from rt where id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');

end;
/
commit;

---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeelist','行政费用汇总表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeelist','800434','行政费用汇总表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeelistdown','行政费用汇总表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeelistdown','800435','行政费用汇总表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeedtl','行政费用明细表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeedtl','800436','行政费用明细表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeedtldown','行政费用明细表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeedtldown','800437','行政费用明细表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeelist','总部行政费用汇总表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeelist','800447','总部行政费用汇总表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeelistdown','总部行政费用汇总表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeelistdown','800448','总部行政费用汇总表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeedtl','总部行政费用明细表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeedtl','800449','总部行政费用明细表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeedtldown','总部行政费用明细表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeedtldown','800450','总部行政费用明细表');


--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

end;
/
commit;