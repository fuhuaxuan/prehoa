create or replace procedure P_PrlDZ_SOS_doMail(p_FlowGid varchar --����Gid
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
              from wf_PrlDZ_Sos f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := 'SOS��������:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body    := '[��������] : ' || R.ApplyType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.SosType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if R.ApplyType = '���' then
      v_Body    := '[����ǰ] : ';
      v_Body    := v_Body ||
                   '<table width="100%" cellpadding="0"  cellspacing="1" style="background-color: #d9dbdf;">';
      v_Body    := v_Body || '  <colgroup>';
      v_Body    := v_Body || '    <col style="width:10%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '  </colgroup>';
      v_Body    := v_Body || '  <thead>';
      v_Body    := v_Body ||
                   '  <tr style="background-color: #ecedef;" align="center">';
      v_Body    := v_Body || '    <td>���</td>';
      v_Body    := v_Body || '    <td>��λ</td>';
      v_Body    := v_Body || '    <td>¥��</td>';
      v_Body    := v_Body || '    <td>���</td>';
      v_Body    := v_Body || '    <td>�������</td>';
      v_Body    := v_Body || '    <td>Ԥ�㵥��<br>���+���+�ƹ�</td>';
      v_Body    := v_Body || '    <td>�������</td>';
      v_Body    := v_Body || '  </tr>';
      v_Body    := v_Body || '  </thead>';
      v_Body    := v_Body || '  <tbody>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    
      for D in (select f.*
                  from Wf_PrlDZ_SOS_Dtl f
                 where f.EntGid = v_EntGid
                   and f.FlowGid = p_FlowGid
                   and f.aType = '10'
                 order by f.Line) loop
        v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
        v_Body    := v_Body || '<td align="center">' || D.Line || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fNo || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.floorNo || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fArea || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.jArea || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fmr || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fmrM || '</td>';
        v_Body    := v_Body || ' </tr>';
        v_Content := v_Content || v_Body;
      end loop;
      v_Body    := '  </tbody>';
      v_Body    := v_Body || '  <tfoot>';
      v_Body    := v_Body || '  <tr style="background-color: white">';
      v_Body    := v_Body || '    <td align="right" colspan="3">�ϼƣ�</td>';
      v_Body    := v_Body || '    <td align="center">' || R.fAreaSum1 ||
                   '</td>';
      v_Body    := v_Body || '    <td align="center">' || R.jAreaSum1 ||
                   '</td>';
      v_Body    := v_Body || '    <td align="center"></td>';
      v_Body    := v_Body || '    <td align="center"></td>';
      v_Body    := v_Body || '  </tr>';
      v_Body    := v_Body || '  </tfoot>';
      v_Body    := v_Body || '</table>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[������] : ';
    v_Body    := v_Body ||
                 '<table width="100%" cellpadding="0"  cellspacing="1" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '  <colgroup>';
    v_Body    := v_Body || '    <col style="width:10%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '  </colgroup>';
    v_Body    := v_Body || '  <thead>';
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '    <td>���</td>';
    v_Body    := v_Body || '    <td>��λ</td>';
    v_Body    := v_Body || '    <td>¥��</td>';
    v_Body    := v_Body || '    <td>���</td>';
    v_Body    := v_Body || '    <td>�������</td>';
    v_Body    := v_Body || '    <td>Ԥ�㵥��<br>���+���+�ƹ�</td>';
    v_Body    := v_Body || '    <td>�������</td>';
    v_Body    := v_Body || '  </tr>';
    v_Body    := v_Body || '  </thead>';
    v_Body    := v_Body || '  <tbody>';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    for D in (select f.*
                from Wf_PrlDZ_SOS_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and f.aType = '20'
               order by f.Line) loop
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '<td align="center">' || D.Line || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.fNo || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.floorNo || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.fArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.jArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.fmr || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fmrM || '</td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
    end loop;
    v_Body    := '  </tbody>';
    v_Body    := v_Body || '  <tfoot>';
    v_Body    := v_Body || '  <tr style="background-color: white">';
    v_Body    := v_Body || '    <td align="right" colspan="3">�ϼƣ�</td>';
    v_Body    := v_Body || '    <td align="center">' || R.fAreaSum2 ||
                 '</td>';
    v_Body    := v_Body || '    <td align="center">' || R.jAreaSum2 ||
                 '</td>';
    v_Body    := v_Body || '    <td align="center"></td>';
    v_Body    := v_Body || '    <td align="center"></td>';
    v_Body    := v_Body || '  </tr>';
    v_Body    := v_Body || '  </tfoot>';
    v_Body    := v_Body || '</table>';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ע] : ' || R.Memo;
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
