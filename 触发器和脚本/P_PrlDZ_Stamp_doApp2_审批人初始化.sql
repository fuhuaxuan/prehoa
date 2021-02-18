create or replace procedure P_PrlDZ_Stamp_doApp2(p_EntGid    varchar2, --��ҵGid
                                                 p_ModelGid  varchar, --ģ��Gid
                                                 p_FlowGid   varchar, --����Gid
                                                 p_AppAssign varchar2, --���
                                                 p_AppMemo   varchar2 --���
                                                 ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrGid      varchar2(32); --�û�Gid
  v_ModelCode   varchar2(32); --ģ�ʹ���
  v_DeptGid     varchar2(32); --��ǰ�û�����
  v_PreDeptCode varchar2(32); --�������Ŵ���
  v_StampType   varchar2(128); --ӡ������
  v_ApplyType   varchar2(128); --ӡ������
  v_Count       int;
begin
  v_Stage := 'ȡ��������Ϣ';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ApplyType
    from wf_PrlDZ_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := 'ȡ��ģ����Ϣ';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign = '�ύ' then
    for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from Prl_Stamp s, WF_PrlDZ_Stamp f, WF_PrlDZ_Stamp_Dtl d
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and d.FlowGid = p_FlowGid
                 and s.ComGid = d.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by  s.appcode) loop
      select max(AppOrder)
        into v_Count
        from wf_PrlDZ_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_PrlDZ_Stamp_App
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
               98
          from dual;
    end loop;
  
    --ȡ�����������ظ���������
    delete from wf_PrlDZ_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);
    v_Stage := '����������';
    insert into WF_Task
      (EntGid,
       ModelGid,
       FlowGid,
       TaskDefGid,
       TaskGid,
       Stat,
       Code,
       Name,
       Memo,
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
             1,
             d.code,
             d.name,
             p_AppMemo,
             d.note,
             a.AppGid,
             a.AppCode,
             a.AppName,
             d.OrderValue,
             d.IsMCF
        from WF_Task_Define d,
             (select *
                from (select *
                        from wf_PrlDZ_Stamp_App t
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