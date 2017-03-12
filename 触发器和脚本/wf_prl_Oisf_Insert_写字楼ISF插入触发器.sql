create or replace trigger wf_prl_Oisf_Insert
  before insert on wf_prl_Oisf
  for each row
declare
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_EntGid      varchar2(32); --��ҵGid
  v_ModelGid    varchar2(32); --ģ��Gid
  v_FillDeptGid varchar2(32); --����Gid
begin
  -- ��ȡ��ҵGid
  v_EntGid := getEntGid;

  v_Stage := 'ȡ��ģ��Gid';
  select ModelGid
    into v_ModelGid
    from wf_model
   where entgid = v_EntGid
     and lower(code) = 'prl_oisf';

  v_Stage := '�������30�����޸�modelgid';
  if :NEW.flowtype = 30 then
    :NEW.ModelGid := v_ModelGid;
  end if;

  if :NEW.FillDeptGid is null then
    select d.Gid
      into v_FillDeptGid
      from dept d
     where d.EntGid = v_EntGid
       and lower(d.code2) = lower(:NEW.FillDeptCode);
    :NEW.FillDeptGid := v_FillDeptGid;
  end if;

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
         where e.Gid = v_EntGid;
      commit;
    end;
end;
/
