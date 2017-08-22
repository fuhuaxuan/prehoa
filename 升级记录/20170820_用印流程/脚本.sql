---Ȩ��ִ�нű�
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--����ģ��Ȩ��
delete from rt where id in ('prl_stamp_app','prl_stamp_appsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_stamp_app','��ӡ��������','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_stamp_app','800425','��ӡ��������');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_stamp_appsave','��ӡ��������','DOA����','30','/bin/hdnet.dll/__explainmodule?url=prl_stamp_appsave','800426','��ӡ��������');

--��Ȩ��Ĭ�ϸ�����Ա��
--������ҵȨ��
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_stamp_app','prl_stamp_appsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_stamp_app','prl_stamp_appsave');

--�������ԱȨ��
delete from org_rt where entgid = v_EntGid and rtid in ('prl_stamp_app','prl_stamp_appsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_stamp_app','prl_stamp_appsave');

--������֯����Ȩ�ޱ�
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_stamp_app','prl_stamp_appsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_stamp_app','prl_stamp_appsave');

end;
/
commit;

create or replace view v_prl_flow as
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid  FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept     filldeptname
  from wf_prl_isf f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid  FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept     filldeptname
  from wf_prl_istf f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.filldeptgid,
       f.filldeptcode,
       f.filldeptname
  from wf_prl_oisf f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.filldeptgid,
       f.filldeptcode,
       f.filldeptname
  from wf_prl_oistf f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid  FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept     filldeptname
  from wf_prl_fee f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid  FillDeptGid,
       f.fillusrdeptcode FillDeptCode,
       f.fillusrdept     filldeptname
  from wf_prl_pay f
union
select f.entgid,
       f.flowgid,
       f.modelgid,
       f.num,
       f.stat,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.filldeptgid,
       f.filldeptcode,
       f.filldeptname
  from wf_prl_baoxiao f;

--��������ִ�нű�ģ�壺201403�棨���в�����ɾ����
--1�����������õ��Ĳ�������
declare
  v_EntGid varchar2(32);         --��ҵGid
  v_ModelGid varchar2(32);       --��������ģ��Gid
  v_ModelCode varchar2(32);      --��������ģ�ʹ���
  v_TaskGid varchar2(32);
  v_TaskGid_T1 varchar2(32);     --��ʼ����
  v_TaskGid_T2 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tend varchar2(32);   --��������
  v_Count int;
BEGIN
--2����ʼ����ֵ
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --��ȡ��ҵGid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--�޸���ҵCode

  --����ģ�ʹ���
  v_ModelCode := 'Prl_Stamp';

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
  select v_EntGid, v_ModelGid, v_ModelCode, '��ӡ��������', 3, '����', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '��ϸ', '�����жϲ鿴Ȩ��', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '��������д���뵥', '��д/�޸�', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '������','����', 1, 0, 0, 0 from dual;

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
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1 from dual;

--6�����幤�����̲�������

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_T2 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tend from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tend from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_T1 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;

--7��Ϊ����Ա�Լ������Ա����Ȩ��
--����Ȩ��  ���� ����Ȩ��  ���� ���Ȩ��  ���� ģ������Ȩ��  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select v_EntGid, v_ModelGid, gid, '1111' from org where EntGid = v_EntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;

--�汾�ţ�2014��3�·�;���в�����ɾ��			
drop table WF_Prl_Stamp;			
create table WF_Prl_Stamp (			
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
	mIsFlow	varchar2(32)	null,
	mModelCode	varchar2(64)	null,
	mFlowGid	varchar2(32)	null,
	mNum	varchar2(64)	null,
	--		
	ApplyType	varchar2(16)	null,
	StampType	varchar2(32)	null,
	ComGid	varchar2(32)	null,
	ComName	varchar2(64)	null,
	--�Ǻ�ͬ���ļ���ӡ		
	FilerName	varchar2(64)	null,
	FileName	varchar2(128)	null,
	FileCount	varchar2(32)	null,
	FileAim	varchar2(128)	null,
	ApplyState	varchar2(32)	null,
	--��ͬ���ļ���ӡ		
	ContractName	varchar2(256)	null,
	ContractCount	varchar2(32)	null,
	ContractFee	number(20,2)	null,
	ContactName	varchar2(128)	null,
	ContractDate1	date	null,
	ContractDate2	date	null,
	ComtractMemo	varchar2(2000)	null,
	Memo	varchar2(2000)	null,
	constraint PK_WF_Prl_Stamp primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_Prl_Stamp UNIQUE(Num)		
	);		
create index idx_WF_Prl_Stamp_1 on WF_Prl_Stamp(FillUsrGid);			
			
drop table WF_Prl_Stamp_App;			
create table WF_Prl_Stamp_App (			
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
	constraint PK_WF_Prl_Stamp_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_Prl_Stamp_Attach;			
create table WF_Prl_Stamp_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	AttachTitle	varchar2(256)	null,
	AttachUrl	varchar2(1024)	null,
	AttachSize	int	null,
	constraint PK_WF_Prl_Stamp_Attach primary key(EntGid, FlowGid, Gid)		
	);		
			
			
			
			
drop table Prl_Stamp_App;			
create table Prl_Stamp_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	Line	int	null,
	StampType	varchar2(32)	null,
	ComGid	varchar2(32)	null,
	ComCode	varchar2(64)	null,
	ComName	varchar2(64)	null,
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_Prl_Stamp_App primary key(EntGid, Gid)		
	);		
			
create or replace procedure P_Prl_Stamp_doMail(p_FlowGid varchar --����Gid
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
              from wf_Prl_Stamp f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid��' || R.Flowgid || '��ģ�ͣ�' || R.ModelName;
    v_Title   := '��ӡ��������:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[��������] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[������] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ʱ��] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
  
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[�Ƿ��������] : ' || R.mIsFlow || '������' || R.mNum || '��';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��������] : ' || R.ApplyType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[����ӡ������] : ' || R.StampType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[��˾����] : ' || R.ComName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    if R.ApplyType = '�Ǻ�ͬ���ļ���ӡ' then
      v_Body    := '[�ļ����շ�����] : ' || R.FilerName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[�ļ�����] : ' || R.FileName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[�ļ�����] : ' || R.FileCount;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[�ļ�Ŀ��] : ' || R.FileAim;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��������������֤] : �ұ�֤�����ύ�����ڸ��µķǺ�ͬ���ļ��뱾������ע������һ��';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    if R.ApplyType = '��ͬǩ����ӡ' then
      v_Body    := '[��ͬ����] : ' || R.ContractName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��ͬ����] : ' || R.ContractCount;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��ͬ���] : ' || R.ContractFee;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[������˾] : ' || R.ContactName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��ͬ����] : ' || to_char(R.ContractDate1, 'YYYY.MM.DD') || '~' ||
                   to_char(R.ContractDate2, 'YYYY.MM.DD');
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[��ͬ��Ҫ] : ' || R.ComtractMemo;
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