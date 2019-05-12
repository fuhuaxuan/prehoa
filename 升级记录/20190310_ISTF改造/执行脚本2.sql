alter table WF_PRL_Baoxiao_dtl add FeeEDate date;
alter table WF_PRLZB_Baoxiao_dtl add FeeEDate date;

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

create or replace view v_prlzb_baoxiao_GR_fee_Dtl as
select t.comgid,
       t.comname,
       to_char(t.createdate, 'YYYY') feeY,
       to_char(t.createdate, 'MM') feeM,
       t.APPLYusrgid,
       t.APPLYusrcode,
       t.APPLYusrname,
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
       d.gid,
       d.feedate,
       d.feeedate,
       d.applyfee applyfee,
       d.acgcode,
       '个人报销单' ModelName,
       d.memo memo
  from wf_prl_baoxiao t, wf_flow tf, wf_prl_baoxiao_dtl d
 where t.entgid = d.entgid
   and t.entgid = tf.entgid
   and t.flowgid = d.flowgid
   and t.flowgid = tf.flowgid
   and tf.stat < 4
   and t.stat not in ('终止', '否决')
   and d.acgcode in ('8.09', '8.02', '7.05', '8.04', '8.08');

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

create or replace view v_prl_baoxiao_fee as
select a.*,
       nvl(f1.applyfee, 0) F1Fee,
       nvl(f2.applyfee, 0) F2Fee,
       nvl(f3.applyfee, 0) F3Fee,
       nvl(f4.applyfee, 0) F4Fee,
       nvl(f5.applyfee, 0) F5Fee,
       nvl(f1.applyfee, 0) + nvl(f2.applyfee, 0) + nvl(f3.applyfee, 0) +
       nvl(f4.applyfee, 0) + nvl(f5.applyfee, 0) FSumFee
  from (select f.feeY,
               f.feeM,
               f.comgid,
               f.comname,
               f.filldeptgid,
               f.filldeptname,
               f.fillusrname,
               f.payman payman,
               f.position,
               f.feedate,
               f.feeedate,
               replace(wm_concat(distinct f.ModelName || '---'),
                       '---',
                       '<br>') ModelName,
               replace(decode(wm_concat(distinct f.memo),
                              '',
                              '',
                              replace(wm_concat(distinct f.memo || '---'),
                                      '---',
                                      '<br>')),
                       ',',
                       '') memo
          from v_prl_baoxiao_fee_dtl f
         group by f.FeeY,
                  f.FeeM,
                  f.comgid,
                  f.comname,
                  f.filldeptgid,
                  f.filldeptname,
                  f.fillusrname,
                  f.payman,
                  f.position,
                  f.feedate,
                  f.feeedate) a,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prl_baoxiao_fee_dtl h
         where h.acgcode in ('8.09')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f1,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prl_baoxiao_fee_dtl h
         where h.acgcode in ('8.02')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f2,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prl_baoxiao_fee_dtl h
         where h.acgcode in ('7.05')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f3,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prl_baoxiao_fee_dtl h
         where h.acgcode in ('8.04')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f4,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prl_baoxiao_fee_dtl h
         where h.acgcode in ('8.08')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f5
 where a.feeY = f1.feeY(+)
   and a.feeM = f1.feeM(+)
   and a.comgid = f1.comgid(+)
   and a.filldeptgid = f1.filldeptgid(+)
   and a.paymAn = f1.payman(+)
   and a.feedate = f1.feedate(+)
   and a.feeedate = f1.feeedate(+)
   and a.feeY = f2.feeY(+)
   and a.feeM = f2.feeM(+)
   and a.comgid = f2.comgid(+)
   and a.filldeptgid = f2.filldeptgid(+)
   and a.paymAn = f2.payman(+)
   and a.feedate = f2.feedate(+)
   and a.feeedate = f2.feeedate(+)
   and a.feeY = f3.feeY(+)
   and a.feeM = f3.feeM(+)
   and a.comgid = f3.comgid(+)
   and a.filldeptgid = f3.filldeptgid(+)
   and a.paymAn = f3.payman(+)
   and a.feedate = f3.feedate(+)
   and a.feeedate = f3.feeedate(+)
   and a.feeY = f4.feeY(+)
   and a.feeM = f4.feeM(+)
   and a.comgid = f4.comgid(+)
   and a.filldeptgid = f4.filldeptgid(+)
   and a.paymAn = f4.payman(+)
   and a.feedate = f4.feedate(+)
   and a.feeedate = f4.feeedate(+)
   and a.feeY = f5.feeY(+)
   and a.feeM = f5.feeM(+)
   and a.comgid = f5.comgid(+)
   and a.filldeptgid = f5.filldeptgid(+)
   and a.paymAn = f5.payman(+)
   and a.feedate = f5.feedate(+)
   and a.feeedate = f5.feeedate(+)
 order by a.comname, a.feeY, a.feeM, a.filldeptname, a.payman;
create or replace view v_prlzb_baoxiao_fee as
select a.*,
       nvl(f1.applyfee, 0) F1Fee,
       nvl(f2.applyfee, 0) F2Fee,
       nvl(f3.applyfee, 0) F3Fee,
       nvl(f4.applyfee, 0) F4Fee,
       nvl(f5.applyfee, 0) F5Fee,
       nvl(f1.applyfee, 0) + nvl(f2.applyfee, 0) + nvl(f3.applyfee, 0) +
       nvl(f4.applyfee, 0) + nvl(f5.applyfee, 0) FSumFee
  from (select f.feeY,
               f.feeM,
               f.comgid,
               f.comname,
               f.filldeptgid,
               f.filldeptname,
               f.fillusrname,
               f.payman,
               f.position,
               f.feedate,
               f.feeedate,
               replace(wm_concat(distinct f.ModelName || '---'),
                       '---',
                       '<br>') ModelName,
               replace(decode(wm_concat(distinct f.memo),
                              '',
                              '',
                              replace(wm_concat(distinct f.memo || '---'),
                                      '---',
                                      '<br>')),
                       ',',
                       '') memo
          from v_prlzb_baoxiao_fee_dtl f
         group by f.FeeY,
                  f.FeeM,
                  f.comgid,
                  f.comname,
                  f.filldeptgid,
                  f.filldeptname,
                  f.fillusrname,
                  f.payman,
                  f.position,
                  f.feedate,
                  f.feeedate) a,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prlzb_baoxiao_fee_dtl h
         where h.acgcode in ('1.04')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f1,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prlzb_baoxiao_fee_dtl h
         where h.acgcode in ('1.06', '4.01')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f2,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prlzb_baoxiao_fee_dtl h
         where h.acgcode in ('11.06')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f3,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prlzb_baoxiao_fee_dtl h
         where h.acgcode in ('1.01', '1.02', '1.03')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f4,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               h.feeedate,
               sum(applyfee) applyfee
          from v_prlzb_baoxiao_fee_dtl h
         where h.acgcode in ('1.07')
         group by h.FeeY,
                  h.FeeM,
                  h.comgid,
                  h.comname,
                  h.filldeptgid,
                  h.filldeptname,
                  h.fillusrname,
                  h.payman,
                  h.feedate,
                  h.feeedate) f5
 where a.feeY = f1.feeY(+)
   and a.feeM = f1.feeM(+)
   and a.comgid = f1.comgid(+)
   and a.filldeptgid = f1.filldeptgid(+)
   and a.paymAn = f1.payman(+)
   and a.feedate = f1.feedate(+)
   and a.feeedate = f1.feeedate(+)
   and a.feeY = f2.feeY(+)
   and a.feeM = f2.feeM(+)
   and a.comgid = f2.comgid(+)
   and a.filldeptgid = f2.filldeptgid(+)
   and a.paymAn = f2.payman(+)
   and a.feedate = f2.feedate(+)
   and a.feeedate = f2.feeedate(+)
   and a.feeY = f3.feeY(+)
   and a.feeM = f3.feeM(+)
   and a.comgid = f3.comgid(+)
   and a.filldeptgid = f3.filldeptgid(+)
   and a.paymAn = f3.payman(+)
   and a.feedate = f3.feedate(+)
   and a.feeedate = f3.feeedate(+)
   and a.feeY = f4.feeY(+)
   and a.feeM = f4.feeM(+)
   and a.comgid = f4.comgid(+)
   and a.filldeptgid = f4.filldeptgid(+)
   and a.paymAn = f4.payman(+)
   and a.feedate = f4.feedate(+)
   and a.feeedate = f4.feeedate(+)
   and a.feeY = f5.feeY(+)
   and a.feeM = f5.feeM(+)
   and a.comgid = f5.comgid(+)
   and a.filldeptgid = f5.filldeptgid(+)
   and a.paymAn = f5.payman(+)
   and a.feedate = f5.feedate(+)
   and a.feeedate = f5.feeedate(+)
 order by a.comname, a.feeY, a.feeM, a.filldeptname, a.payman;
