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
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),10,'���Ÿ�����' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),15,'����' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),20,'����' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),25,'������1' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),30,'������2' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),35,'�����ܼ�' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),40,'�����ܼ�' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),45,'�����ܾ���' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),50,'Deputy CEO' from dual;
insert into PRLZB_Post(EntGid,Gid,Code,Name) select getentgid,sys_guid(),55,'CEO' from dual;
commit;




delete from prlzb_acg;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1,'���÷� ',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.1,'��Ʊ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.2,'��Ʊ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.3,'���⳵��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.4,'ס�޷�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.5,'�ͷ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.6,'�д���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),1.7,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),2,'�ճ���ͨ��',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),2.1,'�򳵷�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),2.2,'���ͷ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3,'�칫����',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.1,'�칫��Ʒ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.2,'�칫���̻���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.3,'�칫�ұ����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.4,'����ˮ��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.5,'�칫���豸ά��/����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.6,'�칫��ά��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.7,'�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.8,'���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.9,'ˮ��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),3.10,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),4,'ҵ���д���',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),4.1,'ҵ���д���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),4.2,'��Ʒ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),5,'��ݷ���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),5.1,'���ڿ��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),5.2,'���ʿ��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),6,'�ͱ�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),6.1,'�ͱ�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7,'ͨѶ��',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.1,'�����绰��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.2,'�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.3,'�ֻ���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),7.4,'��Ƶ�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8,'������ά��',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.1,'�ͷ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.2,'ͣ����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.3,'��·��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.4,'ϴ����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.5,'�⳵��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.6,'���⳵��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),8.7,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9,'רҵ�����',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.1,'��Ʒ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.2,'��ѯ�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.3,'��ʦ��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.4,'���ʷ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),9.5,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),10,'�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),10.1,'�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),10.2,'��Ա��',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11,'B�౨��',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.1,'�򳵷�B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.2,'���ͷ�B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.3,'Ա������B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.4,'�ͱ�����B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.5,'�칫��ƷB',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),11.6,'�ֻ���B',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12,'˰��',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.1,'ӡ��˰',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.2,'��ֵ˰',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.3,'�ǽ�˰',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.4,'�����Ѹ���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),12.5,'�ط���������',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13,'Ա������',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.1,'Ա�����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.2,'Ա����ҵ����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.3,'Ա���ػ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.4,'���ո���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.5,'��˾�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.6,'�⼮��Ա֤���������',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),13.7,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14,'��Ƹ����',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14.1,'������Ƹ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14.2,'��ͷ����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),14.3,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15,'��ѵ����',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15.1,'�ڲ���ѵ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15.2,'�ⲿ��ѵ',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),15.3,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16,'�̶��ʲ��������ʲ�',10 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.1,'�칫�豸',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.2,'�칫�Ҿ�',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.3,'װ�޷���',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.4,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.5,'����',20 from dual;
insert into PRLZB_ACG(EntGid,Gid,Code,Name,Type) select getentgid,sys_guid(),16.6,'�������',20 from dual;

commit;

update PRLZB_ACG a
   set (ParentGID, ParentCode) =
       (select t.Gid, t.Code
          from PRLZB_ACG t
         where t.code = substr(a.code, 0, instr(a.code,'.') - 1))
 where a.type = 20;
commit;