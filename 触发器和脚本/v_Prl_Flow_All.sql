create or replace view v_prl_flow_all as
select f.entgid,
       f.flowgid,
       f.num,
       f.applyfee,
       f.payman,
       f.paybank,
       f.payaccount
  from v_prl_flow f
union
select f.entgid,
       f.flowgid,
       f.num,
       f.applyfee,
       f.payman,
       f.paybank,
       f.payaccount
  from v_prlzb_flow f;
