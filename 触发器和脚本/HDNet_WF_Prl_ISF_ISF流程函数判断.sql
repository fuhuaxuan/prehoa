create or replace function HDNET_Prl_ISF(p_EntGid  varchar2, --��ҵGid
                                         p_FlowGid varchar2 --����FlowGid
                                         ) return number is
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_FlowType   int; --�������� isf-10,iscf-20
  v_OldFlowGid varchar2(32); --����Gid

  v_P1     number(20, 4); --����׼Ԥ��-New:�£�/��׼Ԥ��*100)
  v_P2     number(20, 4); --����׼Ԥ��-New:�£�*�����*(365/12)
  v_P3     number(20, 4); --������ ��
  v_P4     number(20, 4); --װ�޲��� �� + װ�޲��� ��
  v_P5     number(20, 4); --������ҵ̬���� 01 ��ͷ;  �ǲ�����ҵ̬���� �� 01 ��ͷ
  v_P6     number(20, 4); --���������������ܺ�
  v_P7     number(20, 4); --����������ȱ����һ��ȡ���ڼ��ⷽʽ������𵥼�-������ȡ���ڼ��ⷽʽ������𵥼ۣ�*�������*����������(���У��������������㣺ȡ���������ڶζ�Ӧ������)
  v_P8     number(20, 4); --�����գ�ISCF ��ͬ��ʼ���� - ISF ��ͬ��ʼ���ڣ�
  v_CBDate Date; --ISCF ��ͬ��ʼ����

  --ISF ��
  v_Old_P3     number(20, 4); --������ ��
  v_Old_P4     number(20, 4); --װ�޲��� �� + װ�޲��� ��
  v_Old_P6     number(20, 4); --���������������ܺ�
  v_Old_P7     number(20, 4); --����������ȱ����һ��ȡ���ڼ��ⷽʽ������𵥼�-������ȡ���ڼ��ⷽʽ������𵥼ۣ�*�������*����������(���У��������������㣺ȡ���������ڶζ�Ӧ������)
  v_Old_CBDate Date; --ISCF ��ͬ��ʼ����

  v_T1 number(20, 4); --��һ��ȡ���ڼ��ⷽʽ������𵥼�
  v_T2 number(20, 4); --������ȡ���ڼ��ⷽʽ������𵥼�
  v_T3 number(20, 4); --����������

  v_V2 number(20, 4); --
  v_V3 number(20, 4); --
  v_V7 number(20, 4); --

  v_Count number(20, 4); --

  v_Result number(20, 4); --����ֵ
begin
  v_Result := 40;
  v_P8     := 0;
  v_Stage  := 'ȡ������P1-P6���жϵ�ǰ������ISF����ISCF';
  select f.sPARAM1,
         f.sPARAM2,
         f.sPARAM3,
         f.TotalFee + f.OtherTotalFee,
         substr(f.Trade, 0, 2),
         f.Area,
         decode(f.FlowType, 10, 50000, 30000),
         f.FlowType,
         f.oldFlowGid,
         f.ContractDate1
    into v_P1,
         v_P2,
         v_P3,
         v_P4,
         v_P5,
         v_P6,
         v_V2,
         v_FlowType,
         v_OldFlowGid,
         v_CBDate
    from wf_PRL_ISF f
   where f.EntGid = p_EntGid
     and f.FlowGid = p_FlowGid;

  v_Stage := 'ȡ����һ�� ���ⷽʽ������𵥼�';
  v_T1    := 0;
  select count(*)
    into v_Count
    from wf_PRL_ISF_Dtl fd
   where fd.EntGid = p_EntGid
     and fd.FlowGid = p_FlowGid
     and lower(fd.TbID) = 'tb_dtl30'
     and fd.YearType = 1;
  if v_Count != 0 then
    select TBRD
      into v_T1
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = p_FlowGid
       and lower(fd.TbID) = 'tb_dtl30'
       and fd.YearType = 1;
  end if;

  v_Stage := 'ȡ�������� ���ⷽʽ������𵥼� �� ����������';
  v_T2    := 0;
  v_T3    := 0;
  select count(*)
    into v_Count
    from wf_PRL_ISF_Dtl fd
   where fd.EntGid = p_EntGid
     and fd.FlowGid = p_FlowGid
     and lower(fd.TbID) = 'tb_dtl10';
  if v_Count != 0 then
    select TBRD, FreeRentDate2 - FreeRentDate1
      into v_T2, v_T3
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = p_FlowGid
       and lower(fd.TbID) = 'tb_dtl10';
  end if;

  v_Stage := '���� P7 ����������ȱ';
  v_P7    := (v_T1 - v_T2) * v_P6 * v_T3;

  if v_FlowType = 20 then
    v_Stage := 'ȡ��Old ISF��' || v_OldFlowGid || '����P1-P6���жϵ�ǰ������ISF����ISCF';
    select f.sPARAM3, f.TotalFee + f.OtherTotalFee, f.Area, f.ContractDate1
      into v_Old_P3, v_Old_P4, v_Old_P6, v_Old_CBDate
      from wf_PRL_ISF f
     where f.EntGid = p_EntGid
       and f.FlowGid = v_OldFlowGid;
  
    v_Stage := 'ȡ��Old ISF' || v_OldFlowGid || '��һ�� ���ⷽʽ������𵥼�';
    v_T1    := 0;
    select count(*)
      into v_Count
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = v_OldFlowGid
       and lower(fd.TbID) = 'tb_dtl30'
       and fd.YearType = 1;
    if v_Count != 0 then
      select TBRD
        into v_T1
        from wf_PRL_ISF_Dtl fd
       where fd.EntGid = p_EntGid
         and fd.FlowGid = v_OldFlowGid
         and lower(fd.TbID) = 'tb_dtl30'
         and fd.YearType = 1;
    end if;
  
    v_Stage := 'ȡ��Old ISF' || v_OldFlowGid || '������ ���ⷽʽ������𵥼� �� ����������';
  
    v_T2 := 0;
    v_T3 := 0;
    select count(*)
      into v_Count
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = v_OldFlowGid
       and lower(fd.TbID) = 'tb_dtl10';
    if v_Count != 0 then
      select TBRD, FreeRentDate2 - FreeRentDate1
        into v_T2, v_T3
        from wf_PRL_ISF_Dtl fd
       where fd.EntGid = p_EntGid
         and fd.FlowGid = v_OldFlowGid
         and lower(fd.TbID) = 'tb_dtl10';
    end if;
  
    v_Stage  := '����Old ISF' || v_OldFlowGid || ' P7 ����������ȱ';
    v_Old_P7 := (v_T1 - v_T2) * v_Old_P6 * v_T3;
  
    v_Stage := '����P8';
    v_P8    := v_CBDate - v_Old_CBDate;
  
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
  --v_P5:����
  if v_P5 = '01' then
    --v_P6:���
    if v_P6 <= 100 then
      v_V3 := 1;
      v_V7 := 30000;
    elsif v_P6 > 100 and v_P6 <= 250 then
      v_V3 := 2;
      v_V7 := 50000;
    else
      v_V3 := 3;
      v_V7 := 1000000000;
    end if;
    --v_P5:�ǲ���
  else
    --v_P6:���
    if v_P6 <= 250 then
      v_V3 := 1;
      v_V7 := 50000;
    elsif v_P6 > 250 and v_P6 <= 500 then
      v_V3 := 2;
      v_V7 := 80000;
    else
      v_V3 := 3;
      v_V7 := 1000000000;
    end if;
  end if;

  if (v_P1 > 0 or v_P2 > 0) or v_P4 > 0 or (v_P3 > v_V3 or v_P7 > v_V7) or
     v_P8 > 0 then
    v_Result := 60;
  end if;
  if (v_P1 > 10 or v_P2 > 50000) or v_P4 > 80000 or
     (v_P3 > v_V3 and v_P7 > v_V7) or v_P8 > 30 then
    v_Result := 80;
  end if;
  if (v_P1 > 10 or v_P2 > 50000) or v_P4 > 80000 then
    v_Result := 90;
  end if;
  if (v_P1 > 10 and v_P2 > 50000) or v_P4 > 300000 then
    v_Result := 100;
  end if;
  --���ؼ�����
  return v_Result;
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