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
       d.gid,
       d.feedate,
       d.feeedate,
       d.applyfee applyfee,
       d.acgcode,
       '个人报销单' ModelName,
       d.memo memo
  from wf_prlzb_baoxiao t, wf_flow tf, wf_prlzb_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in
       ('1.04', '1.06', '4.01', '11.06', '1.01', '1.02', '1.03', '1.07');
