create or replace view v_prlzb_baoxiao_fee_dtl as
select to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.comgid,
       t.comname,
       t.filldeptgid,
       t.filldeptname,
       t.fillusrname,
       t.payman,
       t.payposition position,
       d.feedate,
       d.applyfee applyfee,
       d.acgcode,
       '个人报销单' ModelName,
       t.memo memo
  from wf_prlzb_baoxiao t, wf_flow tf, wf_prlzb_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in
       ('1.04', '1.06', '4.01', '11.06', '1.01', '1.02', '1.03', '1.07')
union
select to_char(f.createdate, 'YYYY') feeY,
       to_char(f.createdate, 'MM') feeM,
       f.COMPANYGID comgid,
       f.companyname comname,
       f.fillusrdeptgid filldeptgid,
       f.FILLUSRDEPT filldeptname,
       f.fillusrname,
       f.fillusrname payman,
       hr.position,
       trunc(f.createdate) feedate,
       f.payfee applyfee,
       g.code acgcode,
       '付款单' ModelName,
       f.memo memo
  from wf_prlzb_pay f, wf_flow wf, prlzb_acg g, hr_emp hr
 where f.entgid = wf.entgid
   and f.flowgid = wf.flowgid
   and wf.stat < 4
   and f.entgid = hr.entgid
   and f.fillusrgid = hr.usrgid
   and f.stat not in ('终止', '否决')
   and g.entgid = f.entgid
   and g.gid = f.ACGTWOGID
   and g.code in
       ('1.04', '1.06', '4.01', '11.06', '1.01', '1.02', '1.03', '1.07');
