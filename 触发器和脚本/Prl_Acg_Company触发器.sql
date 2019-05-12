CREATE OR REPLACE TRIGGER Prl_Acg_Company_Insert
  before insert on Prl_Acg_Company
  for each row
declare
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_EntGid   varchar2(32); --��ҵGid
  v_OpUsrGid varchar2(32); --�û�Gid
  v_OpMemo   varchar2(4000); --��������
begin
  -- ��ȡ��ҵGid
  v_EntGid   := getEntGid;
  v_OpUsrGid := :New.OpUsrGid;
  v_OpMemo := :New.OpMemo;

  --����޲�������
  if v_OpUsrGid is NULL then
    v_OpMemo := 'ϵͳ����';
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

  --��ղ�������Ϣ
  :NEW.OpUsrGid    := null;
  :NEW.OpUsrCode   := null;
  :NEW.OpUsrName   := null;
  :NEW.OpDate      := null;
  :NEW.OpMemo      := null;
  :NEW.OpModelCode := null;
  :NEW.OpFlowGid   := null;
  :NEW.OpNum       := null;

  --�쳣����
exception
  when others then
    begin
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
         where e.gid = v_EntGid;
    end;
end;
/

CREATE OR REPLACE TRIGGER Prl_Acg_Company_Update
  before update on Prl_Acg_Company
  for each row
declare
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_EntGid   varchar2(32); --��ҵGid
  v_OpUsrGid varchar2(32); --�û�Gid
  v_OpMemo   varchar2(4000); --��������

  v_OpPFee number(20, 2); --����ǰ����
  v_OpCFee number(20, 2); --���������
  v_OpFee  number(20, 2); --��������

begin
  -- ��ȡ��ҵGid������ʼ������
  v_EntGid := getEntGid;
  v_OpMemo := :New.OpMemo;
  v_OpUsrGid := :New.OpUsrGid;
  v_OpPFee   := :OLD.LeftBudgutFee;
  v_OpCFee   := :New.LeftBudgutFee;

  v_Stage    := '�ж� ʣԤԤ�� �Ƿ��޸�';
  if v_OpPFee <> v_OpCFee then
    --����޲�������
    if v_OpUsrGid is NULL then
      v_OpMemo := 'ϵͳ�޸�';
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

  --��ղ�������Ϣ
  :NEW.OpUsrGid    := null;
  :NEW.OpUsrCode   := null;
  :NEW.OpUsrName   := null;
  :NEW.OpDate      := null;
  :NEW.OpMemo      := null;
  :NEW.OpModelCode := null;
  :NEW.OpFlowGid   := null;
  :NEW.OpNum       := null;
  --�쳣����
exception
  when others then
    begin
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
         where e.gid = v_EntGid;
    end;
end;
/