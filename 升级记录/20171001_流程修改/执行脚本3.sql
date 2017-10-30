
--更新写字楼ISF,ISCF数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_oisf f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_oisf_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_oisf_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_oisf_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_oisf_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prl_oisf_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_oisf_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_oisf_app t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/


--更新写字楼ISTF数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_oistf f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_oisf_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_oisf_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_oisf_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_oisf_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prl_oistf_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_oisf_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_oisf_app t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/

--更新ISF,ISCF数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_ISF f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_ISF_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_ISF_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_ISF_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_ISF_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prlDZ_ISF_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_ISF_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_ISF_App t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/

--更新ISTF数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_ISTF f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_ISF_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_ISF_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_ISF_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_ISF_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prlDZ_IStF_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_ISF_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_ISF_App t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/

--更新费用数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_fee f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_fee_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_fee_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_fee_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_fee_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prlDZ_fee_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_fee_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_fee_App t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/

--更新付款数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_pay f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_pay_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_pay_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_pay_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_pay_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prlDZ_pay_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_pay_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_pay_App t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/

--更新个人报销数据
BEGIN
  --for 循环 
  for R in (select f.entgid, f.flowgid, wf.modelgid
              from wf_prl_baoxiao f, wf_flow wf
             where f.entgid = getentgid
               and f.entgid = wf.entgid
               and f.flowgid = wf.flowgid
               and f.stat in ('提交', '同意')
               and wf.stat < 3
               and exists
             (select 1
                      from wf_task t
                     where t.entgid = f.entgid
                       and t.flowgid = f.flowgid
                       and t.stat = 1
                       and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                           ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc'))
             order by f.createdate) loop
    --如果否决过，+ 200
    update wf_prl_baoxiao_App a
       set AppOrder = AppOrder + 200
     where a.EntGid = R.Entgid
       and a.FlowGid = R.Flowgid
       and a.appdate <= (select max(t.appdate)
                           from wf_prl_baoxiao_App t
                          where t.entgid = a.entgid
                            and t.flowgid = a.flowgid
                            and t.appassign = '否决')
       and exists (select 1
              from wf_prl_baoxiao_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.appassign = '否决');
    delete from wf_prl_baoxiao_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null;
    --所有正在审批的流程，插入审批人
    P_prlDZ_baoxiao_doApp(R.Entgid, R.Modelgid, R.Flowgid, '提交');
  
    --删除已经审批的审批人
    delete from wf_prl_baoxiao_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and a.AppOrder <= (select max(AppOrder)
                            from wf_prl_baoxiao_App t
                           where t.entgid = R.Entgid
                             and t.flowgid = R.flowgid
                             and t.apporder < 200
                             and t.appdate is not null);
  
    --所有正在审批的流程，改成T2审批
    update wf_task t
       set (t.taskdefgid, t.code, t.name) =
           (select d.taskdefgid, d.code, d.name
              from wf_task_define d
             where d.entgid = R.ENTGID
               and d.modelgid = R.Modelgid
               and lower(d.code) like '%_t2')
     where t.entgid = R.ENTGID
       and t.flowgid = R.Flowgid
       and t.stat = 1;
  end loop;
end;
/
