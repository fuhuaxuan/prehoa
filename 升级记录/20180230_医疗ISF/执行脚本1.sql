--工作流程执行脚本模板：201403版（此行不允许删除）
--1、定义流程用到的参数名称
declare
  v_EntGid varchar2(32);         --企业Gid
  v_ModelGid varchar2(32);       --工作流程模型Gid
  v_ModelCode varchar2(32);      --工作流程模型代码
  v_TaskGid varchar2(32);
  v_TaskGid_T1 varchar2(32);     --开始步骤
  v_TaskGid_T2 varchar2(32);
  v_TaskGid_TA1 varchar2(32);
  v_TaskGid_TA2 varchar2(32);
  v_TaskGid_TA3 varchar2(32);
  v_TaskGid_TA4 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tend varchar2(32);   --结束步骤
  v_Count int;
BEGIN
--2、初始化赋值
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_TA1 := sys_guid();
  v_TaskGid_TA2 := sys_guid();
  v_TaskGid_TA3 := sys_guid();
  v_TaskGid_TA4 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --获取企业Gid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--修改企业Code

  --定义模型代码
  v_ModelCode := 'PrlYY_ISF';

  --取出当前模型代码对应模型的数量
  select count(*) into v_Count from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  
  --获取模型Gid
  if v_Count = 0 then
    v_ModelGid := sys_guid();
  else
    select ModelGid into v_ModelGid from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  end if;

--3、删除旧有数据信息
  delete from WF_Model where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_rt where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Flow where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task_History where EntGid = v_EntGid and ModelGid = v_ModelGid;

--4、定义工作流程名称 ，步骤等
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  select v_EntGid, v_ModelGid, v_ModelCode, '医疗ISF', 3, '医疗流程', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '明细', '用于判断查看权限', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '发起人填写申请单', '填写', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '请审批','审批', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_TA1, v_ModelCode || '_TA1', '院长','20', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_TA2, v_ModelCode || '_TA2', '医疗总经理','30', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_TA3, v_ModelCode || '_TA3', '医疗顾问','40', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_TA4, v_ModelCode || '_TA4', '医疗CEO','50', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode||'_Tcc', '抄送人阅读', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tend, v_ModelCode || '_Tend', '流程终止', '结束一个流程', 1, 0, 1, 0 from dual;

--5、定义工作流程步骤执行人

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, '**FlowMember**', '**FlowMember**', '@流程参与人@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('all_usr_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_TA1, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_TA2, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_TA3, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_TA4, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

--6、定义工作流程步骤走向

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

--7、为管理员以及相关人员设置权限
--监视权限  　　 作废权限  　　 变更权限  　　 模型设置权限  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select v_EntGid, v_ModelGid, gid, '1111' from org where EntGid = v_EntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;

drop table WF_PrlYY_ISF;			
create table WF_PrlYY_ISF (			
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
	Atype	varchar2(32)	null,
	Category	varchar2(32)	null,
	Dept	varchar2(128)	null,
	Unit	varchar2(4000)	null,
	Floor	varchar2(128)	null,
	Area	NUMBER	null,
	BuildArea	NUMBER	null,
	--		
	Lessee	varchar2(512)	null,
	Contactor	varchar2(64)	null,
	Address	varchar2(512)	null,
	Phone	varchar2(64)	null,
	Email	varchar2(64)	null,
	Fax	varchar2(64)	null,
	--		
	LeaseTermY	NUMBER	null,
	LeaseTermM	NUMBER	null,
	LeaseTermD	NUMBER	null,
	HandoverDate	date	null,
	FreeRentM	NUMBER	null,
	FreeRentD	NUMBER	null,
	FitoutM	NUMBER	null,
	fitoutD	NUMBER	null,
	FitoutDate1	date	null,
	FitoutDate2	date	null,
	ContractDate1	date	null,
	Contractdate2	date	null,
	--		
	Rate	varchar2(32)	null,
	Rate1	NUMBER	null,
	Rate2	NUMBER	null,
	Rate3	NUMBER	null,
	AGR	NUMBER	null,
	Security	NUMBER	null,
	Memo	varchar2(4000)	null,
	AttachType	varchar2(32)	null,
	--		
	EndMemo	varchar2(2000)	null,
	constraint PK_WF_PrlYY_ISF primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlYY_ISF UNIQUE(Num)		
	);		
create index idx_WF_PrlYY_ISF_fillgid on WF_PrlYY_ISF(FillUsrGid);			
			
drop table WF_PrlYY_ISF_dtl;			
create table WF_PrlYY_ISF_dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	TbID	varchar2(32)	null,
	YearType	int	null,
	FreeRentDate1	date	null,
	FreeRentDate2	date	null,
	--		
	TBRD	NUMBER	null,
	TBRM	NUMBER	null,
	PMFD	NUMBER	null,
	PMFM	NUMBER	null,
	ProGTOD	NUMBER	null,
	ProGTOM	NUMBER	null,
	constraint PK_WF_PrlYY_ISF_dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table wf_PrlYY_isf_ground;			
create table wf_PrlYY_isf_ground (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	fgid	varchar2(32)	not null,
	fno	varchar2(64)	not null,
	farea	NUMBER(24,4)	null,
	Jarea	NUMBER(24,4)	null,
	constraint PK_wf_PrlYY_isf_ground primary key(Gid)		
	);		
			
drop table wf_PrlYY_isf_Dept;			
create table wf_PrlYY_isf_Dept (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	mGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	Code	varchar2(32)	not null,
	Name	varchar2(64)	not null,
	constraint PK_wf_PrlYY_isf_Dept primary key(mGid)		
	);		

			
drop table WF_PrlYY_ISF_App;			
create table WF_PrlYY_ISF_App (			
	EntGid 	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	dtlgid	varchar2(32)	not null,
	--		
	appOrder	int	null,
	apptype	int	null,
	AppGid	varchar2(32)	null,
	AppCode	varchar2(64)	null,
	AppName	varchar2(64)	null,
	AppAssign	varchar2(64)	null,
	--		
	AppMemo	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_PrlYY_ISF_App primary key(EntGid, FlowGid,dtlGid)		
	);		
			
drop table WF_PrlYY_ISF_Attach;			
create table WF_PrlYY_ISF_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Type	int	null,
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlYY_ISF_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
			
			
drop table PrlYY_GROUNDH;			
create table PrlYY_GROUNDH (			
	fGid	varchar2(32)	not null,
	fNo	varchar2(64)	not null,
	fArea	NUMBER(24,2)	not null,
	Jarea	NUMBER(24,2)	null,
	floorno	VARCHAR2(16)	null,
	deptsource	varchar2(64)	null,
	--		
	OpType	varchar2(32)	null,
	OpDate	Date	null,
	OpGid	varchar2(32)	null,
	OpCode	varchar2(64)	null,
	OpName	varchar2(64)	null,
	constraint PK_PrlYY_GROUNDH primary key(fGid)		
	);		
			
drop table PrlYY_GROUNDH_Rcd;			
create table PrlYY_GROUNDH_Rcd (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	fGid	varchar2(32)	null,
	fNo	varchar2(32)	null,
	OpType	varchar2(32)	null,
	OpDate	Date	null,
	OpGid	varchar2(32)	null,
	OpCode	varchar2(64)	null,
	OpName	varchar2(64)	null,
	OpMemo	varchar2(4000)	null,
	constraint PK_PrlYY_GROUNDH_Rcd primary key(EntGid,Gid)		
	);		
			
drop table PrlYY_GROUNDH_Temp;			
create table PrlYY_GROUNDH_Temp (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Line	int	null,
	fGid	varchar2(32)	null,
	fno	varchar2(64)	null,
	farea	NUMBER(24,2)	null,
	Jarea	NUMBER(24,2)	null,
	deptsource	varchar2(64)	null,
	floorno	VARCHAR2(16)	null,
	ImportGid	varchar2(32)	null,
	constraint PK_PrlYY_GROUNDH_Temp primary key(EntGid,Gid)		
	);		
			
drop table PrlYY_Dept;			
create table PrlYY_Dept (			
	Gid	varchar2(32)	not null,
	code	VARCHAR2(16)	not null,
	name	varchar2(64)	not null,
	constraint PK_PrlYY_Dept primary key(Gid)		
	);		



insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-01',7.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-02',7.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-03',17.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-04',17 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-05',17.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-06',4.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-07',30 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-08',14.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-09',15.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-10',10.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-11',5.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-12',20 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-13',20.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-14',20.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'A-15',8.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-01',6.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-02',20.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-03',5.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-04',5.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-05',23.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-06',5.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-07',5.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'B-08',23.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-01',5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-02',5.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-03',5.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-04',17.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-05',17.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-06',18.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-07',29.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-08',30.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-09',15.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-10',18.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-11',17.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-12',5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-13',39.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-14',8.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'C-15',11.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-01',18.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-02',17.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-03',17.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-04',17.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-05',17.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-06',26.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-07',9.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-08',14.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-09',14.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-10',14.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-11',14.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-12',6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-13',8.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-14',6.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'D-15',9.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-01',25.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-02',14.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-03',14.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-04',14.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-05',10.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-06',15 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-07',14.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-08',15.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-09',15.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-10',15.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-11',9.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-12',13.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-13',16.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'E-14',7.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'F-01',6.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'F-02',5.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'F-03',5.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'F-04',26.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'F-05',23.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'F-06',24.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-01',25.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-02',24.8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-03',18.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-04',8 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-05',7.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-06',6.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-07',18.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-08',19.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-09',19.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-10',18.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-11',14.6 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-12',12.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'G-13',7.9 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'H-01',36.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'H-02',9.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-01',28.2 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-02',31.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-03',26.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-04',6.9 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-05',8.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-06',7.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-07',8.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-08',30 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-09',29.4 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-10',51.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-11',10.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-12',22.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-13',22.3 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-14',22.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'I-15',9.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'J区',511.7 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'K区',293.1 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'L区',414.5 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'M区',1449 from dual;
insert into PrlYY_GROUNDH(fgid,fno,farea) select sys_guid(),'N区',105.5 from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'内科','内科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'外科','外科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'妇科','妇科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'儿科','儿科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'眼科','眼科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'耳鼻喉科','耳鼻喉科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'肿瘤科','肿瘤科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'心血管科','心血管科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'皮肤科','皮肤科' from dual;
insert into PrlYY_Dept(Gid,Code,Name) select sys_guid(),'中医科','中医科' from dual;
commit;

create or replace view v_wf_model_app as
select d.entgid,
       d.modelgid,
       d.code       modelcode,
       d.name       modelname,
       e.execgidex  appgid,
       e.execcodeex appcode,
       e.execnameex appname,
       d.note       ModelNote
  from WF_Task_Define d, WF_Task_Define_Exec e
 where d.EntGid = e.entgid
   and d.Modelgid = e.ModelGid
   and d.taskdefgid = e.taskdefgid
   and exists (select 1
          from v_org_usr v, v_usr u
         where v.entgid = e.entgid
           and v.entgid = u.entgid
           and v.ORGGID = e.execgidex
           and v.usrgid = u.gid)
 order by d.code, e.execcodeex;

create or replace view v_wf_model_usr_app as
select v.entgid,
       v.modelgid,
       v.modelcode,
       v.modelname,
       v.ModelNote,
       v.appgid OrgGid,
       v.appcode OrgCode,
       v.appname OrgName,
       u.gid AppGid,
       u.code AppCode,
       u.name AppName
  from v_WF_Model_App v, v_org_usr o, v_usr u
 where v.EntGid = o.ENTGID
   and v.EntGid = u.EntGid
   and v.AppGid = o.OrgGid
   and o.USRGID = u.gid;
