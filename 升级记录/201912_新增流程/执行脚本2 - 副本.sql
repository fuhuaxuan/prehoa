
--�汾�ţ�2014��3�·�;���в�����ɾ��			
drop table WF_PrlDZ_AreaAdd;	
drop table WF_PrlDZ_AreaAdd_Dtl;
drop table WF_PrlDZ_AreaAdd_App;
drop table WF_PrlDZ_AreaAdd_Attach;
drop table PrlDZ_AreaSet;

--�汾�ţ�2014��3�·�;���в�����ɾ��			
drop table WF_PrlDZ_Area;			
create table WF_PrlDZ_Area (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Num	varchar2(32)	null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	Stat	varchar2(32)	null,
	--		
	FillUsrGid	varchar2(32)	null,
	FillUsrCode	varchar2(64)	null,
	FillUsrName	varchar2(64)	null,
	FillDeptGid	varchar2(32)	null,
	FillDeptCode	varchar2(64)	null,
	FillDeptName	varchar2(64)	null,
	--		
	EndMemo	varchar2(2000)	null,
	--		
	ProjectName	varchar2(128)	null,
	AddDate	date	null,
	AddArea1	number(20,2)	null,
	AddArea2	number(20,2)	null,
	ChgDate	date	null,
	ChgArea1	number(20,2)	null,
	ChgArea2	number(20,2)	null,
	Memo	varchar2(4000)	null,
	--		
	RootFlowGid	varchar2(32)	null,
	OldFlowGid	varchar2(32)	null,
	constraint PK_WF_PrlDZ_Area primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlDZ_Area UNIQUE(Num)		
	);		
create index idx_WF_PrlDZ_Area_1 on WF_PrlDZ_Area(FillUsrGid);			
			
drop table WF_PrlDZ_Area_Dtl;			
create table WF_PrlDZ_Area_Dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Line	int	null,
	Atype	int	null,
	Name	varchar2(128)	null,
	AddArea	Number(20,2)	null,
	ChgArea	Number(20,2)	null,
	DiffArea	Number(20,2)	null,
	Memo	varchar2(2000)	null,
	constraint PK_WF_PrlDZ_Area_Dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table WF_PrlDZ_Area_App;			
create table WF_PrlDZ_Area_App (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	AppGid	varchar2(32)	null,
	AppCode	varchar2(64)	null,
	AppName	varchar2(64)	null,
	AppDept	varchar2(64)	null,
	AppOrder	int	null,
	AppType	int	null,
	--		
	AppAssign	varchar2(64)	null,
	AppMemo	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_PrlDZ_Area_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlDZ_Area_Attach;			
create table WF_PrlDZ_Area_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlDZ_Area_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
			
			
drop table PrlDZ_Area;			
create table PrlDZ_Area (			
	EntGid 	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Name	varchar2(128)	null,
	Memo	varchar2(2000)	null,
	constraint PK_PrlDZ_Area primary key(EntGid, Gid)		
	);		


create or replace procedure P_PrlDZ_AreaAdd_doApp(p_EntGid    varchar2, --��ҵGid
                                                 p_ModelGid  varchar, --ģ��Gid
                                                 p_FlowGid   varchar, --����Gid
                                                 p_AppAssign varchar2 --���
                                                 ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrGid    varchar2(32); --�û�Gid
  v_ModelCode varchar2(32); --ģ�ʹ���
  v_DeptGid   varchar2(32); --��ǰ�û�����

begin
  commit;
  v_Stage := 'ȡ��������Ϣ';
  select f.fillusrgid, f.filldeptgid
    into v_UsrGid, v_DeptGid
    from wf_PrlDZ_Area f
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
    insert into wf_PrlDZ_Area_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
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
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             20 AppOrder,
             20 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 15
         and rownum = 1
      union
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             35 AppOrder,
             35 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 35
         and rownum = 1
      union
      select p_EntGid,
             p_ModelGid,
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
             p_ModelGid,
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
      union
      select p_EntGid,
             p_ModelGid,
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
      union
      select p_EntGid,
             p_ModelGid,
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
      union
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             92 AppOrder,
             92 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 92
         and rownum = 1
      union
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             o.AppGid,
             o.AppCode,
             o.AppName,
             95 AppOrder,
             95 AppType
        from v_wf_model_usr_app o
       where o.EntGid = p_EntGid
         and o.ModelGid = p_ModelGid
         and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
             ('_td1')
         and rownum = 1;

    commit;
    --ȡ�����������ظ���������
    delete from wf_PrlDZ_Area_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_Area_App t
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
                          from wf_PrlDZ_Area_App t
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

create or replace procedure P_PrlDZ_AreaAdd_doMail(p_FlowGid varchar --����Gid
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
    v_Body    := '������Ϣ : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:5%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:30%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:45%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>�к�</td>';
    v_Body    := v_Body || '<td>��Ŀ</td>';
    v_Body    := v_Body || '<td>'|| R.addDate ||'���</td>';
    v_Body    := v_Body || '<td>��ע</td>';
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
      v_Body    := v_Body || '<td align="center">' || D.Memo || '</td>';
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
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:45%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>�к�</td>';
    v_Body    := v_Body || '<td>��Ŀ</td>';
    v_Body    := v_Body || '<td>'|| R.addDate ||'�����</td>';
    v_Body    := v_Body || '<td>��ע</td>';
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
      v_Body    := v_Body || '<td align="center">' || D.Memo || '</td>';
      v_Body    := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
    v_Body    := '</table>';
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