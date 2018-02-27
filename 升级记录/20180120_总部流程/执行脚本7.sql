drop table PrlZB_App;			
create table PrlZB_App (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	ComGid	Varchar2(32)	null,
	ComCode	Varchar2(64)	null,
	ComName	Varchar2(64)	null,
	--		
	ModelGid	Varchar2(32)	null,
	ModelCode	Varchar2(64)	null,
	ModelName	Varchar2(64)	null,
	--		
	PostGid	varchar2(32)	null,
	PostCode	int	null,
	PostName	varchar2(64)	null,
	--		
	AppGid	Varchar2(32)	null,
	AppCode	Varchar2(64)	null,
	AppName	Varchar2(64)	null,
	constraint PK_PrlZB_App primary key(EntGid, Gid)		
	);		


insert into PrlZB_App
  (EntGid,
   Gid,
   ComGid,
   ComCode,
   ComName,
   PostGid,
   PostCode,
   PostName,
   AppGid,
   AppCode,
   AppName,
   ModelGid,
   ModelCode,
   ModelName)
  select f.EntGid,
         f.Gid,
         f.ComGid,
         f.ComCode,
         f.ComName,
         f.PostGid,
         f.PostCode,
         f.PostName,
         f.AppGid,
         f.AppCode,
         f.AppName,
         m.modelgid,
         m.code,
         m.name
    from PrlZB_Stamp_App f, wf_model m
   where f.entgid = m.entgid
     and lower(m.code) = 'prlzb_stamp';


insert into PrlZB_App
  (EntGid,
   Gid,
   ComGid,
   ComCode,
   ComName,
   PostGid,
   PostCode,
   PostName,
   AppGid,
   AppCode,
   AppName,
   ModelGid,
   ModelCode,
   ModelName)
  select f.EntGid,
         f.Gid,
         f.ComGid,
         f.ComCode,
         f.ComName,
         f.PostGid,
         f.PostCode,
         f.PostName,
         f.AppGid,
         f.AppCode,
         f.AppName,
         m.modelgid,
         m.code,
         m.name
    from PrlZB_Fee_App f, wf_model m
   where f.entgid = m.entgid
     and lower(m.code) = 'prlzb_fee';


insert into PrlZB_App
  (EntGid,
   Gid,
   ComGid,
   ComCode,
   ComName,
   PostGid,
   PostCode,
   PostName,
   AppGid,
   AppCode,
   AppName,
   ModelGid,
   ModelCode,
   ModelName)
  select f.EntGid,
         f.Gid,
         f.ComGid,
         f.ComCode,
         f.ComName,
         f.PostGid,
         f.PostCode,
         f.PostName,
         f.AppGid,
         f.AppCode,
         f.AppName,
         m.modelgid,
         m.code,
         m.name
    from PrlZB_Pay_App f, wf_model m
   where f.entgid = m.entgid
     and lower(m.code) = 'prlzb_pay';

insert into PrlZB_App
  (EntGid,
   Gid,
   ComGid,
   ComCode,
   ComName,
   PostGid,
   PostCode,
   PostName,
   AppGid,
   AppCode,
   AppName,
   ModelGid,
   ModelCode,
   ModelName)
  select f.EntGid,
         f.Gid,
         f.ComGid,
         f.ComCode,
         f.ComName,
         f.PostGid,
         f.PostCode,
         f.PostName,
         f.AppGid,
         f.AppCode,
         f.AppName,
         m.modelgid,
         m.code,
         m.name
    from PrlZB_Baoxiao_App f, wf_model m
   where f.entgid = m.entgid
     and lower(m.code) = 'prlzb_baoxiao';




CREATE OR REPLACE VIEW V_PrlZB_App AS
select t.*,
       b.AppGid  BAppGid,
       b.AppCode BAppCode,
       b.AppName BAppName,
       f.AppGid  FAppGid,
       f.AppCode FAppCode,
       f.AppName FAppName,
       p.AppGid  PAppGid,
       p.AppCode PAppCode,
       p.AppName PAppName,
       s.AppGid  SAppGid,
       s.AppCode SAppCode,
       s.AppName SAppName
  from (select p.entgid,
               p.gid    PostGid,
               p.code   PostCode,
               p.Name   PostName,
               c.Gid    ComGid,
               c.code   ComCode,
               c.name   ComName
          from PrlZB_Post p, Prlzb_Company c
         where p.entgid = c.entgid) t,
       PrlZB_App b,
       PrlZB_App f,
       PrlZB_App p,
       PrlZB_App s
 where t.entgid = b.entgid(+)
   and t.entgid = f.entgid(+)
   and t.entgid = p.entgid(+)
   and t.entgid = s.entgid(+)
   and t.PostGid = b.postgid(+)
   and t.PostGid = f.postgid(+)
   and t.PostGid = p.postgid(+)
   and t.PostGid = s.postgid(+)
   and t.ComGid = b.ComGid(+)
   and t.ComGid = f.ComGid(+)
   and t.ComGid = p.ComGid(+)
   and t.ComGid = s.ComGid(+)
   and lower(b.modelcode(+)) = 'prlzb_baoxiao'
   and lower(f.modelcode(+)) = 'prlzb_fee'
   and lower(p.modelcode(+)) = 'prlzb_pay'
   and lower(s.modelcode(+)) = 'prlzb_stamp'
 order by t.Postcode;


drop table PrlZB_Acg_Post;			
create table PrlZB_Acg_Post (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	ComGid	Varchar2(32)	null,
	ComCode	Varchar2(64)	null,
	ComName	Varchar2(64)	null,
	--		
	AcgGid	Varchar2(32)	null,
	AcgCode	Varchar2(64)	null,
	AcgName	Varchar2(64)	null,
	--		
	PostGid	varchar2(32)	null,
	PostCode	int	null,
	PostName	varchar2(64)	null,
	--		
	Apper	int	default 0 null,
	constraint PK_PrlZB_Acg_Post primary key(EntGid, Gid)		
	);		


CREATE OR REPLACE VIEW V_PrlZB_Acg_Post AS
select t.*,
       a1.Apper  A1Apper,
       a2.Apper  A2Apper,
       a3.Apper  A3Apper,
       a4.Apper  A4Apper,
       a5.Apper  A5Apper,
       a6.Apper  A6Apper,
       a7.Apper  A7Apper,
       a8.Apper  A8Apper,
       a9.Apper  A9Apper,
       a10.Apper A10Apper
  from (select p.entgid,
               p.gid    AcgGid,
               p.code   AcgCode,
               p.Name   AcgName,
               c.Gid    ComGid,
               c.code   ComCode,
               c.name   ComName
          from PrlZB_Acg p, Prlzb_Company c
         where p.entgid = c.entgid
           and p.type = 20) t,
       PrlZB_Acg_Post a1,
       PrlZB_Acg_Post a2,
       PrlZB_Acg_Post a3,
       PrlZB_Acg_Post a4,
       PrlZB_Acg_Post a5,
       PrlZB_Acg_Post a6,
       PrlZB_Acg_Post a7,
       PrlZB_Acg_Post a8,
       PrlZB_Acg_Post a9,
       PrlZB_Acg_Post a10
 where t.EntGid = a1.EntGid(+)
   and t.EntGid = a2.EntGid(+)
   and t.EntGid = a3.EntGid(+)
   and t.EntGid = a4.EntGid(+)
   and t.EntGid = a5.EntGid(+)
   and t.EntGid = a6.EntGid(+)
   and t.EntGid = a7.EntGid(+)
   and t.EntGid = a8.EntGid(+)
   and t.EntGid = a9.EntGid(+)
   and t.EntGid = a10.EntGid(+)
   and t.AcgGid = a1.AcgGid(+)
   and t.AcgGid = a2.AcgGid(+)
   and t.AcgGid = a3.AcgGid(+)
   and t.AcgGid = a4.AcgGid(+)
   and t.AcgGid = a5.AcgGid(+)
   and t.AcgGid = a6.AcgGid(+)
   and t.AcgGid = a7.AcgGid(+)
   and t.AcgGid = a8.AcgGid(+)
   and t.AcgGid = a9.AcgGid(+)
   and t.AcgGid = a10.AcgGid(+)
   and t.ComGid = a1.ComGid(+)
   and t.ComGid = a2.ComGid(+)
   and t.ComGid = a3.ComGid(+)
   and t.ComGid = a4.ComGid(+)
   and t.ComGid = a5.ComGid(+)
   and t.ComGid = a6.ComGid(+)
   and t.ComGid = a7.ComGid(+)
   and t.ComGid = a8.ComGid(+)
   and t.ComGid = a9.ComGid(+)
   and t.ComGid = a10.ComGid(+)
   and lower(a1.postcode(+)) = '10'
   and lower(a2.postcode(+)) = '15'
   and lower(a3.postcode(+)) = '20'
   and lower(a4.postcode(+)) = '25'
   and lower(a5.postcode(+)) = '30'
   and lower(a6.postcode(+)) = '35'
   and lower(a7.postcode(+)) = '40'
   and lower(a8.postcode(+)) = '45'
   and lower(a9.postcode(+)) = '50'
   and lower(a10.postcode(+)) = '55'
 order by t.AcgCode;