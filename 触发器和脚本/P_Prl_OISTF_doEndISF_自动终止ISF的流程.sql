create or replace procedure P_Prl_OISTF_doEndISF(p_Date date --时间
                                                 ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

begin
  for R in (select v.ISFModelGid,
                   v.ISFFlowGid,
                   v.ISFFillUsrName,
                   v.ISFNum,
                   to_char(v.ISFcreatedate, 'YY.MM.DD HH24:MI'),
                   v.ISFFlowType,
                   v.ISFCONTRACTDATE2
              from v_Prl_OISF v
             where v.EntGid = getentgid
               and v.ISFCONTRACTDATE2 <= trunc(sysdate)
               and v.ISCFFlowGid is null
               and v.ISTFFlowGid is null
               and v.ISFStat not in ('40')
             order by v.ISFCONTRACTDATE2) loop
    v_Stage := '单号：' || R.ISFNum || '到期自动终止';
    update wf_prl_oisf
       set stat = 40, LastUpdDate = sysdate
     where EntGid = getentgid
       AND FlowGid = R.ISFFlowGid;
    commit;
  end loop;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr(v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
      insert into Log
        (EntGid,
         EntCode,
         EntName,
         UsrGid,
         UsrCode,
         UsrName,
         CreateDate,
         Atype,
         AContent)
        select e.gid,
               e.code,
               e.name,
               'sys',
               'sys',
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = getentgid;
      commit;
    end;
end;
/

begin
  for v in (select job
              from user_jobs
             where what in ('P_Prl_OISTF_doEndISF(null);')) loop
    dbms_job.remove(v.job);
  end loop;
  commit;
end;
/


--每1天执行一次，每天临晨00:30进行
variable J_Prl_OISTF_doEndISF number;
begin
  DBMS_JOB.SUBMIT (:J_Prl_OISTF_doEndISF, 'P_Prl_OISTF_doEndISF(null);', trunc(sysdate) + 23/24 + 50/60/24, 'trunc(sysdate + 1) + 23/24 + 50/60/24');
end;
/
commit;