create or replace view v_prl_baoxiao_fee_dtl as
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
  from wf_prl_baoxiao t, wf_flow tf, wf_prl_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in ('8.09', '8.02', '7.05', '8.04', '8.08');
