drop table WF_PrlGG_ISTF;			
create table WF_PrlGG_ISTF (			
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
	OldFlowGid	varchar2(32)	null,
	category	varchar2(32)	null,
	categorytext	varchar2(128)	null,
	Terminationdate	date	null,
	lessee	varchar2(512)	null,
	Tradingname	varchar2(1024)	null,
	Remarks	varchar2(4000)	null,
	--		
	DataASum	NUMBER(20,4)	null,
	DataBSum	NUMBER(20,4)	null,
	DataCSum	NUMBER(20,4)	null,
	DataDSum	NUMBER(20,4)	null,
	DataESum	NUMBER(20,4)	null,
	--		
	NumA	NUMBER	null,
	NumB	NUMBER	null,
	NumC	NUMBER	null,
	NumD	NUMBER	null,
	NumE	NUMBER	null,
	NumF	NUMBER	null,
	NumG	NUMBER	null,
	NumSum	NUMBER(20,4)	null,
	--		
	EndMemo	varchar2(2000)	null,
	constraint PK_WF_PrlGG_ISTF primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlGG_ISTF UNIQUE(Num)		
	);		
create index idx_WF_PrlGG_ISTF_fillgid on WF_PrlGG_ISTF(FillUsrGid);			
			
drop table WF_PrlGG_ISTF_dtl;			
create table WF_PrlGG_ISTF_dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Line	varchar2(32)	null,
	DataName	varchar2(32)	null,
	DataA	NUMBER	null,
	DataB	NUMBER	null,
	DataC	NUMBER	null,
	DataD	NUMBER	null,
	DataE	NUMBER	null,
	Memo	VARCHAR2(2000)	null,
	constraint PK_WF_PrlGG_ISTF_dtl primary key(EntGid, FlowGid, Gid)		
	);		
--��������ִ�нű�ģ�壺201403�棨���в�����ɾ����
--1�����������õ��Ĳ�������
declare
  v_EntGid varchar2(32);         --��ҵGid
  v_ModelGid varchar2(32);       --��������ģ��Gid
  v_ModelCode varchar2(32);      --��������ģ�ʹ���
  v_TaskGid varchar2(32);
  v_TaskGid_T1 varchar2(32);     --��ʼ����
  v_TaskGid_T2 varchar2(32);
  v_TaskGid_Th9 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tend varchar2(32);   --��������
  v_Count int;
BEGIN
--2����ʼ����ֵ
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_Th9 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --��ȡ��ҵGid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--�޸���ҵCode

  --����ģ�ʹ���
  v_ModelCode := 'PrlGG_ISTF';

  --ȡ����ǰģ�ʹ����Ӧģ�͵�����
  select count(*) into v_Count from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  
  --��ȡģ��Gid
  if v_Count = 0 then
    v_ModelGid := sys_guid();
  else
    select ModelGid into v_ModelGid from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  end if;

--3��ɾ������������Ϣ
  delete from WF_Model where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_rt where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Flow where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task_History where EntGid = v_EntGid and ModelGid = v_ModelGid;

--4�����幤���������� �������
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  select v_EntGid, v_ModelGid, v_ModelCode, '���λISTF', 3, '��Ŀ��������', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '��ϸ', '�����жϲ鿴Ȩ��', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '��������д���뵥', '��д', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '������','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th9, v_ModelCode || '_Th9', '�����ܼ�','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode||'_Tcc', '�������Ķ�', '����', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tend, v_ModelCode || '_Tend', '������ֹ', '����һ������', 1, 0, 1, 0 from dual;

--5�����幤�����̲���ִ����

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, '**FlowMember**', '**FlowMember**', '@���̲�����@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('all_usr_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Th9, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('joyce.ong');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1 from dual;

--6�����幤�����̲�������

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_T2 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tend from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_T1 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tend from dual;

--7��Ϊ����Ա�Լ������Ա����Ȩ��
--����Ȩ��  ���� ����Ȩ��  ���� ���Ȩ��  ���� ģ������Ȩ��  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select v_EntGid, v_ModelGid, gid, '1111' from org where EntGid = v_EntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;
create or replace procedure P_PrlGG_ISTF_doApp(p_EntGid    varchar2, --��ҵGid
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
    from wf_PrlGG_ISTF f
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
         and rownum = 1;
  
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
