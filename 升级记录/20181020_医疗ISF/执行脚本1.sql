---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_add','地理位置新增','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_add','800601','地理位置新增');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_addsave','地理位置新增','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_addsave','800602','地理位置新增保存');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_mod','地理位置修改','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_mod','800603','地理位置修改');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_modsave','地理位置修改','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_modsave','800604','地理位置修改保存');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_del','地理位置删除','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_del','800605','地理位置删除');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_list','地理位置查看','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_list','800606','地理位置列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_dtl','地理位置查看','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_dtl','800607','地理位置明细');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_down','地理位置导出','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_down','800608','地理位置导出');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_import','地理位置导入','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_import','800609','地理位置导入');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_importsave','地理位置导入','医疗地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_importsave','800610','地理位置导入保存');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

end;
/
commit;