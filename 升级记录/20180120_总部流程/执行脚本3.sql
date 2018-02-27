drop table PRLZB_COMPANY;			
create table PRLZB_COMPANY(			
	EntGid 	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Stat	int	default 10 not null,
	CODE	varchar2(128)	null,
	NAME	varchar2(512)	null,
	constraint PK_PRLZB_COMPANY primary key(EntGid, Gid)		
	);		
			
drop table PRLZB_ACG;			
create table PRLZB_ACG (			
	EntGid 	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Type	varchar2(32)	null,
	Code	number	null,
	NAME	varchar2(256)	null,
	ParentGID	varchar2(32)	null,
	ParentCode	number	null,
	feeflag	int	default 10 not null,
	payflag	int	default 10 not null,
	constraint PK_PRLZB_ACG primary key(EntGid, Gid)		
	);		

drop table PRLZB_Post;			
create table PRLZB_Post(			
	EntGid 	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	CODE	int	null,
	NAME	varchar2(512)	null,
	constraint PK_PRLZB_Post primary key(EntGid, Gid)		
	);		
			
drop table PrlZB_Stamp_App;			
create table PrlZB_Stamp_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	ComGid	Varchar2(32)	null,
	ComCode	Varchar2(64)	null,
	ComName	Varchar2(64)	null,
	--		
	PostGid	varchar2(32)	null,
	PostCode	int	null,
	PostName	varchar2(64)	null,
	--		
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_PrlZB_Stamp_App primary key(EntGid, Gid)		
	);		
			
drop table PrlZB_Pay_App;			
create table PrlZB_Pay_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	ComGid	Varchar2(32)	null,
	ComCode	Varchar2(64)	null,
	ComName	Varchar2(64)	null,
	--		
	PostGid	varchar2(32)	null,
	PostCode	int	null,
	PostName	varchar2(64)	null,
	--		
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_PrlZB_Pay_App primary key(EntGid, Gid)		
	);		
			
drop table PrlZB_Fee_App;			
create table PrlZB_Fee_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	ComGid	Varchar2(32)	null,
	ComCode	Varchar2(64)	null,
	ComName	Varchar2(64)	null,
	--		
	PostGid	varchar2(32)	null,
	PostCode	int	null,
	PostName	varchar2(64)	null,
	--		
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_PrlZB_Fee_App primary key(EntGid, Gid)		
	);		
			
drop table PrlZB_BaoXiao_App;			
create table PrlZB_BaoXiao_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	ComGid	Varchar2(32)	null,
	ComCode	Varchar2(64)	null,
	ComName	Varchar2(64)	null,
	--		
	PostGid	varchar2(32)	null,
	PostCode	int	null,
	PostName	varchar2(64)	null,
	--		
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_PrlZB_BaoXiao_App primary key(EntGid, Gid)		
	);		

			
delete from PRLZB_Post;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),10,'部门负责人' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),15,'行政' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),20,'人事' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),25,'财务经理1' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),30,'财务经理2' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),35,'财务总监' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),40,'人事总监' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),45,'区域总经理' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),50,'Deputy CEO' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),55,'CEO' from dual;
commit;




delete from prlzb_acg;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1,'差旅费 ',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.1,'机票',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.2,'火车票',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.3,'出租车费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.4,'住宿费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.5,'餐费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.6,'招待费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.7,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),2,'日常交通费',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),2.1,'打车费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),2.2,'加油费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3,'办公费用',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.1,'办公用品',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.2,'办公室绿化费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.3,'办公室保洁费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.4,'饮用水费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.5,'办公室设备维修/保养',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.6,'办公室维修',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.7,'房租费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.8,'电费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.9,'水费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.10,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),4,'业务招待费',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),4.1,'业务招待费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),4.2,'礼品',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),5,'快递费用',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),5.1,'国内快递',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),5.2,'国际快递',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),6,'劳保费用',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),6.1,'劳保费用',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7,'通讯费',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.1,'国定电话费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.2,'宽带费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.3,'手机费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.4,'视频会议费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8,'车辆及维护',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.1,'油费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.2,'停车费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.3,'过路费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.4,'洗车费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.5,'租车费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.6,'出租车费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.7,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9,'专业服务费',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.1,'审计费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.2,'咨询服务费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.3,'律师费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.4,'验资费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.5,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),10,'会务费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),10.1,'会议费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),10.2,'会员费',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11,'B类报销',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.1,'打车费B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.2,'加油费B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.3,'员工宿舍B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.4,'劳保费用B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.5,'办公用品B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.6,'手机费B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12,'税类',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.1,'印花税',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.2,'增值税',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.3,'城建税',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.4,'教育费附加',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.5,'地方教育附加',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13,'员工福利',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.1,'员工体检',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.2,'员工商业保险',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.3,'员工关怀',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.4,'节日福利',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.5,'公司活动',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.6,'外籍人员证件办理费用',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.7,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14,'招聘费用',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14.1,'网络招聘',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14.2,'猎头费用',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14.3,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15,'培训费用',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15.1,'内部培训',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15.2,'外部培训',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15.3,'其他',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16,'固定资产及无形资产',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.1,'办公设备',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.2,'办公家具',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.3,'装修费用',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.4,'车辆',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.5,'电脑',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.6,'电脑软件',20 from dual;

commit;

update PRLZB_ACG a
   set (ParentGID, ParentCode) =
       (select t.Gid, t.Code
          from PRLZB_ACG t
         where t.code = substr(a.code, 0, instr(a.code,'.') - 1))
 where a.type = 20;
commit;