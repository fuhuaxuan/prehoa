select distinct code
  from wf_task t
 where stat = 1
      
   and exists (select 1
          from wf_model m
         where m.modelgid = t.modelgid
           and lower(m.code) in ('prldz_isf',
                                 'prldz_iscf',
                                 'prldz_istf',
                                 'prldz_fee',
                                 'prldz_pay',
                                 'prldz_baoxiao',
                                 'prl_oisf',
                                 'prl_oiscf',
                                 'prl_oistf'))
      
   and lower(substr(code, instr(lower(code), '_t', 1)+1)) not in
       ('t1', 'tmod', 't3', 't4', 't5', 't6', 'tcc')

 order by code