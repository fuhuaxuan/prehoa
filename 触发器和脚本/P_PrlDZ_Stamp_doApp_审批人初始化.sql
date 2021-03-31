create or replace procedure P_PrlDZ_Stamp_doApp(p_EntGid    varchar2, --企业Gid
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
  v_ApplyType   varchar2(128); --印章类型
  v_AppOrder    int;
begin
  commit;
  v_AppOrder := 0;
  v_Stage    := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ApplyType
    from wf_PrlDZ_Stamp f
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
    v_AppOrder := v_AppOrder + 1;
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
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             20 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 10
         and rownum = 1;

    v_AppOrder := v_AppOrder + 1;
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
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             21 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 15
         and rownum = 1;

    v_AppOrder := v_AppOrder + 1;
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
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             23 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 23
         and rownum = 1
         and v_ApplyType = '标准类合同用印';
  
    for C in (select f.*
                from wf_PrlDZ_Stamp_Dtl f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
               order by ComName) loop
      v_AppOrder := v_AppOrder + 1;
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
               v.PostGid AppGid,
               v.PostCode AppCode,
               v.PostName AppName,
               v_AppOrder AppOrder,
               25 AppType
          from v_Post v
         where v.EntGid = p_EntGid
           and v.deptGid = C.ComGid
           and v.atype = 30
           and rownum = 1;
    end loop;
  
    v_AppOrder := v_AppOrder + 1;
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
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             30 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 35
         and rownum = 1;
  
    /*for C in (select f.*
                from wf_PrlDZ_Stamp_Dtl f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
               order by ComName) loop
    v_AppOrder := v_AppOrder + 1;
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
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             30 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = C.ComGid
         and v.atype = 35
         and rownum = 1;
    end loop;*/
  
    for C in (select f.*
                from wf_PrlDZ_Stamp_Dtl f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
               order by ComName) loop
      v_AppOrder := v_AppOrder + 1;
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
               v.PostGid AppGid,
               v.PostCode AppCode,
               v.PostName AppName,
               v_AppOrder AppOrder,
               35 AppType
          from v_Post v
         where v.EntGid = p_EntGid
           and v.deptGid = C.ComGid
           and v.atype = 40
           and rownum = 1;
    end loop;
  
    for C in (select f.*
                from wf_PrlDZ_Stamp_Dtl f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
               order by ComName) loop
      v_AppOrder := v_AppOrder + 1;
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
               v.PostGid AppGid,
               v.PostCode AppCode,
               v.PostName AppName,
               v_AppOrder AppOrder,
               37 AppType
          from v_Post v
         where v.EntGid = p_EntGid
           and v.deptGid = C.ComGid
           and v.atype = 80
           and rownum = 1;
    end loop;
  
    if v_ApplyType <> '标准类合同用印' or v_PreDeptCode in ('0001', '0023') then
      for R in (select a.AppGid, a.AppCode, a.AppName, a.Line, a.StampType
                  from Prl_Stamp_App a, wf_PrlDZ_Stamp_Dtl d
                 where a.EntGid = p_EntGid
                   and a.EntGid = d.EntGid
                   and d.FlowGid = p_FlowGid
                   and v_StampType like '%' || StampType || '%'
                   and a.ComGid = d.ComGid
                 order by d.ComName,
                          decode(a.StampType,
                                 '财务印章',
                                 50,
                                 '公司公章',
                                 60,
                                 '法定代表人名章',
                                 70,
                                 '公司股东章',
                                 80,
                                 '合同章',
                                 90),
                          a.Line) loop
        v_AppOrder := v_AppOrder + 1;
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
                 v_AppOrder,
                 decode(R.StampType,
                        '财务印章',
                        50,
                        '公司公章',
                        60,
                        '法定代表人名章',
                        70,
                        '公司股东章',
                        80,
                        '合同章',
                        90)
            from dual;
        commit;
      end loop;
    end if;
  
    /*for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from PrlDZ_Stamp s, WF_PrlDZ_Stamp f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and s.ComGid = f.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by s.appcode) loop
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
    
      commit;
    end loop;*/
  
    --取出审批人中重复的审批人
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
    v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
      insert into WF_Task
        (EntGid,
         ModelGid,
         FlowGid,
         TaskDefGid,
         TaskGid,
         Stat,
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
               1,
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
