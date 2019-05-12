create or replace procedure P_Prl_OISF_doMail(p_FlowGid varchar --����Gid
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
                   substr(wm.code, instr(wm.code, '_', 1) + 2) MCode,
                   wm.name ModelName
              from wf_Prl_OISF f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := 'д��¥' || R.Mcode || '��������:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Category ���] : ' || R.Atype || R.Category ||
                 R.Categorytext;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Unit No. ��λ] : ' || R.Unit;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Area ���] : ' || R.Area;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Tenant/Licensee �⻧] : ' || R.Lessee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Trading Name �̵�Ӫҵ����] : ' || R.Tradingname;
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
    v_Body    := '[Free of rent Period ������] : ' || R.Freerenty || '��/' ||
                 R.Freerentm || '��/' || R.Freerentd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Fit-Out Period װ����] : ' || R.Fitoutm || '��/' ||
                 R.Fitoutd || '�գ�' || to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Security Deposit (mths) ��֤��] : ' || R.Security;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body := ' <table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body := v_Body || ' <col style="padding-left:4px;">';
    v_Body := v_Body || '<col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body ||
              '  <tr style="background-color: #ecedef;" align="center">';
    v_Body := v_Body || '   <td rowspan="2">Yr ��</td>';
    v_Body := v_Body || '   <td colspan="4">Base Rental<br>�̶����</td>';
    v_Body := v_Body ||
              '   <td colspan="4" nowrap>Property Mgmt Fee<br>��ܷ�</td>';
    v_Body := v_Body || ' </tr>';
    v_Body := v_Body ||
              ' <tr style="background-color: #ecedef;" align="center">';
    v_Body := v_Body || '   <td>�O/��</td>';
    v_Body := v_Body || '  <td>����/��</td>';
    v_Body := v_Body || '   <td>(����)<br>�O/��</td>';
    v_Body := v_Body || '   <td>(���⣩<br>�O/��</td>';
    v_Body := v_Body || '   <td>�O/��</td>';
    v_Body := v_Body || '  <td>����/��</td>';
    v_Body := v_Body || '   <td>(����)<br>�O/��</td>';
    v_Body := v_Body || '   <td>(���⣩<br>�O/��</td>';
    v_Body := v_Body || ' </tr>';
  
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_Prl_OIsf_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and lower(f.TBID) in ('tb_dtl30')
               order by f.TBID, f.yeartype) loop
      v_Body := ' <tr valign="top" style="background-color: white" align="center">';
    
      v_Body    := v_Body || '<td nowrap> Yr ' || D.Yeartype || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.TBRM, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Ftbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Ftbrm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.pmfd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.pmfm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Fpmfd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Fpmfm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
  
    v_Body    := '[New ��] : ' || R.Brcnew || 'RMB/�O/��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Existing Ŀǰ] : ' || R.Brcexist || 'RMB/�O/��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Budget ��׼Ԥ��] : ' || R.Brcbudget || 'RMB/�O/��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Special Terms and Conditions/Remarks :�ر�����/����] : ' ||
                 R.Memo;
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
