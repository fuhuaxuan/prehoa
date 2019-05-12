create or replace view v_ZBACG as      
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
    from PRLZB_ACG
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
    from PRLZB_ACG a, PRLZB_ACG b
   where b.type = '20'
     and a.type = '10'
     and a.gid = b.parentgid;
