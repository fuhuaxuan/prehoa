alter table wf_prl_isf add SecurityStand Number(20,4);
alter table wf_prl_isf add MonthSale Number(20,4);
alter table wf_prl_isf add IsHY varchar2(10);
alter table wf_prl_isf add IsQZ varchar2(10);
alter table wf_prl_isf add AttachType varchar2(32);
alter table WF_PRL_ISF_Attach add Attach_Type int;



update WF_PRL_ISF_Attach set Attach_Type = 50;
update wf_prl_isf set SecurityStand=Security,AttachType = '����';
commit;

create or replace procedure HDNET_Prl_doISF(p_EntGid  varchar2, --��ҵGid
                                            p_FlowGid varchar2 --����FlowGid
                                            ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_FlowType   int; --�������� isf-10,iscf-20
  v_OldFlowGid varchar2(32); --����Gid

  v_P1     number(20, 4); --����׼Ԥ��-New:�£�/��׼Ԥ��*100)
  v_P2     number(20, 4); --����׼Ԥ��-New:�£�*�����*(365/12)
  v_P3     number(20, 4); --������ ��
  v_P4     number(20, 4); --װ�޲��� �� + װ�޲��� ��
  v_P5     varchar(32); --������ҵ̬���� 01 ��ͷ;  �ǲ�����ҵ̬���� �� 01 ��ͷ
  v_P6     number(20, 4); --���������������ܺ�
  v_P7     number(20, 4); --����������ȱ����һ��ȡ���ڼ��ⷽʽ������𵥼�-������ȡ���ڼ��ⷽʽ������𵥼ۣ�*�������*����������(���У��������������㣺ȡ���������ڶζ�Ӧ������)
  v_P8     number(20, 4); --�����գ�ISCF ��ͬ��ʼ���� - ISF ��ͬ��ʼ���ڣ�
  v_P9     number(20, 4); --��֤����죨��׼ - ʵ�ʣ�
  v_Atype  varchar(32); --����
  v_CBDate Date; --ISCF ��ͬ��ʼ����

  v_Category varchar2(64); --���
  v_D1       varchar2(32); --�����ǣ��̶����ǹ̶���������
  v_D2       number(20, 4); --�����·�

  --ISF ��
  v_Old_P3     number(20, 4); --������ ��
  v_Old_P4     number(20, 4); --װ�޲��� �� + װ�޲��� ��
  v_Old_P6     number(20, 4); --���������������ܺ�
  v_Old_P7     number(20, 4); --����������ȱ����һ��ȡ���ڼ��ⷽʽ������𵥼�-������ȡ���ڼ��ⷽʽ������𵥼ۣ�*�������*����������(���У��������������㣺ȡ���������ڶζ�Ӧ������)
  v_Old_CBDate Date; --ISCF ��ͬ��ʼ����

  v_YearFee number(20, 4); --��һ��ȡ���ڼ��ⷽʽ������𵥼�
  v_FreeFee number(20, 4); --������ȡ���ڼ��ⷽʽ������𵥼�
  v_FreeDay number(20, 4); --����������

  v_Old_YearFee number(20, 4); --��һ��ȡ���ڼ��ⷽʽ������𵥼�
  v_Old_FreeFee number(20, 4); --������ȡ���ڼ��ⷽʽ������𵥼�
  v_Old_FreeDay number(20, 4); --����������

  v_T2 number(20, 4); --P2����
  v_T3 number(20, 4); --P3����
  v_T6 number(20, 4); --P6����
  v_T7 number(20, 4); --P7����

  v_Count number(20, 4); --�ж��Ƿ����

  v_Result number(20, 4); --����ֵ
begin
  v_Result := 40;
  v_P8     := 0;
  v_P9     := 0;
  v_Stage  := 'ȡ������P1-P6���жϵ�ǰ������ISF����ISCF';
  select nvl(f.sPARAM1, 0),
         nvl(f.sPARAM2, 0),
         nvl(f.FreeRentM, 0),
         nvl(f.TotalFee + f.OtherTotalFee, 0),
         decode(substr(f.Trade, 0, 2), '01', '����', '�ǲ���'),
         nvl(f.Area, 0),
         decode(f.FlowType, 10, 50000, 30000),
         f.FlowType,
         f.oldFlowGid,
         f.ContractDate1,
         nvl(f.BRCNew, 0),
         nvl(f.MZQCNew, 0),
         f.Category,
         nvl(f.LeaseTermM, 0),
         nvl(f.SecurityStand, 0) - nvl(f.Security, 0),
         f.Atype
    into v_P1,
         v_P2,
         v_P3,
         v_P4,
         v_P5,
         v_P6,
         v_T2,
         v_FlowType,
         v_OldFlowGid,
         v_CBDate,
         v_YearFee,
         v_FreeFee,
         v_Category,
         v_D2,
         v_P9,
         v_Atype
    from wf_PRL_ISF f
   where f.EntGid = p_EntGid
     and f.FlowGid = p_FlowGid;

  v_Stage := '�ж����ڵ����';
  if v_Category = 'Licence ������Լ(�̶�)' then
    v_D1 := '�̶�';
  elsif v_Category = 'Licence ������Լ(�ǹ̶�)' then
    v_D1 := '�ǹ̶�';
  else
    v_D1 := '����';
  end if;

  v_Stage   := 'ȡ������������';
  v_FreeDay := 0;
  select count(*)
    into v_Count
    from wf_PRL_ISF_Dtl fd
   where fd.EntGid = p_EntGid
     and fd.FlowGid = p_FlowGid
     and lower(fd.TbID) = 'tb_dtl10';
  if v_Count != 0 then
    select nvl(FreeRentDate2 - FreeRentDate1 + 1, 0)
      into v_FreeDay
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = p_FlowGid
       and lower(fd.TbID) = 'tb_dtl10';
  end if;

  v_Stage := '���� P7 ����������ȱ';
  v_P7    := (v_YearFee - v_FreeFee) * v_P6 * v_FreeDay;

  if v_OldFlowGid is not null then
    v_Stage := 'ȡ��Old ISF��' || v_OldFlowGid || '����P1-P6���жϵ�ǰ������ISF����ISCF';
    select nvl(f.FreeRentM, 0),
           nvl(f.TotalFee + f.OtherTotalFee, 0),
           nvl(f.Area, 0),
           f.ContractDate1,
           nvl(f.BRCNew, 0),
           nvl(f.MZQCNew, 0)
      into v_Old_P3,
           v_Old_P4,
           v_Old_P6,
           v_Old_CBDate,
           v_Old_YearFee,
           v_Old_FreeFee
      from wf_PRL_ISF f
     where f.EntGid = p_EntGid
       and f.FlowGid = v_OldFlowGid;
  
    v_Stage       := 'ȡ��Old ISF' || v_OldFlowGid || '����������';
    v_Old_FreeDay := 0;
    select count(*)
      into v_Count
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = v_OldFlowGid
       and lower(fd.TbID) = 'tb_dtl10';
    if v_Count != 0 then
      select nvl(FreeRentDate2 - FreeRentDate1 + 1, 0)
        into v_Old_FreeDay
        from wf_PRL_ISF_Dtl fd
       where fd.EntGid = p_EntGid
         and fd.FlowGid = v_OldFlowGid
         and lower(fd.TbID) = 'tb_dtl10';
    end if;
  
    v_Stage  := '����Old ISF' || v_OldFlowGid || ' P7 ����������ȱ';
    v_Old_P7 := (v_Old_YearFee - v_Old_FreeFee) * v_Old_P6 * v_Old_FreeDay;
  
    v_Stage := '����P8';
    if v_CBDate is not null and v_Old_CBDate is not null then
      v_P8 := v_CBDate - v_Old_CBDate;
    end if;
  
    v_Stage := '�����µ�P3';
    if v_Old_P3 = v_P3 then
      v_P3 := 0;
    end if;
  
    v_Stage := '�����µ�P4';
    if v_Old_P4 = v_P4 then
      v_P4 := 0;
    end if;
  
    v_Stage := '�����µ�P7';
    if v_Old_P7 = v_P7 then
      v_P7 := 0;
    end if;
  end if;

  v_T6 := 1000000000;
  --v_P5:����
  if v_P5 = '����' then
    --v_P6:���
    if v_P6 <= 100 then
      v_T3 := 1;
      v_T7 := 30000;
    elsif v_P6 > 100 and v_P6 <= 250 then
      v_T3 := 2;
      v_T7 := 50000;
    else
      v_T3 := 3;
      v_T6 := 250;
      v_T7 := 1000000000;
    end if;
    --v_P5:�ǲ���
  else
    --v_P6:���
    if v_P6 <= 250 then
      v_T3 := 1;
      v_T7 := 50000;
    elsif v_P6 > 250 and v_P6 <= 500 then
      v_T3 := 2;
      v_T7 := 80000;
    else
      v_T3 := 3;
      v_T6 := 500;
      v_T7 := 1000000000;
    end if;
  end if;

  v_Stage := '�ж��������յ���Ľڵ�';
  if v_D1 = '�̶�' then
    if v_D2 >= 0 then
      v_Result := 60;
    end if;
    if v_D2 > 6 then
      v_Result := 90;
    end if;
    if v_D2 > 12 then
      v_Result := 100;
    end if;
  elsif v_D1 = '����' then
    if (v_P1 > 0 or v_P2 > 0) or v_P4 > 0 or
       (v_Atype = 'Rental ����' and v_P9 > 0) or (v_P3 > v_T3 or v_P7 > v_T7) or
       v_P8 > 0 then
      v_Result := 60;
    end if;
    if (v_P1 > 10 or v_P2 > 50000) or v_P4 > 80000 or
       (v_Atype = 'Rental ����' and v_P9 > 10000) or
       (v_P3 > v_T3 or v_P7 > v_T7) or v_P8 > 30 then
      v_Result := 80;
    end if;
    if (v_P1 > 10 or v_P2 > 50000) or v_P4 > 80000 or
       (v_Atype = 'Rental ����' and v_P9 > 10000) or
       (v_P6 > v_T6 and v_P3 > v_T3) then
      v_Result := 90;
    end if;
    if (v_P1 > 10 and v_P2 > 50000) or v_P4 > 300000 or
       (v_Atype = 'Rental ����' and v_P9 > 50000) then
      v_Result := 100;
    end if;
  end if;

  --���ؼ�����
  --40-TA3
  --60-TB
  --80-TC1
  --90-TC2
  --100-TD
  v_Stage := '����P1-P8��ISF����';
  update wf_PRL_ISF
     set (sPARAM3, sPARAM4, sPARAM5, sPARAM6, sPARAM7, sPARAM8, sStep) =
         (select v_P3, v_P4, v_P5, v_P6, v_P7, v_P8, v_Result from dual)
   where EntGid = p_EntGid
     and FlowGid = p_FlowGid;
  commit;
  --�쳣����
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('����Gid:' || p_FlowGid || ';' || v_Stage || ' ʧ��!' ||
                          SQLCode || ':' || SQLERRM,
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
        select e.Gid,
               e.Code,
               e.Name,
               'sys',
               'sys',
               'ϵͳ�Զ�',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.Gid = p_EntGid;
      commit;
    end;
end;
/
