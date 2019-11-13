create or replace view v_PRL_Ground_Floor as
select g.floorno, g.fno, g.farea
  from prl_groundh g
 where g.deptsource = '0001'
 and g.fstat not in ('Õ£”√')
 order by g.floorno;
