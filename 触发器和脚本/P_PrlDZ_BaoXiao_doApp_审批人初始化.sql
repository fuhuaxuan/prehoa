create or replace procedure P_PrlDZ_Baoxiao_doApp(p_EntGid    varchar2, --��ҵGid
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

  v_AppFee number(20, 2);
  v_IsCM   varchar2(32);
begin
  commit;
  v_Stage := 'ȡ��������Ϣ';
  select nvl(SumFee, 0),
         f.FillUsrGid,
         f.filldeptgid,
         substr(f.filldeptcode, 0, 4),
         f.iscm
    into v_AppFee, v_UsrGid, v_DeptGid, v_PreDeptCode, v_IsCM
    from wf_Prl_Baoxiao f
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
    insert into wf_Prl_Baoxiao_App
      (EntGid,
       modelGid,
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
                     3          AppOrder,
                     3          AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 3
                 and rownum = 1
                 and exists
               (select 1
                        from wf_prl_baoxiao_dtl d
                       where d.entgid = v.EntGid
                         and d.flowgid = p_FlowGid
                         and d.acgcode in ('7.05', '8.02', '8.04'))
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     10         AppOrder,
                     10         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 10
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     30         AppOrder,
                     30         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 30
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     35         AppOrder,
                     35         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 35
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     40         AppOrder,
                     40         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 40
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     50         AppOrder,
                     50         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 71
                 and rownum = 1
                 and ((v_AppFee > 2000 and v_IsCM is null) or v_IsCM = '��')
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     60         AppOrder,
                     60         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 50
                 and rownum = 1
                 and ((v_AppFee > 2000 and v_IsCM is null) or v_IsCM = '��')
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_AppFee > 10000
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     90         AppOrder,
                     90         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 80
                 and rownum = 1
                 and v_AppFee > 10000
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_td1')
                 and rownum = 1
                 and v_AppFee > 50000
              union
              select o.AppGid,
                     o.AppCode,
                     o.AppName,
                     100       AppOrder,
                     100       AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_td2')
                 and rownum = 1
                 and v_AppFee > 50000) t;
  
    commit;
    --ȡ�����������ظ���������
    delete from wf_Prl_Baoxiao_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_Baoxiao_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder <= 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);
  end if;
  commit;
  --�쳣����
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('����Gid:' || p_FlowGid || ';�û�Gid:' || v_UsrGid ||
                          ';���:' || v_AppFee || ';' || v_Stage || ' ʧ��!' ||
                          SQLCode || ':' || SQLERRM,
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
