create or replace procedure P_Prl_OISF_doApp(p_EntGid    varchar2, --企业Gid
                                             p_ModelGid  varchar, --模型Gid
                                             p_FlowGid   varchar, --流程Gid
                                             p_AppAssign varchar2 --意见
                                             ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee number(20, 2);
  v_Step   int;
begin
  commit;
  v_Stage := '取出流程信息';
  select f.FillUsrGid, f.filldeptgid, substr(f.filldeptcode, 0, 4), f.sStep
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_Step
    from wf_Prl_OISF f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_OISF_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
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
                 and v_Step > 40
              union
              select o.AppGid, o.AppCode, o.AppName, 60 AppOrder, 60 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tb2')
                 and rownum = 1
                 and v_Step > 40
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_Step > 60
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
                 and v_Step > 80
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc3')
                 and rownum = 1
                 and v_Step > 80
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
                     ('_td')
                 and rownum = 1
                 and v_Step > 90) t;
  
    commit;
    --取出审批人中重复的审批人
    delete from wf_Prl_OISF_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_OISF_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder <= 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_OIsf_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_Prl_OISTF_doApp(p_EntGid    varchar2, --企业Gid
                                              p_ModelGid  varchar, --模型Gid
                                              p_FlowGid   varchar, --流程Gid
                                              p_AppAssign varchar2 --意见
                                              ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee number(20, 2);
begin
  commit;
  v_Stage := '取出流程信息';
  select nvl(numa, 0) + nvl(numb, 0) + nvl(numc, 0) + nvl(numd, 0) +
         nvl(numg, 0),
         f.FillUsrGid,
         f.filldeptgid,
         substr(f.filldeptcode, 0, 4)
    into v_AppFee, v_UsrGid, v_DeptGid, v_PreDeptCode
    from wf_Prl_OISTF f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_OISF_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
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
              union
              select o.AppGid, o.AppCode, o.AppName, 60 AppOrder, 60 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tb2')
                 and rownum = 1
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_AppFee > 80000
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
                 and v_AppFee > 80000
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc3')
                 and rownum = 1
                 and v_AppFee > 80000
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
                     ('_td')
                 and rownum = 1
                 and v_AppFee > 300000) t;
  
    commit;
    --取出审批人中重复的审批人
    delete from wf_Prl_OISF_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_OISF_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder <= 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_oISF_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_Prl_Stamp_doApp(p_EntGid    varchar2, --企业Gid
                                              p_ModelGid  varchar, --模型Gid
                                              p_FlowGid   varchar, --流程Gid
                                              p_AppAssign varchar2 --意见
                                              ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码
  v_StampType   varchar2(128); --印章类型
  v_ComGid      varchar2(32); --项目ID
  v_Count       int;
begin
  commit;
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.Comgid
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ComGid
    from wf_prl_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_Stamp_App
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
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     2          AppOrder,
                     30         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 35
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     3          AppOrder,
                     35         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 40
                 and rownum = 1) t;
  
    for R in (select AppGid, AppCode, AppName, Line, StampType
                from Prl_Stamp_App
               where EntGid = p_EntGid
                 and v_StampType like '%' || StampType || '%'
                 and ComGid = v_ComGid
               order by decode(StampType,
                               '财务印章',
                               50,
                               '公司公章',
                               60,
                               '法定代表人名章',
                               70,
                               '公司股东章',
                               80,
                               '合同用章',
                               90),
                        Line) loop
      select count(*)
        into v_Count
        from wf_Prl_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_Prl_Stamp_App
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
                      '财务印章',
                      50,
                      '公司公章',
                      60,
                      '法定代表人名章',
                      70,
                      '公司股东章',
                      80,
                      '合同用章',
                      90)
          from dual;
      commit;
    end loop;
    --取出审批人中重复的审批人
    delete from wf_Prl_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_Stamp_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_Baoxiao_doApp(p_EntGid    varchar2, --企业Gid
                                                  p_ModelGid  varchar, --模型Gid
                                                  p_FlowGid   varchar, --流程Gid
                                                  p_AppAssign varchar2 --意见
                                                  ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee number(20, 2);
  v_IsCM   varchar2(32);
begin
  commit;
  v_Stage := '取出流程信息';
  select nvl(SumFee, 0),
         f.FillUsrGid,
         f.filldeptgid,
         substr(f.filldeptcode, 0, 4),
         f.iscm
    into v_AppFee, v_UsrGid, v_DeptGid, v_PreDeptCode, v_IsCM
    from wf_Prl_Baoxiao f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
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
                 and ((v_AppFee > 2000 and v_IsCM is null) or v_IsCM = '是')
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
                 and ((v_AppFee > 2000 and v_IsCM is null) or v_IsCM = '是')
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
    --取出审批人中重复的审批人
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
  
    v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_Baoxiao_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_Fee_doApp(p_EntGid    varchar2, --企业Gid
                                              p_ModelGid  varchar, --模型Gid
                                              p_FlowGid   varchar, --流程Gid
                                              p_AppAssign varchar2 --意见
                                              ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee    number(20, 2);
  v_AFee      number(20, 2);
  v_BFee      number(20, 2);
  v_CFee      number(20, 2);
  v_DFee      number(20, 2);
  v_EFee      number(20, 2);
begin
  commit;
  v_Stage := '取出流程信息';
  select nvl(askfee, 0) + nvl(naskfee, 0),
         f.FillUsrGid,
         f.FillUsrDeptGid,
         substr(f.FillUsrDeptCode, 0, 4),
         nvl(aVALUE, 0),
         nvl(bVALUE, 0),
         nvl(cVALUE, 0),
         nvl(dVALUE, 0),
         nvl(eVALUE, 0)
    into v_AppFee,
         v_UsrGid,
         v_DeptGid,
         v_PreDeptCode,
         v_AFee,
         v_BFee,
         v_CFee,
         v_DFee,
         v_EFee
    from wf_Prl_Fee f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_Fee_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
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
                 and v_AppFee > v_bFee
                 and (v_bFee + v_cFee + v_dFee + v_eFee) > 0
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
                 and v_AppFee > v_bFee
                 and (v_bFee + v_cFee + v_dFee + v_eFee) > 0
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_AppFee > v_cFee
                 and (v_cFee + v_dFee + v_eFee) > 0
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
                 and v_AppFee > v_cFee
                 and (v_cFee + v_dFee + v_eFee) > 0
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_td1')
                 and rownum = 1
                 and v_AppFee > v_dFee
                 and (v_dFee + v_eFee) > 0
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
                 and v_AppFee > v_dFee
                 and (v_dFee + v_eFee) > 0) t;

    commit;
    --取出审批人中重复的审批人
    delete from wf_Prl_Fee_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_Fee_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder <= 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_Fee_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_ISF_doApp(p_EntGid    varchar2, --企业Gid
                                              p_ModelGid  varchar, --模型Gid
                                              p_FlowGid   varchar, --流程Gid
                                              p_AppAssign varchar2 --意见
                                              ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee   number(20, 2);
  v_DeptName varchar2(64);
  v_Step     int;
begin
  commit;
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.fillusrdeptgid,
         substr(f.fillusrdeptcode, 0, 4),
         f.fillusrdept,
         f.sStep
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_DeptName, v_Step
    from wf_Prl_ISF f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_ISF_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
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
                 and v_Step > 40
              union
              select o.AppGid, o.AppCode, o.AppName, 60 AppOrder, 60 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tb2')
                 and rownum = 1
                 and v_Step > 40
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_Step > 60
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
                 and v_Step > 80
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_td1')
                 and rownum = 1
                 and v_Step > 90
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
                 and v_Step > 90
                 and instr(v_DeptName, '-1', 1) = 0) t;
  
    commit;
    --取出审批人中重复的审批人
    delete from wf_Prl_ISF_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_ISF_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder <= 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_ISF_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_ISTF_doApp(p_EntGid    varchar2, --企业Gid
                                               p_ModelGid  varchar, --模型Gid
                                               p_FlowGid   varchar, --流程Gid
                                               p_AppAssign varchar2 --意见
                                               ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee number(20, 2);
begin
  commit;
  v_Stage := '取出流程信息';
  select nvl(numa, 0) + nvl(numb, 0) + nvl(numc, 0) + nvl(numd, 0) +
         nvl(numg, 0),
         f.FillUsrGid,
         f.fillusrdeptgid,
         substr(f.fillusrdeptcode, 0, 4)
    into v_AppFee, v_UsrGid, v_DeptGid, v_PreDeptCode
    from wf_Prl_ISTF f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_ISF_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
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
              union
              select o.AppGid, o.AppCode, o.AppName, 60 AppOrder, 60 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tb2')
                 and rownum = 1
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_AppFee > 80000
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
                 and v_AppFee > 80000
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_td1')
                 and rownum = 1
                 and v_AppFee > 300000
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
                 and v_AppFee > 300000) t;

    commit;
    --取出审批人中重复的审批人
    delete from wf_Prl_ISF_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_ISF_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder <= 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_ISF_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_Pay_doApp(p_EntGid    varchar2, --企业Gid
                                              p_ModelGid  varchar, --模型Gid
                                              p_FlowGid   varchar, --流程Gid
                                              p_AppAssign varchar2 --意见
                                              ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码

  v_AppFee    number(20, 2);
  v_AFee      number(20, 2);
  v_BFee      number(20, 2);
  v_CFee      number(20, 2);
  v_DFee      number(20, 2);
  v_EFee      number(20, 2);
  v_Count     int;
  v_AcgTwoGid varchar2(32);
begin
  commit;
  v_Stage := '取出流程信息';
  select nvl(payfee, 0),
         f.FillUsrGid,
         f.FillUsrDeptGid,
         substr(f.FillUsrDeptCode, 0, 4),
         nvl(aVALUE, 0),
         nvl(bVALUE, 0),
         nvl(cVALUE, 0),
         nvl(dVALUE, 0),
         nvl(eVALUE, 0),
         f.AcgTwoGid
    into v_AppFee,
         v_UsrGid,
         v_DeptGid,
         v_PreDeptCode,
         v_AFee,
         v_BFee,
         v_CFee,
         v_DFee,
         v_EFee,
         v_AcgTwoGid
    from wf_Prl_Pay f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出项目信息';
  select count(*)
    into v_Count
    from v_acg a
   where a.entgid = p_EntGid
     and a.gid = v_AcgTwoGid
     and a.code in ('1.01', '1.02', '1.03', '2.01', '2.02', '2.03');

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    insert into wf_Prl_Pay_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
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
                     45         AppOrder,
                     45         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 20
                 and rownum = 1
                 and v_AppFee > v_bFee
                 and (v_bFee + v_cFee + v_dFee + v_eFee) > 0
                 and v_Count > 0
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
                 and v_AppFee > v_bFee
                 and (v_bFee + v_cFee + v_dFee + v_eFee) > 0
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
                 and v_AppFee > v_bFee
                 and (v_bFee + v_cFee + v_dFee + v_eFee) > 0
              union
              select o.AppGid, o.AppCode, o.AppName, 80 AppOrder, 80 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_tc1')
                 and rownum = 1
                 and v_AppFee > v_cFee
                 and (v_cFee + v_dFee + v_eFee) > 0
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
                 and v_AppFee > v_cFee
                 and (v_cFee + v_dFee + v_eFee) > 0
              union
              select o.AppGid, o.AppCode, o.AppName, 95 AppOrder, 95 AppType
                from v_wf_model_usr_app o
               where o.EntGid = p_EntGid
                 and o.ModelGid = p_ModelGid
                 and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
                     ('_td1')
                 and rownum = 1
                 and v_AppFee > v_dFee
                 and (v_dFee + v_eFee) > 0
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
                 and v_AppFee > v_dFee
                 and (v_dFee + v_eFee) > 0) t;

    commit;
    --取出审批人中重复的审批人
    delete from wf_Prl_Pay_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_Pay_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < = 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
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
                          from wf_Prl_PAy_App t
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
                   and t.ExecGid = a.AppGid);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid ||
                          ';金额:' || v_AppFee || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
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
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = p_EntGid;
      commit;
    end;
end;
/