create or replace trigger wf_prl_Oisf_Insert
  before insert on wf_prl_Oisf
  for each row
declare
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid      varchar2(32); --企业Gid
  v_ModelGid    varchar2(32); --模型Gid
  v_FillDeptGid varchar2(32); --部门Gid
begin
  -- 获取企业Gid
  v_EntGid := getEntGid;

  v_Stage := '取出模型Gid';
  select ModelGid
    into v_ModelGid
    from wf_model
   where entgid = v_EntGid
     and lower(code) = 'prl_oisf';

  v_Stage := '如果类型30，则修改modelgid';
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
         where e.Gid = v_EntGid;
      commit;
    end;
end;
/
