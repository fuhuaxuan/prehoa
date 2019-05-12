---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_grfeedtl','���˷�����ϸ��','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_grfeedtl','800440','������ϸ�б�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_grfeedtldown','���˷�����ϸ��','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_grfeedtldown','800441','������ϸ����');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_grfeedtl','���˷�����ϸ��','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_grfeedtl','800510','������ϸ�б�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_grfeedtldown','���˷�����ϸ��','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_grfeedtldown','800510','������ϸ����');

--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_grfeedtl','prl_grfeedtldown','prlzb_grfeedtl','prlzb_grfeedtldown');

--������֯����Ȩ�ޱ�
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
              '���÷�',
              '8.10',
              '���÷�',
              '8.11',
              '���÷�',
              '8.12',
              '���÷�',
              '8.02',
              '�д���',
              '7.05',
              '��������',
              '7.08',
              '��������') AcgType,
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
   and t.stat not in ('��ֹ', '���')
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
              '���÷�',
              '1.02',
              '���÷�',
              '1.03',
              '���÷�',
              '1.04',
              '���÷�',
              '1.05',
              '���÷�',
              '1.06',
              '�д���',
              '4.01',
              '�д���',
              '11.06',
              '��������',
              '15.01',
              '��������',
              '15.02',
              '��������') AcgType,
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
   and t.stat not in ('��ֹ', '���')
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
