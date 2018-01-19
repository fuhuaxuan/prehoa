create or replace view v_prl_flow as
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid  FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept     filldeptname,
       f.Tradingname            FMemo
  from wf_prl_isf f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid  FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept     filldeptname,
       i.Tradingname            FMemo
  from wf_prl_istf f, wf_prl_isf i
 where f.entgid = i.entgid
   and f.oldflowgid = i.flowgid
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.filldeptgid,
       f.filldeptcode,
       f.filldeptname,
       f.Tradingname fMemo
  from wf_prl_oisf f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.filldeptgid,
       f.filldeptcode,
       f.filldeptname,
       i.Tradingname FMemo
  from wf_prl_oistf f, wf_prl_oisf i
 where f.entgid = i.entgid
   and f.oldflowgid = i.flowgid
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept filldeptname,
       f.askfee || '' FMemo
  from wf_prl_fee f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept filldeptname,
       f.payfee || '' FMemo
  from wf_prl_pay f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.filldeptgid,
       f.filldeptcode,
       f.filldeptname,
       f.sumfee || '' FMemo
  from wf_prl_baoxiao f;
