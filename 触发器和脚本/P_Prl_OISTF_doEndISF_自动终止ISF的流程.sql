create or replace procedure P_Prl_OISTF_doEndISF(p_Date date --ʱ��
                                                 ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

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
    v_Stage := '���ţ�' || R.ISFNum || '�����Զ���ֹ';
    update wf_prl_oisf
       set stat = 40, LastUpdDate = sysdate
     where EntGid = getentgid
       AND FlowGid = R.ISFFlowGid;
    commit;
  end loop;
  --�쳣����
exception
  when others then
    begin
      rollback;
      v_ErrText := substr(v_Stage || ' ʧ��!' || SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --������־
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
               'ϵͳ�Զ�',
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


--ÿ1��ִ��һ�Σ�ÿ���ٳ�00:30����
variable J_Prl_OISTF_doEndISF number;
begin
  DBMS_JOB.SUBMIT (:J_Prl_OISTF_doEndISF, 'P_Prl_OISTF_doEndISF(null);', trunc(sysdate) + 23/24 + 50/60/24, 'trunc(sysdate + 1) + 23/24 + 50/60/24');
end;
/
commit;