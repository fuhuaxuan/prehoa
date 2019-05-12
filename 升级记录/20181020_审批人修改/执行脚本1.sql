create table prl_company_1020 as select * from prl_company;
drop table prl_company;

CREATE OR REPLACE VIEW prl_company AS
select d.entgid, d.gid, d.code2 code, d.name
  from dept d
 where d.code2 not in ('0000')
   and length(d.code1) = 8
   order by d.code2;

update wf_prl_fee f
   set f.companygid =
       (select p.gid from prl_company p where p.name = f.companyname)
 where exists (select 1 from prl_company p where p.name = f.companyname);


update wf_prl_pay f
   set f.companygid =
       (select p.gid from prl_company p where p.name = f.companyname)
 where exists (select 1 from prl_company p where p.name = f.companyname);


update wf_prl_baoxiao f
   set f.comgid =
       (select p.gid from prl_company p where p.name = f.comname)
 where exists (select 1 from prl_company p where p.name = f.comname);

update wf_prl_stamp f
   set f.comgid =
       (select p.gid from prl_company p where p.name = f.comname)
 where exists (select 1 from prl_company p where p.name = f.comname);

update wf_prldz_change f
   set f.comgid =
       (select p.gid from prl_company p where p.name = f.comname)
 where exists (select 1 from prl_company p where p.name = f.comname);

update wf_prldz_acgadd f
   set f.comgid =
       (select p.gid from prl_company p where p.name = f.comname)
 where exists (select 1 from prl_company p where p.name = f.comname);

update wf_prldz_acgchg f
   set f.comgid =
       (select p.gid from prl_company p where p.name = f.comname)
 where exists (select 1 from prl_company p where p.name = f.comname);



update prl_acg_company f
   set f.companygid =
       (select p.gid
          from prl_company p, prl_company_1020 t
         where t.name = p.name
           and f.companygid = t.gid)
 where exists (select p.gid
          from prl_company p, prl_company_1020 t
         where t.name = p.name
           and f.companygid = t.gid);


update prl_doa_rcd f
   set f.companygid =
       (select p.gid
          from prl_company p, prl_company_1020 t
         where t.name = p.name
           and f.companygid = t.gid)
 where exists (select p.gid
          from prl_company p, prl_company_1020 t
         where t.name = p.name
           and f.companygid = t.gid);



alter table wf_prldz_sos add fmrMSum1 number(24,2);

alter table wf_prldz_sos add fmrMSum2 number(24,2);

update wf_prldz_sos f
   set fmrMSum1 =
       (select sum(fmrM)
          from wf_prldz_sos_dtl t
         where f.flowgid = t.flowgid
           and t.atype = 10);

update wf_prldz_sos f
   set fmrMSum2 =
       (select sum(fmrM)
          from wf_prldz_sos_dtl t
         where f.flowgid = t.flowgid
           and t.atype = 20);
