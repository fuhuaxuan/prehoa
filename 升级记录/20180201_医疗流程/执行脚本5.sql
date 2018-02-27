declare
  v_EntGid       varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');
--ɾ��ģ��Ȩ��
delete rt where id like 'prlyy_%';

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_company','��˾����','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_company','800501','��˾����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_companysave','��˾����','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_companysave','800502','��˾����');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_app','������������','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_app','800503','������������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_appsave','������������','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_appsave','800504','������������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_acg_post','��Ŀ��������','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_acg_post','800505','��Ŀ��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_acg_postsave','��Ŀ��������','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_acg_postsave','800506','��Ŀ��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_stamp_app','��ӡ��������','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_stamp_app','800507','��ӡ��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_stamp_appsave','��ӡ��������','ҽԺ���̹���','30','/bin/hdnet.dll/__explainmodule?url=prlyy_stamp_appsave','800508','��ӡ��������');

--��Ȩ��Ĭ�ϸ�����Ա��ͺ�����˾�û���
--������ҵȨ��
delete ent_rt where rtid like 'prlyy_%';
insert into Ent_RT (EntGid, RTID) select v_EntGid, ID from rt  where id like 'prlyy_%';

--�������ԱȨ��
delete Org_RT where EntGid = v_EntGid and OrgGid = (select Gid from Org where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp')) and RTID like 'prlyy_%';
insert into Org_rt select v_EntGid, a.Gid, b.rtid, 10 from Org a, Ent_Rt b
where a.EntGid = v_EntGid AND b.EntGid = v_EntGid and lower(a.Code) = lower('Admin_Grp') and b.RTID like 'prlyy_%';

--������֯����Ȩ�ޱ�
delete Org_RT_All where EntGid = v_EntGid and OrgGid = (select Gid from Org where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp'))  and RTID like 'prlyy_%';
insert into Org_rt_All select v_EntGid, a.Gid, b.rtid, 10 from Org a, Ent_Rt b
where a.EntGid = v_EntGid AND b.EntGid = v_EntGid and lower(a.Code) = lower('Admin_Grp') and b.RTID like 'prlyy_%';

end;
/
commit;