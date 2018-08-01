create or replace view v_prl_flow_all as
select f.entgid, f.flowgid, f.applyfee
  from v_prl_flow f
union
select f.entgid, f.flowgid, f.applyfee
  from v_prlzb_flow f;