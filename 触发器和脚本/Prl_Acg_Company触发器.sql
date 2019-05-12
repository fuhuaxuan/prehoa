CREATE OR REPLACE TRIGGER Prl_Acg_Company_Insert
  before insert on Prl_Acg_Company
  for each row
declare
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid   varchar2(32); --企业Gid
  v_OpUsrGid varchar2(32); --用户Gid
  v_OpMemo   varchar2(4000); --操作内容
begin
  -- 获取企业Gid
  v_EntGid   := getEntGid;
  v_OpUsrGid := :New.OpUsrGid;
  v_OpMemo := :New.OpMemo;

  --如果无操作对象
  if v_OpUsrGid is NULL then
    v_OpMemo := '系统新增';
  end if;
  insert into PRL_DOA_Rcd
    (EntGid,
     Gid,
     ComAcgGid,
     Year,
     COMPANYGid,
     ACGGID,
     OpUsrGid,
     OpUsrCode,
     OpUsrName,
     OpDate,
     OpPFee,
     OpCFee,
     OpFee,
     OpMemo,
     OpModelCode,
     OpFlowGid,
     OpNum)
    select v_EntGid,
           sys_guid(),
           :NEW.Gid,
           :NEW.Year,
           :NEW.COMPANYGid,
           :NEW.ACGGID,
           :NEW.OpUsrGid,
           :NEW.OpUsrcode,
           nvl(:NEW.OpUsrName,'sys'),
           nvl(:NEW.OpDate, sysdate),
           0,
           :New.LeftBudgutFee,
           :New.LeftBudgutFee,
           v_OpMemo,
           :NEW.OpModelCode,
           :NEW.OpFlowGid,
           :NEW.OpNum
      from dual;

  --清空操作者信息
  :NEW.OpUsrGid    := null;
  :NEW.OpUsrCode   := null;
  :NEW.OpUsrName   := null;
  :NEW.OpDate      := null;
  :NEW.OpMemo      := null;
  :NEW.OpModelCode := null;
  :NEW.OpFlowGid   := null;
  :NEW.OpNum       := null;

  --异常处理
exception
  when others then
    begin
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
         where e.gid = v_EntGid;
    end;
end;
/

CREATE OR REPLACE TRIGGER Prl_Acg_Company_Update
  before update on Prl_Acg_Company
  for each row
declare
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid   varchar2(32); --企业Gid
  v_OpUsrGid varchar2(32); --用户Gid
  v_OpMemo   varchar2(4000); --操作内容

  v_OpPFee number(20, 2); --操作前费用
  v_OpCFee number(20, 2); --操作后费用
  v_OpFee  number(20, 2); --操作费用

begin
  -- 获取企业Gid，并初始化数据
  v_EntGid := getEntGid;
  v_OpMemo := :New.OpMemo;
  v_OpUsrGid := :New.OpUsrGid;
  v_OpPFee   := :OLD.LeftBudgutFee;
  v_OpCFee   := :New.LeftBudgutFee;

  v_Stage    := '判断 剩预预算 是否被修改';
  if v_OpPFee <> v_OpCFee then
    --如果无操作对象
    if v_OpUsrGid is NULL then
      v_OpMemo := '系统修改';
    end if;
    insert into PRL_DOA_Rcd
      (EntGid,
       Gid,
       ComAcgGid,
       Year,
       COMPANYGid,
       ACGGID,
       OpUsrGid,
       OpUsrCode,
       OpUsrName,
       OpDate,
       OpPFee,
       OpCFee,
       OpFee,
       OpMemo,
       OpModelCode,
       OpFlowGid,
       OpNum)
      select v_EntGid,
             sys_guid(),
             :NEW.Gid,
             :NEW.Year,
             :NEW.COMPANYGid,
             :NEW.ACGGID,
             :NEW.OpUsrGid,
             :NEW.OpUsrcode,
             nvl(:NEW.OpUsrName,'sys'),
             nvl(:NEW.OpDate,sysdate),
             :OLD.LeftBudgutFee,
             :New.LeftBudgutFee,
             :New.LeftBudgutFee - :OLD.LeftBudgutFee,
             v_OpMemo,
             :NEW.OpModelCode,
             :NEW.OpFlowGid,
             :NEW.OpNum
        from dual;
  end if;

  --清空操作者信息
  :NEW.OpUsrGid    := null;
  :NEW.OpUsrCode   := null;
  :NEW.OpUsrName   := null;
  :NEW.OpDate      := null;
  :NEW.OpMemo      := null;
  :NEW.OpModelCode := null;
  :NEW.OpFlowGid   := null;
  :NEW.OpNum       := null;
  --异常处理
exception
  when others then
    begin
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
         where e.gid = v_EntGid;
    end;
end;
/