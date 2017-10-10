
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
    
    --删除已经审批的审批人
    delete from wf_prl_oisf_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_oisf_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
 
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
    
    --删除已经审批的审批人
    delete from wf_prl_oisf_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_oisf_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
  
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
    
    --删除已经审批的审批人
    delete from wf_prl_ISF_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_ISF_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
  
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
    
    --删除已经审批的审批人
    delete from wf_prl_ISF_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_ISF_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
  
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
    
    --删除已经审批的审批人
    delete from wf_prl_fee_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_fee_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
  
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
    
    --删除已经审批的审批人
    delete from wf_prl_pay_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_pay_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
  
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
    
    --删除已经审批的审批人
    delete from wf_prl_baoxiao_App a
     where a.entgid = R.Entgid
       and a.flowgid = R.Flowgid
       and a.appdate is null
       and exists (select 1
              from wf_prl_baoxiao_App t
             where t.entgid = a.entgid
               and t.flowgid = a.flowgid
               and t.apporder < 200
               and t.appdate is not null
               and t.apptype = a.apptype);
  
  end loop;
end;
/


delete from wf_prl_isf_app
 where dtlgid in
       (
       select a.gid
      , a.flowgid, b.code, a.apporder, a.AppName, b.execName
          from (select c.*
                  from (select FlowGid, min(apporder) apporder
                          from wf_prl_baoxiao_app
                         where appdate is null
                         group by flowgid) t,
                       wf_prl_baoxiao_app c
                 where t.flowgid = c.flowgid
                   and t.apporder = c.apporder
                   and c.appdate is null) a,
               (select FlowGid, t.code, t.execcode, t.execname
                  from wf_task t
                 where stat = 1
                   and lower(substr(code, instr(lower(code), '_t', 1) + 1)) not in
                       ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc')) b
         where a.flowgid = b.flowgid
           and a.appcode <> b.execcode
          order by a.flowgid , b.execname, a.appcode
           )
