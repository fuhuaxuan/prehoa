create or replace view v_prl_oisf_floor as
select t.fno,
       t.floorno,
       g.farea,
       t.farea tarea,
       v.ISFNum,
       v.ISFFlowType,
       v.ISFlessee
  from wf_prl_oisf_ground g, prl_groundh t, v_Prl_OISF_Done v
 where g.entgid = v.entgid
   and g.flowgid = v.ISFFlowGid
   and lower(g.fno) = lower(t.fno)
   and v.ISFDepeCode = t.deptsource
   and v.ISCFFlowGid is null
   and v.ISTFFlowGid is null
   and v.ISFStat not in ('40')
   and v.ISFFlowType in ('ISF', 'ISCF')
   and t.fstat not in ('Õ£”√')
   and v.ISFCONTRACTDATE1 <= sysdate
   and v.ISFCONTRACTDATE2 >= sysdate;


create or replace view v_prl_oisf_floor as
select t.fno,
       t.floorno,
       g.farea,
       t.farea tarea,
       v.ISFNum,
       v.ISFFlowType,
       v.ISFlessee
  from wf_prl_oisf_ground g, prl_groundh t, v_Prl_OISF v
 where g.entgid = v.entgid
   and g.flowgid = v.ISFFlowGid
   and lower(g.fno) = lower(t.fno)
   and v.ISFDepeCode = t.deptsource
   and v.ISCFFlowGid is null
   and v.ISTFFlowGid is null
   and v.ISFStat not in ('40')
   and v.ISFFlowType in ('ISF', 'ISCF')
   and t.fstat not in ('Õ£”√')
   and v.ISFCONTRACTDATE1 <= add_months(trunc(sysdate,'YYYY'),12)-1
   and v.ISFCONTRACTDATE2 >= trunc(sysdate,'YYYY');
