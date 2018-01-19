--版本号：2014年3月份;此行不允许删除			
drop table WF_PrlZB_BaoXiao;			
create table WF_PrlZB_BaoXiao (			
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
	ApplyUsrGid	varchar2(32)	null,
	ApplyUsrCode	varchar2(64)	null,
	ApplyUsrName	varchar2(64)	null,
	IsCM	varchar2(32)	null,
	--		
	ComGid	varchar2(32)	null,
	ComName	varchar2(256)	null,
	PayMan	varchar2(256)	null,
	PayBank	varchar2(256)	null,
	PayAccount	varchar2(256)	null,
	Memo	varchar2(4000)	null,
	--		
	IsTake	varchar2(32)	null,
	CertType	varchar2(128)	null,
	CertNum	varchar2(128)	null,
	PayDate	date	null,
	SumFee	Number(20,2)	null,
	constraint PK_WF_PrlZB_BaoXiao primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlZB_BaoXiao UNIQUE(Num)		
	);		
create index idx_WF_PrlZB_BaoXiao_1 on WF_PrlZB_BaoXiao(FillUsrGid);			
			
drop table WF_PrlZB_BaoXiao_Dtl;			
create table WF_PrlZB_BaoXiao_Dtl (			
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
	ApplyFee	Number(20,2)	null,
	Memo	varchar2(2000)	null,
	constraint PK_WF_PrlZB_BaoXiao_Dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table WF_PrlZB_BaoXiao_App;			
create table WF_PrlZB_BaoXiao_App (			
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
	constraint PK_WF_PrlZB_BaoXiao_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlZB_BaoXiao_Attach;			
create table WF_PrlZB_BaoXiao_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlZB_BaoXiao_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
drop table WF_PrlZB_Fee;			
create table WF_PrlZB_Fee (			
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
	FillUsrDeptGid	varchar2(32)	null,
	FillUsrDeptCode	varchar2(64)	null,
	FillUsrDept	varchar2(64)	null,
	--		
	CompanyGid	varchar2(32)	null,
	CompanyName	varchar2(128)	null,
	AcgOneGid	varchar2(32)	null,
	AcgOneName	varchar2(256)	null,
	AcgTwoGid	varchar2(32)	null,
	AcgTwoName	varchar2(256)	null,
	AcgOther	varchar2(256)	null,
	Target	varchar2(2000)	null,
	Memo	varchar2(2000)	null,
	--		
	VendorName1	varchar2(512)	null,
	VendorName2	varchar2(512)	null,
	VendorName3	varchar2(512)	null,
	VendorName4	varchar2(512)	null,
	VendorName5	varchar2(512)	null,
	VendorName6	varchar2(512)	null,
	VendorFee1	NUMBER	null,
	VendorFee2	NUMBER	null,
	VendorFee3	NUMBER	null,
	VendorFee4	NUMBER	null,
	VendorFee5	NUMBER	null,
	VendorFee6	NUMBER	null,
	--		
	Reason	varchar2(2000)	null,
	ControlFee	NUMBER	null,
	Askfee	NUMBER	null,
	NAskfee	NUMBER	null,
	Confirmfee	NUMBER	null,
	NConfirmfee	NUMBER	null,
	Confirmdate	date	null,
	--		
	DOACode	varchar2(64)	null,
	DOAName	varchar2(64)	null,
	Avalue	NUMBER	null,
	Bvalue	NUMBER	null,
	Cvalue	NUMBER	null,
	Dvalue	NUMBER	null,
	Evalue	NUMBER	null,
	TStart	varchar2(64)	null,
	TEnd	varchar2(64)	null,
	AreaFlag	varchar2(64)	null,
	--		
	EndStat	int	default 0 not null,
	Enddate	date	null,
	EndMemo	varchar2(2000)	null,
	constraint PK_WF_PrlZB_Fee primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlZB_Fee UNIQUE(Num)		
	);		
create index idx_WF_PrlZB_Fee_fillgid on WF_PrlZB_Fee(FillUsrGid);			
			
drop table WF_PrlZB_Fee_dtl;			
create table WF_PrlZB_Fee_dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	sline	int	null,
	--		
	textvalue	varchar2(128)	null,
	vendorfee1	NUMBER	null,
	vendorfee2	NUMBER	null,
	vendorfee3	NUMBER	null,
	vendorfee4	NUMBER	null,
	vendorfee5	NUMBER	null,
	vendorfee6	NUMBER	null,
	constraint PK_WF_PrlZB_Fee_dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlZB_Fee_App;			
create table WF_PrlZB_Fee_App (			
	EntGid 	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	dtlgid	varchar2(32)	not null,
	--		
	AppOrder	int	null,
	apptype	int	null,
	AppGid	varchar2(32)	null,
	AppCode	varchar2(64)	null,
	AppName	varchar2(64)	null,
	AppAssign	varchar2(64)	null,
	--		
	note	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_PrlZB_Fee_App primary key(EntGid, FlowGid,dtlGid)		
	);		
			
			
drop table WF_PrlZB_Fee_Attach;			
create table WF_PrlZB_Fee_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlZB_Fee_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
drop table WF_PrlZB_PAY;			
create table WF_PrlZB_PAY (			
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
	FillUsrDeptGid	varchar2(32)	null,
	FillUsrDeptCode	varchar2(64)	null,
	FillUsrDept	varchar2(64)	null,
	--		
	FeeModelCode	varchar2(32)	null,
	FeeFlowGid	varchar2(32)	null,
	FeeNum	varchar2(32)	null,
	PartNum	int	null,
	isEnd	int	null,
	--		
	CompanyGid	varchar2(32)	null,
	CompanyName	varchar2(128)	null,
	AcgOneGid	varchar2(32)	null,
	AcgOneName	varchar2(256)	null,
	AcgTwoGid	varchar2(32)	null,
	AcgTwoName	varchar2(256)	null,
	AcgOther	varchar2(256)	null,
	--		
	PayFee	NUMBER	null,
	NPayFee	NUMBER	null,
	BigRMB	varchar2(2000)	null,
	ControlFee	NUMBER	null,
	PayWay	varchar2(512)	null,
	Memo	varchar2(2000)	null,
	Payee	varchar2(512)	null,
	Bank	varchar2(512)	null,
	Account	varchar2(512)	null,
	--		
	FeeA	NUMBER	null,
	FeeB	NUMBER	null,
	FeeNotPay	NUMBER	null,
	FeeLeft	NUMBER	null,
	FeeOk	NUMBER	null,
	--		
	Certtype	varchar2(128)	null,
	certnum	varchar2(128)	null,
	PayDate	date	null,
	--		
	DOACode	varchar2(64)	null,
	DOAName	varchar2(64)	null,
	Avalue	NUMBER	null,
	Bvalue	NUMBER	null,
	Cvalue	NUMBER	null,
	Dvalue	NUMBER	null,
	Evalue	NUMBER	null,
	TStart	varchar2(64)	null,
	TEnd	varchar2(64)	null,
	AreaFlag	varchar2(64)	null,
	EndMemo	varchar2(2000)	null,
	constraint PK_WF_PrlZB_PAY primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlZB_PAY UNIQUE(Num)		
	);		
create index idx_WF_PrlZB_PAY_fillgid on WF_PrlZB_PAY(FillUsrGid);			
			
drop table WF_PrlZB_PAY_App;			
create table WF_PrlZB_PAY_App (			
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
	note	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_PrlZB_PAY_App primary key(EntGid, FlowGid,dtlGid)		
	);		
			
			
drop table WF_PrlZB_PAY_Attach;			
create table WF_PrlZB_PAY_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_PrlZB_PAY_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		
			
			
--版本号：2014年3月份;此行不允许删除			
drop table WF_PrlZB_Stamp;			
create table WF_PrlZB_Stamp (			
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
	DeptType	varchar2(16)	null,
	ApplyType	varchar2(16)	null,
	StampType	varchar2(32)	null,
	ComGid	varchar2(32)	null,
	ComName	varchar2(64)	null,
	--非合同类文件用印		
	FilerName	varchar2(64)	null,
	FileName	varchar2(128)	null,
	FileCount	varchar2(32)	null,
	FileAim	varchar2(128)	null,
	ApplyState	varchar2(32)	null,
	--合同类文件用印		
	ContractName	varchar2(256)	null,
	ContractCount	varchar2(32)	null,
	ContractFee	varchar2(64)	null,
	ContactName	varchar2(128)	null,
	ContractDate1	date	null,
	ContractDate2	date	null,
	ComtractMemo	varchar2(2000)	null,
	Memo	varchar2(2000)	null,
	constraint PK_WF_PrlZB_Stamp primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlZB_Stamp UNIQUE(Num)		
	);		
create index idx_WF_PrlZB_Stamp_1 on WF_PrlZB_Stamp(FillUsrGid);			
			
drop table WF_PrlZB_Stamp_App;			
create table WF_PrlZB_Stamp_App (			
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
	constraint PK_WF_PrlZB_Stamp_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlZB_Stamp_Attach;			
create table WF_PrlZB_Stamp_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	AttachTitle	varchar2(256)	null,
	AttachUrl	varchar2(1024)	null,
	AttachSize	int	null,
	constraint PK_WF_PrlZB_Stamp_Attach primary key(EntGid, FlowGid, Gid)		
	);		
			
			
			
			
drop table PrlZB_Stamp_App;			
create table PrlZB_Stamp_App (			
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
	constraint PK_PrlZB_Stamp_App primary key(EntGid, Gid)		
	);		
			
