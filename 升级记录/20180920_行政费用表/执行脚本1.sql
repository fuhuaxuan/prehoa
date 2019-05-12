---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');


--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');
insert into ent_rt select v_EntGid , id from rt where id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlxz_feelist','prlxz_feelistdown','prlxz_feedtl','prlxz_feedtldown','prlzb_feelist','prlzb_feelistdown');

end;
/
commit;

---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeelist','�������û��ܱ�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeelist','800434','�������û��ܱ�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeelistdown','�������û��ܱ�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeelistdown','800435','�������û��ܱ�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeedtl','����������ϸ��','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeedtl','800436','����������ϸ��');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_xzfeedtldown','����������ϸ��','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_xzfeedtldown','800437','����������ϸ��');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeelist','�ܲ��������û��ܱ�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeelist','800447','�ܲ��������û��ܱ�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeelistdown','�ܲ��������û��ܱ�','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeelistdown','800448','�ܲ��������û��ܱ�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeedtl','�ܲ�����������ϸ��','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeedtl','800449','�ܲ�����������ϸ��');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_xzfeedtldown','�ܲ�����������ϸ��','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prlzb_xzfeedtldown','800450','�ܲ�����������ϸ��');


--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_xzfeelist','prl_xzfeelistdown','prl_xzfeedtl','prl_xzfeedtldown','prlzb_xzfeelist','prlzb_xzfeelistdown','prlzb_xzfeedtl','prlzb_xzfeedtldown');

end;
/
commit;