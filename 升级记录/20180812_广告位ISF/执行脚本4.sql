create or replace procedure P_PrlGG_ISF_doApp(p_EntGid    varchar2, --��ҵGid
                                              p_ModelGid  varchar, --ģ��Gid
                                              p_FlowGid   varchar, --����Gid
                                              p_AppAssign varchar2 --���
                                              ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrGid    varchar2(32); --�û�Gid
  v_ModelCode varchar2(32); --ģ�ʹ���
  v_DeptGid   varchar2(32); --��ǰ�û�����
  v_TotalFee   number(20,4); --�����

begin
  commit;

  v_Stage := 'ȡ��������Ϣ';
  select f.fillusrgid, f.filldeptgid,f.TotalFee
    into v_UsrGid, v_DeptGid,v_TotalFee
    from wf_PrlGG_ISF f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := 'ȡ��ģ����Ϣ';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '��ֹ' then
    --����������
    insert into wf_PrlGG_ISF_App
      (EntGid,
       FlowGid,
       dtlGid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             10 AppOrder,
             10 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 10
         and rownum = 1
      union
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             30 AppOrder,
             30 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 30
         and rownum = 1
      union
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             40 AppOrder,
             40 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 40
         and rownum = 1
      union
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             50 AppOrder,
             50 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 71
         and rownum = 1
         and v_TotalFee > 0
      union
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             60 AppOrder,
             60 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 50
         and rownum = 1
         and v_TotalFee > 0
      union
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             80 AppOrder,
             80 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 80
         and rownum = 1
         and v_TotalFee > 10000
      union
      select p_EntGid,
             p_FlowGid,
             sys_guid(),
             o.AppGid,
             o.AppCode,
             o.AppName,
             90 AppOrder,
             90 AppType
        from v_wf_model_usr_app o
       where o.EntGid = p_EntGid
         and o.ModelGid = p_ModelGid
         and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
             ('_th9')
         and rownum = 1
         and v_TotalFee > 10000;
  
    commit;
    --ȡ�����������ظ���������
    delete from wf_PrlGG_ISF_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlGG_ISF_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.appType = a.appType);
    v_Stage := '����������';
    if p_AppAssign = '�ύ' then
      insert into WF_Task
        (EntGid,
         ModelGid,
         FlowGid,
         TaskDefGid,
         TaskGid,
         Stat,
         Code,
         Name,
         Note,
         ExecGid,
         ExecCode,
         ExecName,
         OrderValue,
         IsMCF)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               d.TaskDefGid,
               sys_guid(),
               1,
               d.code,
               d.name,
               d.note,
               a.AppGid,
               a.AppCode,
               a.AppName,
               d.OrderValue,
               d.IsMCF
          from WF_Task_Define d,
               (select *
                  from (select *
                          from wf_PrlGG_ISF_App t
                         where t.entgid = p_EntGid
                           and t.flowgid = p_FlowGid
                           and t.AppOrder <= 100
                           and t.AppDate is null
                         order by t.Apporder)
                 where rownum = 1) a
         where d.EntGid = p_EntGid
           and d.ModelGid = p_ModelGid
           and replace(lower(d.code), lower(v_ModelCode), '') in ('_t2')
           and not exists (select 1
                  from wf_task t
                 where t.entgid = p_EntGid
                   and t.flowgid = p_FlowGid
                   and t.TaskDefGid = d.taskdefgid
                   and t.ExecGid = a.AppGid
                   and t.stat = 1);
    end if;
  end if;
  commit;
  --�쳣����
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('����Gid:' || p_FlowGid || ';�û�Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' ʧ��!' || SQLCode || ':' || SQLERRM,
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
    v_Body    := '[���] : ' || R.Atype;
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
    v_Body    := '[B����ͬ��Ϣ] : ' ;
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
    v_Body    := '[���ʽ] : ' || R.Rate;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Ԥ�����+����] : ' || R.AGR;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��֤��] : ' || R.Security;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��ʽ] : ' || R.Incash;
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
    v_Body    := v_Body || '    <td nowrap>Yr��</td>';
    v_Body    := v_Body || '    <td nowrap>���</td>';
    v_Body    := v_Body || '    <td nowrap>Ԫ/��</td>';
    v_Body    := v_Body || '    <td nowrap>Ԫ/��</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from wf_PrlGG_ISF_Dtl f
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
      v_Body    := v_Body || '  <td nowrap> �̶���� </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrm, 'FM999999999990.9990') || ' </td>';
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
    v_Body    := '[�ر�����/����] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select distinct hr.Email
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
create or replace procedure P_PrlGG_ISCF_doApp(p_EntGid    varchar2, --��ҵGid
                                              p_ModelGid  varchar, --ģ��Gid
                                              p_FlowGid   varchar, --����Gid
                                              p_AppAssign varchar2 --���
                                              ) as
begin
  P_PrlGG_ISF_doApp(p_EntGid, p_ModelGid, p_FlowGid, p_AppAssign);
end;
/
create or replace procedure P_PrlGG_ISCF_doMail(p_FlowGid varchar --����Gid
                                                ) as
begin
  P_PrlGG_ISF_doMail(p_FlowGid);
end;
/