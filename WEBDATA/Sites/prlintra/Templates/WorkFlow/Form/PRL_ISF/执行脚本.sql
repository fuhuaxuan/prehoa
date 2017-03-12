declare
  sEntGid varchar2(32);
  sModelGid varchar2(32);
  sTaskGid_t1 varchar2(32);
  sTaskGid_t2 varchar2(32);
  sTaskGid_t3 varchar2(32);
  sTaskGid_t4 varchar2(32);
  sTaskGid_t5 varchar2(32);
  sTaskGid_t6 varchar2(32);
  sTaskGid_t7 varchar2(32);
  sTaskGid_t8 varchar2(32);
  sTaskGid_t9 varchar2(32);
  sTaskGid_t10 varchar2(32);
  sTaskGid_tmod varchar2(32);
  sTaskGid_tcc1 varchar2(32);
  sTaskGid_tcc2 varchar2(32);
  sTaskGid_tend varchar2(32);
BEGIN
  select Gid into sEntGid from Ent where Lower(code) = 'standardintra';--修改企业Gid
  sModelGid := sys_guid();
  sTaskGid_t1 := sys_guid();
  sTaskGid_t2 := sys_guid();
  sTaskGid_t3 := sys_guid();
  sTaskGid_t4 := sys_guid();
  sTaskGid_t5 := sys_guid();
  sTaskGid_t6 := sys_guid();
  sTaskGid_t7 := sys_guid();
  sTaskGid_t8 := sys_guid();
  sTaskGid_t9 := sys_guid();
  sTaskGid_t10 := sys_guid();
  sTaskGid_tmod := sys_guid();
  sTaskGid_tcc1 := sys_guid();
  sTaskGid_tcc2 := sys_guid();
  sTaskGid_tend := sys_guid();

  --删除旧数据
  delete from WF_Task_Define where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Exec where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Condition where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_rt where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Model where entgid = sEntGid and lower(code) = lower('PRL_ISF');


  --Model Table
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  values(sEntGid, sModelGid, 'PRL_ISF', '租赁意向申报表 Income Summary Form', 3, '租户', '1.0', 0, 0);

  --Model Tasks Define
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t1, 'PRL_ISF_T1', '提交', '提交', 1, 1, 0, 0);
 
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t2, 'PRL_ISF_TA1', '财务经理/FM审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t3, 'PRL_ISF_TA2', '招商经理/LM审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t4, 'PRL_ISF_TA3', '商场总经理/CM审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t5, 'PRL_ISF_TB', '常务理事/COO审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t6, 'PRL_ISF_TC1', '资产总监/Hd Invest审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t7, 'PRL_ISF_TC2', '首席财务官/CFO审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t8, 'PRL_ISF_TD', '首席执行官/CEO审批', '审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tmod, 'PRL_ISF_TMod', '提交者修改', '修改', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc1, 'PRL_ISF_Tcc1', 'Asset Manager请阅读', '请阅读', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc2, 'PRL_ISF_Tcc2', '请阅读', '请阅读', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tend, 'PRL_ISF_Tend', '流程终止', '结束一个流程', 99, 0, 1, 0);



  --Model Tasks Execer Define
  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'all_usr_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_t2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_t3, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_t4, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t5, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t6, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t7, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t8, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';


  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tmod, '**CreateGid**', '**CreateCode**', '@发起人@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tcc1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tcc2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);


  --Model Task Condition
  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t1, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t1, sTaskGid_t2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tmod, sTaskGid_t2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t2, sTaskGid_t3);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t3, sTaskGid_t4);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t4, sTaskGid_t5);



  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t5, sTaskGid_t6);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t6, sTaskGid_t7);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t7, sTaskGid_t8);




  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t2, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t3, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t4, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t5, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t6, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t7, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t8, sTaskGid_tmod);



  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t2, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t3, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t4, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t5, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t6, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t7, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t8, sTaskGid_tcc1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t4, sTaskGid_tcc2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t5, sTaskGid_tcc2);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t7, sTaskGid_tcc2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t8, sTaskGid_tcc2);




  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t2, sTaskGid_t1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t3, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t4, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t5, sTaskGid_t1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t6, sTaskGid_t1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t7, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t8, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t4, sTaskGid_tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t5, sTaskGid_tend);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t7, sTaskGid_tend);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t8, sTaskGid_tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tmod, sTaskGid_tend);


  --流程控制权限
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select sEntGid, sModelGid, gid, '1111' from org where entgid = sEntGid and code = 'Admin_Grp';


end;
/

commit;
drop table WF_PRL_ISF;			
create table WF_PRL_ISF (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Num	varchar2(32)	null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	Stat	int	null,
	--		
	FillUsrGid	varchar2(32)	null,
	FillUsrCode	varchar2(64)	null,
	FillUsrName	varchar2(64)	null,
	FillUsrDeptGid	varchar2(32)	null,
	FillUsrDeptCode	varchar2(64)	null,
	FillUsrDept	varchar2(64)	null,
	--		
	DEPT	varchar2(128)	null,
	unit	varchar2(128)	null,
	area	NUMBER	null,
	trade	varchar2(128)	null,
	atype	varchar2(32)	null,
	category	varchar2(32)	null,
	categorytext	varchar2(128)	null,
	lessee	varchar2(512)	null,
	tradingname	varchar2(1024)	null,
	address	varchar2(512)	null,
	contactor	varchar2(64)	null,
	phone	varchar2(64)	null,
	email	varchar2(64)	null,
	fax	varchar2(64)	null,
	leaseTermY	NUMBER	null,
	leaseTermM	NUMBER	null,
	leaseTermD	NUMBER	null,
	Related	varchar2(64)	null,
	HandoverDATE	date	null,
	contractDate1	date	null,
	contractdate2	date	null,
	detail	varchar2(512)	null,
	freeRentM	NUMBER	null,
	freeRentD	NUMBER	null,
	freeRentdate1	date	null,
	freeRentdate2	date	null,
	fitoutM	NUMBER	null,
	fitoutD	NUMBER	null,
	fitoutdate1	date	null,
	fitoutdate2	date	null,
	rate	varchar2(64)	null,
	collection	varchar2(64)	null,
	PMFD	NUMBER	null,
	PMFM	NUMBER	null,
	POSFeeD	NUMBER	null,
	POSFeeM	NUMBER	null,
	LegalFeeD	NUMBER	null,
	LegalFeeM	NUMBER	null,
	TotalFeeD	NUMBER	null,
	TotalFeeM	NUMBER	null,
	AGR	NUMBER	null,
	security	NUMBER	null,
	incash	NUMBER	null,
	BRCnew	NUMBER	null,
	BRCExist	NUMBER	null,
	BRCbudget	NUMBER	null,
	brcbudgettext	varchar2(1024)	null,
	Memo	varchar2(4000)	null,
	SDTopUp 	NUMBER	null,
	AdminFee 	NUMBER	null,
	--		
	sPARAM1	NUMBER	null,
	sPARAM2	NUMBER	null,
	constraint PK_WF_PRL_ISF primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PRL_ISF UNIQUE(Num)		
	);		
create index idx_WF_PRL_ISF_fillgid on WF_PRL_ISF(FillUsrGid);			
drop table WF_PRL_ISF_dtl;			
create table WF_PRL_ISF_dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	yeartype	int	null,
	--		
	TBRD	NUMBER	null,
	TBRM	NUMBER	null,
	AP	NUMBER	null,
	GTO	NUMBER	null,
	ProGTOD	NUMBER	null,
	ProGTOM	NUMBER	null,
	ProGTOrent	NUMBER	null,
	constraint PK_WF_PRL_ISF_dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PRL_ISF_App;			
create table WF_PRL_ISF_App (			
	EntGid 	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	dtlgid	varchar2(32)	not null,
	--		
	AppStat	int	null,
	--		
	apptype	int	null,
	AppGid	varchar2(32)	null,
	AppCode	varchar2(64)	null,
	AppName	varchar2(64)	null,
	AppDept	varchar2(64)	null,
	AppAssign	varchar2(64)	null,
	--		
	note	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_PRL_ISF_App primary key(EntGid, FlowGid,dtlGid)		
	);		
			
			
drop table WF_PRL_ISF_Attach;			
create table WF_PRL_ISF_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PRL_ISF_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
			
			
drop table WF_PRL_ISF_CC;			
create table WF_PRL_ISF_CC (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	CCStat	int	null,
	--		
	cctype	int	null,
	CCGid	varchar2(32)	null,
	CCCode	varchar2(64)	null,
	CCName	varchar2(64)	null,
	CCDept	varchar2(64)	null,
	--		
	CCDate	date	null,
	constraint PK_WF_PRL_ISF_cc primary key(EntGid, FlowGid, Gid)		
	);		
