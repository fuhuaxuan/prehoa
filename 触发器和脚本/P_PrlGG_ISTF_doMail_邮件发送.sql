create or replace procedure P_PrlGG_ISTF_doMail(p_FlowGid varchar --����Gid
                                                ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_EntGid varchar2(32); --��ҵGid

  v_Title   varchar2(64); --����
  v_Email   varchar(1024); --�ʼ�
  v_Content varchar2(32500); --����

  v_Head   varchar(64); --��ͷ
  v_Body   varchar(2048); --������
  v_TStart varchar(32);
  v_TEnd   varchar(32);
  v_Foot   varchar(64); --��β
  v_T1     varchar(1024);
  v_T2     varchar(1024);

begin
  -- ��ȡ��ҵGid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>���� :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '��</td></tr>';
  v_Foot    := '<tr><td>-----------����չʾ���-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';
  v_T1      := '';
  v_T2      := '';
  --for ѭ�� ȡ��δ��ȡ�Ŀ��
  for R in (select f.*,
                   t.unit,
                   t.area,
                   t.lessee        lessee1,
                   t.tradingname   tradingname1,
                   t.leaseTermY,
                   t.leaseTermM,
                   t.leaseTermD,
                   t.HandoverDate,
                   t.contractDate1,
                   t.contractdate2,
                   t.freeRentY,
                   t.freeRentM,
                   t.freeRentD,
                   t.fitoutM,
                   t.fitoutD,
                   t.fitoutdate1,
                   t.fitoutdate2,
                   wm.name         ModelName
              from wf_PrlGG_ISTF f, wf_Prl_OISF t, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = t.entgid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.oldflowgid = t.flowgid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := '���λISTF��������:' || R.Filldeptname;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[���] : ' || R.Category || ' ' || R.Categorytext;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    for D in (select f.*
                from wf_PrlGG_ISF_ground f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
               order by f.fno) loop
      v_T1 := v_T1 || D.fNo || ';';
      v_T2 := v_T2 || D.floorno || ';';
    end loop;
    v_Body    := '[��λ] : ' || v_T1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[λ��] : ' || v_T2;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body    := '[�⻧] : ' || R.Lessee1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�̵�Ӫҵ����] : ' || R.Tradingname1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��������] : ' || R.Leasetermy || '��/' || R.Leasetermm || '��/' ||
                 R.Leasetermd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��������] : ' || to_char(R.Handoverdate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ͬ��ʼ����] : ' || to_char(R.Contractdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Contractdate2, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Freerentm || '��/' || R.Freerentd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������ֹ����] : ' || to_char(R.TERMINATIONDATE, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '���������Ŀ�ϼ� : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[ʵ��Ӧ�ɽ��C=A-B] : ' || R.DATACSUM;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[ʵ�ʽ��ɽ��D] : ' || R.DATADSUM;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Ӧ�˻�(׷��)���E=D-C] : ' || R.DATAESUM;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[δ�����Լ���޵���𼰷���] : ' || R.NUMA;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ǰ��ֹ�Ĳ����������û�յĿ��] : ' || R.NUMD;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Ƿ����] : ' || R.NUMG;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�˳�ԭ��] : ' || R.REMARKS;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select distinct hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and hr.Email is not null
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1)) loop
      v_Email := v_Email || U.EMAIL || ',';
    end loop;
    if v_Email is not null then
      HDNet_SendMail(v_Title, v_Email, v_Content);
    end if;
  end loop;
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
      commit;
    end;
end;
/
