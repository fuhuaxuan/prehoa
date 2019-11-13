drop table WF_Prl_Flow_Attach;			
create table WF_Prl_Flow_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Attach_Gid	varchar2(32)	not null,
	--		
	Attach_Title	varchar2(256)	null,
	Attach_Url	varchar2(1024)	null,
	Attach_Size	int	null,
	constraint PK_WF_Prl_Flow_Attach primary key(EntGid, FlowGid, Attach_Gid)		
	);		

