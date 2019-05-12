create or replace view v_ACG as      
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
    from PRL_ACG
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
    from PRL_ACG a, PRL_ACG b
   where b.type = '20'
     and a.type = '10'
     and a.gid = b.parentgid;
