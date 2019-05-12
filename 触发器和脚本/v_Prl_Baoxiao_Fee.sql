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
