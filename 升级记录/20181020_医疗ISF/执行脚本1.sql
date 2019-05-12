---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_add','����λ������','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_add','800601','����λ������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_addsave','����λ������','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_addsave','800602','����λ����������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_mod','����λ���޸�','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_mod','800603','����λ���޸�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_modsave','����λ���޸�','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_modsave','800604','����λ���޸ı���');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_del','����λ��ɾ��','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_del','800605','����λ��ɾ��');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_list','����λ�ò鿴','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_list','800606','����λ���б�');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_dtl','����λ�ò鿴','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_dtl','800607','����λ����ϸ');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_down','����λ�õ���','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_down','800608','����λ�õ���');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_import','����λ�õ���','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_import','800609','����λ�õ���');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlyy_groundh_importsave','����λ�õ���','ҽ�Ƶ���λ��','30','/bin/hdnet.dll/__explainmodule?url=prlyy_groundh_importsave','800610','����λ�õ��뱣��');

--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlyy_groundh_add','prlyy_groundh_addsave','prlyy_groundh_mod','prlyy_groundh_modsave','prlyy_groundh_del','prlyy_groundh_list','prlyy_groundh_dtl','prlyy_groundh_down','prlyy_groundh_import','prlyy_groundh_importsave');

end;
/
commit;