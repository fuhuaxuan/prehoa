update wf_prl_stamp set applytype = '标准类合同用印' where applytype = '合同签署用印';

update wf_prlzb_stamp set applytype = '标准类合同用印' where applytype = '合同签署用印';


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
  v_ComGid      varchar2(32); --项目Gid
  v_StampType   varchar2(128); --印章类型
  v_ApplyType   varchar2(128); --印章类型
  v_Count       int;
begin
  commit;
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType,
         f.Comgid
    into v_UsrGid,
         v_DeptGid,
         v_PreDeptCode,
         v_StampType,
         v_ApplyType,
         v_ComGid
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
                     23         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 23
                 and rownum = 1
                 and v_ApplyType = '标准类合同用印'
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     3          AppOrder,
                     25         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_ComGid
                 and v.atype = 30
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     4          AppOrder,
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
                     5          AppOrder,
                     35         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 40
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     6          AppOrder,
                     37         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 80
                 and rownum = 1) t;
    if v_ApplyType <> '标准类合同用印' then
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
                                 '合同章',
                                 90),
                          Line) loop
        select max(AppOrder)
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
                        '合同章',
                        90)
            from dual;
        commit;
      end loop;
    end if;
  
    for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from Prl_Stamp s, WF_Prl_Stamp f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and s.ComGid = f.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by s.appcode) loop
      select max(AppOrder)
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
               98
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

create or replace procedure P_PrlZB_Stamp_doApp(p_EntGid    varchar2, --企业Gid
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
  v_ComGid      varchar2(32); --项目ID
  v_Count       int;
begin
  commit;
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType,
         f.Comgid
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ApplyType, v_ComGid
    from wf_PrlZB_Stamp f
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
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     2          AppOrder,
                     25         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 30
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
                 and rownum = 1
              union
              select v.PostGid  AppGid,
                     v.PostCode AppCode,
                     v.PostName AppName,
                     4          AppOrder,
                     37         AppType
                from v_Post v
               where v.EntGid = p_EntGid
                 and v.deptGid = v_DeptGid
                 and v.atype = 80
                 and rownum = 1) t;
  
    if v_ApplyType <> '标准类合同用印' then
      for R in (select AppGid, AppCode, AppName, Line, StampType
                  from PrlZB_Stamp_App
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
                                 '合同章',
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

    for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from PrlZB_Stamp s, WF_PrlZB_Stamp f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and s.ComGid = f.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by s.appcode) loop
      select max(AppOrder)
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
               98
          from dual;
    
      commit;
    end loop;

    --取出审批人中重复的审批人
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


---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prl_stamp_list','prl_stamp_down');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_stamp_list','流程应用','工作流程应用','30','/bin/hdnet.dll/__explainmodule?url=prl_stamp_list','210030','地理位置列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_stamp_down','流程应用','工作流程应用','30','/bin/hdnet.dll/__explainmodule?url=prl_stamp_down','210031','地理位置导出');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_stamp_list','prl_stamp_down');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_stamp_list','prl_stamp_down');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prl_stamp_list','prl_stamp_down');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_stamp_list','prl_stamp_down');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_stamp_list','prl_stamp_down');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_stamp_list','prl_stamp_down');

end;
/
commit;

-- 插入已有权限用户组的权限
delete Org_RT
 where EntGid = getEntGid
   and RTID in ('prl_stamp_list','prl_stamp_down');
insert into Org_rt
  select getEntGid, o.OrgGid, r.id, o.ATYPE
    from Org_rt o, rt r
   where o.EntGid = getEntGid
     and o.RTID = 'wfalltasklist'
     and r.id in ('prl_stamp_list','prl_stamp_down');

delete Org_RT_All
 where EntGid = getEntGid
   and RTID in ('prl_stamp_list','prl_stamp_down');

insert into Org_RT_All
  select getEntGid, o.OrgGid, r.id, o.ATYPE
    from Org_RT_All o, rt r
   where o.EntGid = getEntGid
     and o.RTID = 'wfalltasklist'
     and r.id in ('prl_stamp_list','prl_stamp_down');
commit;