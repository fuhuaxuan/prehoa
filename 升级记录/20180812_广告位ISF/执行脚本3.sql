drop table WF_prlGG_ISF;			
create table WF_prlGG_ISF (			
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
	--A		
	Lessee	varchar2(512)	null,
	Tradingname	varchar2(1024)	null,
	Contactor	varchar2(64)	null,
	Address	varchar2(512)	null,
	Phone	varchar2(64)	null,
	Email	varchar2(64)	null,
	Fax	varchar2(64)	null,
	--B		
	LeaseTermY	NUMBER	null,
	LeaseTermM	NUMBER	null,
	LeaseTermD	NUMBER	null,
	HandoverDate	date	null,
	FreeRentM	NUMBER	null,
	FreeRentD	NUMBER	null,
	ContractDate1	date	null,
	Contractdate2	date	null,
	Rate	varchar2(64)	null,
	--C		
	AGR	NUMBER	null,
	Security	NUMBER	null,
	Incash	varchar2(64)	null,
	BRCNew	NUMBER	null,
	BRCExist	NUMBER	null,
	BRCBudget	NUMBER	null,
	TotalFee	NUMBER	null,
	Memo	varchar2(4000)	null,
	EndMemo	varchar2(4000)	null,
	--Mall数据交换		
	mallstat	int	null,
	mallNum	varchar2(64)	null,
	mallModDate	date	null,
	MallMemo	varchar2(1024)	null,
	--流程ISCF，ISTF		
	FlowType	int	null,
	OldFlowGid	varchar2(32)	null,
	constraint PK_WF_prlGG_ISF primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_prlGG_ISF UNIQUE(Num)		
	);		
create index idx_WF_prlGG_ISF_fillgid on WF_prlGG_ISF(FillUsrGid);			
			
			
drop table WF_prlGG_ISF_dtl;			
create table WF_prlGG_ISF_dtl (			
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
	constraint PK_WF_prlGG_ISF_dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table wf_prlGG_isf_ground;			
create table wf_prlGG_isf_ground (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	fgid	int	not null,
	fno	varchar2(64)	not null,
	floorno	VARCHAR2(16)	null,
	fmr	NUMBER(24,4)	not null,
	constraint PK_wf_prlGG_isf_ground primary key(Gid)		
	);		
			
drop table WF_prlGG_ISF_App;			
create table WF_prlGG_ISF_App (			
	EntGid 	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	dtlgid	varchar2(32)	not null,
	--		
	AppStat	int	null,
	--		
	appOrder	int	null,
	appType	int	null,
	AppGid	varchar2(32)	null,
	AppCode	varchar2(64)	null,
	AppName	varchar2(64)	null,
	AppDept	varchar2(64)	null,
	AppAssign	varchar2(64)	null,
	--		
	AppMemo	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_prlGG_ISF_App primary key(EntGid, FlowGid,dtlGid)		
	);		
			
drop table WF_prlGG_ISF_Attach;			
create table WF_prlGG_ISF_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_prlGG_ISF_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
			
