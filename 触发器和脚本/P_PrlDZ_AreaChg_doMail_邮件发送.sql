create or replace procedure P_PrlDZ_AreaChg_doMail(p_FlowGid varchar --����Gid
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
              from wf_PrlDZ_Area f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := '��Ŀ����:' || R.Filldeptname;
    v_Content := v_Content || v_Head;

    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��Ŀ] : ' || R.ProjectName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�걨����] : ' || to_char(R.AddDate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�������] : ' || to_char(R.ChgDate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '������Ϣ : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:5%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:30%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:10%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:10%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:10%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:23%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:23%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>�к�</td>';
    v_Body    := v_Body || '<td>��Ŀ</td>';
    v_Body    := v_Body || '<td>�걨���</td>';
    v_Body    := v_Body || '<td>������</td>';
    v_Body    := v_Body || '<td>����</td>';
    v_Body    := v_Body || '<td>�걨��ע</td>';
    v_Body    := v_Body || '<td>�����ע</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;

    for D in (select f.*
                from wf_PrlDZ_Area_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and f.Atype = 1) loop
      v_Body    := '<tr valign="top" style="background-color: white">';
      v_Body    := v_Body || '<td align="center">' || D.Line || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.Name || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.AddArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.ChgArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.DiffArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.AddMemo || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.ChgMemo || '</td>';
      v_Body    := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
    v_Body    := '</table>';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;

    v_Body    := '������Ϣ : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:5%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:30%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:10%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:10%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:10%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:23%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:23%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>�к�</td>';
    v_Body    := v_Body || '<td>��Ŀ</td>';
    v_Body    := v_Body || '<td>�걨���</td>';
    v_Body    := v_Body || '<td>������</td>';
    v_Body    := v_Body || '<td>����</td>';
    v_Body    := v_Body || '<td>�걨��ע</td>';
    v_Body    := v_Body || '<td>�����ע</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;

    for D in (select f.*
                from wf_PrlDZ_Area_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and f.Atype = 2) loop
      v_Body    := '<tr valign="top" style="background-color: white">';
      v_Body    := v_Body || '<td align="center">' || D.Line || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.Name || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.AddArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.ChgArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.DiffArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.AddMemo || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.ChgMemo || '</td>';
      v_Body    := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
    v_Body    := '</table>';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;

    v_Body    := '[�걨��ע] : ' || R.AddMemo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�����ע] : ' || R.ChgMemo;
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