---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_feeblack','费用供应商黑名单','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_feeblack','800452','费用供应商黑名单');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_feeblacksave','费用供应商黑名单','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_feeblacksave','800453','费用供应商黑名单');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_invoicelist','电子发票下载','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_invoicelist','800454','电子发票下载');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_invoicedown','电子发票下载','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_invoicedown','800455','电子发票下载');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

end;
/
commit;

drop table Prl_FeeBlack;			
create table Prl_FeeBlack (			
	EntGid 	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Name	varchar2(128)	null,
	Memo	varchar2(2000)	null,
	constraint PK_Prl_FeeBlack primary key(EntGid, Gid)		
	);		


create or replace view v_prl_Invoice as
select f.entgid,
       f.modelgid,
       '付款流程' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.companygid comgid,
       f.companyname comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prl_pay f, wf_prl_pay_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '已完成'
union all
select f.entgid,
       f.modelgid,
       '总部付款流程' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.companygid comgid,
       f.companyname comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prlzb_pay f, wf_prlzb_pay_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '已完成'
union all
select f.entgid,
       f.modelgid,
       '个人报销流程' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.comgid,
       f.comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prl_baoxiao f, wf_prl_baoxiao_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '已完成'
union all
select f.entgid,
       f.modelgid,
       '总部个人报销流程' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.comgid,
       f.comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prlzb_baoxiao f, wf_prlzb_baoxiao_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '已完成';