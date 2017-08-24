create or replace procedure P_PrlDZ_ISTF_doMail(p_FlowGid varchar --����Gid
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

begin
  -- ��ȡ��ҵGid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>���� :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '��</td></tr>';
  v_Foot    := '<tr><td>-----------����չʾ���-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';
  --for ѭ�� ȡ��δ��ȡ�Ŀ��
  for R in (select f.*,
                   decode(f.category,
                          10,
                          'Early Termination ��ǰ��ֹ',
                          20,
                          'Termination ������ֹ',
                          30,
                          'Others ����:' || f.categorytext) categoryText1,
                   t.unit,
                   t.area,
                   t.lessee lessee1,
                   t.tradingname tradingname1,
                   t.leaseTermY,
                   t.leaseTermM,
                   t.leaseTermD,
                   t.HandoverDate,
                   t.Rate1,
                   t.Rate,
                   t.contractDate1,
                   t.contractdate2,
                   t.freeRentM,
                   t.freeRentD,
                   t.freeRentdate1,
                   t.freeRentdate2,
                   t.fitoutM,
                   t.fitoutD,
                   t.fitoutdate1,
                   t.fitoutdate2,
                   t.collection,
                   wm.name ModelName
              from wf_Prl_ISTF f, wf_Prl_ISF t, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = t.entgid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.oldflowgid = t.flowgid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := 'ISTF��������:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Category ���] : ' || R.Categorytext1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Unit No. ��λ] : ' || R.Unit;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Area ���] : ' || R.Area;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Tenant/Licensee �⻧] : ' || R.Lessee1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Trading Name �̵�Ӫҵ����] : ' || R.Tradingname1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Lease Term ��������] : ' || R.Leasetermy || '��/' ||
                 R.Leasetermm || '��/' || R.Leasetermd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Handover Date ��������] : ' ||
                 to_char(R.Handoverdate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Contract Date ��ͬ��ʼ����] : ' ||
                 to_char(R.Contractdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Contractdate2, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Free of rent Period ������] : ' || R.Freerentm || '��/' ||
                 R.Freerentd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Fit-Out Period װ����] : ' || R.Fitoutm || '��/' ||
                 R.Fitoutd || '�գ�' || to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := R.RATE1 || '(' || R.Rate || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Termination Date ������ֹ����] : ' ||
                 to_char(R.TERMINATIONDATE, 'YYYY.MM.DD');
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
    v_Body    := '[��𣨺���ҵ�ѣ������] : ' || R.NUMB;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[װ�޲���] : ' || R.NUMC;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ǰ��ֹ�Ĳ����������û�յĿ��] : ' || R.NUMD;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Remarks �˳�ԭ��] : ' || R.REMARKS;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1)) loop
      v_Email := U.EMAIL || ',';
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