create or replace view v_prl_baoxiao_GR_fee_Dtl as
select t.comgid,
       t.comname,
       to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.APPLYusrgid,
       t.APPLYusrcode,
       t.APPLYusrname,
       decode(d.acgcode,
              '8.09',
              '差旅费',
              '8.10',
              '差旅费',
              '8.11',
              '差旅费',
              '8.12',
              '差旅费',
              '8.02',
              '招待费',
              '7.05',
              '其他费用',
              '7.08',
              '其他费用') AcgType,
decode(d.acgcode,
                 '8.09',
                 1,
                 '8.10',
                 1,
                 '8.11',
                 1,
                 '8.12',
                 1,
                 '8.02',
                 2,
                 '7.05',
                 3,
                 '7.08',
                 3) AcgOrder,
       d.feedate,
       d.feeedate,
       d.applyfee,
       d.acgcode,
       d.Acgname,
       d.memo
  from wf_prl_baoxiao t, wf_flow tf, wf_prl_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in
       ('8.09', '8.10', '8.11', '8.12', '8.02', '7.05', '7.08');