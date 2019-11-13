create or replace procedure P_PrlDZ_Pay_doPay(p_EntGid    varchar2, --��ҵGid
                                              p_ModelGid  varchar, --ģ��Gid
                                              p_ModelCode varchar2, --ģ�ʹ���
                                              p_FlowGid   varchar, --����Gid
                                              p_UsrGid    varchar, --�û�Gid
                                              p_PayDate   date, --֧��ʱ��
                                              p_Certtype  varchar2, --ƾ֤����
                                              p_Certnum   varchar2 --ƾ֤���
                                              ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrCode varchar2(32); --�û�
  v_UsrName varchar2(32);

  v_FillUsrGid  varchar2(32); --������
  v_FillUsrCode varchar2(32);
  v_FillUsrName varchar2(32);

  v_FromTaskGid varchar2(32); --��Դ����Gid
  v_EndTaskGid  varchar2(32); --��ֹ����Gid
  v_TccTaskGid  varchar2(32); --��������Gid

  v_Num    varchar2(32);
  v_PayFee number(20, 4);

begin
  if lower(p_ModelCode) = lower('PrlDZ_Pay') and p_FlowGid is not null then
    v_Stage := 'ȡ���û���Ϣ';
    select v.Code, v.Name
      into v_UsrCode, v_UsrName
      from v_usr v
     where v.EntGid = p_EntGid
       and v.Gid = p_UsrGid;
  
    v_Stage := 'ȡ��������Ϣ';
    select nvl(nvl(npayfee, payfee), 0), f.num
      into v_PayFee, v_Num
      from wf_Prl_Pay f
     where f.entgid = p_EntGid
       and f.flowgid = p_FlowGid;
  
    v_Stage := 'ȡ����������Ϣ';
    select v.CREATERGID, v.CREATERCode, v.CREATERName
      into v_FillUsrGid, v_FillUsrCode, v_FillUsrName
      from wf_flow v
     where v.EntGid = p_EntGid
       and v.FlowGid = p_FlowGid;
  
    v_Stage := '�õ����������������Gid';
    select TaskDefGid
      into v_TccTaskGid
      from WF_Task_Define
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and lower(Code) = lower('PrlDZ_Pay_Tcc');
  
    v_Stage := '�õ���Դ�����������Gid';
    select TaskDefGid
      into v_FromTaskGid
      from WF_Task_Define
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and lower(Code) = lower('PrlDZ_Pay_T5')
       and IsMcf = 0;
  
    v_Stage := '�õ���ǰ��������ֹ�����Gid';
    select TaskDefGid
      into v_EndTaskGid
      from WF_Task_Define
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and IsEnd = 1;
  
    v_Stage := '��������';
    update wf_Prl_Pay
       set (LastUpdDate, Stat, CertType, CertNum, PayDate) =
           (select sysdate, '�����', p_Certtype, p_Certnum, p_PayDate
              from dual)
     where EntGid = p_EntGid
       AND FlowGid = p_FlowGid;
  
    v_Stage := '����������';
    insert into wf_Prl_Pay_App
      (EntGid,
       FlowGid,
       dtlgid,
       AppGid,
       AppCode,
       AppName,
       AppType,
       AppOrder,
       AppAssign,
       AppDate)
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             p_UsrGid,
             v_UsrCode,
             v_UsrName,
             90,
             90,
             'ȷ�ϸ���',
             sysdate
        from dual;
  
    v_Stage := '���õ���״̬';
    update wf_Prl_fee f
       set f.LastUpdDate = sysdate, endstat = '10', f.enddate = p_PayDate
     where f.entgid = p_EntGid
       and exists (select 1
              from wf_Prl_Pay p
             where p.entgid = f.entgid
               and p.flowgid = p_FlowGid
               and p.feeflowgid = f.flowgid
               and p.isend = '10');
  
    v_Stage := '������Ŀ��Ԥ�����';
    update PRL_ACG_COMPANY o
       set (LeftBudgutFee,
            OpUsrGid,
            OpUsrCode,
            OpUsrName,
            OpDate,
            OpMemo,
            OpModelCode,
            OpFlowGid,
            OpNum) =
           (select o.LeftBudgutFee - v_PayFee,
                   p_UsrGid,
                   v_UsrCode,
                   v_UsrName,
                   sysdate,
                   '�������뵥�ۼ�',
                   'PrlDZ_Pay',
                   p_FlowGid,
                   v_Num
              from dual)
     where o.entgid = p_EntGid
       and exists (select 1
              from wf_Prl_Pay wf
             where wf.entgid = p_EntGid
               and wf.flowgid = p_FlowGid
               and o.ACGGID = wf.acgtwogid
               and o.CompanyGid = wf.CompanyGid
               and to_char(wf.CreateDate, 'YYYY') = o.Year
               and wf.feeflowgid is null);
  
    v_Stage := '��ʣ��ķ��ûع�';
    update PRL_ACG_COMPANY o
       set (LeftBudgutFee,
            OpUsrGid,
            OpUsrCode,
            OpUsrName,
            OpDate,
            OpMemo,
            OpModelCode,
            OpFlowGid,
            OpNum) =
           (select o.LeftBudgutFee + nvl(wf.feeleft, 0),
                   p_UsrGid,
                   v_UsrCode,
                   v_UsrName,
                   sysdate,
                   '�������뵥����',
                   'PrlDZ_Pay',
                   p_FlowGid,
                   v_Num
              from wf_Prl_Pay wf, wf_prl_fee f
             where wf.entgid = p_EntGid
               and wf.flowgid = p_FlowGid
               and wf.entgid = f.entgid
               and wf.feeflowgid = f.flowgid
               and o.ACGGID = wf.acgtwogid
               and o.CompanyGid = wf.CompanyGid
               and to_char(wf.CreateDate, 'YYYY') = o.Year
               and wf.feeflowgid is not null
               and wf.isEnd = 10)
     where o.entgid = p_EntGid
       and exists (select 1
              from wf_Prl_Pay wf, wf_prl_fee f
             where wf.entgid = p_EntGid
               and wf.flowgid = p_FlowGid
               and wf.entgid = f.entgid
               and wf.feeflowgid = f.flowgid
               and o.ACGGID = wf.acgtwogid
               and o.CompanyGid = wf.CompanyGid
               and to_char(wf.CreateDate, 'YYYY') = o.Year
               and wf.feeflowgid is not null
               and wf.isEnd = 10
               and nvl(wf.feeleft, 0) > 0);
  
    v_Stage := '����FromTask��״̬Ϊ3';
    update WF_Task
       set Stat = 3, ETime = sysdate
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and FlowGid = p_FlowGid
       and TaskDefGid = v_FromTaskGid
       and ExecGid = p_UsrGid
       and IsMcf = 0;
  
    v_Stage := '�������̵�ʵ��״̬';
    update WF_Flow
       set Stat = 3, LastUpdDate = sysdate, FinishDate = sysdate
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and FlowGid = p_FlowGid;
  
    v_Stage := '�������̵�ʵ��������δ��������״̬';
    update WF_Task
       set Stat = 4, ETime = sysdate
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and FlowGid = p_FlowGid
       and Stat < 3
       and IsMcf = 0;
  
    v_Stage := '������������';
    insert into WF_Task
      (EntGid,
       ModelGid,
       FlowGid,
       TaskDefGid,
       TaskGid,
       Code,
       Name,
       Note,
       Stat,
       ExecGid,
       ExecCode,
       ExecName,
       OrderValue,
       IsMCF)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             v_TccTaskGid,
             sys_guid(),
             Code,
             Name,
             Note,
             1,
             v_FillUsrGid,
             v_FillUsrCode,
             v_FillUsrName,
             OrderValue,
             IsMCF
        from WF_Task_Define
       where EntGid = p_EntGid
         and ModelGid = p_ModelGid
         and TaskDefGid = v_TccTaskGid;
  
    v_Stage := '�������̽�������';
    insert into WF_Task
      (EntGid,
       ModelGid,
       FlowGid,
       TaskDefGid,
       TaskGid,
       Code,
       Name,
       Note,
       Stat,
       ExecGid,
       ExecCode,
       ExecName,
       OrderValue)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             v_EndTaskGid,
             sys_guid(),
             Code,
             Name,
             Note,
             3,
             p_UsrGid,
             v_UsrCode,
             v_UsrName,
             OrderValue
        from WF_Task_Define
       where EntGid = p_EntGid
         and ModelGid = p_ModelGid
         and TaskDefGid = v_EndTaskGid;
  
    v_Stage := 'WF_Model.Ap2 - 1;WF_Model.Ap1 + 1';
    update WF_Model
       set Ap2 = Ap2 - 1, Ap1 = Ap1 + 1, LastUpdDate = sysdate
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid;
  
    v_Stage := '��WF_Task���еĸ�ʵ����Ϣ����WF_Task_History��ɾ��WF_Task���еĸ�ʵ����Ϣ';
    insert into WF_Task_History
      select *
        from WF_Task
       where EntGid = p_EntGid
         and ModelGid = p_ModelGid
         and FlowGid = p_FlowGid
         and Stat <= 6
         and IsMcf = 0;
  
    v_Stage := 'ɾ�����̵������¼';
    delete from WF_Task
     where EntGid = p_EntGid
       and ModelGid = p_ModelGid
       and FlowGid = p_FlowGid
       and IsMcf = 0;
  
    commit;
  end if;
  --�쳣����
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('����Gid:' || p_FlowGid || ';�û�Gid:' || p_UsrGid ||
                          '��������;' || v_Stage || ' ʧ��!' || SQLCode || ':' ||
                          SQLERRM,
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
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
