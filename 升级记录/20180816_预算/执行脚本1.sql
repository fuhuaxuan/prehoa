--��������ִ�нű�ģ�壺201403�棨���в�����ɾ����
--1�����������õ��Ĳ�������
declare
  v_EntGid varchar2(32);         --��ҵGid
  v_ModelGid varchar2(32);       --��������ģ��Gid
  v_ModelCode varchar2(32);      --��������ģ�ʹ���
  v_TaskGid varchar2(32);
  v_TaskGid_T1 varchar2(32);     --��ʼ����
  v_TaskGid_T2 varchar2(32);
  v_TaskGid_Th6 varchar2(32);
  v_TaskGid_Th7 varchar2(32);
  v_TaskGid_Th9 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tend varchar2(32);   --��������
  v_Count int;
BEGIN
--2����ʼ����ֵ
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_Th6 := sys_guid();
  v_TaskGid_Th7 := sys_guid();
  v_TaskGid_Th9 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --��ȡ��ҵGid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--�޸���ҵCode

  --����ģ�ʹ���
  v_ModelCode := 'PrlDZ_AcgAdd';

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
  select v_EntGid, v_ModelGid, v_ModelCode, '��ĿԤ������������', 3, '��Ŀ��������', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '��ϸ', '�����жϲ鿴Ȩ��', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '��������д���뵥', '��д', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '������','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th6, v_ModelCode || '_Th6', '�����ܼ�','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th7, v_ModelCode || '_Th7', '�����ܼ�','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th9, v_ModelCode || '_Th9', 'CEO','����', 1, 0, 0, 0 from dual;

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
  select v_EntGid, v_ModelGid, v_TaskGid_Th6, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('rick.lu');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Th7, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('joyce.ong');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Th9, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('ivan.koh');

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
--�汾�ţ�2014��3�·�;���в�����ɾ��			
drop table WF_PrlDZ_AcgAdd;			
create table WF_PrlDZ_AcgAdd (			
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
	ComGid	varchar2(32)	null,
	ComName	varchar2(256)	null,
	TotalFee	Number(20,2)	null,
	Memo	varchar2(4000)	null,
	constraint PK_WF_PrlDZ_AcgAdd primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlDZ_AcgAdd UNIQUE(Num)		
	);		
create index idx_WF_PrlDZ_AcgAdd_1 on WF_PrlDZ_AcgAdd(FillUsrGid);			
			
drop table WF_PrlDZ_AcgAdd_Dtl;			
create table WF_PrlDZ_AcgAdd_Dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Line	int	null,
	PAcgGid	varchar2(32)	null,
	PAcgCode	number	null,
	PAcgName	varchar2(128)	null,
	AcgGid	varchar2(32)	null,
	AcgCode	number	null,
	AcgName	varchar2(128)	null,
	AcgFee	Number(20,2)	null,
	LeftFee	Number(20,2)	null,
	ApplyFee	Number(20,2)	null,
	Memo	varchar2(2000)	null,
	constraint PK_WF_PrlDZ_AcgAdd_Dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table WF_PrlDZ_AcgAdd_App;			
create table WF_PrlDZ_AcgAdd_App (			
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
	constraint PK_WF_PrlDZ_AcgAdd_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlDZ_AcgAdd_Attach;			
create table WF_PrlDZ_AcgAdd_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlDZ_AcgAdd_Attach primary key(EntGid, FlowGid, Attach_Gid)		
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
  v_TaskGid_Th6 varchar2(32);
  v_TaskGid_Th7 varchar2(32);
  v_TaskGid_Th9 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tend varchar2(32);   --��������
  v_Count int;
BEGIN
--2����ʼ����ֵ
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_Th6 := sys_guid();
  v_TaskGid_Th7 := sys_guid();
  v_TaskGid_Th9 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --��ȡ��ҵGid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--�޸���ҵCode

  --����ģ�ʹ���
  v_ModelCode := 'PrlDZ_AcgChg';

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
  select v_EntGid, v_ModelGid, v_ModelCode, '��ĿԤ�����·�����������', 3, '��Ŀ��������', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '��ϸ', '�����жϲ鿴Ȩ��', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '��������д���뵥', '��д', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '������','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th6, v_ModelCode || '_Th6', '�����ܼ�','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th7, v_ModelCode || '_Th7', '�����ܼ�','����', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Th9, v_ModelCode || '_Th9', 'CEO','����', 1, 0, 0, 0 from dual;

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
  select v_EntGid, v_ModelGid, v_TaskGid_Th6, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('rick.lu');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Th7, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('joyce.ong');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Th9, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('ivan.koh');

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
--�汾�ţ�2014��3�·�;���в�����ɾ��			
drop table WF_PrlDZ_AcgChg;			
create table WF_PrlDZ_AcgChg (			
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
	ComGid	varchar2(32)	null,
	ComName	varchar2(256)	null,
	--		
	PAcgGid	varchar2(32)	null,
	PAcgCode	varchar2(32)	null,
	PAcgName	varchar2(128)	null,
	PAcgFee	Number(20,2)	null,
	ApplyFee	Number(20,2)	null,
	--		
	CAcgGid	varchar2(32)	null,
	CAcgCode	varchar2(32)	null,
	CAcgName	varchar2(128)	null,
	CAcgFee	Number(20,2)	null,
	Memo	varchar2(4000)	null,
	constraint PK_WF_PrlDZ_AcgChg primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlDZ_AcgChg UNIQUE(Num)		
	);		
create index idx_WF_PrlDZ_AcgChg_1 on WF_PrlDZ_AcgChg(FillUsrGid);			
			
drop table WF_PrlDZ_AcgChg_App;			
create table WF_PrlDZ_AcgChg_App (			
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
	constraint PK_WF_PrlDZ_AcgChg_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlDZ_AcgChg_Attach;			
create table WF_PrlDZ_AcgChg_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlDZ_AcgChg_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		

create or replace procedure P_PrlDZ_AcgAdd_doApp(p_EntGid    varchar2, --��ҵGid
                                                 p_ModelGid  varchar, --ģ��Gid
                                                 p_FlowGid   varchar, --����Gid
                                                 p_AppAssign varchar2 --���
                                                 ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrGid    varchar2(32); --�û�Gid
  v_ModelCode varchar2(32); --ģ�ʹ���
  v_DeptGid   varchar2(32); --��ǰ�û�����
  v_TotalFee  number(20, 4); --�����

begin
  commit;
  v_Stage := 'ȡ��������Ϣ';
  select f.fillusrgid, f.filldeptgid, f.totalFee
    into v_UsrGid, v_DeptGid, v_TotalFee
    from wf_PrlDZ_AcgAdd f
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
    insert into wf_PrlDZ_AcgAdd_App
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
             30 AppOrder,
             30 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 30
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
             o.AppGid,
             o.AppCode,
             o.AppName,
             60 AppOrder,
             60 AppType
        from v_wf_model_usr_app o
       where o.EntGid = p_EntGid
         and o.ModelGid = p_ModelGid
         and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
             ('_th6')
         and rownum = 1
      union
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             o.AppGid,
             o.AppCode,
             o.AppName,
             70 AppOrder,
             70 AppType
        from v_wf_model_usr_app o
       where o.EntGid = p_EntGid
         and o.ModelGid = p_ModelGid
         and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
             ('_th7')
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
    delete from wf_PrlDZ_AcgAdd_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_AcgAdd_App t
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
                          from wf_PrlDZ_AcgAdd_App t
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
create or replace procedure P_PrlDZ_AcgAdd_doMail(p_FlowGid varchar --����Gid
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
              from Wf_PrlDZ_AcgAdd f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := 'Ԥ����:' || R.Filldeptname;
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
    v_Body    := v_Body || '<col style="padding-left:4px;width:55%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:15%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:15%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:15%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>��Ŀ��Ϣ</td>';
    v_Body    := v_Body || '<td>����ܷ���</td>';
    v_Body    := v_Body || '<td>ʣ��Ԥ��</td>';
    v_Body    := v_Body || '<td>��������Ԥ��[Ԫ]</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_PrlDZ_AcgAdd_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid) loop
      v_Body    := '<tr valign="top" style="background-color: white">';
      v_Body    := v_Body || '<td>[' || D.Acgcode || ']' || D.Acgname ||
                   '</td>';
      v_Body    := v_Body || '<td align="center">' || D.Acgfee || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.Leftfee || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.Applyfee || '</td>';
      v_Body    := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[����Ԥ�����] : ' || R.Totalfee || 'Ԫ';
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
create or replace procedure P_PrlDZ_AcgChg_doApp(p_EntGid    varchar2, --��ҵGid
                                                 p_ModelGid  varchar, --ģ��Gid
                                                 p_FlowGid   varchar, --����Gid
                                                 p_AppAssign varchar2 --���
                                                 ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_UsrGid    varchar2(32); --�û�Gid
  v_ModelCode varchar2(32); --ģ�ʹ���
  v_DeptGid   varchar2(32); --��ǰ�û�����
  v_TotalFee  number(20, 4); --�����
  v_CFee      number(20, 2);
  v_DFee      number(20, 2);

begin
  commit;
  v_Stage := 'ȡ��������Ϣ';
  select f.fillusrgid, f.filldeptgid, f.ApplyFee, nvl(a.C, 0), nvl(a.D, 0)
    into v_UsrGid, v_DeptGid, v_TotalFee, v_CFee, v_DFee
    from wf_PrlDZ_AcgChg f, Prl_Acg a
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid
     and f.PAcgGid = a.Gid;

  v_Stage := 'ȡ��ģ����Ϣ';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '��ֹ' then
    --����������
    insert into wf_PrlDZ_AcgChg_App
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
             30 AppOrder,
             30 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 30
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
             o.AppGid,
             o.AppCode,
             o.AppName,
             60 AppOrder,
             60 AppType
        from v_wf_model_usr_app o
       where o.EntGid = p_EntGid
         and o.ModelGid = p_ModelGid
         and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
             ('_th6')
         and rownum = 1
      union
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             o.AppGid,
             o.AppCode,
             o.AppName,
             70 AppOrder,
             70 AppType
        from v_wf_model_usr_app o
       where o.EntGid = p_EntGid
         and o.ModelGid = p_ModelGid
         and replace(lower(o.Modelcode), lower(v_ModelCode), '') in
             ('_th7')
         and rownum = 1
         and v_TotalFee > v_CFee
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
         and v_TotalFee > v_CFee
      union
      select p_EntGid,
             p_ModelGid,
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
         and v_TotalFee > v_DFee;

    commit;
    --ȡ�����������ظ���������
    delete from wf_PrlDZ_AcgChg_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select max(t.appType) appType,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_AcgChg_App t
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
                          from wf_PrlDZ_AcgChg_App t
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
create or replace procedure P_PrlDZ_AcgChg_doMail(p_FlowGid varchar --����Gid
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
              from Wf_PrlDZ_AcgChg f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := 'Ԥ����:' || R.Filldeptname;
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
    v_Body    := '[����ǰ��Ŀ] : [' || R.PAcgCode || ']' || R.PAcgName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�������Ŀ] : [' || R.CAcgCode || ']' || R.CAcgName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[���η���Ԥ��] : ' || R.ApplyFee || 'Ԫ';
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

alter table prl_acg add A Int;
alter table prl_acg add B Int;
alter table prl_acg add C Int;
alter table prl_acg add D Int;


update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '1.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '1.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '1.03';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '2.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '2.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '2.03';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '3.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '3.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '3.03';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '3.04';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.03';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.04';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.05';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.06';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.07';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.08';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.09';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.1';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.11';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.12';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.13';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.14';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.15';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '4.16';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '5.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '5.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.03';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.04';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.05';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.06';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '6.07';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.01';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.03';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.04';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.05';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.06';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.07';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.08';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.09';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '7.1';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.01';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.02';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.03';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.04';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.05';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.06';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.07';
update prl_acg set (c,d) = (select '250000','500000' from dual) where code = '8.08';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.01';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.02';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '9.03';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.04';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.05';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.06';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.07';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.08';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '9.09';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '9.1';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '9.11';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '9.12';
update prl_acg set (c,d) = (select '100000','400000' from dual) where code = '9.13';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.14';
update prl_acg set (c,d) = (select '500000','2000000' from dual) where code = '9.15';
commit;
create or replace view v_prl_acg_fee as
select c.EntGid,
       c.Gid,
       c.Year,
       c.COMPANYGid ComGid,
       o.name ComName,
       c.ACGGID,
       a.code AcgCode,
       a.name AcgName,
       nvl(c.LeftBudgutFee, 0) LeftFee,
       nvl(f.applyFee, 0) + nvl(b.applyFee, 0) + nvl(p.applyFee, 0) +
       nvl(h.applyFee, 0) YesFee,
       nvl(f.applyFee, 0) FYesFee,
       nvl(b.applyFee, 0) BYesFee,
       nvl(p.applyFee, 0) PYesFee,
       nvl(h.applyFee, 0) hYesFee,
       nvl(f1.applyFee, 0) + nvl(b1.applyFee, 0) + nvl(p1.applyFee, 0) +
       nvl(h1.applyFee, 0) AllFee,
       nvl(f1.applyFee, 0) FAllFee,
       nvl(b1.applyFee, 0) BAllFee,
       nvl(p1.applyFee, 0) PAllFee,
       nvl(h1.applyFee, 0) HAllFee,
       nvl(t.opcfee, 0) OpFee
  from PRL_ACG_COMPANY c,
       prl_acg a,
       prl_company o,
       (select b.*
          from (select r.entgid, r.comacggid, r.year, min(r.opdate) opdate
                  from PRL_DOA_Rcd r
                 where r.oppfee = 0
                   and r.opusrname = 'sys'
                 group by r.entgid, r.comacggid, r.year) a,
               PRL_DOA_Rcd b
         where a.entgid = b.entgid
           and a.comacggid = b.comacggid
           and a.year = b.year
           and a.opdate = b.opdate) t,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(confirmfee, askfee)) applyFee,
               '���õ�' atype
          from wf_prl_fee f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat < 3
           and f.stat not in ('13', '100', '��ֹ')
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) f,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(confirmfee, askfee)) applyFee,
               '���õ�' atype
          from wf_prl_fee f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat = 3
           and f.stat not in ('13', '100', '��ֹ')
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) f1,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               fd.acggid acggid,
               f.comgid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               '���˱�����' atype
          from wf_prl_baoxiao f, wf_prl_baoxiao_dtl fd, wf_flow wf
         where f.entgid = wf.entgid
           and f.entgid = fd.entgid
           and f.flowgid = wf.flowgid
           and f.flowgid = fd.flowgid
           and wf.stat < 3
           and f.stat not in ('��ֹ')
           and f.istake is null
         group by f.entgid,
                  fd.acggid,
                  f.comgid,
                  to_char(f.createdate, 'YYYY')) b,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               fd.acggid acggid,
               f.comgid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               '���˱�����' atype
          from wf_prl_baoxiao f, wf_prl_baoxiao_dtl fd, wf_flow wf
         where f.entgid = wf.entgid
           and f.entgid = fd.entgid
           and f.flowgid = wf.flowgid
           and f.flowgid = fd.flowgid
           and wf.stat = 3
           and f.stat not in ('��ֹ')
           and f.istake is null
         group by f.entgid,
                  fd.acggid,
                  f.comgid,
                  to_char(f.createdate, 'YYYY')) b1,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(payfee, 0)) applyFee,
               '���' atype
          from WF_PRL_PAY f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat < 3
           and f.stat not in ('13', '100', '��ֹ')
           and f.feeflowgid is null
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) p,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.acgtwogid acggid,
               f.companygid comgid,
               sum(nvl(payfee, 0)) applyFee,
               '���' atype
          from WF_PRL_PAY f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat = 3
           and f.stat not in ('13', '100', '��ֹ')
           and f.feeflowgid is null
         group by f.entgid,
                  f.acgtwogid,
                  f.companygid,
                  to_char(f.createdate, 'YYYY')) p1,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.pAcgGid acggid,
               f.comGid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               'Ԥ�����' atype
          from WF_PRLDZ_AcgChg f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat < 3
           and f.stat not in ('��ֹ')
         group by f.entgid,
                  f.pAcgGid,
                  f.comGid,
                  to_char(f.createdate, 'YYYY')) h,
       (select f.entgid,
               to_char(f.createdate, 'YYYY') Year,
               f.pAcgGid acggid,
               f.comGid comgid,
               sum(nvl(ApplyFee, 0)) applyFee,
               'Ԥ�����' atype
          from WF_PRLDZ_AcgChg f, wf_flow wf
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and wf.stat = 3
           and f.stat not in ('��ֹ')
         group by f.entgid,
                  f.pAcgGid,
                  f.comGid,
                  to_char(f.createdate, 'YYYY')) h1
 where c.entgid = a.entgid
   and c.entgid = o.entgid
   and c.acggid = a.gid
   and c.companygid = o.gid
   and c.entgid = f.entgid(+)
   and c.Year = f.year(+)
   and c.COMPANYGid = f.comgid(+)
   and c.acggid = f.acggid(+)
   and c.entgid = b.entgid(+)
   and c.Year = b.year(+)
   and c.COMPANYGid = b.comgid(+)
   and c.acggid = b.acggid(+)
   and c.entgid = p.entgid(+)
   and c.Year = p.year(+)
   and c.COMPANYGid = p.comgid(+)
   and c.acggid = p.acggid(+)
   and c.entgid = f1.entgid(+)
   and c.Year = f1.year(+)
   and c.COMPANYGid = f1.comgid(+)
   and c.acggid = f1.acggid(+)
   and c.entgid = b1.entgid(+)
   and c.Year = b1.year(+)
   and c.COMPANYGid = b1.comgid(+)
   and c.acggid = b1.acggid(+)
   and c.entgid = p1.entgid(+)
   and c.Year = p1.year(+)
   and c.COMPANYGid = p1.comgid(+)
   and c.acggid = p1.acggid(+)
   and c.entgid = t.entgid(+)
   and c.gid = t.comacggid(+)
   and c.year = t.year(+)  
   and c.entgid = h.entgid(+)
   and c.Year = h.year(+)
   and c.COMPANYGid = h.comgid(+)
   and c.acggid = h.acggid(+)
   and c.entgid = h1.entgid(+)
   and c.Year = h1.year(+)
   and c.COMPANYGid = h1.comgid(+)
   and c.acggid = h1.acggid(+);
