---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_feedtl','总部费用明细列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_feedtl','800441','费用明细列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_feedtldown','总部费用明细列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_feedtldown','800442','费用明细下载');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_baoxiaolist','总部个人报销列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_baoxiaolist','800443','个人报销列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_baoxiaolistdown','总部个人报销列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_baoxiaolistdown','800444','个人报销下载');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_paylist','总部付款查看列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_paylist','800445','付款查看列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_paydown','总部付款查看列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_paydown','800446','付款查看列表');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');
insert into ent_rt select v_EntGid , id from rt where id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

end;
/
commit;