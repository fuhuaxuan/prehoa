create or replace view v_prl_acg_fee as
select c.EntGid,
       c.Gid,
       c.Year,
       c.COMPANYGid ComGid,
       o.name ComName,
       c.ACGGID,
       a.code AcgCode,
       a.name AcgName,
       nvl(c.LeftBudgutFee, 0) LeftFee,
       nvl(f.applyFee, 0) + nvl(b.applyFee, 0) + nvl(p.applyFee, 0) +
       nvl(h.applyFee, 0) YesFee,
       nvl(f.applyFee, 0) FYesFee,
       nvl(b.applyFee, 0) BYesFee,
       nvl(p.applyFee, 0) PYesFee,
       nvl(h.applyFee, 0) hYesFee,
       nvl(f1.applyFee, 0) + nvl(b1.applyFee, 0) + nvl(p1.applyFee, 0) +
       nvl(h1.applyFee, 0) AllFee,
       nvl(f1.applyFee, 0) FAllFee,
       nvl(b1.applyFee, 0) BAllFee,
       nvl(p1.applyFee, 0) PAllFee,
       nvl(h1.applyFee, 0) HAllFee,
       nvl(t.opcfee, 0) OpFee
  from PRL_ACG_COMPANY c,
       prl_acg a,
       prl_company o,
       (select b.*
          from (select r.entgid, r.comacggid, r.year, min(r.opdate) opdate
                  from PRL_DOA_Rcd r
                 where r.oppfee = 0
                   and r.opusrname = 'sys'
                 group by r.entgid, r.comacggid, r.year) a,
               PRL_DOA_Rcd b
         where a.entgid = b.entgid
           and a.comacggid = b.comacggid
           and a.year = b.year
           and a.opdate = b.opdate) t,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(confirmfee, askfee)) applyFee,
               '费用单' atype
          from wf_prl_fee f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat < 3
           and f.stat not in ('13', '100', '终止')
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) f,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(confirmfee, askfee)) applyFee,
               '费用单' atype
          from wf_prl_fee f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat = 3
           and f.stat not in ('13', '100', '终止')
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) f1,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               fd.acggid acggid,
               f.comgid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               '个人报销单' atype
          from wf_prl_baoxiao f, wf_prl_baoxiao_dtl fd, wf_flow wf
         where f.entgid = wf.entgid
           and f.entgid = fd.entgid
           and f.flowgid = wf.flowgid
           and f.flowgid = fd.flowgid
           and wf.stat < 3
           and f.stat not in ('终止')
           and f.istake is null
         group by f.entgid,
                  fd.acggid,
                  f.comgid,
                  to_char(f.createdate, 'YYYY')) b,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               fd.acggid acggid,
               f.comgid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               '个人报销单' atype
          from wf_prl_baoxiao f, wf_prl_baoxiao_dtl fd, wf_flow wf
         where f.entgid = wf.entgid
           and f.entgid = fd.entgid
           and f.flowgid = wf.flowgid
           and f.flowgid = fd.flowgid
           and wf.stat = 3
           and f.stat not in ('终止')
           and f.istake is null
         group by f.entgid,
                  fd.acggid,
                  f.comgid,
                  to_char(f.createdate, 'YYYY')) b1,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(payfee, 0)) applyFee,
               '付款单' atype
          from WF_PRL_PAY f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat < 3
           and f.stat not in ('13', '100', '终止')
           and f.feeflowgid is null
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) p,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(payfee, 0)) applyFee,
               '付款单' atype
          from WF_PRL_PAY f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat = 3
           and f.stat not in ('13', '100', '终止')
           and f.feeflowgid is null
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) p1,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.pAcgGid acggid,
               f.comGid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               '预算分配' atype
          from WF_PRLDZ_AcgChg f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat < 3
           and f.stat not in ('终止')
         group by f.entgid,
                  f.pAcgGid,
                  f.comGid,
                  to_char(f.createdate, 'YYYY')) h,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.pAcgGid acggid,
               f.comGid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               '预算分配' atype
          from WF_PRLDZ_AcgChg f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat = 3
           and f.stat not in ('终止')
         group by f.entgid,
                  f.pAcgGid,
                  f.comGid,
                  to_char(f.createdate, 'YYYY')) h1
 where c.entgid = a.entgid
   and c.entgid = o.entgid
   and c.acggid = a.gid
   and c.companygid = o.gid
   and c.entgid = f.entgid(+)
   and c.Year = f.year(+)
   and c.COMPANYGid = f.comgid(+)
   and c.acggid = f.acggid(+)
   and c.entgid = b.entgid(+)
   and c.Year = b.year(+)
   and c.COMPANYGid = b.comgid(+)
   and c.acggid = b.acggid(+)
   and c.entgid = p.entgid(+)
   and c.Year = p.year(+)
   and c.COMPANYGid = p.comgid(+)
   and c.acggid = p.acggid(+)
   and c.entgid = f1.entgid(+)
   and c.Year = f1.year(+)
   and c.COMPANYGid = f1.comgid(+)
   and c.acggid = f1.acggid(+)
   and c.entgid = b1.entgid(+)
   and c.Year = b1.year(+)
   and c.COMPANYGid = b1.comgid(+)
   and c.acggid = b1.acggid(+)
   and c.entgid = p1.entgid(+)
   and c.Year = p1.year(+)
   and c.COMPANYGid = p1.comgid(+)
   and c.acggid = p1.acggid(+)
   and c.entgid = t.entgid(+)
   and c.gid = t.comacggid(+)
   and c.year = t.year(+)  
   and c.entgid = h.entgid(+)
   and c.Year = h.year(+)
   and c.COMPANYGid = h.comgid(+)
   and c.acggid = h.acggid(+)
   and c.entgid = h1.entgid(+)
   and c.Year = h1.year(+)
   and c.COMPANYGid = h1.comgid(+)
   and c.acggid = h1.acggid(+);
