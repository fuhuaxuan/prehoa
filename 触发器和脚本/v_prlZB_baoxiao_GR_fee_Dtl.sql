create or replace view v_prlzb_baoxiao_GR_fee_Dtl as
select t.comgid,
       t.comname,
       to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.payusrgid applyusrgid,
       t.payusrcode applyusrcode,
       t.payman applyusrname,
       decode(d.acgcode,
              '1.01',
              '差旅费',
              '1.02',
              '差旅费',
              '1.03',
              '差旅费',
              '1.04',
              '差旅费',
              '1.05',
              '差旅费',
              '1.06',
              '招待费',
              '4.01',
              '招待费',
              '11.06',
              '其他费用',
              '15.01',
              '其他费用',
              '15.02',
              '其他费用') AcgType,
       decode(d.acgcode,
              '1.01',
              1,
              '1.02',
              1,
              '1.03',
              1,
              '1.04',
              1,
              '1.05',
              1,
              '1.06',
              2,
              '4.01',
              2,
              '11.06',
              3,
              '15.01',
              3,
              '15.02',
              3) AcgOrder,
       d.feedate,
       d.feeedate,
       d.applyfee,
       d.acgcode,
       d.Acgname,
       d.memo
  from wf_prlzb_baoxiao t, wf_flow tf, wf_prlzb_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in ('1.01',
                     '1.02',
                     '1.03',
                     '1.04',
                     '1.05',
                     '1.06',
                     '4.01',
                     '11.06',
                     '15.01',
                     '15.02');
