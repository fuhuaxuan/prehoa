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
  select Gid into sEntGid from Ent where Lower(code) = 'prlintra';--ÐÞ¸ÄÆóÒµGid
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

  --É¾³ý¾ÉÊý¾Ý
  delete from WF_Task_Define where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Exec where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Condition where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_rt where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Model where entgid = sEntGid and lower(code) = lower('PRL_ISF');


  --Model Table
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  values(sEntGid, sModelGid, 'PRL_ISF', '×âÁÞÒâÏòÉê±¨±í Income Summary Form', 3, '×â»§', '1.0', 0, 0);

  --Model Tasks Define
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t1, 'PRL_ISF_T1', 'Ìá½»', 'Ìá½»', 1, 1, 0, 0);
 
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t2, 'PRL_ISF_TA1', '²ÆÎñ¾­Àí/FMÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t3, 'PRL_ISF_TA2', 'ÕÐÉÌ¾­Àí/LMÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t4, 'PRL_ISF_TA3', 'ÉÌ³¡×Ü¾­Àí/CMÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t5, 'PRL_ISF_TB', '³£ÎñÀíÊÂ/COOÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t6, 'PRL_ISF_TC1', '×Ê²ú×Ü¼à/Hd InvestÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t7, 'PRL_ISF_TC2', 'Ê×Ï¯²ÆÎñ¹Ù/CFOÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t8, 'PRL_ISF_TD', 'Ê×Ï¯Ö´ÐÐ¹Ù/CEOÉóÅú', 'ÉóÅú', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tmod, 'PRL_ISF_TMod', 'Ìá½»ÕßÐÞ¸Ä', 'ÐÞ¸Ä', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc1, 'PRL_ISF_Tcc1', 'Asset ManagerÇëÔÄ¶Á', 'ÇëÔÄ¶Á', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc2, 'PRL_ISF_Tcc2', 'ÇëÔÄ¶Á', 'ÇëÔÄ¶Á', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tend, 'PRL_ISF_Tend', 'Á÷³ÌÖÕÖ¹', '½áÊøÒ»¸öÁ÷³Ì', 1, 0, 1, 0);



  --Model Tasks Execer Define
  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'all_usr_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_t2, '**SpecGid**', '**SpecCode**', '@Á÷³ÌÖÐÖ¸¶¨@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_t3, '**SpecGid**', '**SpecCode**', '@Á÷³ÌÖÐÖ¸¶¨@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_t4, '**SpecGid**', '**SpecCode**', '@Á÷³ÌÖÐÖ¸¶¨@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t5, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t6, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t7, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t8, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';


  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tmod, '**CreateGid**', '**CreateCode**', '@·¢ÆðÈË@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tcc1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tcc2, '**SpecGid**', '**SpecCode**', '@Á÷³ÌÖÐÖ¸¶¨@', 1);


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


  --Á÷³Ì¿ØÖÆÈ¨ÏÞ
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


drop table TGROUNDH;			
create table TGROUNDH (			
	fgid	int	not null,
	fno	varchar2(64)	not null,
	farea	NUMBER(24,2)	not null,
	fmr	NUMBER(24,2)	not null,
	--		
	floorno	VARCHAR2(16)	null,
	--		
	fstat	VARCHAR2(16)	null,
	fnow	int	null,
	constraint PK_TGROUNDH primary key(fGid)		
	);		
drop table Tbusrange;			
create table Tbusrange (			
	code	int	not null,
	name	varchar2(64)	not null,
	constraint PK_Tbusrange primary key(code)		
	);		



prompt PL/SQL Developer import file
prompt Created on 2012Äê9ÔÂ6ÈÕ by yuhong
set feedback off
set define off
prompt Disabling triggers for TBUSRANGE...
alter table TBUSRANGE disable all triggers;
prompt Disabling triggers for TGROUNDH...
alter table TGROUNDH disable all triggers;
prompt Deleting TGROUNDH...
delete from TGROUNDH;
commit;
prompt Deleting TBUSRANGE...
delete from TBUSRANGE;
commit;
prompt Loading TBUSRANGE...
insert into TBUSRANGE (CODE, NAME)
values (1, 'Öé±¦³Ç');
insert into TBUSRANGE (CODE, NAME)
values (2, 'ÖÓ±íÑÛ¾µ');
insert into TBUSRANGE (CODE, NAME)
values (3, '»¯×±Æ·');
insert into TBUSRANGE (CODE, NAME)
values (4, 'Ð¬Ã±');
insert into TBUSRANGE (CODE, NAME)
values (5, 'ÔË¶¯³Ç£¨ÔË¶¯1ºÅ£©');
insert into TBUSRANGE (CODE, NAME)
values (6, 'Ð¬³Ç£¨Ð¬ÀÏ´ó£©');
insert into TBUSRANGE (CODE, NAME)
values (7, '¼Ò¾Ó¹Ý');
insert into TBUSRANGE (CODE, NAME)
values (8, 'Å®×°');
insert into TBUSRANGE (CODE, NAME)
values (9, 'ÄÐ×°');
insert into TBUSRANGE (CODE, NAME)
values (10, 'Í¯×°');
insert into TBUSRANGE (CODE, NAME)
values (101, '°åÊ½');
insert into TBUSRANGE (CODE, NAME)
values (102, '°ì¹«¼Ò¾ß');
insert into TBUSRANGE (CODE, NAME)
values (103, '³÷¹ñ');
insert into TBUSRANGE (CODE, NAME)
values (104, '´°Á±');
insert into TBUSRANGE (CODE, NAME)
values (105, '´É×©');
insert into TBUSRANGE (CODE, NAME)
values (106, 'µÆ¾ß');
insert into TBUSRANGE (CODE, NAME)
values (107, 'µØ°å');
insert into TBUSRANGE (CODE, NAME)
values (108, 'µçÆ÷');
insert into TBUSRANGE (CODE, NAME)
values (109, 'µõ¶¥');
insert into TBUSRANGE (CODE, NAME)
values (11, 'Í¯Íæ');
insert into TBUSRANGE (CODE, NAME)
values (110, '¶ùÍ¯');
insert into TBUSRANGE (CODE, NAME)
values (111, '¹Åµä');
insert into TBUSRANGE (CODE, NAME)
values (112, '¹ÅµäÏç´å');
insert into TBUSRANGE (CODE, NAME)
values (113, 'ºìÄ¾');
insert into TBUSRANGE (CODE, NAME)
values (114, '»§Íâ¼Ò¾ß');
insert into TBUSRANGE (CODE, NAME)
values (115, '¼Ò¾ÓÊÎÆ·');
insert into TBUSRANGE (CODE, NAME)
values (116, '¼Ò×°¹«Ë¾');
insert into TBUSRANGE (CODE, NAME)
values (117, '½¨²ÄÆäËû');
insert into TBUSRANGE (CODE, NAME)
values (118, '½à¾ß');
insert into TBUSRANGE (CODE, NAME)
values (119, '¾»Ë®');
insert into TBUSRANGE (CODE, NAME)
values (12, 'ÌåÓýÓÃÆ·');
insert into TBUSRANGE (CODE, NAME)
values (120, '¿ÍÌüÎå½ð');
insert into TBUSRANGE (CODE, NAME)
values (121, 'Â¥ÌÝ');
insert into TBUSRANGE (CODE, NAME)
values (122, 'ÃÅ´°');
insert into TBUSRANGE (CODE, NAME)
values (123, 'ÃÅÀà');
insert into TBUSRANGE (CODE, NAME)
values (124, 'Ç½Ö½');
insert into TBUSRANGE (CODE, NAME)
values (126, 'É³·¢');
insert into TBUSRANGE (CODE, NAME)
values (127, 'ÊµÄ¾');
insert into TBUSRANGE (CODE, NAME)
values (125, 'Èí´²´²µæ');
insert into TBUSRANGE (CODE, NAME)
values (128, 'ÊÎÆ·');
insert into TBUSRANGE (CODE, NAME)
values (129, 'ÌÙÆ÷');
insert into TBUSRANGE (CODE, NAME)
values (13, 'Ð¡¼Òµç');
insert into TBUSRANGE (CODE, NAME)
values (130, 'Îå½ð');
insert into TBUSRANGE (CODE, NAME)
values (131, 'ÒÆÃÅÒÂ¹ñ');
insert into TBUSRANGE (CODE, NAME)
values (132, 'ÓÍÆáÍ¿ÁÏ');
insert into TBUSRANGE (CODE, NAME)
values (133, 'ÈËÔìÊ¯');
insert into TBUSRANGE (CODE, NAME)
values (134, 'Ê¯¸àÏß');
insert into TBUSRANGE (CODE, NAME)
values (135, 'Ë¯ÃßÖÐÐÄ');
insert into TBUSRANGE (CODE, NAME)
values (136, '±ÚÂ¯');
insert into TBUSRANGE (CODE, NAME)
values (137, 'Ê¯²Ä');
insert into TBUSRANGE (CODE, NAME)
values (138, '½ðÊô');
insert into TBUSRANGE (CODE, NAME)
values (139, 'Ð¡¿îÆ¤É³·¢');
insert into TBUSRANGE (CODE, NAME)
values (14, '²ÍÒû');
insert into TBUSRANGE (CODE, NAME)
values (140, 'ÒÂ¼Ü');
insert into TBUSRANGE (CODE, NAME)
values (141, 'É¢ÈÈÆ÷');
insert into TBUSRANGE (CODE, NAME)
values (142, '±ÚÖ½');
insert into TBUSRANGE (CODE, NAME)
values (143, '¹èÔåÄà');
insert into TBUSRANGE (CODE, NAME)
values (144, 'ÌïÔ°Ïç´å');
insert into TBUSRANGE (CODE, NAME)
values (145, '¹ÅµäÅ·Ê½');
insert into TBUSRANGE (CODE, NAME)
values (146, '³÷¹ñ');
insert into TBUSRANGE (CODE, NAME)
values (147, 'é½é½Ã×');
insert into TBUSRANGE (CODE, NAME)
values (148, '¹ºÎïÆäËü');
insert into TBUSRANGE (CODE, NAME)
values (15, 'Ò½Ò©');
insert into TBUSRANGE (CODE, NAME)
values (16, 'Ê³Æ·');
insert into TBUSRANGE (CODE, NAME)
values (17, 'ÑÌ¾Æ');
insert into TBUSRANGE (CODE, NAME)
values (18, 'ÌØ²ú');
insert into TBUSRANGE (CODE, NAME)
values (19, 'ÃÀÈÝ');
insert into TBUSRANGE (CODE, NAME)
values (20, 'Ïä°üÆ¤¾ß');
insert into TBUSRANGE (CODE, NAME)
values (21, 'ÊÎÆ·');
insert into TBUSRANGE (CODE, NAME)
values (22, 'ÓéÀÖ');
insert into TBUSRANGE (CODE, NAME)
values (23, '½ÌÓý»ú¹¹');
insert into TBUSRANGE (CODE, NAME)
values (24, '°Ù»õ');
insert into TBUSRANGE (CODE, NAME)
values (25, 'ÆäËû');
insert into TBUSRANGE (CODE, NAME)
values (26, '¼ÒÊÎÀà');
insert into TBUSRANGE (CODE, NAME)
values (27, 'µç½Ì');
insert into TBUSRANGE (CODE, NAME)
values (28, 'Ó¤Ó×');
insert into TBUSRANGE (CODE, NAME)
values (29, 'Í¯Ð¬');
insert into TBUSRANGE (CODE, NAME)
values (30, 'ÔË¶¯');
insert into TBUSRANGE (CODE, NAME)
values (31, 'ÐÝÏÐ');
insert into TBUSRANGE (CODE, NAME)
values (32, 'ÓðÈÞ');
commit;
prompt 80 records loaded
prompt Loading TGROUNDH...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (1, 'B2-A', 240, 2, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (2, 'B2-02', 40, 10.41, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (3, 'B2-03\04', 217, 2.92, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (4, 'B2-05', 100, 3.91, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (5, 'B2-06', 100, 6, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (6, 'B2¡ª07', 100, 4.11, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (7, 'B2-08', 100, 2.52, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (8, 'B2-09', 45, 6.65, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (9, 'B2-11', 56, 8, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (10, 'B2-12A', 70, 6.2, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (11, 'B2-12B', 70, 7.37, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (12, 'B2-12C', 60, 8.81, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (13, 'B2-12D', 55, 3.25, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (14, 'B2-12E', 37, 9.48, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (15, 'B2-12F', 77, 6.05, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (16, 'B2-12G1', 49, 8.66, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (17, 'B2-12G2', 49, 7.16, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (18, 'B2-12H', 70, 5.01, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (19, 'B2-013.14', 94.4, 4, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (20, 'B2-015', 32, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (21, 'B2-16A', 7, 7.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (22, 'B2-16B', 6, 8.96, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (23, 'B2-17A¡¢E', 84, 5.67, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (24, 'B2-17B', 24, 12.46, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (25, 'B2-17C', 24, 6.85, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (26, 'B2-17D', 12, 5.88, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (27, 'B2-17F', 86, 5.58, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (28, 'B2-17G¡¢I', 55, 7.88, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (29, 'B2-17H', 40, 6.64, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (30, 'B2-017j', 33, 5.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (31, 'B2-17K1', 16, 5.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (32, 'B2-17K2', 20, 7.66, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (33, 'B2-17L¡¢M', 52, 5.71, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (34, 'B2-17N', 50.4, 6.72, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (35, 'B2-20', 13.6, 6.4, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (36, 'B2-023', 1003, 4, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (37, 'B2-024', 443, 5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (38, 'B2-26', 77.8, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (1111, 'B2-27', 37.8, 0, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (39, 'B2-H-1', 220, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (40, 'B2-H2', 15, 9.3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (41, 'B2H-3/4', 21, 13.7, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (42, 'B2H-6', 80, 1.03, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (43, 'B2H-7', 17, 7.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (44, 'B2-H8', 12, 8.4, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (45, 'B2H-9', 6.1, 11, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (46, 'B2-H11', 20, 10, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (47, 'B2-H11', 17, 21.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (48, 'B2H-12', 20, 8, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (49, 'B2H-13/30', 40, 15, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (50, 'B2H-14\24', 33, 7.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (51, 'B2H-15', 25, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (52, 'B2-H15', 3.5, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (53, 'B2-H18', 20, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (54, 'B2-H20', 8, 12.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (55, 'B2H-20', 5, 14, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (56, 'B2-H22', 30, 7, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (57, 'B2-H25', 14, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (58, 'B2-H26', 15, 11.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (59, 'B2-H27', 15, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (60, 'B2-H28', 20, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (61, 'B2-H29', 17, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (62, 'B2-H32', 22, 8, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (63, 'B2-H33', 13, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (64, 'B2-H34', 16, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (65, 'B2H-35', 15, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (66, 'B2H-37', 9, 12.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (67, 'B2H-38', 5, 13.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (68, 'B2H-39', 17, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (69, 'B2-H-40', 6, 14, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (70, 'B2H-41', 4, 20, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (71, 'B2H-42', 5.5, 2.88, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (72, 'B2-P01¡¢ 02', 100, 5.88, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (73, 'B2-P03', 25, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (74, 'B2-P04', 25, 8.51, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (75, 'B2-P05 06', 50, 4.93, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (76, 'B2-P07 08', 50, 8.51, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (77, 'B2-P09', 60, 4.55, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (78, 'B2-P10', 10, 10, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (79, 'B2F-02', 116, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (80, 'B2F-03', 120, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (81, 'B2F-04-05', 250, 4.24, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (82, 'B2F-06 07 08', 515, 2.83, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (83, 'B2F-009', 105.4, 5.19, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (84, 'B2F-010.11', 193.5, 3.35, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (85, 'B2F-12', 83.6, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (86, 'B2F-13', 284.7, 6, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (87, 'B2F-014', 117, 4.09, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (88, 'B2F-15', 146.1, 3.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (89, 'B2F-20', 175, 2, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (90, 'B2F-21', 194, 2, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (91, 'B2F-22', 30, 2, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (92, 'B2-BM01', 40, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (93, 'B2-BM02', 18, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (94, 'B2-BM03', 18, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (95, 'B2-BM04', 18, 6.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (96, 'B2-BM05', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (97, 'B2-BM06¡¢07', 54, 2.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (98, 'B2-BM08', 19, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (99, 'B2-BM09', 19, 3, 'B2', 'Î´×â', 1);
commit;
prompt 100 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (100, 'B2-BM10', 18, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (101, 'B2-BM11', 14, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (102, 'B2-BM12', 15, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (103, 'B2-BM13', 14, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (104, 'B2-BM14', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (105, 'B2-BM15', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (106, 'B2-BM16', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (107, 'B2-BM17', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (108, 'B2-BM18', 20, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (109, 'B2-BM19', 20, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (110, 'B2-BM20-1', 13, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (111, 'B2-BM20-2', 13, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (112, 'B2-BM21', 17, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (113, 'B2-BM22', 18, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (114, 'B2-BM23', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (115, 'B2-BM24', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (116, 'B2-BM25', 30, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (117, 'B2-BM26', 20, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (118, 'B2-BM27', 20, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (119, 'B2-BM28', 9, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (120, 'B2-BM29', 10, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (121, 'B2-BM30', 10, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (122, 'B2-BM31', 10, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (123, 'B2-BM32', 10, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (124, 'B2-BM33', 10, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (125, 'B2-BM34', 19, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (126, 'B2-BM35', 25, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (127, 'B2-BM36', 17, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (128, 'B2-BM37', 59, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (129, 'B2-BM38', 77, 4.62, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (130, 'B2-BM39', 29, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (131, 'B2-BM41', 27, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (132, 'B2-BM40', 36, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (133, 'B2-BM42¡¢43', 95, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (134, 'B2-BM44', 94, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (135, 'B2-BM45-01', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (136, 'B2-BM45-02', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (137, 'B2-BM45-03', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (138, 'B2-BM45-04', 20, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (139, 'B2-BM46', 119, 6, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (140, 'B2-BM47-01', 16, 9.5, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (141, 'B2-BM47-02', 15, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (142, 'B2-BM47-03', 17, 9, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (143, 'B2-BM47-4', 13, 3, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (144, 'B2-BM48', 35, 8, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (145, 'B2-BM49', 65, 7, 'B2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (146, 'B1F-08\09', 294, 4.77, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (147, 'B1-38A', 22.5, 4.62, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (148, 'B1-42', 59.7, 7.07, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (149, 'B1-43¡¢44¡¢48¡¢49', 404.9, 4.84, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (150, 'B1-45', 137.4, 7, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (151, 'B1-46', 135.9, 7, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (152, 'B1-47', 77, 7, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (153, 'B1-50/51', 245.2, 4, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (154, 'B1-52', 31.8, 6.13, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (155, 'B1-53', 1500, .99, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (156, 'B1-53A', 242, 3.17, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (157, 'B1-54', 82, 4.17, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (158, 'B1-55', 11.2, 7.79, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (159, 'B1-56', 37, 6.61, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (160, 'B1-57+61', 61, 6.18, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (161, 'B1-60', 38.6, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (162, 'B1-62', 43.8, 5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (163, 'B1-63', 40.3, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (164, 'B1-64', 9.5, 10, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (165, 'B1-65', 39.3, 5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (166, 'B1-66A', 25.6, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (167, 'B1-66B', 17, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (168, 'B1-67', 39.6, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (169, 'B1-68+69', 58.8, 5.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (170, 'B1-70', 41.1, 5.13, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (171, 'B1-71', 24.4, 6.34, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (172, 'B1-73', 50, 4, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (173, 'B1-74', 19, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (174, 'B1-75', 74, 5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (175, 'B1-76', 66.5, 4.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (176, 'B1-78', 86, 5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (177, 'B1-79', 81.8, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (178, 'B1-80¡¢81¡¢82¡¢83¡¢108¡¢109', 548.4, 5.77, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (179, 'B1-84¡¢85', 88.8, 7.77, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (180, 'B1-87', 23.3, 7.41, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (181, 'B1-88¡¢89a¡¢89b¡¢110b', 330, 7.85, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (182, 'B1-90¡¢89b', 91, 7.59, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (183, 'B1-91', 53.2, 7.11, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (184, 'B1-92', 53.3, 6.79, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (185, 'B1-93', 21.1, 8.57, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (186, 'B1-95', 108.9, 6.94, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (187, 'B1-96', 15.8, 7.98, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (188, 'B1-97¡¢98¡¢99¡¢107', 449.8, 5.76, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (189, 'B1-100', 13, 5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (190, 'B1-101', 15.5, 5.27, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (191, 'B1-102/103/104', 373.1, 4.77, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (192, 'B1-105', 16.3, 7.73, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (193, 'B1-106', 14.9, 8.09, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (194, 'B1-110a', 108.6, 7.77, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (195, 'B1-111', 126, 7.18, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (196, 'B1-113', 39.5, 7.14, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (197, 'B1H-41', 4, 33.4, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (198, 'B1F-06', 258, 6.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (199, 'B1F-07', 174.6, 6.5, 'B1', 'Î´×â', 1);
commit;
prompt 200 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (200, 'B1F-12-14', 338, 7.78, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (201, 'B1F-15~18', 444.9, 6.71, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (202, 'B1F-19\20\24\25', 425, 6.16, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (203, 'B1F-21.22', 318.7, 3.41, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (204, 'B1F-23', 112.3, 6.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (205, 'B1F-27-28', 181, 6.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (206, 'B1F-29', 277.6, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (207, 'B1F-30', 544, 5.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (208, 'B1F-34', 44.2, 2.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (209, 'B1F-35', 77.3, 7, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (210, 'B1F-36', 104.4, 3.83, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (211, 'B1F-37', 103.2, 3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (212, 'B1F-38.39', 140.6, 3.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (213, 'B1F-40¡¢41', 67.8, 4.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (214, 'B1F-42', 55.2, 4.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (215, 'B1F-50¡¢51¡¢52¡¢53', 2200, 2.37, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (216, 'B1F54', 5.2, 13, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (217, 'B1F 55', 280, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (218, 'B1F-072', 415, 5.62, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (219, 'B1L-01', 8, 25.1, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (220, 'B1ZL-01', 81, 4.26, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (221, 'B1ZL-02', 129, 6.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (222, 'B1ZL-03', 115, 4, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (223, 'B1ZL-04', 129, 3.57, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (224, 'B1ZL-05', 54, 7, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (225, 'B1ZL-06', 71, 7.1, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (226, 'B1ZL-07', 16, 14.38, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (227, 'B1ZL-08', 77, 4.48, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (228, 'B1ZL-09', 73, 6.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (229, 'B1ZL-10', 89, 3.88, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (230, 'B1ZL-11', 51, 6.77, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (231, 'B1F-26', 160, 6, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (232, 'B1x-1', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (233, 'B1x-2', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (234, 'B1x-4', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (235, 'B1x-5', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (236, 'B1x-6', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (237, 'B1x-9', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (238, 'B1x-10', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (239, 'B1x-11', 25, 8.3, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (240, 'B1-d01', 15, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (241, 'B1-d02', 15, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (242, 'B1-d03', 15, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (243, 'B1-d04', 35, 8, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (244, 'B1-d05', 15, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (245, 'B1-d06', 25, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (246, 'B1-d07', 9.5, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (247, 'B1-d08', 22, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (248, 'B1-d09', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (249, 'B1-d10', 28, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (250, 'B1-d11', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (251, 'B1-d12', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (252, 'B1-d13', 19.5, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (253, 'B1-d14', 19.5, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (254, 'B1-d15', 19.5, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (255, 'B1-d16', 19.5, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (256, 'B1-d17', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (257, 'B1-d18', 22, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (258, 'B1-d19', 21, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (259, 'B1-d20', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (260, 'B1-d21', 18, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (261, 'B1-d22', 19, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (262, 'B1-d23', 18, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (263, 'B1-d24', 16, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (264, 'B1-d25', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (265, 'B1-d26', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (266, 'B1-d27', 20, 8.5, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (267, 'F1-01 02 03 04', 900, 6.39, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (268, 'F1-05', 24, 13.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (269, 'F1-06', 277, 3.32, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (270, 'F1-07', 157.1, 4.39, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (271, 'F1-09', 44, 11.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (272, 'F1-10', 60, 8.22, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (273, 'F1-11', 139, 5.59, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (274, 'F1-12', 78.6, 17.19, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (275, 'F1-13', 120, 12.79, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (276, 'F1-14', 101, 9.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (277, 'F1-15', 38, 6.98, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (278, 'F1-16-19', 346, 9, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (279, 'F1-20', 363, 9, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (280, 'F1-21', 64, 10.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (281, 'F1-22', 62, 10.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (282, 'F1-23\24\54A\54B\55A\55B\88ABCD', 1065, 9, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (283, 'F1-25¡¢51A¡¢51B', 246, 7.8, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (284, 'F1-29', 88, 10.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (285, 'F1-29-49', 2029, 0, null, 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (286, 'F1-30', 51, 11.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (287, 'F1-31', 98, 10.48, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (288, 'F1-32', 93, 6.78, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (289, 'F1-33', 93, 6.01, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (290, 'F1-34', 93, 5.6, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (291, 'F1-35', 75, 10.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (292, 'F1-36', 44, 3.36, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (293, 'F1-37', 70, 8.22, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (294, 'F1-38', 92, 10.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (295, 'F1-39', 53, 11, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (296, 'F1-40', 50, 7.56, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (297, 'F1-41', 50, 13.15, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (298, 'F1-42', 53, 9.3, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (299, 'F1-43', 53, 11, 'F1', 'Î´×â', 1);
commit;
prompt 300 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (300, 'F1-44', 50, 18.08, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (301, 'F1-45', 50, 8.63, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (302, 'F1-46', 53, 8.68, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (303, 'F1-47', 70, 7.2, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (304, 'F1-48 49', 27, 4.87, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (305, 'F1-50', 246, 11.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (306, 'F1-52¡¢53', 54, 17.15, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (307, 'F1-56A\B', 40, 11.51, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (308, 'F1-57¡¢F1-60', 80, 8.68, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (309, 'F1-58', 36, 11.42, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (310, 'F1-59', 31, 17.68, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (311, 'F1-61\62\63\66B', 148.3, 6.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (312, 'F1-64-69', 193, 9.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (313, 'F1-66A', 22, 29.89, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (314, 'F1-70ÖÁ85', 320, 4.62, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (315, 'F1F-01\02\03', 420, 8.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (316, 'F1F-04', 455.1, 14.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (317, 'F1F-05', 550.8, .84, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (318, 'F1F-06', 390, 1.77, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (319, 'F1F-07', 45.1, 9.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (320, 'F1F-09¡¢08¡¢10', 564, 2.81, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (321, 'F1F-11', 139, 9, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (322, 'F1F-12', 179, 9.77, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (323, 'F1F-13-16', 1410, 3.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (324, 'F1F-17', 346, 6.54, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (325, 'F1F-18', 18, 10, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (326, 'F1F-19', 395, 1.58, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (327, 'F2F-20¡¢21', 228, 5.59, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (328, 'F1F-22-24', 418, 3.3, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (329, 'F1F-25', 278, 5.05, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (330, 'F1F-26', 97, 9.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (331, 'F1F-27', 256, 9, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (332, 'F1F-28', 100, 4, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (333, 'F1F-29/30/31', 510, 2.41, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (334, 'F1F-32/33/34/35/36/37', 886, 8.5, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (335, 'F1F-45', 356, 8, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (336, 'F2X-01', 605, 2.85, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (337, 'F2X-02', 605, 4.17, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (338, 'F2X-03/04', 245, 11.56, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (339, 'F2X-05/06/07', 380, 11.42, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (340, 'F2X08/09', 220, 7.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (341, 'F2X-10/11', 200, 6.99, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (342, 'F2X-12', 105, 8, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (343, 'F2X-13', 60, 5.75, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (344, 'F2X-14', 130, 2.7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (345, 'F2X-14B', 13, 5.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (346, 'F2X-15/16/17', 285, 4.44, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (347, 'F2X-18/19', 220, 9.34, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (348, 'F2X-20/21', 200, 7.12, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (349, 'F2X-22', 90, 8.42, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (350, 'F2X-23', 110, 7.7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (351, 'F2X-24', 85, 7.7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (352, 'F2X-25', 50, 15.12, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (353, 'F2X-26', 135, 3.45, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (354, 'F2X-27', 80, 4.32, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (355, 'F2X-28', 100, 6.99, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (356, 'F2X-29', 45, 8.4, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (357, 'F2X-30', 45, 5.11, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (358, 'F2X-31', 60, 5.48, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (359, 'F2X-32', 45, 11.69, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (360, 'F2X-33', 50, 10.52, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (361, 'F2X-34', 60, 1.92, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (362, 'F2X-35', 60, 5.75, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (363, 'F2X-36', 60, 7.67, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (364, 'F2X-37', 60, 6.94, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (365, 'F2X-38', 47, 8.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (366, 'F2X-39', 50, 8.05, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (367, 'F2X-40', 60, 8, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (368, 'F2X-41', 60, 5.48, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (369, 'F2X-42', 60, 7.67, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (370, 'F2X-43', 45, 12.79, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (371, 'F2X-44', 60, 5.48, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (372, 'F2X-45', 60, 6.71, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (373, 'F2X-46', 45, 5.11, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (374, 'F2X-47', 55, 7.32, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (375, 'F2X-48', 65, 7.08, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (376, 'F2X-49', 50, 5.66, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (377, 'F2X-62', 60, 5.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (378, 'F2X-50', 40, 8.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (379, 'F2X-51', 36, 10.05, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (380, 'F2X-52', 30, 5.55, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (381, 'F2X-53', 120, 7.19, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (382, 'F2X-54', 30, 6.27, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (383, 'F2X-55', 32, 6.38, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (384, 'F2X-56', 28, 7.08, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (385, 'F2X-57', 34, 6.09, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (386, 'F2X-58', 34, 6.09, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (387, 'F2X-59', 70, 5.95, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (388, 'F2X-61', 25, 7.56, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (389, 'F2F-01/02', 928, 6.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (390, 'F2F-03', 58.4, 4.19, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (391, 'F2F-04/05', 182.4, 2.88, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (392, 'F2F-06', 196, 5.27, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (393, 'F2F-07', 41.4, 7.63, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (394, 'F2F-08/09', 200, 4.19, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (395, 'F2F-10', 105.3, 6.56, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (396, 'F2F-11', 214.7, 7.24, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (397, 'F2F-12', 41, 12.19, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (398, 'F2F-13/14', 380, 7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (399, 'F2F-15', 90, 6.07, 'F2', 'Î´×â', 1);
commit;
prompt 400 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (400, 'F2F-16/17/18', 1086, 3.53, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (401, 'F2F-19', 265.4, 7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (402, 'F2F-19b', 90, 4.66, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (403, 'F2F-20', 55.6, 4.49, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (404, 'F2F-21/22', 350, 7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (405, 'F2F-23', 202, 7.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (406, 'F2F-24', 15, 5.27, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (407, 'F2F-27', 10, 6.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (408, 'F2F-28', 10, 6.05, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (409, 'F2F-29', 842, 6, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (410, 'F2F-30', 94.4, 7.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (411, 'F2F-31', 172.7, 7.1, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (412, 'F2F-32', 169.6, 7.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (413, 'F2F-33/34', 290.2, 3.55, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (414, 'F2F-35', 150, 6.06, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (415, 'F2F-36', 263.7, 3.83, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (416, 'F2F-37', 54.5, 9.95, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (417, 'F2F-38A', 176.4, 7.3, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (418, 'F2F-38', 120, 7.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (419, 'F2F-41', 92.8, 6.81, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (420, 'F2F-40', 88, 5.7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (421, 'F2F-42', 400, 3.53, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (422, 'F2F-43', 101.4, 3.66, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (423, 'F2F-43/44', 102, 3.58, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (424, 'F2F-45', 107.5, 7.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (425, 'F2F-47', 290, 2.27, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (426, 'F2F48/49', 679.9, 1.55, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (427, 'F2F-50', 86, 6.73, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (428, 'F2F-51', 175, 7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (429, 'F2F-52', 175, 7, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (430, 'F2F-53', 175, 4.5, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (431, 'F2F-54', 55.6, 6.82, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (432, 'F2F-55', 166.2, 7.76, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (433, 'F2F-56', 10, 12.32, 'F2', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (434, 'F3-128', 40, 6.16, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (435, 'F3-101/147', 756, 2.57, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (436, 'F3-102/103/104', 243, 6, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (437, 'F3-105B/106', 321, 1.37, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (438, 'F3-107', 40, 8.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (439, 'F3-108/109/111', 300, 5.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (440, 'F3-110', 732, 2.69, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (441, 'F3-112', 28, 5.15, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (442, 'F3-113', 41, 4.6, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (443, 'F3-114', 359, 5.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (444, 'F3-115', 87, 4.71, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (445, 'F3-116', 62, 4.18, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (446, 'F3-117/118', 1355, 1.82, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (447, 'F3-119/120/121', 618, 3, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (448, 'F3-122', 22, 6.02, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (449, 'F3-123', 125, 5.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (450, 'F3-124', 45, 7.1, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (451, 'F3-125', 46.5, 3.65, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (452, 'F3-126/127', 732, 4.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (453, 'F3-129', 305, 5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (454, 'F3-130', 263.1, 2, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (455, 'F3-131', 30, 4.11, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (456, 'F3-132', 427, 3.03, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (457, 'F3-133/134', 348, 2.92, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (458, 'F3-135/136', 105.9, 3.13, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (459, 'F3-137', 650, 2, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (460, 'F3-138', 295, 5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (461, 'F3-140/142', 394, 2.6, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (462, 'F3-141', 45, 6, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (463, 'F3-143/144', 221, 5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (464, 'F3-145/146', 166.2, 3.12, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (465, 'F3-148', 23, 7, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (466, 'F3-211/212/202/203/225', 2447.7, 2.35, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (467, 'F3-204', 1750, 3.95, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (468, 'F3-205/206/207', 247, 2.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (469, 'F3-210', 62, 4.27, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (470, 'F3-213', 62, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (471, 'F3-214', 106, 2.07, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (472, 'F3-215', 105, 5.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (473, 'F3-216', 86, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (474, 'F3-217', 93, 6.21, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (475, 'F3-218', 62, 3.22, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (476, 'F3-219', 143, 4.11, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (477, 'F3-220', 60, 4.2, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (478, 'F3-221', 64, 3.13, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (479, 'F3-222/226/228/229/230/231', 526, 5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (480, 'F3-223', 67, 7.14, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (481, 'F3-224', 97, 5.2, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (482, 'F3F-01/02', 35, 4, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (483, 'F3F-03', 35, 2.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (484, 'F3F-04', 35, 5.4, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (485, 'F3F-05', 31, 3.68, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (486, 'F3F-06', 15, 7, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (487, 'F3F-07', 18, 3.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (488, 'F3F-08/09/10', 36, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (489, 'F3F-11', 81, 5.01, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (490, 'F3F-12', 32, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (491, 'F3F-13/14/17/18/19', 164, 3.07, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (492, 'F3F-15', 31, 3.77, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (493, 'F3F-16', 32, 5.91, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (494, 'F3F-21/22', 40, 3.71, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (495, 'F3F-23/24', 55, 3.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (496, 'F3F-25/26/27', 80, 4.73, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (497, 'F3F-28', 24, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (498, 'F3F-29', 50, 3.78, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (499, 'F3F-30/31', 55, 7.23, 'F3', 'Î´×â', 1);
commit;
prompt 500 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (500, 'F3F-32/33', 50, 3.66, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (501, 'F3F-34', 48, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (502, 'F3F-35/36/37/38/39/40/41', 193, 1.99, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (503, 'F3F-42/43', 68, 6.5, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (504, 'F3F-44', 29, 5.43, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (505, 'F3F-45', 28, 7, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (506, 'F3F-46', 26, 4.71, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (507, 'F3F-47', 22, 3.69, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (508, 'F3F-48', 7, 4.12, 'F3', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (509, 'F4Y-01', 120, 5.94, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (510, 'F4Y-02', 90, 7.76, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (511, 'F4Y-03', 310, 3.45, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (512, 'F4Y-04', 320, 3.9, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (513, 'F4Y-05', 120, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (514, 'F4Y-06', 150, 5.75, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (515, 'F4Y-08', 360, 3.42, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (516, 'F4Y-09', 222, 4.69, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (517, 'F4Y-11', 135, 6.9, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (518, 'F4Y-14', 107, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (519, 'F4Y-15', 75, 4.02, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (520, 'F4Y-16', 128, 8.35, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (521, 'F4Y-17.18', 94, 5.13, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (522, 'F4Y-19', 120, 4.38, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (523, 'F4Y-20', 120, 8.26, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (524, 'F4Y-21', 110, 4.18, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (525, 'F4Y-22', 110, 7.57, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (526, 'F4Y-23', 85, 6.09, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (527, 'F4Y-24', 85, 5.41, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (528, 'F4Y-13', 89, 6.46, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (529, 'F4Y-25A', 30, 8.68, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (530, 'F4Y-25B', 30, 3.84, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (531, 'F4Y-26a', 61, 5.66, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (532, 'F4Y-26B', 61, 6.6, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (533, 'F4Y-28', 85, 4.9, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (534, 'F4Y-29', 120, 2.37, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (535, 'F4Y-30-31', 198, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (536, 'F4Y-32', 217, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (537, 'F4Y-33', 90, 4.05, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (538, 'F4Y-34/35', 161, 4.08, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (539, 'F4-01', 3000, 2.51, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (540, 'F4F-01', 618, 4, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (541, 'F4F-01b¡¢02¡¢03', 400, 3.63, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (542, 'F4F-04', 93.9, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (543, 'F4F-05', 176, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (544, 'F4F-06', 90, 3, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (545, 'F4F-07', 37, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (546, 'F4F-08-11', 1355, 1.46, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (547, 'F4F-13', 200, 3.64, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (548, 'F4F-14.15', 266, 2.07, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (549, 'F4F-20', 78, 4.79, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (550, 'F4F-21', 168, 4.42, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (551, 'F4F-22.23', 400, 3.6, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (552, 'F4F-28', 120, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (553, 'F4F-29-31', 436.8, 3.51, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (554, 'F4F-32-34', 440, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (555, 'F4F-35¡¢36', 323, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (556, 'F4F-37', 182, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (557, 'F4F-38', 80, 5.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (558, 'F4F-39-41', 445, 2.2, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (559, 'F4F-42', 153, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (560, 'F4F-43', 155, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (561, 'F4F-44', 55, 6.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (562, 'F4F-45¡¢51', 323, 4.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (563, 'F4F-52', 154, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (564, 'F4F-53', 140, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (565, 'F4F-54', 86, 5.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (566, 'F4F-55', 166, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (567, 'F4N-01', 66, 3.94, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (568, 'F4N-02', 52, 3.58, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (569, 'F4N-03', 56, 5.14, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (570, 'F4N-04', 75, 3.29, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (571, 'F4N-5¡¢6', 95, 5.3, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (572, 'F4N-08', 11, 3.5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (573, 'F4N-9¡¢10¡¢11', 170, 5, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (574, 'F4N-12', 165, 1.79, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (575, 'F4N-13', 60, 4.57, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (576, 'F4N-16', 50, 5.21, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (577, 'F4N-17.18', 86, 1.82, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (578, 'F4N-19.20', 100, 3.45, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (579, 'F4N-21', 60, 4.34, 'F4', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (580, 'F5F-01-03', 1031, 2, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (581, 'F5F-04-06', 380, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (582, 'F5F-07/12(04)', 40, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (583, 'F5F-08-11¡¢F4F-08-11', 1355, 1.4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (584, 'F5F-08A', 10, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (585, 'F5F-12', 40, 4.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (586, 'F5F-12(01)', 17, 5.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (587, 'F5F-12(02)', 19, 5.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (588, 'F5F-12(03)', 18, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (589, 'F5F-13-15', 471.1, 2, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (590, 'F5F-20-22', 395, 3.27, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (591, 'F5F-23', 215, 3.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (592, 'F5F-24', 20, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (593, 'F5F-25-28', 1510, 2, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (594, 'F5F-29', 140, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (595, 'F5F-30-33', 551, 2.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (596, 'F5F-34-35', 242, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (597, 'F5F-36-37', 276, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (598, 'F5F-38-39', 299.4, 2.38, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (599, 'F5F-40', 90, 4.5, 'F5', 'Î´×â', 1);
commit;
prompt 600 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (600, 'F5F-41', 241, 3.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (601, 'F5F-42-43', 282, 3.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (602, 'F5F-44-45', 280, 3, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (603, 'F5F-47-48-49-50-53A', 1200, 1.34, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (604, 'F5F-50-54', 418, 3.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (605, 'F5F-56', 168, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (606, 'F5-01¡¢04-07', 2545, 1.89, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (607, 'F5-02(1)', 75.5, 5.81, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (608, 'F5-02(2)', 80, 4.32, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (609, 'F5-02(3)', 75.5, 3.92, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (610, 'F5-02(4)', 80.5, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (611, 'F5-02(5)', 63, 4.85, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (612, 'F5-02(6)', 114, 5.53, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (613, 'F5-02(7)', 109.5, 4.2, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (614, 'F5-02(8)', 67.5, 5.11, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (615, 'F5-02(9)', 85, 4.06, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (616, 'F5-02(10)', 83, 3.93, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (617, 'F5-02(11)(15)', 110, 4.98, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (618, 'F5-02(12) ', 55, 3.49, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (619, 'F5-02(13)', 83, 4.23, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (620, 'F5-02(14)', 83, 2.57, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (621, 'F5-02(16) ', 55, 6.28, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (622, 'F5-02(17)', 65, 3.71, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (623, 'F5-02(18)', 103, 6.78, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (624, 'F5-02(19)-(20)', 168, 3.26, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (625, 'F5-02(21)', 97, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (626, 'F5-02(22)', 97, 3.36, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (627, 'F5-02(23)-£¨24£©', 190, 1.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (628, 'F5-02(b)', 56, 3.52, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (629, 'F5-02(C) ', 56, 3.9, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (630, 'F5-03(1)', 130, 2.28, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (631, 'F5-03(2)', 108.2, 5.32, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (632, 'F5-03(3)-(4)', 184, 3.93, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (633, 'F5-03(5)', 87.3, 7.91, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (634, 'F5-03(6)-(8)', 281.7, 2.45, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (635, 'F5-03(9)-(10)', 162, 4.46, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (636, 'F5-03(11)-(12) ', 162, 3.72, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (637, 'F5-03(13)', 80, 4.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (638, 'F5-03(13) a', 53, 4.11, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (639, 'F5-08', 109.1, 4.52, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (640, 'F5-09', 105.9, 3.41, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (641, 'F5-10-11', 198.5, 3.48, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (642, 'F5-12', 132.5, 4, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (643, 'F5-12£¨B£©£¨13£©', 157, 5.76, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (644, 'F5-14', 90, 4.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (645, 'F5-15', 96, 4.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (646, 'F5-16-18', 283, 6.09, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (647, 'F5-19', 67, 3.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (648, 'F5-20', 135, 3.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (649, 'F5-17-01', 220, .76, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (650, 'F5-17-02', 85, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (651, 'F5-17-03', 85, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (652, 'F5-17-04', 140, 5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (653, 'F5-18-01', 79, 1.56, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (654, 'F5-18-02', 59, .56, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (655, 'F5-18-03', 75, .44, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (656, 'F5-18-04', 64, 5.14, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (657, 'F5-19-01', 160, 2, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (658, 'F5-19-02', 177, 4.5, 'F5', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (659, 'F6-1', 797, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (660, 'F6-2', 232, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (661, 'F6-3', 360, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (662, 'F6-4', 49.3, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (663, 'F6-5', 1416, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (664, 'F6-6', 50, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (665, 'F6-7', 448, 4, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (666, 'F6-8', 410, 4, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (667, 'F6-9', 656, 4, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (668, 'F6-10', 345, 4, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (669, 'F6-11', 390, 4, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (670, 'F6-12', 195, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (671, 'F6-13', 1370, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (672, 'F6-14', 155, 3.7, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (673, 'F6-15', 269, 3.7, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (674, 'F6-16', 341, 3.7, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (675, 'F6-17', 255, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (676, 'F6-18', 308, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (677, 'F6-19', 285, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (678, 'F6-20', 256, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (679, 'F6-21', 345, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (680, 'F6-22', 286, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (681, 'F6-23', 656, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (682, 'F6-24', 181, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (683, 'F6-25', 518, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (684, 'F6-26', 166, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (685, 'F6-27', 367, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (686, 'F6-28', 205, 3, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (687, 'F6-29', 257, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (688, 'F6-30', 3297, 2, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (689, 'F6-31', 3823, 2.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (690, 'F6-32', 479, 3.5, 'F6', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (691, '7F04-07', 363.1, 3.45, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (692, 'F7F-08 F7F-09', 245, 3.5, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (693, '7F10-11', 333, 3.62, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (694, '7F13-15¡¢12A', 345, 3.58, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (695, '7F23-25', 367, 2.3, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (696, '7F27-28', 760, 2.31, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (697, 'F7F-29 F7F-30', 570, 3.5, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (698, '7F32-34', 446, 2.79, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (699, '7F48-53', 880, 2, 'F7', 'Î´×â', 1);
commit;
prompt 700 records committed...
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (700, '7F54-55', 318.8, 3.26, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (701, '7F56-57', 279, 2.29, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (702, '7F58-60', 450, 6.25, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (703, '7F61-63', 500, 2, 'F7', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (704, '7F-74', 14, 5, 'F7', '´ý×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (705, '8F01', 28, 8.98, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (706, '8F02', 43.9, 8.16, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (707, '8F03', 22, 9.25, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (708, '8F04', 44, 6.62, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (709, '8F05', 22, 2.49, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (710, '8F06', 25, 9.1, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (711, '8F07', 40, 6.68, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (712, '8F08', 44, 6.31, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (713, '8F09', 40, 3.34, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (714, '8F10', 44, 6.62, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (715, '8F11', 22, 9.25, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (716, '8F12', 44, 6.62, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (717, '8F15-A', 38, 6.36, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (718, '8F15-B', 26, 7.05, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (719, '8F16-B', 33, 6.42, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (720, '8F16-A', 40, 6.34, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (721, '8M01', 1247, 1.5, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (722, '8M02', 873, 3.21, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (723, '8F-001', 25255, 2.62, 'F8', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (724, '7F-001', 2907, 3.56, 'F7', '´ý×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (725, '7F-A/B/C/D/E/F/HÇø¡¢B1-GÇø', 8901, 4.09, 'F7', '´ý×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (726, 'F1F-42', 230, 8.24, 'F1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (726, 'B1-001', 6400, 4.35, 'B1', 'Î´×â', 1);
insert into TGROUNDH (FGID, FNO, FAREA, FMR, FLOORNO, FSTAT, FNOW)
values (727, 'B2-002', 13335, 1.71, 'B2', 'Î´×â', 1);
commit;
prompt 729 records loaded
prompt Enabling triggers for TBUSRANGE...
alter table TBUSRANGE enable all triggers;
prompt Enabling triggers for TGROUNDH...
alter table TGROUNDH enable all triggers;
set feedback on
set define on
prompt Done.

