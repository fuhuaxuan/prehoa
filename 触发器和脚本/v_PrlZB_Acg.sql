create or replace view v_prlZB_Acg as
select entgid,
         gid,
         code,
         name,
         type,
         '' parentgid,
         null parentcode,
         '' parentname,
         feeflag,
         payflag
    from PrlZB_Acg
   where type = '10'
  union
  select b.entgid,
         b.gid,
         b.code,
         b.name,
         b.type,
         a.gid,
         a.code,
         a.name,
         b.feeflag,
         b.payflag
    from PrlZB_Acg a, PrlZB_Acg b
   where b.type = '20'
     and a.type = '10'
     and a.gid = b.parentgid;