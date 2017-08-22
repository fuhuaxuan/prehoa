create or replace procedure P_PrlDZ_BaoXiao_doMail(p_FlowGid varchar --����Gid
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
  for R in (select f.*, wm.name ModelName
              from Wf_Prl_Baoxiao f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := '���˱�����������:' || R.Filldeptname;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��˾����] : ' || R.Comname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:80%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>��Ŀ��Ϣ</td>';
    v_Body    := v_Body || '<td>����������[Ԫ]</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_Prl_Baoxiao_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid) loop
      v_Body := '<tr valign="top" style="background-color: white">';
      v_Body := v_Body || '<td>[' || D.Acgcode || ']' || D.Acgname ||
                '</td>';
      v_Body := v_Body || '<td align="center">' || D.Applyfee || '</td>';
      v_Body := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[����������] : ' || R.Sumfee || 'Ԫ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������ע] : ' || R.Memo;
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
                         and t.Stat = 1
                         and t.ExecGid <> R.Fillusrgid)) loop
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
create or replace procedure P_PrlDZ_Fee_doMail(p_FlowGid varchar --����Gid
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
  for R in (select f.*, wm.name ModelName
              from wf_Prl_Fee f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�'|| R.ModelName;
    v_Title   := '���ô�������:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��˾����] : ' || R.Companyname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��Ŀ����] : ' || R.ACGONENAME || '-' || R.Acgtwoname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[DOA��Ϣ] : ' || R.Doacode || '-' || R.Doaname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����Ŀ��] : ' || R.Target;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������Ŀ����] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�Ƽ�������] : ' || R.Reason;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[ʣ��Ԥ����] : ' || R.Controlfee || 'Ԫ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����������] : ����' || R.Askfee || 'Ԫ������' ||
                 nvl(R.Naskfee, '0') || 'Ԫ';
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
                         and t.Stat = 1
                         and t.ExecGid <> R.Fillusrgid)) loop
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
create or replace procedure P_PrlDZ_ISF_doMail(p_FlowGid varchar --����Gid
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
                   substr(wm.code, instr(wm.code, '_', 1) + 1) MCode,
                   wm.name ModelName
              from wf_Prl_ISF f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := R.Mcode || '��������:' || R.Fillusrdept;
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
    v_Body    := '[Free of rent Period ������] : ' || R.Freerentm || '��/' ||
                 R.Freerentd || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Fit-Out Period װ����] : ' || R.Fitoutm || '��/' ||
                 R.Fitoutd || '�գ�' || to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := R.RATE1 || '(' || R.Rate || ')';
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
    v_Body := v_Body || '   <td colspan="3">Base Rental<br>�̶����</td>';
    v_Body := v_Body ||
              '   <td colspan="3" nowrap>Property Mgmt Fee<br>��ܷ�</td>';
    v_Body := v_Body || '   <td colspan="2">A �г��ƹ��</td>';
    v_Body := v_Body || '   <td rowspan="2" nowrap>GTO ���</td>';
    v_Body := v_Body ||
              '   <td colspan="2" nowrap>Projected GTO Rent<Br>Ԥ��Ӫҵ��</td>';
    v_Body := v_Body ||
              '   <td rowspan="2" nowrap>Projected GTO Rent<Br>Ԥ��������</td>';
    v_Body := v_Body || ' </tr>';
    v_Body := v_Body ||
              ' <tr style="background-color: #ecedef;" align="center">';
    v_Body := v_Body || '   <td>�O/��</td>';
    v_Body := v_Body || '  <td>[����]�O/��</td>';
    v_Body := v_Body || '   <td>����/��</td>';
    v_Body := v_Body || '   <td>�O/��</td>';
    v_Body := v_Body || '   <td>[����]�O/��</td>';
    v_Body := v_Body || '  <td>����/��</td>';
    v_Body := v_Body || '  <td>�O/��</td>';
    v_Body := v_Body || '  <td>[����]�O/��</td>';
    v_Body := v_Body || '  <td>�O/��</td>';
    v_Body := v_Body || '  <td>����/��</td>';
    v_Body := v_Body || ' </tr>';
  
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_Prl_Isf_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and lower(f.TBID) in ('tb_dtl10', 'tb_dtl30')
               order by f.TBID, f.yeartype) loop
      v_Body := ' <tr valign="top" style="background-color: white" align="center">';
      if lower(D.TbId) = 'tb_dtl10' then
        v_Body := v_Body || '<td nowrap> ��:' ||
                  to_char(D.Freerentdate1, 'YYYY.MM.DD') || '~' ||
                  to_char(D.Freerentdate2, 'YYYY.MM.DD') || ') </td>';
      else
        v_Body := v_Body || '<td nowrap> Yr ' || D.Yeartype || ' </td>';
      end if;
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Jtbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.pmfd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Jpmfd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.pmfm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Apfixed, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Japfixed, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap>' || D.Gto || '%</td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Progtod, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Progtom, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap>' ||
                   to_char(D.Progtorent, 'FM999999999990.9990') || '</td>';
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
    for U in (select hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1
                         and t.ExecGid <> R.Fillusrgid)) loop
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
create or replace procedure P_PrlDZ_ISCF_doMail(p_FlowGid varchar --����Gid
                                                ) as
begin
  P_PrlDZ_ISF_doMail(p_FlowGid);
end;
/
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
                         and t.Stat = 1
                         and t.ExecGid <> R.Fillusrgid)) loop
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
create or replace procedure P_PrlDZ_Pay_doMail(p_FlowGid varchar --����Gid
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
  for R in (select f.*, wm.name ModelName
              from wf_Prl_Pay f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := '�����������:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if R.Feeflowgid is not null then
      v_Body    := '[���õ���] : ' || R.Feenum || '-' || R.Partnum;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[�Ƿ�β��] : ';
      if R.Isend = 10 then
        v_Body := v_Body || '��';
      else
        v_Body := v_Body || '��';
      end if;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[��˾����] : ' || R.Companyname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��Ŀ����] : ' || R.acgonename || '-' || R.acgtwoname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[DOA��Ϣ] : ' || R.Doacode;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || nvl(R.payfee, 0) || 'Ԫ';
    if substr(R.Acgonename, 0, 1) = '3' then
      v_Body := v_Body || '(��˾�е���' || nvl(R.Npayfee, 0) || 'Ԫ)';
    end if;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Ҫ��֧����ʽ] : ' || R.Payway;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�����(��д)] : ' || R.Bigrmb;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[���ע] :' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�տλ] : ' || R.Payee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if R.Feeflowgid is not null then
      v_Body    := '[��A����Ŀ�ܶ�] : ' || R.feea;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��B���Ѹ�����] : ' || R.Feeb;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��C�����θ���] : ' || R.Payfee;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��Ƿ���=A-B-C] : ' || R.Feeleft;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[ʵ�ʸ����ܶ�=B+C] : ' || R.Feeok;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
  
    v_Content := v_Content || v_Foot;
    for U in (select hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1
                         and t.ExecGid <> R.Fillusrgid)) loop
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