---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_feedtl','�ܲ�������ϸ�б�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_feedtl','800441','������ϸ�б�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_feedtldown','�ܲ�������ϸ�б�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_feedtldown','800442','������ϸ����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_baoxiaolist','�ܲ����˱����б�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_baoxiaolist','800443','���˱����б�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_baoxiaolistdown','�ܲ����˱����б�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_baoxiaolistdown','800444','���˱�������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_paylist','�ܲ�����鿴�б�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_paylist','800445','����鿴�б�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_paydown','�ܲ�����鿴�б�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_paydown','800446','����鿴�б�');

--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');
insert into ent_rt select v_EntGid , id from rt where id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_feedtl','prlzb_feedtldown','prlzb_baoxiaolist','prlzb_baoxiaolistdown','prlzb_paylist','prlzb_paydown');

end;
/
commit;