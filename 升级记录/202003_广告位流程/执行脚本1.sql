alter table WF_prlGG_ISF add Atype2 varchar2(32);
alter table WF_prlGG_ISF add Atype3 varchar2(32);
alter table WF_prlGG_ISF add MinArea NUMBER;
alter table WF_prlGG_ISF add MaxArea NUMBER;
alter table WF_prlGG_ISF add Collection varchar2(64);
alter table WF_prlGG_ISF add PowerType varchar2(32);
alter table WF_prlGG_ISF add PowerFee1 NUMBER;
alter table WF_prlGG_ISF add PowerFee2 NUMBER;
alter table WF_prlGG_ISF add WaterType varchar2(32);
alter table WF_prlGG_ISF add WaterFee1 NUMBER;
alter table WF_prlGG_ISF add WaterFee2 NUMBER;
alter table WF_prlGG_ISF_dtl add GTO NUMBER;
alter table WF_prlGG_ISF_dtl add ProGTO NUMBER;
alter table WF_prlGG_ISF_dtl add ProGTOrent NUMBER;
alter table WF_prlGG_ISF add FitoutM NUMBER;
alter table WF_prlGG_ISF add fitoutD NUMBER;
alter table WF_prlGG_ISF add FitoutDate1 date;
alter table WF_prlGG_ISF add FitoutDate2 date;
alter table wf_prlGG_isf_ground add farea NUMBER;
alter table wf_prlGG_isf_ground add jarea NUMBER;


create or replace procedure P_PrlGG_ISF_doMail(p_FlowGid varchar --����Gid
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
  v_T1     varchar(1024);
  v_T2     varchar(1024);
  v_T3     number;
  v_T4     number;
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
  v_T1      := '';
  v_T2      := '';
  v_T3      := 0;
  v_T4      := 0;
  --for ѭ�� ȡ��δ��ȡ�Ŀ��
  for R in (select f.*,
                   substr(wm.code, instr(wm.code, '_', 1) + 1) MCode,
                   wm.name ModelName
              from wf_PrlGG_ISF f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := '���λ' || R.Mcode || ':' || R.FilldeptName;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[���] : ' || R.Atype || ' ' || R.Atype2 || ' ' || R.Atype3;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    for D in (select f.*
                from wf_PrlGG_ISF_ground f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
               order by f.fno) loop
      v_T1 := v_T1 || D.fNo || ';';
      v_T2 := v_T2 || D.floorno || ';';
      select v_T3 + nvl(D.fArea, 0) into v_T3 from dual;
      select v_T4 + nvl(D.jArea, 0) into v_T4 from dual;
    end loop;
    v_Body    := '[��λ] : ' || v_T1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[λ��] : ' || v_T2;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if v_T3 = v_T4 then
      v_Body    := '[���] : ' || v_T3;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    else
      v_Body    := '[���] : ' || v_T3 || '-' || v_T4;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[A���⻧��Ϣ] : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�⻧] : ' || R.Lessee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�̵�Ӫҵ����] : ' || R.Tradingname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ϵ��] : ' || R.Contactor;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ַ] : ' || R.Address;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�绰] : ' || R.Phone;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�����ʼ�] : ' || R.Email;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Fax;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[B����ͬ��Ϣ] : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��������] : ' || R.Leasetermy || '��/' || R.Leasetermm || '��/' ||
                 R.Leasetermd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��������] : ' || to_char(R.Handoverdate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Freerentm || '��/' || R.Freerentd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[װ����] : ' || R.Fitoutm || '��/' || R.Fitoutd || '�գ�' ||
                 to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ͬ��ʼ����] : ' || to_char(R.Contractdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Contractdate2, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[���ʽ] : ' || R.Rate;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������ʽ] : ' || R.Collection;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[C����������]';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body    := ' <table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '    <td nowrap rowspan="4">Yr��</td>';
    v_Body    := v_Body || '    <td nowrap rowspan="4">���</td>';
    v_Body    := v_Body || '    <td nowrap>Ԫ/��</td>';
    v_Body    := v_Body || '    <td nowrap>Ԫ/��</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body ||
                 '    <td class="App_ListTd" style="padding:0px" nowrap colspan="2">Details ϸ��</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body ||
                 '    <td class="App_ListTd" style="padding:0px" nowrap colspan="2">�O/��</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body ||
                 '    <td class="App_ListTd" style="padding:0px" nowrap colspan="2">�O/��</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from wf_PrlGG_ISF_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and lower(f.TBID) in ('tb_dtl10', 'tb_dtl30')
               order by f.TBID, f.yeartype) loop
      v_Body := ' <tr valign="top" style="background-color: white" align="center"  rowspan="4">';
      if lower(D.TbId) = 'tb_dtl10' then
        v_Body := v_Body || '<td nowrap> ��:' ||
                  to_char(D.Freerentdate1, 'YYYY.MM.DD') || '~' ||
                  to_char(D.Freerentdate2, 'YYYY.MM.DD') || ') </td>';
      else
        v_Body := v_Body || '<td nowrap> Yr ' || D.Yeartype || ' </td>';
      end if;
      v_Body    := v_Body || '  <td nowrap> �̶���� </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '  <td nowrap> �������� </td>';
      v_Body    := v_Body || '  <td nowrap  colspan="2"> ' ||
                   to_char(D.GTO, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '  <td nowrap> Ԥ��Ӫҵ�� </td>';
      v_Body    := v_Body || '  <td nowrap  colspan="2"> ' ||
                   to_char(D.ProGTO, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '  <td nowrap> Ԥ�������� </td>';
      v_Body    := v_Body || '  <td nowrap  colspan="2"> ' ||
                   to_char(D.ProGTOrent, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[��] : ' || R.Brcnew;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Ŀǰ] : ' || R.Brcexist;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��׼Ԥ��] : ' || R.Brcbudget;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ͬ����������] : ' || R.TotalFee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Ԥ�����+����] : ' || R.AGR;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��֤��] : ' || R.Security;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ʽ] : ' || R.Incash;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�����ȡ] : ' || R.PowerType;
    if R.PowerType = '����' then
      v_Body := v_Body || R.PowerFee1 || 'Ԫ/��';
    elsif R.PowerType = '�̶�����' then
      v_Body := v_Body || R.PowerFee2 || 'Ԫ/��';
    end if;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[ˮ����ȡ] : ' || R.WaterType;
    if R.WaterType = '����' then
      v_Body := v_Body || R.WaterFee1 || 'Ԫ/��';
    elsif R.WaterType = '�̶�����' then
      v_Body := v_Body || R.WaterFee2 || 'Ԫ/��';
    end if;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�ر�����/����] : ' || R.Memo;
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
