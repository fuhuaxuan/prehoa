alter table WF_PRL_ISTF add cFee number;
alter table WF_PRL_ISTF add DFee number;
alter table WF_PRL_ISTF add EFee number;
drop table WF_PRL_ISTF_fee;			
create table WF_PRL_ISTF_fee (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	aType	varchar2(10)	null,
	Line	int	null,
	bDate	date	null,
	eDate	date	null,
	TBRD	NUMBER	null,
	PMFD	NUMBER	null,
	Apfixed	NUMBER	null,
	GTO	NUMBER	null,
	Rent	NUMBER	null,
	Memo	VARCHAR2(2000)	null,
	constraint PK_WF_PRL_ISTF_fee primary key(EntGid, FlowGid, Gid)		
	);		



alter table prl_GROUNDH add fmrY number;
alter table prl_GROUNDH_Temp add fmrY number;
alter table WF_PrlDZ_Sos_Dtl add fmrY number;
