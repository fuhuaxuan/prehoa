create or replace view v_PRL_FeeRT as
select entgid,
         gid,
         gid    ausrgid,
         code   ausrcode,
         name   ausrname,
         gid    busrgid,
         code   busrcode,
         name   busrname
    from v_usr
  union all
  select entgid,
         gid,
         ausrgid,
         ausrcode,
         ausrname,
         busrgid,
         busrcode,
         busrname
    from PRL_FeeRT;