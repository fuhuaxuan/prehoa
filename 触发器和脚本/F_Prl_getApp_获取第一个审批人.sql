
create or replace function F_Prl_getApp(p_EntGid   varchar2, --企业Gid
                                        p_ModelGid varchar2, --模型Gid
                                        p_UsrGid   varchar2, --用户Gid
                                        p_isXZ     varchar2 --是否行政
                                        ) return varchar2 is
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_ModelCode varchar2(32); --模型代码
  v_DeptGid   varchar2(32); --当前用户部门

  v_AppGid varchar2(32); --变量（记录每天小时）
begin
  v_Stage := '取出用户部门信息';

  select d.Gid
    into v_DeptGid
    from hr_emp hr, dept d
   where hr.EntGid = p_EntGid
     and hr.EntGid = d.EntGid
     and hr.DeptGid = d.gid
     and hr.UsrGid = p_UsrGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  select AppGid
    into v_AppGid
    from (select *
            from (select max(t.AppType) AppType, t.AppGid
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
                             and p_isXZ = '是'
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
                             and lower(v_ModelCode) not in
                                 ('prl_oisf', 'prl_oiscf', 'prl_oistf')
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
                             and rownum = 1) t
                   group by t.AppGid) a
           order by a.AppType)
   where rownum = 1;

  --返回计算结果
  return v_AppGid;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('模型Gid:' || p_ModelGid || ';用户Gid:' || p_UsrGid || ';' ||
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
