---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_company','��˾����','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_company','800501','��˾����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_companysave','��˾����','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_companysave','800502','��˾����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_app','������������','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_app','800503','��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_appsave','������������','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_appsave','800504','��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_acg_post','��Ŀ��������','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_acg_post','800505','��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_acg_postsave','��Ŀ��������','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_acg_postsave','800506','��������');

--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_company','prlzb_companysave','prlzb_app','prlzb_appsave','prlzb_acg_post','prlzb_acg_postsave');

end;
/
commit;