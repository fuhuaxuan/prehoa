create or replace view v_prlzb_baoxiao_fee as
select a.*,
       nvl(f1.applyfee, 0) F1Fee,
       nvl(f2.applyfee, 0) F2Fee,
       nvl(f3.applyfee, 0) F3Fee,
       nvl(f4.applyfee, 0) F4Fee,
       nvl(f5.applyfee, 0) F5Fee,
       nvl(f1.applyfee, 0) + nvl(f2.applyfee, 0) + nvl(f3.applyfee, 0) +
       nvl(f4.applyfee, 0) + nvl(f5.applyfee, 0) FSumFee,
       f1.memo || f2.memo || f3.memo || f4.memo || f5.memo memo
  from (select distinct f.feeY,
                        f.feeM,
                        f.comgid,
                        f.comname,
                        f.filldeptgid,
                        f.filldeptname,
                        f.fillusrname,
                        f.payman,
                        f.position,
                        f.feedate
          from v_prlzb_baoxiao_fee_dtl f) a,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               sum(applyfee) applyfee,
               replace(decode(wm_concat(h.memo),
                              '',
                              '',
                              replace(wm_concat(distinct h.memo || '---'), '---', '<br>')),
                       ',',
                       '') memo
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
                  h.feedate) f1,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               sum(applyfee) applyfee,
               replace(decode(wm_concat(h.memo),
                              '',
                              '',
                              replace(wm_concat(distinct h.memo || '---'), '---', '<br>')),
                       ',',
                       '') memo
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
                  h.feedate) f2,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               sum(applyfee) applyfee,
               replace(decode(wm_concat(h.memo),
                              '',
                              '',
                              replace(wm_concat(distinct h.memo || '---'), '---', '<br>')),
                       ',',
                       '') memo
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
                  h.feedate) f3,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               sum(applyfee) applyfee,
               replace(decode(wm_concat(h.memo),
                              '',
                              '',
                              replace(wm_concat(distinct h.memo || '---'), '---', '<br>')),
                       ',',
                       '') memo
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
                  h.feedate) f4,
       (select h.feeY,
               h.FeeM,
               h.comgid,
               h.comname,
               h.filldeptgid,
               h.filldeptname,
               h.fillusrname,
               h.payman,
               h.feedate,
               sum(applyfee) applyfee,
               replace(decode(wm_concat(h.memo),
                              '',
                              '',
                              replace(wm_concat(distinct h.memo || '---'), '---', '<br>')),
                       ',',
                       '') memo
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
                  h.feedate) f5
 where a.feeY = f1.feeY(+)
   and a.feeM = f1.feeM(+)
   and a.comgid = f1.comgid(+)
   and a.filldeptgid = f1.filldeptgid(+)
   and a.paymAn = f1.payman(+)
   and a.feedate = f1.feedate(+)
   and a.feeY = f2.feeY(+)
   and a.feeM = f2.feeM(+)
   and a.comgid = f2.comgid(+)
   and a.filldeptgid = f2.filldeptgid(+)
   and a.paymAn = f2.payman(+)
   and a.feedate = f2.feedate(+)
   and a.feeY = f3.feeY(+)
   and a.feeM = f3.feeM(+)
   and a.comgid = f3.comgid(+)
   and a.filldeptgid = f3.filldeptgid(+)
   and a.paymAn = f3.payman(+)
   and a.feedate = f3.feedate(+)
   and a.feeY = f4.feeY(+)
   and a.feeM = f4.feeM(+)
   and a.comgid = f4.comgid(+)
   and a.filldeptgid = f4.filldeptgid(+)
   and a.paymAn = f4.payman(+)
   and a.feedate = f4.feedate(+)
   and a.feeY = f5.feeY(+)
   and a.feeM = f5.feeM(+)
   and a.comgid = f5.comgid(+)
   and a.filldeptgid = f5.filldeptgid(+)
   and a.paymAn = f5.payman(+)
   and a.feedate = f5.feedate(+)
 order by a.comname, a.feeY, a.feeM, a.filldeptname, a.payman;