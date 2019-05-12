CREATE OR REPLACE VIEW prl_company AS
select d.entgid, d.gid, d.code2 code, d.name, 10 stat
  from dept d
 where d.code2 not in ('0000')
   and length(d.code1) = 8
   order by d.code2;
