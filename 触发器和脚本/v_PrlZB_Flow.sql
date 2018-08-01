create or replace view v_prlzb_flow as
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
       f.askfee || '' FMemo,
       f.askfee applyfee
  from wf_prlzb_fee f
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
       f.payfee || '' FMemo,
       f.payfee applyfee
  from wf_prlzb_pay f
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
       f.sumfee || '' FMemo,
       f.sumfee applyfee
  from wf_prlzb_baoxiao f;
