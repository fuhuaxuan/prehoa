---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prlzb_stamp_app','prlzb_stamp_appsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_stamp_app','��ӡ��������','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_stamp_app','800507','��ӡ��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlzb_stamp_appsave','��ӡ��������','�ܲ����̹���','30','/bin/hdnet.dll/__explainmodule?url=prlzb_stamp_appsave','800508','��ӡ��������');


--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prlzb_stamp_app','prlzb_stamp_appsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prlzb_stamp_app','prlzb_stamp_appsave');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prlzb_stamp_app','prlzb_stamp_appsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_stamp_app','prlzb_stamp_appsave');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlzb_stamp_app','prlzb_stamp_appsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlzb_stamp_app','prlzb_stamp_appsave');

end;
/
commit;

drop table PrlZB_Stamp_App;			
create table PrlZB_Stamp_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	Line	int	null,
	StampType	varchar2(32)	null,
	ComGid	varchar2(32)	null,
	ComCode	varchar2(64)	null,
	ComName	varchar2(64)	null,
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_PrlZB_Stamp_App primary key(EntGid, Gid)		
	);		


create or replace procedure P_PrlZB_Stamp_doApp(p_EntGid    varchar2, --��ҵGid
                                              p_ModelGid  varchar, --ģ��Gid
                                              p_FlowGid   varchar, --����Gid
                                              p_AppAssign varchar2 --���
                                              ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrGid      varchar2(32); --�û�Gid
  v_ModelCode   varchar2(32); --ģ�ʹ���
  v_DeptGid     varchar2(32); --��ǰ�û�����
  v_PreDeptCode varchar2(32); --�������Ŵ���
  v_StampType   varchar2(128); --ӡ������
  v_ComGid      varchar2(32); --��ĿID
  v_Count       int;
begin
  commit;
  v_Stage := 'ȡ��������Ϣ';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.Comgid
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ComGid
    from wf_PrlZB_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := 'ȡ��ģ����Ϣ';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '��ֹ' then
    --����������
    insert into wf_PrlZB_Stamp_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             t.AppGid,
             t.AppCode,
             t.AppName,
             t.AppOrder,
             t.AppType
        from (select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     1          AppOrder,
                     20         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 10
                 and rownum = 1) t;
  
    for R in (select AppGid, AppCode, AppName, Line, StampType
                from PrlZB_Stamp_App
               where EntGid = p_EntGid
                 and v_StampType like '%' || StampType || '%'
                 and ComGid = v_ComGid
               order by decode(StampType,
                               '����ӡ��',
                               50,
                               '��˾����',
                               60,
                               '��������������',
                               70,
                               '��˾�ɶ���',
                               80,
                               '��ͬ����',
                               90),
                        Line) loop
      select count(*)
        into v_Count
        from wf_PrlZB_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_PrlZB_Stamp_App
        (EntGid,
         ModelGid,
         FlowGid,
         Gid,
         AppGid,
         AppCode,
         AppName,
         AppOrder,
         AppType)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               sys_guid(),
               R.AppGid,
               R.AppCode,
               R.AppName,
               v_Count + 1,
               decode(R.StampType,
                      '����ӡ��',
                      50,
                      '��˾����',
                      60,
                      '��������������',
                      70,
                      '��˾�ɶ���',
                      80,
                      '��ͬ����',
                      90)
          from dual;
      commit;
    end loop;
    --ȡ�����������ظ���������
    delete from wf_PrlZB_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlZB_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);v_Stage := '����������';
    if p_AppAssign = '�ύ' then
      insert into WF_Task
        (EntGid,
         ModelGid,
         FlowGid,
         TaskDefGid,
         TaskGid,
         Code,
         Name,
         Note,
         ExecGid,
         ExecCode,
         ExecName,
         OrderValue,
         IsMCF)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               d.TaskDefGid,
               sys_guid(),
               d.code,
               d.name,
               d.note,
               a.AppGid,
               a.AppCode,
               a.AppName,
               d.OrderValue,
               d.IsMCF
          from WF_Task_Define d,
               (select *
                  from (select *
                          from wf_PrlZB_Stamp_App t
                         where t.entgid = p_EntGid
                           and t.flowgid = p_FlowGid
                           and t.AppOrder <= 100
                           and t.AppDate is null
                         order by t.Apporder)
                 where rownum = 1) a
         where d.EntGid = p_EntGid
           and d.ModelGid = p_ModelGid
           and replace(lower(d.code), lower(v_ModelCode), '') in ('_t2')
           and not exists (select 1
                  from wf_task t
                 where t.entgid = p_EntGid
                   and t.flowgid = p_FlowGid
                   and t.TaskDefGid = d.taskdefgid
                   and t.ExecGid = a.AppGid
                   and t.stat = 1);
    end if;
  end if;
  commit;
  --�쳣����
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('����Gid:' || p_FlowGid || ';�û�Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' ʧ��!' || SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --������־
      insert into Log
        (EntGid,
         EntCode,
         EntName,
         UsrGid,
         UsrCode,
         UsrName,
         CreateDate,
         Atype,
         AContent)
        select e.gid,
               e.code,
               e.name,
               'sys',
               'sys',
               'ϵͳ�Զ�',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
