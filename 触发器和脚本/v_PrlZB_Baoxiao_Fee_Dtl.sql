create or replace view v_prlzb_baoxiao_fee_dtl as
select to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.comgid,
       t.comname,
       dp.Gid filldeptgid,
       dp.Name filldeptname,
       t.fillusrname,
       t.payman,
       hr.position position,
       d.gid,
       d.feedate,
       d.feeedate,
       d.applyfee applyfee,
       d.acgcode,
       '个人报销单' ModelName,
       d.memo memo
  from wf_prlzb_baoxiao t, wf_flow tf, wf_prlzb_baoxiao_dtl d,dept dp,hr_emp hr
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and t.PayUsrGid = hr.UsrGid
   and hr.deptGid = dp.Gid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in
       ('1.04', '1.06', '4.01', '11.06', '1.01', '1.02', '1.03', '1.07');
