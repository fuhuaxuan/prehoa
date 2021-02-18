---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_feeblack','���ù�Ӧ�̺�����','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_feeblack','800452','���ù�Ӧ�̺�����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_feeblacksave','���ù�Ӧ�̺�����','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_feeblacksave','800453','���ù�Ӧ�̺�����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_invoicelist','���ӷ�Ʊ����','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_invoicelist','800454','���ӷ�Ʊ����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_invoicedown','���ӷ�Ʊ����','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_invoicedown','800455','���ӷ�Ʊ����');

--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_feeblack','prl_feeblacksave','prl_invoicelist','prl_invoicedown');

--������֯����Ȩ�ޱ�
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
       '��������' ModelName,
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
   and f.stat = '�����'
union all
select f.entgid,
       f.modelgid,
       '�ܲ���������' ModelName,
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
   and f.stat = '�����'
union all
select f.entgid,
       f.modelgid,
       '���˱�������' ModelName,
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
   and f.stat = '�����'
union all
select f.entgid,
       f.modelgid,
       '�ܲ����˱�������' ModelName,
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
   and f.stat = '�����';