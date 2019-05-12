---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_grfeedtl','个人费用明细表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_grfeedtl','800440','费用明细列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_grfeedtldown','个人费用明细表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_grfeedtldown','800441','费用明细下载');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_grfeedtl','个人费用明细表','总部流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_grfeedtl','800510','费用明细列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_grfeedtldown','个人费用明细表','总部流程管理','30','/bin/hdnet.dll/__explainmodule?url=prlzb_grfeedtldown','800510','费用明细下载');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

end;
/
commit;

create or replace view v_prl_baoxiao_GR_fee_Dtl as
select t.comgid,
       t.comname,
       to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.APPLYusrgid,
       t.APPLYusrcode,
       t.APPLYusrname,
       decode(d.acgcode,
              '8.09',
              '差旅费',
              '8.10',
              '差旅费',
              '8.11',
              '差旅费',
              '8.12',
              '差旅费',
              '8.02',
              '招待费',
              '7.05',
              '其他费用',
              '7.08',
              '其他费用') AcgType,
decode(d.acgcode,
                 '8.09',
                 1,
                 '8.10',
                 1,
                 '8.11',
                 1,
                 '8.12',
                 1,
                 '8.02',
                 2,
                 '7.05',
                 3,
                 '7.08',
                 3) AcgOrder,
       d.feedate,
       d.applyfee,
       d.acgcode,
       d.Acgname,
       d.memo
  from wf_prl_baoxiao t, wf_flow tf, wf_prl_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in
       ('8.09', '8.10', '8.11', '8.12', '8.02', '7.05', '7.08');

create or replace view v_prlzb_baoxiao_GR_fee_Dtl as
select t.comgid,
       t.comname,
       to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.APPLYusrgid,
       t.APPLYusrcode,
       t.APPLYusrname,
       decode(d.acgcode,
              '1.01',
              '差旅费',
              '1.02',
              '差旅费',
              '1.03',
              '差旅费',
              '1.04',
              '差旅费',
              '1.05',
              '差旅费',
              '1.06',
              '招待费',
              '4.01',
              '招待费',
              '11.06',
              '其他费用',
              '15.01',
              '其他费用',
              '15.02',
              '其他费用') AcgType,
       decode(d.acgcode,
              '1.01',
              1,
              '1.02',
              1,
              '1.03',
              1,
              '1.04',
              1,
              '1.05',
              1,
              '1.06',
              2,
              '4.01',
              2,
              '11.06',
              3,
              '15.01',
              3,
              '15.02',
              3) AcgOrder,
       d.feedate,
       d.applyfee,
       d.acgcode,
       d.Acgname,
       d.memo
  from wf_prlzb_baoxiao t, wf_flow tf, wf_prlzb_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in ('1.01',
                     '1.02',
                     '1.03',
                     '1.04',
                     '1.05',
                     '1.06',
                     '4.01',
                     '11.06',
                     '15.01',
                     '15.02');
